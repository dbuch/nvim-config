local M = {}

-- define an chain complete list
local chain_complete_list = {
  default = {
    {complete_items = {'lsp', 'snippet'}},
    {complete_items = {'path'}, triggered_only = {'/'}},
    {complete_items = {'buffers'}},
  },
  string = {
    {complete_items = {'path'}, triggered_only = {'/'}},
  },
  comment = {},
}

local function make_on_attach(config)
  return function(client)
    if config.before then
      config.before(client)
    end

    local lightbulb = require('lightbulb')
    require('completion').on_attach({
      sorting = 'alphabet',
      matching_strategy_list = {'exact', 'fuzzy'},
      chain_complete_list = chain_complete_list,
    })

    -- omni completion source
    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    vim.cmd[[augroup nvim_lspconfig_user_autocmds]]
    vim.cmd[[autocmd! * <buffer>]]
    vim.cmd[[augroup end]]

    lightbulb.on_attach(client)

    if client.name == "rust_analyzer" then
      vim.cmd(
             [[autocmd BufEnter,BufWinEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request { ]]
          .. [[prefix = '» ', highlight = "Comment", enabled = {"ChainingHint"} ]]
          .. [[} ]]
      )
    end

    -- formatting
    if config.after then
      config.after(client)
    end
  end
end

function M.setup()
  local code_action_handler = function (_, _, actions)
    if actions == nil or vim.tbl_isempty(actions) then return end
    --if vim.fn.pumvisible() ~=1 then return end

    local data = {}
    for i, action in ipairs (actions) do
      local title = action.title:gsub('\r\n', '\\r\\n')
      title = title:gsub('\n','\\n')
      data[i] = title
    end

    require'luadev'.print(vim.inspect(data))
  end

  vim.lsp.handlers['textDocument/codeAction'] = code_action_handler
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      signs = true,
      update_in_insert = false,
    }
  )

  Indicator_errors = ' '
  Indicator_warnings = ' '
  Indicator_info = '🛈 '
  Indicator_hint = '❗'

  local function define_signs(opts_table)
    for k, v in pairs(opts_table) do
      vim.fn.sign_define(k, v)
    end
  end

  define_signs {
    LspDiagnosticsSignError = {
      text = Indicator_errors,
      texthl = 'LspDiagnosticsSignError'
    },
    LspDiagnosticsSignWarning = {
      text = Indicator_warnings,
      texthl = 'LspDiagnosticsSignWarning',
    },
    LspDiagnosticsSignInformation = {
      text = Indicator_info,
      texthl = 'LspDiagnosticsSignInformation',
    },
    LspDiagnosticsSignHint = {
      text = Indicator_hint,
      texthl = 'LspDiagnosticsSignHint',
    }
  }
end

function M.config()
  local lspconfig = require('lspconfig')
  local lsp_status = require('lsp-status')

  lsp_status.register_progress()
  lsp_status.config {
    select_symbol = function(cursor_pos, symbol)
      if symbol.valueRange then
        local value_range = {
          ["start"] = {
            character = 0,
            line = vim.fn.byte2line(symbol.valueRange[1])
          },
          ["end"] = {
            character = 0,
            line = vim.fn.byte2line(symbol.valueRange[2])
          }
        }

        return require("lsp-status.util").in_range(cursor_pos, value_range)
      end
    end
  }

  local snippet_capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true
        }
      }
    }
  }

  local servers = {
    clangd = {
      cmd = {
        'clangd', -- '--background-index',
        '--clang-tidy', '--completion-style=bundled', '--header-insertion=iwyu',
        '--suggest-missing-includes', '--cross-file-rename'
      },
      handlers = lsp_status.extensions.clangd.setup(),
      init_options = {
        clangdFileStatus = true,
        usePlaceholders = true,
        completeUnimported = true
      }
    },
    sqlls = {},
    vimls = {},
    texlab = {},
    rust_analyzer = {},
    sumneko_lua = {
      settings = {
        Lua = {
          runtime = {
            -- Get the language server to recognize LuaJIT globals like `jit` and `bit`
            version = 'LuaJIT',
            -- Setup your lua path
            path = vim.split(package.path, ';'),
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = {
              [vim.fn.expand('$VIMRUNTIME/lua')] = true,
              [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
            },
          },
        }
      }
    },
  }

  for server, config in pairs(servers) do
    config.on_attach = make_on_attach(config)
    config.capabilities = vim.tbl_deep_extend(
      "keep", config.capabilities or {}, lsp_status.capabilities, snippet_capabilities
      )

    lspconfig[server].setup(config)
  end
end

return M

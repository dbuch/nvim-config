local M = {}

local function make_on_attach(config)
  return function(client)
    if config.before then
      config.before(client)
    end

    -- omni completion source
    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    require('lightbulb').on_attach(client)

    vim.cmd[[augroup nvim_lspconfig_user_autocmds]]
    vim.cmd[[autocmd! * <buffer>]]
    vim.cmd[[augroup end]]

    if client.name == "rust_analyzer" then
      local workspace_folders = vim.lsp.buf.list_workspace_folders()
      if #workspace_folders > 0 then
        local dap = require('dap')
        dap.configurations.rust = {}
        local arch = tostring(io.popen('uname -m','r'):read('*l'))

        for _, workspace in ipairs(workspace_folders) do
          local cargo_toml = io.open(workspace .. "/Cargo.toml")
          local content = cargo_toml:read("*a")
          local parsed = require('utils.toml').parse(content)
          local name = parsed.package.name
          local program = workspace .. '/target/debug/' .. name
          table.insert(dap.configurations.rust, {
            type = 'rust';
            request = 'launch';
            name = 'Launch ' .. name;
            program = program;
            host = arch;
          })
        end
      end

      vim.cmd(
             [[autocmd BufEnter,BufWinEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request { ]]
          .. [[prefix = '» ', highlight = "Comment", enabled = {"ChainingHint"} ]]
          .. [[} ]]
      )
    end

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
        'clangd',
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
    rust_analyzer = {
      settings = {
        ["rust-analyzer"] = {
          diagnostics = {
            enable = true,
            disabled = {"unresolved-proc-macro"},
            enableExperimental = true,
          }
        }
      }
    },
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
      "force", config.capabilities or {}, lsp_status.capabilities, snippet_capabilities
      )

    lspconfig[server].setup(config)
  end
end

return M

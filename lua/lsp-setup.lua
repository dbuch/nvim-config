local M = {}

local nvim_exec = vim.api.nvim_exec
local expand = vim.fn.expand
local toml = require('utils.toml')
local path = require('utils.path')

local function make_on_attach(config)
  return function(client)
    if config.before then
      config.before(client)
    end

    -- omni completion source
    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    require('lightbulb').on_attach(client)

    nvim_exec([[
      augroup nvim_lspconfig_user_autocmds
      autocmd! * <buffer>
      augroup end
    ]], false)

    if client.name == "rust_analyzer" then
      local workspace_folders = vim.lsp.buf.list_workspace_folders()
      if #workspace_folders > 0 then
        local dap = require('dap')
        dap.configurations.rust = {}
        local arch = tostring(io.popen('uname -m','r'):read('*l'))

        for _, workspace in ipairs(workspace_folders) do
          local cargo_toml = io.open(workspace .. "/Cargo.toml")
          local parsed = toml.parse(cargo_toml:read("*a"))
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
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      signs = true,
      update_in_insert = false,
    }
  )

  local function define_signs(opts_table)
    for k, v in pairs(opts_table) do
      vim.fn.sign_define(k, v)
    end
  end

  define_signs {
    LspDiagnosticsSignError = {
      text = ' ',
      texthl = 'LspDiagnosticsSignError'
    },
    LspDiagnosticsSignWarning = {
      text = ' ',
      texthl = 'LspDiagnosticsSignWarning',
    },
    LspDiagnosticsSignInformation = {
      text = '🛈 ',
      texthl = 'LspDiagnosticsSignInformation',
    },
    LspDiagnosticsSignHint = {
      text = '❗',
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

  local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
  local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"

  local servers = {
    jsonls = {
      cmd = { "vscode-json-languageserver", "--stdio" },
      filetypes = { "json" },
      root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
    },
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
    pyls = {},
    texlab = {
      cmd = { "texlab" },
      latex = {
        build = {
          onSave = true;
        }
      }
    },
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
      cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" };
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
              [expand('$VIMRUNTIME/lua')] = true,
              [expand('$VIMRUNTIME/lua/vim/lsp')] = true,
              [expand('$HOME/.config/nvim/lua')] = true,
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

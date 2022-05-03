local M = {}

local toml = require('utils.toml')

local function make_on_attach(config)
  return function(client)
    if config.before then
      config.before(client)
    end

    -- omni completion source
    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    require('lsp_signature').on_attach({
      floating_window_above_first = true,
    })
    require('lightbulb').on_attach(client)

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

  local snippet_capabilities = vim.lsp.protocol.make_client_capabilities()
  lsp_status.capabilities = require('cmp_nvim_lsp').update_capabilities(snippet_capabilities)

  local servers = {
    bashls = {},
    html = {
      cmd = { "vscode-html-languageserver", "--stdio" },
      filetypes = { "html" },
      root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
    },
    yamlls = {},
    cssls = {
      cmd = { "vscode-css-languageserver", "--stdio" },
      filetypes = { "css" },
      root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
    },
    tsserver = {},
    omnisharp = {
      cmd = { "omnisharp", "-lsp", "-hpid", tostring(vim.fn.getpid()) }
    },
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
    texlab = {
      cmd = { "texlab" },
      latex = {
        build = {
          onSave = true;
        }
      }
    },
    pyright = {},
    rust_analyzer = {},
    sumneko_lua = require("lua-dev").setup({
      lspconfig = {
        cmd = { "lua-language-server" },
      }
    })
  }

  for server, config in pairs(servers) do
    config.on_attach = make_on_attach(config)
    config.capabilities = lsp_status.capabilities

    if lspconfig[server] ~= nil then
      lspconfig[server].setup(config)
    else
      print("Server: " .. server)
    end
  end
end

return M

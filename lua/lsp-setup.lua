local M = {}

local function make_on_attach(config)
  return function(client, bufnr)
    if config.before then
      config.before(client)
    end

    -- omni completion source
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    require('lsp_signature').on_attach({
      floating_window_above_first = true,
      bind = false,
    }, bufnr)

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

  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl= hl, numhl = hl })
  end
end

function M.config()
  local lspconfig = require('lspconfig')
  local lsp_status = require('lsp-status')
  require('neodev').setup({})

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

  lsp_status.capabilities = require('cmp_nvim_lsp').default_capabilities()

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
      cmd = { "omnisharp" },
      -- Enables support for reading code style, naming convention and analyzer
      -- settings from .editorconfig.
      enable_editorconfig_support = true,

      -- If true, MSBuild project system will only load projects for files that
      -- were opened in the editor. This setting is useful for big C# codebases
      -- and allows for faster initialization of code navigation features only
      -- for projects that are relevant to code that is being edited. With this
      -- setting enabled OmniSharp may load fewer projects and may thus display
      -- incomplete reference lists for symbols.
      enable_ms_build_load_projects_on_demand = false,

      -- Enables support for roslyn analyzers, code fixes and rulesets.
      enable_roslyn_analyzers = false,

      -- Specifies whether 'using' directives should be grouped and sorted during
      -- document formatting.
      organize_imports_on_format = false,

      -- Enables support for showing unimported types and unimported extension
      -- methods in completion lists. When committed, the appropriate using
      -- directive will be added at the top of the current file. This option can
      -- have a negative impact on initial completion responsiveness,
      -- particularly for the first few completion sessions after opening a
      -- solution.
      enable_import_completion = false,

      -- Specifies whether to include preview versions of the .NET SDK when
      -- determining which version to use for project loading.
      sdk_include_prereleases = true,

      -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
      -- true
      analyze_open_documents_only = false,
    },
    jsonls = {
      cmd = { "vscode-json-languageserver", "--stdio" },
      filetypes = { "json" },
      root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
    },
    clangd = {
      cmd = {
        'clangd', '--offset-encoding=utf-32',
        '--clang-tidy', '--completion-style=bundled', '--header-insertion=iwyu',
        '--suggest-missing-includes', '--cross-file-rename'
      },
      handlers = lsp_status.extensions.clangd.setup(),
      init_options = {
        clangdFileStatus = true,
        usePlaceholders = true,
        completeUnimported = true
      },
      capabilities = vim.tbl_deep_extend("force", lsp_status.capabilities, { offsetEncoding = { 'utf-32' } })
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
    rust_analyzer = {
      cmd = { "rust-analyzer" },
      settings = {
        ["rust-analyzer"] = {
          ["cargo"] = {
            features = "all",
            runBuildScripts = "true",
          },
          checkOnSave = {
            command = "clippy"
          },
        }
      },
    },
    wgsl_analyzer = {
      cmd = { "wgsl_analyzer" }
    },
    sumneko_lua = {
      lspconfig = {
        cmd = { "lua-language-server" },
      }
    }
  }

  for server, config in pairs(servers) do
    config.on_attach = make_on_attach(config)
    config.flags = {
      debounce_text_changes = 150,
    }
    config.capabilities = lsp_status.capabilities

    if lspconfig[server] ~= nil then
      lspconfig[server].setup(config)
    else
      print("Server: " .. server)
    end
  end
end

return M

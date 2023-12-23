local NvimTrait = require 'dbuch.traits.nvim'
return {
  {
    'neovim/nvim-lspconfig',
    event = 'LazyFile',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'onsails/lspkind-nvim',
      {
        'folke/neodev.nvim',
        opts = {
          pathStrict = true,
          setup_jsonls = false,
        },
      },
    },
    opts = function(_, _)
      local lspconfig = require 'lspconfig'
      return {
        diagnostics = {
          virtual_text = { source = true },
          severity_sort = true,
          update_in_insert = false,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = '●',
              [vim.diagnostic.severity.WARN] = '●',
              [vim.diagnostic.severity.INFO] = '●',
              [vim.diagnostic.severity.HINT] = '○',
            },
          },
        },
        servers = {
          -- VSCode Servers
          html = {
            cmd = { 'vscode-html-languageserver', '--stdio' },
            filetypes = { 'html' },
            root_dir = lspconfig.util.root_pattern('.git', vim.fn.getcwd()),
          },
          yamlls = {},
          cssls = {
            cmd = { 'vscode-css-languageserver', '--stdio' },
            filetypes = { 'css' },
            root_dir = lspconfig.util.root_pattern('.git', vim.fn.getcwd()),
          },
          jsonls = {
            cmd = { 'vscode-json-languageserver', '--stdio' },
            filetypes = { 'json' },
            root_dir = lspconfig.util.root_pattern('.git', vim.fn.getcwd()),
          },
          nushell = {},
          tsserver = {},
          bashls = {},
          omnisharp = {
            cmd = { 'omnisharp' },
            enable_editorconfig_support = true,
            enable_ms_build_load_projects_on_demand = false,
            enable_roslyn_analyzers = true,
            organize_imports_on_format = true,
            enable_import_completion = true,
            sdk_include_prereleases = true,
            analyze_open_documents_only = false,
          },
          lemminx = {},
          clangd = {
            cmd = {
              'clangd',
              '--offset-encoding=utf-32',
              '--clang-tidy',
              '--completion-style=bundled',
              '--header-insertion=iwyu',
              '--suggest-missing-includes',
              '--cross-file-rename',
            },
            init_options = {
              clangdFileStatus = true,
              usePlaceholders = true,
              completeUnimported = true,
            },
          },
          pyright = {},
          taplo = {},
          rust_analyzer = {
            cmd = { 'rust-analyzer' },
            settings = {
              ['rust-analyzer'] = {
                cargo = {
                  buildScripts = {
                    enable = false,
                  },
                },
                procMacro = {
                  enable = true,
                },
                checkOnSave = {
                  command = 'clippy',
                },
              },
            },
          },
          wgsl_analyzer = {
            cmd = { 'wgsl_analyzer' },
          },
          lua_ls = {
            settings = {
              Lua = {
                runtime = {
                  pathStrict = 'true',
                },
                completion = {
                  callSnippet = 'Replace',
                },
                diagnostics = {
                  groupSeverity = {
                    strong = 'Warning',
                    strict = 'Warning',
                  },
                  groupFileStatus = {
                    ['ambiguity'] = 'Opened',
                    ['await'] = 'Opened',
                    ['codestyle'] = 'None',
                    ['duplicate'] = 'Opened',
                    ['global'] = 'Opened',
                    ['luadoc'] = 'Opened',
                    ['redefined'] = 'Opened',
                    ['strict'] = 'Opened',
                    ['strong'] = 'Opened',
                    ['type-check'] = 'Opened',
                    ['unbalanced'] = 'Opened',
                    ['unused'] = 'Opened',
                  },
                  unusedLocalExclude = { '_*' },
                  globals = {
                    'it',
                    'describe',
                    'before_each',
                    'after_each',
                    'pending',
                  },
                },
                format = {
                  enable = true,
                  defaultConfig = {
                    indent_style = 'space',
                    indent_size = '2',
                    column_width = '120',
                    quote_style = 'AutoPreferSingle',
                    no_call_parentheses = 'true',
                    line_endings = 'Unix',
                  },
                },
              },
            },
          },
        },
      }
    end,
    config = function(_plugin, opts)
      -- Register LspAttach
      NvimTrait.on_attach(function(_client, buffer)
        vim.bo[buffer].omnifunc = 'v:lua.vim.lsp.omnifunc'
        vim.lsp.semantic_tokens.force_refresh(buffer)
      end)

      vim.diagnostic.config(opts.diagnostics)

      local handlers = vim.diagnostic.handlers

      local orig_signs_handler = handlers.signs

      -- Override the built-in signs handler to aggregate signs
      handlers.signs = {
        show = function(ns, bufnr, diagnostics, show_opts)
          -- Find the "worst" diagnostic per line
          local max_severity_per_line = {}
          for _, d in pairs(diagnostics) do
            local m = max_severity_per_line[d.lnum]
            if not m or d.severity < m.severity then
              max_severity_per_line[d.lnum] = d
            end
          end

          -- Pass the filtered diagnostics (with our custom namespace) to
          -- the original handler
          local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
          orig_signs_handler.show(ns, bufnr, filtered_diagnostics, show_opts)
        end,
        hide = orig_signs_handler.hide,
      }

      local servers = opts.servers
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      for server, server_opts in pairs(servers) do
        require('lspconfig')[server].setup(vim.tbl_deep_extend('force', {
          capabilities = vim.deepcopy(capabilities),
        }, server_opts or {}))
      end
    end,
  },
}

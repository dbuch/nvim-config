return {
  { 'Vonr/align.nvim' },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function(_, opts)
      local null_ls = require 'null-ls'
      opts.sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.completion.spell,
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'ray-x/lsp_signature.nvim',
      'onsails/lspkind-nvim',
      { 'folke/neodev.nvim', opts = { experimental = { pathStrict = true } } },
      {
        'j-hui/fidget.nvim',
        config = function()
          require('fidget').setup {
            text = {
              spinner = 'dots',
            },
            fmt = {
              stack_upwards = false,
              task = function(task_name, message, percentage)
                local pct = percentage and string.format(' (%s%%)', percentage) or ''
                if task_name then
                  return string.format('%s%s [%s]', message, pct, task_name)
                else
                  return string.format('%s%s', message, pct)
                end
              end,
            },
            sources = {
              ['null-ls'] = {
                ignore = true,
              },
            },
          }
        end,
      },
    },
    opts = {
      servers = {
        -- VSCode Servers
        html = {
          cmd = { 'vscode-html-languageserver', '--stdio' },
          filetypes = { 'html' },
          -- root_dir = lspconfig.util.root_pattern('.git', vim.fn.getcwd()),
        },
        yamlls = {},
        cssls = {
          cmd = { 'vscode-css-languageserver', '--stdio' },
          filetypes = { 'css' },
          -- root_dir = lspconfig.util.root_pattern('.git', vim.fn.getcwd()),
        },
        jsonls = {
          cmd = { 'vscode-json-languageserver', '--stdio' },
          filetypes = { 'json' },
          -- root_dir = lspconfig.util.root_pattern('.git', vim.fn.getcwd()),
        },

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

        texlab = {
          cmd = { 'texlab' },
          latex = {
            build = {
              onSave = true,
            },
          },
        },

        pyright = {},

        rust_analyzer = {
          cmd = { 'rust-analyzer' },
          settings = {
            ['rust-analyzer'] = {
              ['cargo'] = {
                features = 'all',
                runBuildScripts = true,
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
              completion = {
                callSnippet = 'Replace',
              },
              format = {
                enable = true,
                defaultConfig = {
                  indent_type = 'Spaces',
                  indent_width = '2',
                  column_width = '90',
                  quote_style = 'AutoPreferSingle',
                  no_call_parentheses = 'true',
                  line_endings = 'Unix',
                },
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      require('dbuch.traits.nvim').on_attach(function(client, buffer)
        vim.bo[buffer].omnifunc = 'v:lua.vim.lsp.omnifunc'

        require('lsp_signature').on_attach({
          floating_window_above_first = true,
          hi_parameter = 'Visual',
          bind = false,
        }, buffer)

        if client.server_capabilities.code_lens then
          vim.notify 'CodeLens'
          vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
            buffer = buffer,
            callback = vim.lsp.codelens.refresh,
          })
          vim.lsp.codelens.refresh()
        end
      end)

      local servers = opts.servers
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

      local function setup(server)
        local server_opts = vim.tbl_deep_extend('force', {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})
        require('lspconfig')[server].setup(server_opts)
      end

      for server, server_opts in pairs(servers) do
        if server_opts then
          setup(server)
        end
      end
    end,
  },
}

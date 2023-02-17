return {
  { 'Vonr/align.nvim' },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function(_, opts)
      local null_ls = require 'null-ls'
      opts.sources = {
        null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.just,
        -- null_ls.builtins.diagnostics.pylint,
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'onsails/lspkind-nvim',
      { 'folke/neodev.nvim', opts = { experimental = { pathStrict = true } } },
      {
        'j-hui/fidget.nvim',
        opts = {
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
        },
      },
    },
    opts = function(_, _)
      local lspconfig = require 'lspconfig'
      return {
        diagnostics = {
          virtual_text = { source = true },
          severity_sort = true,
          update_in_insert = true,
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
          ruff_lsp = {},
          taplo = {},
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
                runtime = {
                  pathStrict = 'true',
                },
                completion = {
                  callSnippet = 'Replace',
                },
                diagnostics = {
                  groupFileStatus = {
                    ['ambiguity']  = 'Opened',
                    ['await']      = 'Opened',
                    ['codestyle']  = 'None',
                    ['duplicate']  = 'Opened',
                    ['global']     = 'Opened',
                    ['luadoc']     = 'Opened',
                    ['redefined']  = 'Opened',
                    ['type-check'] = 'Opened',
                    ['unbalanced'] = 'Opened',
                    ['unused']     = 'Opened',
                  },
                  unusedLocalExclude = { '_*' },
                  globals = {
                    'it',
                    'describe',
                    'before_each',
                    'after_each',
                    'pending'
                  }
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
            }
          },
        },
      }
    end,
    config = function(_plugin, opts)
      -- Register LspAttach
      require('dbuch.traits.nvim').on_attach(function(client, buffer)
        vim.bo[buffer].omnifunc = 'v:lua.vim.lsp.omnifunc'

        if client.server_capabilities.code_lens then
          vim.api.nvim_set_hl(0, 'LspCodeLens', { link = 'WarningMsg' })
          vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
            buffer = buffer,
            callback = vim.lsp.codelens.refresh,
          })
          vim.lsp.codelens.refresh()
        end
      end)

      -- Set Signs
      require('dbuch.traits.nvim').DefineSigns {
        DiagnosticSignError = '●',
        DiagnosticSignWarn = '●',
        DiagnosticSignInfo = '●',
        DiagnosticSignHint = '○',
      }
      vim.diagnostic.config(opts.diagnostics)

      -- Override the built-in signs handler to aggregate signs
      local orig_signs_handler = vim.diagnostic.handlers.signs
      vim.diagnostic.handlers.signs = {
        show = function(ns, bufnr, _, show_opts)
          local diagnostics = vim.diagnostic.get(bufnr)

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
  -- Dap
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'mfussenegger/nvim-dap-python',
      'rcarriga/nvim-dap-ui',
    },
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
      'f3fora/cmp-spell',
      {
        'saecki/crates.nvim',
        event = 'BufRead Cargo.toml',
        config = true,
      },
    },
    opts = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require 'lspkind'
      local has_words_before = require('dbuch.traits.nvim').has_words_before
      return {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = {
            winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:Visual,Search:None',
            col_offset = -3,
            side_padding = 0,
          },
        },
        view = {
          -- entries = { name = 'custom', selection_order = 'near_cursor' },
          entries = { name = 'custom' },
        },
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = function(entry, item)
            local kind = lspkind.cmp_format {
                  mode = 'symbol_text',
                  maxwidth = 50,
                  ellipsis_char = '…',
                } (entry, item)

            local tokens = {}
            for token in vim.gsplit(kind.kind, '%s') do
              if token ~= '' then
                table.insert(tokens, token)
              end
            end

            kind.kind = (' %s '):format(tokens[1])
            kind.menu = ('    (%s)'):format(tokens[2])

            return kind
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        mapping = cmp.mapping.preset.insert {
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable( -1) then
              luasnip.jump( -1)
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<A-j>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<A-k>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable( -1) then
              luasnip.jump( -1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<C-Space>'] = cmp.mapping.complete({}),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
        },
        sources = {
          { name = 'nvim_lua' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'calc' },
          { name = 'crates' },
          { name = 'buffer' },
        },
        compare = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
        experimental = {
          ghost_text = true,
        },
      }
    end,
    config = function(_, opts)
      local cmp = require 'cmp'
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })
      for _, v in pairs { '/', '?' } do
        cmp.setup.cmdline(v, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' },
          },
        })
      end
      cmp.setup(opts)
    end,
  },
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = function()
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      check_ts = true,
    },
    config = function(_, opts)
      require('nvim-autopairs').setup(opts)
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-refactor',
      {
        'nvim-treesitter/nvim-treesitter-context',
        opts = {
          enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
          max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
          trim_scope = 'outer',
        },
        config = function(_, opts)
          require 'treesitter-context'.setup(opts)
        end
      },
    },
    opts = {
      ensure_installed = {
        'c',
        'css',
        'c_sharp',
        'cpp',
        'lua',
        'rust',
        'html',
        'javascript',
        'typescript',
        'bash',
        'glsl',
        'sql',
        'markdown',
        'markdown_inline',
        'python',
        'regex',
        'query',
        'help',
        'toml',
        'yaml',
        'json',
        'vim',
        'bash',
      },

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      refactor = {
        highlight_current_scope = { enable = true },
      },

      textobjects = {
        enable = true,
        lookahead = true,
        lsp_interop = {
          enable = true,
        },
      },

      indent = {
        'enabled',
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = 'gnn',
          node_incremental = 'grn',
          scope_incremental = 'grc',
          node_decremental = 'grm',
        },
      },

      matchup = {
        enable = true,
      },

      fold = {
        enable = true,
        disable = { 'rst', 'make' },
      },

      context_commentstring = { enable = true, enable_autocmd = false },

      disable = function(_, buf)
        local max_filesize = 1024 * 1024 -- MiB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          vim.notify('Treesitter is disabled due to huge filesize (1MiB)', vim.log.levels.WARN)
          return true
        end
      end,
    },
    config = function(_, opts)
      require('nvim-treesitter').define_modules {
        fold = {
          attach = function()
            vim.opt_local.spell = true
            vim.opt_local.foldexpr = 'nvim_treesitter#foldexpr()'
            vim.opt_local.foldmethod = 'expr'
            vim.opt_local.foldenable = false
          end,
          detach = function()
          end,
        },
      }

      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}

-- TODO:
-- 'rafamadriz/friendly-snippets',
-- {
--   'ahmedkhalf/project.nvim',
--   init = function()
--     require('lazy').load { plugins = { 'project.nvim' } }
--   end,
--   cmd = 'Telescope projects',
--   opts = {
--     manual_mode = false,
--     detection_methods = { 'lsp', 'patterns' },
--     patterns = {
--       '.git',
--       '_darcs',
--       '.hg',
--       '.bzr',
--       '.svn',
--       'Makefile',
--       'package.json',
--       'Cargo.toml',
--     },
--     ignore_lsp = {},
--     exclude_dirs = {
--       '~/.local/share/*',
--       '~/.rustup/toolchains/*',
--       '~/.cargo/*',
--       '/',
--       '~/',
--     },
--     show_hidden = false,
--     silent_chdir = true,
--     datapath = vim.fn.stdpath 'data',
--   },
--   config = function(_, opts)
--     require('project_nvim').setup(opts)
--   end,
-- },

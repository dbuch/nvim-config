return {
  -- Init
  {
    'stevearc/dressing.nvim',
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.input(...)
      end
    end,
  },
  {
    'ahmedkhalf/project.nvim',
    init = function()
      require('lazy').load { plugins = { 'project.nvim' } }
    end,
    cmd = 'Telescope projects',
    opts = {
      manual_mode = false,
      detection_methods = { 'lsp', 'patterns' },
      patterns = {
        '.git',
        '_darcs',
        '.hg',
        '.bzr',
        '.svn',
        'Makefile',
        'package.json',
        'Cargo.toml',
      },
      ignore_lsp = {},
      exclude_dirs = {
        '~/.local/share/*',
        '~/.rustup/toolchains/*',
        '~/.cargo/*',
        '/',
        '~/',
      },
      show_hidden = false,
      silent_chdir = true,
      datapath = vim.fn.stdpath 'data',
    },
    config = function(_, opts)
      require('project_nvim').setup(opts)
    end,
  },
  {
    'rcarriga/nvim-notify',
    init = function()
      require('lazy').load { plugins = { 'nvim-notify' } }
    end,
    config = function()
      vim.notify = require 'notify'
    end,
  },
  -- Editor
  {
    'lewis6991/satellite.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },
  {
    'luukvbaal/statuscol.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('statuscol').setup { setopt = true }
    end,
  },
  {
    'lewis6991/cleanfold.nvim',
    config = function()
      require('cleanfold').setup()
    end,
  },
  {
    'lewis6991/foldsigns.nvim',
    config = function()
      require('foldsigns').setup {
        exclude = { 'GitSigns.*' },
      }
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    cmd = 'NvimTreeFindFileToggle',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require 'dbuch.tree'
    end,
  },
  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    config = function()
      require 'dbuch.trouble'
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    cmd = 'ToggleTerm',
    config = function()
      require 'dbuch.terminal'
    end,
  },
  { 'Vonr/align.nvim' },
  -- Dap
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'mfussenegger/nvim-dap-python',
    },
  },
  { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap' } },
  -- Buffer
  {
    'dbuch/hover.nvim',
    config = function()
      require('hover').setup {
        init = function()
          require 'hover.providers.lsp'
          --require('hover.providers.gh')
          require 'hover.providers.dictionary'
          --require('hover.providers.diagnostic')
          require 'hover.providers.man'
        end,
      }
      vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
      vim.keymap.set('n', 'gK', require('hover').hover_select, { desc = 'hover.nvim (select)' })
    end,
  },
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require 'dbuch.gitsigns'
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup {
        check_ts = true,
      }
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
    dependencies = {
      'hrsh7th/nvim-cmp',
      'nvim-treesitter/nvim-treesitter',
    },
  },
  {
    'AndrewRadev/bufferize.vim',
    cmd = 'Bufferize',
    config = function()
      vim.g.bufferize_command = 'enew'
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'bufferize',
        group = 'vimrc',
        callback = function()
          vim.opt_local.wrap = true
        end,
      })
    end,
  },
  -- Coloring
  'folke/lsp-colors.nvim',
  {
    'lewis6991/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  -- Icons
  'nvim-tree/nvim-web-devicons',
  -- 'ryanoasis/vim-devicons',
  -- LSP
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'folke/neodev.nvim',
      'ray-x/lsp_signature.nvim',
      'onsails/lspkind-nvim',
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
    config = function()
      require 'dbuch.lsp'
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require 'dbuch.null-ls'
    end,
  },
  -- 'rafamadriz/friendly-snippets',
  {
    'hrsh7th/nvim-cmp',
    version = false,
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
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
    config = function()
      require 'dbuch.cmp'
    end,
  },
  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      require 'dbuch.treesitter'
    end,
  },
}

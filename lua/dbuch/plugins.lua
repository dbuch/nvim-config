return {
  -- Core
  'lewis6991/impatient.nvim',
  -- Editor
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
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require 'dbuch.tree'
    end,
  },
  { 'gpanders/editorconfig.nvim' },
  { 'sindrets/diffview.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  {
    'folke/trouble.nvim',
    config = function()
      require 'dbuch.trouble'
    end,
  },
  {
    'ahmedkhalf/project.nvim',
    config = function()
      require 'dbuch.project'
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require 'dbuch.terminal'
    end,
  },
  { 'stevearc/dressing.nvim' },
  { 'Vonr/align.nvim'},
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
    'lewis6991/satellite.nvim',
    config = function()
      require('satellite').setup()
    end,
  },
  {
    'numToStr/Comment.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },
  { 'lewis6991/gitsigns.nvim', config = function () require'dbuch.gitsigns' end },
  { 'simrat39/symbols-outline.nvim', config = function () require'dbuch.symbs' end },
  {
    'windwp/nvim-autopairs',
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
  {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require 'notify'
    end,
  },
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
    dependencies = {
      'folke/neodev.nvim',
      'ray-x/lsp_signature.nvim',
      'onsails/lspkind-nvim',
    },
    config = function()
      require 'dbuch.lsp'
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require 'dbuch.null-ls'
    end,
  },
  'rafamadriz/friendly-snippets',
  {
    'saecki/crates.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'jose-elias-alvarez/null-ls.nvim' },
    config = function()
      require('crates').setup {}
    end,
  },
  {
    'hrsh7th/nvim-cmp',
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
    },
    config = function()
      require 'dbuch.cmp'
    end,
  },
  -- Treesitter
  {
    'nvim-lua/telescope.nvim',
    dependencies = {
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require 'dbuch.telescope'
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'theHamsta/nvim-dap-virtual-text',
    },
    build = ':TSUpdate',
    config = function()
      require 'dbuch.treesitter'
    end,
  },
  -- Other
  {
    'LhKipp/nvim-nu',
    dependencies = {
      'jose-elias-alvarez/null-ls.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('nu').setup {
        complete_cmd_names = true,
      }
    end,
  },
}

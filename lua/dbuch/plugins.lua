require('dbuch.packer').setup {
  -- Core
  'lewis6991/impatient.nvim',
  'wbthomason/packer.nvim',
  -- Editor
  { 'lewis6991/cleanfold.nvim', config = [[require('cleanfold').setup()]] },
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
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    config = [[require'dbuch.tree']],
  },
  { 'gpanders/editorconfig.nvim' },
  { 'sindrets/diffview.nvim', requires = { 'nvim-lua/plenary.nvim' } },
  { 'folke/trouble.nvim', config = [[require'dbuch.trouble']] },
  { 'ahmedkhalf/project.nvim', config = [[require'dbuch.project']] },
  {
    'akinsho/toggleterm.nvim',
    tag = '*',
    config = [[require'dbuch.terminal']],
  },
  'stevearc/dressing.nvim',
  -- Dap
  {
    'mfussenegger/nvim-dap',
    requires = {
      'mfussenegger/nvim-dap-python',
      { 'theHamsta/nvim-dap-virtual-text', after = 'nvim-treesitter' },
    },
    --  setup = function() require 'dap-setup'.setup() end,
    --  config = function() require 'dap-setup'.config() end,
  },
  { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } },
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
      vim.keymap.set(
        'n',
        'gK',
        require('hover').hover_select,
        { desc = 'hover.nvim (select)' }
      )
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
    requires = { 'JoosepAlviste/nvim-treesitter' },
    config = function()
      require('Comment').setup {
        pre_hook = require(
          'ts_context_commentstring.integrations.comment_nvim'
        ).create_pre_hook(),
      }
    end,
  },
  { 'rmagatti/goto-preview', config = [[require'dbuch.preview']] },
  { 'lewis6991/gitsigns.nvim', config = [[require'dbuch.gitsigns']] },
  { 'simrat39/symbols-outline.nvim', config = [[require'dbuch.symbs']] },
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
    requires = {
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
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('hlslens').setup {
        calm_down = true,
      }
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
            local pct = percentage and string.format(' (%s%%)', percentage)
              or ''
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
  { 'lewis6991/nvim-colorizer.lua', config = [[require('colorizer').setup()]] },
  -- Icons
  'kyazdani42/nvim-web-devicons',
  'ryanoasis/vim-devicons',
  -- LSP
  {
    'neovim/nvim-lspconfig',
    requires = {
      'folke/neodev.nvim',
      'ray-x/lsp_signature.nvim',
      'onsails/lspkind-nvim',
      'theHamsta/nvim-semantic-tokens',
    },
    config = "require'dbuch.lsp'",
  },
  { 'jose-elias-alvarez/null-ls.nvim', config = [[require('dbuch.null-ls')]] },
  'rafamadriz/friendly-snippets',
  {
    'saecki/crates.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'jose-elias-alvarez/null-ls.nvim' },
    config = function()
      require('crates').setup {}
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    requires = {
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
    config = [[require('dbuch.cmp')]],
  },
  -- Treesitter
  {
    'nvim-lua/telescope.nvim',
    requires = {
      { 'nvim-telescope/telescope-fzy-native.nvim', run = 'make' },
      'nvim-lua/plenary.nvim',
    },
    config = [[require('dbuch.telescope')]],
  },
  {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    run = ':TSUpdate',
    config = [[require('dbuch.treesitter')]],
  },
  -- Other
  {
    'LhKipp/nvim-nu',
    requires = {
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

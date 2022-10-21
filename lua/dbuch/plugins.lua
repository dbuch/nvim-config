local packer = require('dbuch.packer')
packer.setup {

  -- Core

  'lewis6991/impatient.nvim',
  'wbthomason/packer.nvim',

  {'lewis6991/github_dark.nvim', config = function()
    vim.cmd.color'github_dark'
  end},

  -- Editor
  {'lewis6991/spaceless.nvim', config = [[require('spaceless').setup()]]},
  {'lewis6991/cleanfold.nvim', config = [[require('cleanfold').setup()]]},
  {'lewis6991/foldsigns.nvim',
    config = function()
      require'foldsigns'.setup{
        exclude = {'GitSigns.*'}
      }
    end
  },

  {'sindrets/diffview.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  },

  'folke/trouble.nvim', --  EXITFREE lag

  -- Buffer
  {'lewis6991/hover.nvim', config  = function()
    require('hover').setup{
      init = function()
        require('hover.providers.lsp')
        require('hover.providers.gh')
        require('hover.providers.dictionary')
        require('hover.providers.man')
      end
    }
    vim.keymap.set('n', 'K', require('hover').hover, {desc='hover.nvim'})
    vim.keymap.set('n', 'gK', require('hover').hover_select, {desc='hover.nvim (select)'})
  end},

  {'lewis6991/gitsigns.nvim', config = "require'dbuch.gitsigns'" },

  {'windwp/nvim-autopairs',
    config = function()
      require 'nvim-autopairs'.setup {}
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
    end,
    requires = {
      'hrsh7th/nvim-cmp',
    }
  },

  {'AndrewRadev/bufferize.vim',
    cmd = 'Bufferize',
    config = function()
      vim.g.bufferize_command = 'enew'
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'bufferize',
        group = 'vimrc',
        callback = function()
          vim.opt_local.wrap = true
        end
      })
    end
  },

  {'rcarriga/nvim-notify', config = function()
    vim.notify = require("notify")
  end},

  {'j-hui/fidget.nvim', config = function()
    require'fidget'.setup{
      text = {
        spinner = "dots",
      },
      fmt = {
        stack_upwards = false,
        task = function(task_name, message, percentage)
          local pct = percentage and string.format(" (%s%%)", percentage) or ""
          if task_name then
            return string.format("%s%s [%s]", message, pct, task_name)
          else
            return string.format("%s%s", message, pct)
          end
        end,
      },
      sources = {
        ['null-ls'] = {
          ignore = true
        }
      }
    }
  end},

  -- Coloring
  'folke/lsp-colors.nvim',
  {'lewis6991/nvim-colorizer.lua', config = [[require('colorizer').setup()]] },

  -- Icons
  'kyazdani42/nvim-web-devicons',
  'ryanoasis/vim-devicons',

  -- LSP
  {'neovim/nvim-lspconfig',
    requires = {
      'folke/lua-dev.nvim',
      'ray-x/lsp_signature.nvim',
      'onsails/lspkind-nvim',
    },
    config = "require'dbuch.lsp'"
  },

  {'jose-elias-alvarez/null-ls.nvim', config = [[require('dbuch.null-ls')]]},

  {'hrsh7th/nvim-cmp',
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
    config = [[require('dbuch.cmp')]]
  },

  -- Lua/Neovim Dev

  {'neovim/nvimdev.nvim',
    requires = {'neomake/neomake'}
  },


  {'folke/neodev.nvim',
    requires = {
      'neovim/nvim-lspconfig',
      'hrsh7th/nvim-cmp',
    }
  },

  -- Treesitter

  {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
  {'nvim-lua/telescope.nvim',
    requires = {
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
      'nvim-lua/plenary.nvim'
    },
    config = [[require('dbuch.telescope")]]
  },


  {'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-context',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/playground',
    },
    run = ':TSUpdate',
    config = [[require('dbuch.treesitter')]],
  }

  --TODO:

  --[[ {'whatyouhide/vim-lengthmatters', config = function()
    vim.g.lengthmatters_highlight_one_column = 1
    vim.g.lengthmatters_excluded = {'packer'}
  end}, ]]

  -- {'junegunn/vim-easy-align',
  --   keys = 'ga',
  --   config = function()
  --     vim.keymap.set({'x', 'n'}, 'ga', '<Plug>(EasyAlign)')
  --     vim.g.easy_align_delimiters = {
  --       [';']  = { pattern = ';'        , left_margin = 0 },
  --       ['[']  = { pattern = '['        , left_margin = 1, right_margin = 0 },
  --       [']']  = { pattern = ']'        , left_margin = 0, right_margin = 1 },
  --       [',']  = { pattern = ','        , left_margin = 0, right_margin = 1 },
  --       [')']  = { pattern = ')'        , left_margin = 0, right_margin = 0 },
  --       ['(']  = { pattern = '('        , left_margin = 0, right_margin = 0 },
  --       ['=']  = { pattern = [[<\?=>\?]], left_margin = 1, right_margin = 1 },
  --       ['|']  = { pattern = [[|\?|]]   , left_margin = 1, right_margin = 1 },
  --       ['&']  = { pattern = [[&\?&]]   , left_margin = 1, right_margin = 1 },
  --       [':']  = { pattern = ':'        , left_margin = 1, right_margin = 1 },
  --       ['?']  = { pattern = '?'        , left_margin = 1, right_margin = 1 },
  --       ['<']  = { pattern = '<'        , left_margin = 1, right_margin = 0 },
  --       ['>']  = { pattern = '>'        , left_margin = 1, right_margin = 0 },
  --       ['\\'] = { pattern = '\\'       , left_margin = 1, right_margin = 0 },
  --       ['+']  = { pattern = '+'        , left_margin = 1, right_margin = 1 }
  --     }
  --   end
  -- },
  --'fladson/vim-kitty',
}


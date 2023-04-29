return {
  {
    'andymass/vim-matchup',
    event = 'BufReadPost',
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = 'status_manual' }
    end,
  },
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = true,
  },
  {
    'windwp/nvim-autopairs',
    event = { 'BufReadPost', 'BufNewFile' },
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
    'LhKipp/nvim-nu',
    build = ':TSInstall nu',
    ft = 'nu',
    init = function()
      vim.filetype.add {
        extension = {
          nu = 'nu',
        },
      }
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = true,
  },
  {
    'brenoprata10/nvim-highlight-colors',
    cmd = {'HighlightColorsOn', 'HighlightColorsOff', 'HighlightColorsToggle'},
    config = true
  },
  {
    'rafcamlet/nvim-luapad',
    cmd = 'LuaRun',
    config = true,
  }
}

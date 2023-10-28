return {
  {
    'andymass/vim-matchup',
    event = 'BufReadPost',
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = 'status_manual' }
    end,
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

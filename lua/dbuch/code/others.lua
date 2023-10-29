return {
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
    },
    config = true,
  },
  {
    'brenoprata10/nvim-highlight-colors',
    cmd = { 'HighlightColorsOn', 'HighlightColorsOff', 'HighlightColorsToggle' },
    config = true,
  },
}

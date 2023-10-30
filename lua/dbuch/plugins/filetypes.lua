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
    'NoahTheDuke/vim-just',
    event = { 'BufReadPre', 'BufNewFile' },
    ft = { '\\cjustfile', '*.just', '.justfile' },
  },
}

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
    opts = {
      use_lsp_features = false,
    },
  },
  {
    'NoahTheDuke/vim-just',
    event = 'LazyFile',
    ft = { '\\cjustfile', '*.just', '.justfile' },
  },
}

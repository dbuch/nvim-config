return {
  {
    dev = true,
    'nu-ts.nvim',
    ft = { 'nu', '*.nu' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      add_filtype = false,
    },
  },
  {
    'NoahTheDuke/vim-just',
    event = 'LazyFile',
    ft = { '\\cjustfile', '*.just', '.justfile' },
  },
}

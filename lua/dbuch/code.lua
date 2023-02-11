return {
  {
    'folke/neodev.nvim',
    opts = {
      library = {
        plugins = false,
      },
    },
  },
  { 'Vonr/align.nvim' },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function(_, opts)
      local null_ls = require 'null-ls'
      opts.sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.completion.spell,
      }
    end,
  },

  { import = 'dbuch.code.lsp' },
}

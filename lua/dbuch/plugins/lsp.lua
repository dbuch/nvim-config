local NvimTrait = require 'dbuch.traits.nvim'

---@module 'lazy'
---@type LazyPluginSpec[]
return {
  {
    'folke/lazydev.nvim',
    dev = true,
    ft = 'lua',
    cmd = 'LazyDev',
    enabled = true,
    dependencies = {
      { 'Bilal2453/luvit-meta', lazy = true },
    },
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
      integrations = {
        lspconfig = false,
        cmp = false,
      },
    },
  },
}

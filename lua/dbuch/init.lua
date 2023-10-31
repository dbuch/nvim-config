require 'dbuch.options'
require 'dbuch.status'
require 'dbuch.autocmds'
require 'dbuch.mappings'
require('dbuch.traits.lazy').setup()
require('lazy').setup {
  spec = {
    { import = 'dbuch.core' },
    { import = 'dbuch.plugins' },
  },
  defaults = {
    lazy = false,
  },
  checker = {
    enabled = false,
    notify = true,
    frequency = 14400, -- Every fourth hour
  },
  change_detection = {
    notify = false,
  },
  dev = {
    path = '~/dev/nvim/plugins',
    patterns = { 'dbuch' },
    fallback = false,
  },
  lockfile = vim.fn.stdpath 'data' .. '/lazy-lock.json',--[[@type string]]
  performance = {
    rtp = {
      disabled_plugins = {
        'netrw',
        'netrwPlugin',
        'matchit',
        'matchparen',
        'tutor',
        'tohtml',
        'tarPlugin',
        'zipPlugin',
        'gzip',
      },
    },
  },
  debug = vim.env.LAZY_DEBUG or false,
}

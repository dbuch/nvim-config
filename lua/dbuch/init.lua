require 'dbuch.options'
require 'dbuch.status'
require 'dbuch.autocmds'
require 'dbuch.mappings'
require('dbuch.traits.lazy').lazy_notify()
require('dbuch.traits.lazy').initialize_lazyfile()
require('lazy').setup {
  spec = {
    { import = 'dbuch.plugins' },
  },
  defaults = {
    lazy = true,
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
    path = '~/dev/nvim/plugins/',
    ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
    patterns = {}, -- For example {"folke"}
    fallback = false, -- Fallback to git when local plugin doesn't exist
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

require 'dbuch.theme'
require 'dbuch.status'
require 'dbuch.autocmds'
require 'dbuch.jumps'
require 'dbuch.quit'
require 'dbuch.options'

require 'dbuch.traits.nvim'.defer_notify()

require('lazy').setup {
  spec = {
    { import = 'dbuch.core' },
    { import = 'dbuch.editor' },
    { import = 'dbuch.code' },
  },
  defaults = {
    lazy = true,
  },
  --  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        'netrw',
        'netrwPlugin',
        'tutor',
        'tohtml',
        'tarPlugin',
        'zipPlugin',
        'gzip',
      },
    },
  },
}

require 'dbuch.mappings'

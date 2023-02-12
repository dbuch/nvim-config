require 'dbuch.theme'
require 'dbuch.status'
require 'dbuch.autocmds'
require 'dbuch.diagnostic'
require 'dbuch.jumps'
require 'dbuch.quit'
require 'dbuch.options'

require('lazy').setup {
  spec = {
    { import = 'dbuch.core' },
    { import = 'dbuch.editor' },
    { import = 'dbuch.code' },
    { import = 'dbuch.others' },
  },
  defaults = {
    lazy = true,
    -- version = '*',
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

require 'dbuch.theme'
require 'dbuch.status'
require 'dbuch.autocmds'
require 'dbuch.jumps'
require 'dbuch.quit'
require 'dbuch.options'

require('lazy').setup {
  spec = {
    { import = 'dbuch.core' },
    { import = 'dbuch.editor' },
    { import = 'dbuch.code' },
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
}

require 'dbuch.mappings'

local LazyTrait = require 'dbuch.traits.lazy'
local NvimTrait = require 'dbuch.traits.nvim'

LazyTrait.lazy_notify()
LazyTrait.initialize_lazyfile()
NvimTrait.init_printf()

require 'dbuch.options'
require 'dbuch.status'
require 'dbuch.autocmds'
require 'dbuch.mappings'

---@class DevSpec
---@field path string
---@field patterns string[]
---@field fallback boolean

require('lazy').setup {
  spec = {
    { import = 'dbuch.plugins' },
  },
  defaults = {
    lazy = true,
  },
  checker = {
    enabled = true,
    notify = true,
    frequency = 14400, -- Every fourth hour
  },
  change_detection = {
    notify = false,
  },
  ---@type DevSpec
  dev = {
    path = '~/dev/nvim/plugins/',
    patterns = {},
    fallback = false,
  },
  lockfile = vim.fn.stdpath 'data' .. '/lazy-lock.json',--[[@type string]]
  performance = {
    rtp = {
      disabled_plugins = {
        'compiler',
        'bugreport',
        '2html_plugin',
        'ftplugin',
        'optwin',
        'syntax',
        'netrw',
        'netrwPlugin',
        'matchit',
        'matchparen',
        'tutor',
        'tohtml',
        'vimball',
        'vimballPlugin',
        'tarPlugin',
        'zipPlugin',
        'gzip',
      },
    },
  },
  debug = vim.env.LAZY_DEBUG or false,
}

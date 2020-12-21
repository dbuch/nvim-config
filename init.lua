vim.g.mapleader = ' '

require('settings')

require('plugins')

require('utils')
require('keymap')
require('colorizer').setup()
require('nvim-web-devicons').setup()
require('colorbuddy').colorscheme('onedark')

require('statusline')

require('nvim-treesitter').setup {
  ensure_installed = {
    "c",
    "rust",
    "cpp",
    "lua",
    "css",
    "html",
    "javascript",
    "bash",
  },
  indent = {
    'enabled'
  }
}

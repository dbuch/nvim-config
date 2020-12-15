vim.g.mapleader = ' '

require('plugins')
require('keymap')
require('settings')
require('colorizer').setup()
require('nvim-web-devicons').setup()
require('colorbuddy').colorscheme('onedark')

require('lsp-setup')

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

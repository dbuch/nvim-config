vim.g.mapleader = ' '

require('plugins')

require('settings')

require('colorizer').setup()
require('nvim-web-devicons').setup()
require('colorbuddy').colorscheme('onedark')

require('keymap')
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


vim.g.mapleader = ' '

require('plugins')

require('sk_telescope')

require('settings')

require('colorizer').setup()
require('nvim-web-devicons').setup()
require('colorbuddy').colorscheme('onedark')

require('keymap')
require('lsp-setup')

require('statusline')

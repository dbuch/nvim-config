vim.g.mapleader = ' '

local function disable_default_plugins()
  -- Disable unnecessary default plugins
  vim.g.loaded_2html_plugin      = 1
  vim.g.loaded_getscript         = 1
  vim.g.loaded_getscriptPlugin   = 1
  vim.g.loaded_gzip              = 1
  vim.g.loaded_logiPat           = 1
  vim.g.loaded_matchit           = 1
  vim.g.loaded_matchparen        = 1
  vim.g.netrw_nogx               = 1
  vim.g.loaded_netrwPlugin       = 1
  vim.g.loaded_netrwSettings     = 1
  vim.g.loaded_netrwFileHandlers = 1
  vim.g.loaded_rrhelper          = 1
  vim.g.loaded_spellfile_plugin  = 1
  vim.g.loaded_tar               = 1
  vim.g.loaded_tarPlugin         = 1
  vim.g.loaded_vimball           = 1
  vim.g.loaded_vimballPlugin     = 1
  vim.g.loaded_zip               = 1
  vim.g.loaded_zipPlugin         = 1

  -- No Ruby or perl support
  vim.g.loaded_node_provider = 0
  vim.g.loaded_ruby_provider = 0
  vim.g.loaded_perl_provider = 0
  vim.g.loaded_python_provider = 0
end

disable_default_plugins()

require('settings')

require('plugins')

require('utils')
require('keymap')
require('colorizer').setup()
require('nvim-web-devicons').setup()
require('colorbuddy').colorscheme('onedark')

require('statusline')

require('rooter').setup()

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

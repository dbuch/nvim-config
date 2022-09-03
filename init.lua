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
  vim.g.loaded_node_provider     = 1
  vim.g.loaded_ruby_provider     = 1
  vim.g.loaded_perl_provider     = 1
  vim.g.loaded_python_provider   = 1
end

disable_default_plugins()

local function load_core_module(modules)
  for _, module in ipairs(modules) do
    local ok, _ = pcall(require, module)
    if not ok then
      print(string.format("Failed to load: %s", module))
    end
  end
end

load_core_module({
  'impatient',
  'settings',
  'plugins',
  'keymap',
  'statusline',
  'nvim-web-devicons'
})

require('nvim-web-devicons').setup()
require('colorizer').setup {
  'html';
  'lua';
  'javascript';
  'css';
}

require 'lsp-setup'.config()
require 'lsp-setup'.setup()
require 'completion-setup'.setup()

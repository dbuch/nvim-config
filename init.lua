_G.safe_require = function(module_name)
  ---@diagnostic disable-next-line: no-unknown
  local success, module = pcall(require, module_name)
  if success then
    return module
  end
  vim.api.nvim_err_writeln(('ERROR: Failed to load: %s'):format(module_name))
end

_G.Utils = require 'dbuch.utils'

-- Early Configuration
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_gzip = 1
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0

vim.loader.enable()

-- Bootstrap
---@type string
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
  vim
    .system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    })
    :wait()
end

vim.opt.rtp:prepend(lazypath)

-- Initialize
safe_require 'dbuch'

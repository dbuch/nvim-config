-- Bootstrap And Config

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

--local function check_health()
--  vim.health.report_start("dbuch")
--
--  if vim.fn.has("nvim-0.8.0") == 1 then
--    vim.health.report_ok("Using Neovim >= 0.8.0")
--  else
--    vim.health.report_error("Neovim >= 0.8.0 is required")
--  end
--
--  for _, cmd in ipairs({ "git", "rg", "fd", "just", "ruff", "taplo" }) do
--    local name = type(cmd) == "string" and cmd or vim.inspect(cmd)
--    local commands = type(cmd) == "string" and { cmd } or cmd
--    ---@cast commands string[]
--    local found = false
--
--    for _, c in ipairs(commands) do
--      if vim.fn.executable(c) == 1 then
--        name = c
--        found = true
--      end
--    end
--
--    if found then
--      vim.health.report_ok(("`%s` is installed"):format(name))
--    else
--      vim.health.report_warn(("`%s` is not installed"):format(name))
--    end
--  end
--end
--check_health()

-- Initialize
require 'dbuch'

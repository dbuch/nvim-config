local M = {}

local api = vim.api
local path = require('utils.path')
local patterns = {'.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'Cargo.toml', 'CMakeLists.txt'}

local function register_au()
  local cmd = vim.api.nvim_command

  cmd("augroup luarooter")
  cmd("autocmd!")
  cmd("autocmd VimEnter,BufReadPost,BufEnter * nested lua require'rooter'.root()")
  cmd("autocmd BufWritePost * nested lua require'rooter'.unroot()")
  cmd("autocmd User RootUpdated redrawstatus!")
  cmd("augroup END")
end

local function should_activate()
  if vim.api.nvim_buf_get_option(0, 'buftype') ~= '' then
    return false
  end

  local filename = vim.fn.expand('%:p', 1)
  if not filename or filename == "" then
    return false
  end

  return true
end

function M.unroot()
  vim.api.nvim_buf_set_var(0, 'rootDir', '')
end

function M.root()
  if not should_activate() then return end

  local isRooted, _ = pcall(api.nvim_buf_get_var, 0, 'rootDir')
  if not isRooted then
    local root_path = path.root_pattern {patterns} (vim.fn.expand('%'))
    local cd_status, _ = pcall(api.nvim_command, 'cd ' .. root_path)
    if cd_status then
      api.nvim_buf_set_var(0, 'rootDir', root_path)
      api.nvim_command('doautocmd <nomodeline> User RootUpdated')
    end
  end
end

function M.IsRooted()
  local status, _ = pcall(vim.api.nvim_buf_get_var, 0, 'rootDir')
  return status
end

function M.getCurrentRoot()
  local status, root = pcall(vim.api.nvim_buf_get_var, 0, 'rootDir')
  if not status then
    return ''
  end
  return root
end

function M.setup()
  register_au()
end

return M

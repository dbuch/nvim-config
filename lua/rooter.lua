local M = {}

local api = vim.api
local path = require('utils.path')
local patterns = {'.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'Cargo.toml'}

local function register_au()
  local cmd = vim.api.nvim_command

  cmd("augroup luarooter")
  cmd("autocmd!")
  cmd("autocmd VimEnter,BufReadPost,BufEnter * nested lua require'rooter'.root()")
  cmd("autocmd BufWritePost * nested lua require'rooter'.unroot()")
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
    local buf_file = vim.fn.expand('%')
    local root_path = path.root_pattern {patterns} (buf_file)

    api.nvim_buf_set_var(0, 'rootDir', root_path)
    api.nvim_command('cd ' .. root_path)
    print('CWD: ' .. root_path)
  end
end

function M.setup()
  register_au()
end

return M

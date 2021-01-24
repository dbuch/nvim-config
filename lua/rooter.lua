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

local function isEmpty(s)
  return s == nil or s == ''
end

function M.root()
  if not should_activate() then return end

  if not M.IsRooted() then
    local root_path = path.root_pattern {patterns} (vim.fn.expand('%'))
    if not isEmpty(root_path) then
      local ok, _ = pcall(api.nvim_command, 'cd ' .. root_path)
      if ok then
        api.nvim_buf_set_var(0, 'rootDir', root_path)
        api.nvim_command('doautocmd <nomodeline> User RootUpdated')
      end
    end
  end
end

function M.IsRooted()
  local status, var = pcall(vim.api.nvim_buf_get_var, 0, 'rootDir')
  return status and not isEmpty(var)
end

function M.GetRoot()
  local status, root = pcall(vim.api.nvim_buf_get_var, 0, 'rootDir')
  if not status then
    return ''
  end
  -- TODO: Likely not portable or even correct
  root = string.gsub(root, os.getenv("HOME"), '~', 1)
  if root == nil then
    return ''
  end
  return root
end

function M.setup()
  register_au()
end

return M

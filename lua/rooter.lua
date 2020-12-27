local M = {}

local api = vim.api
local path = require('utils.path')

local function register_au()
  vim.api.nvim_command("augroup luarooter")
  vim.api.nvim_command("autocmd!")
  vim.api.nvim_command("autocmd VimEnter,BufReadPost,BufEnter * lua require'rooter'.root()")
  vim.api.nvim_command("autocmd BufWritePost * nested lua vim.api.nvim_buf_set_var(0, 'rootDir', '')")
  vim.api.nvim_command("augroup END")
end

function M.root()
  local buf_dir = vim.fn.expand('%')
  local root_pattern = path.root_pattern {'.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'Cargo.toml'}
  local root_path = root_pattern(buf_dir)
  local _, current_root = pcall(api.nvim_buf_get_var, 0, 'rootDir')

  if root_path and current_root then
    api.nvim_buf_set_var(0, 'rootDir', root_path)
    api.nvim_command("cd " .. root_path)
  end
end

function M.setup()
  register_au()
end

return M

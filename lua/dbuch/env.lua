M = {}

---comment
---@param what string
---@return string|string[]|nil
function Normalized_stdpath(what)
  local path = vim.fn.stdpath(what)
  if path == nil then
    return nil
  end

  if type(path) == 'string' then
    return vim.fs.normalize(path)
  end

  local paths = {}
  for _, value in ipairs(path) do
    path = vim.fs.normalize(value)
    table.insert(paths, path)
  end
  return paths
end

---@type boolean
M.is_unix = vim.loop.os_uname().sysname:match 'Windows' == nil
---@type string|string[]|nil
M.cache_dir = Normalized_stdpath 'cache'
---@type string|string[]|nil
M.data_dir = Normalized_stdpath 'data'
---@type string|string[]|nil
M.log_dir = Normalized_stdpath 'log'
---@type string|string[]|nil
M.undo_dir = M.cache_dir .. '/undodir/'

return M

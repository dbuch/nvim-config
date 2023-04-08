M = {}

M.is_windws = vim.loop.os_uname().sysname:match 'Windows'

M.cache = function()
  return vim.fn.stdpath 'cache'
end

M.data = function()
  return vim.fn.stdpath 'data'
end

M.log = function()
  return vim.fn.stdpath 'log'
end

return M

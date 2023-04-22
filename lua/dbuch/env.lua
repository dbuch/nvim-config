M = {}

---@type boolean
M.is_unix = vim.loop.os_uname().sysname:match('Windows') == nil
---@type string
M.cache_dir = vim.fs.normalize (vim.fn.stdpath 'cache')
---@type string
M.data_dir = vim.fs.normalize (vim.fn.stdpath 'data')
---@type string
M.log_dir = vim.fs.normalize (vim.fn.stdpath 'log')
---@type string
M.undo_dir = vim.fs.normalize(M.cache_dir .. '/undodir/')

return M

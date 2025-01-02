---@type vim.lsp.Config
return {
  cmd = { 'nu', '--lsp' },
  filetypes = { 'nu' },
  root_dir = function(cb)
    cb(vim.fn.getcwd())
  end,
}

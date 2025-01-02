---@type vim.lsp.Config
return {
  cmd = { 'vscode-json-languageserver', '--stdio' },
  filetypes = { 'json' },
  root_dir = function(cb)
    cb(vim.fn.getcwd())
  end,
}

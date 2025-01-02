---@type vim.lsp.Config
return {
  cmd = { 'vscode-css-languageserver', '--stdio' },
  filetypes = { 'css' },
  root_dir = function(cb)
    cb(vim.fn.getcwd())
  end,
}

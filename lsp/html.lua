---@type vim.lsp.Config
return {
  cmd = { 'vscode-html-languageserver', '--stdio' },
  filetypes = { 'html' },
  root_dir = function(cb)
    cb(vim.fn.getcwd())
  end,
}

local enabled_lsps = {
  -- Data/Exchangeable formats ls
  'html',
  'jsonls',
  'cssls',
  'taplo',

  -- Programming
  'clangd',
  'lua_ls',
  -- 'omnisharp',
  'pyright',
  'ruff',
  'zls',
  -- 'omnisharp',
  -- 'wgsl_analyzer',
  -- 'ts_ls',

  -- Shell
  'nushell',
  'bashls',
}

vim.lsp.config('*', {
  root_markers = { '.git' },
})

vim.lsp.enable(enabled_lsps)

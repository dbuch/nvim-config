require("project_nvim").setup({
  manual_mode = false,
  detection_methods = { "lsp", "patterns" },
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "Cargo.toml" },
  ignore_lsp = {},
  exclude_dirs = { "~/.local/share/*", "~/.rustup/toolchains/*", "~/.cargo/*", "/", "~/" },
  show_hidden = false,
  silent_chdir = true,
  datapath = vim.fn.stdpath("data"),
})

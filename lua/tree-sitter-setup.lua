local M = {}

function M.config()
  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      "c",
      "rust",
      "cpp",
      "lua",
      "css",
      "html",
      "javascript",
      "bash",
    },
    indent = {
      'enabled'
    }
  }
  vim.cmd [[:TSUpdate]]
end

return M

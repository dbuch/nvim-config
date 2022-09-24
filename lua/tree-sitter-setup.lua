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
      "glsl",
    },
    indent = {
      'enabled'
    },
    matchup = {
      enable = true,
    }
  }
end

return M

local M = {}

function M.config()
  require("gitsigns").setup {
    watch_gitdir = {
      enabled = true,
      interval = 1000
    }
  }
end

return M

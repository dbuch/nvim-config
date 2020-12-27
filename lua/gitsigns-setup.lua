local M = {}

function M.config()
  require("gitsigns").setup {
    signs = {
      add          = {hl = 'DiffAdd'   , text = '+'},
      change       = {hl = 'DiffChange', text = '!'},
      delete       = {hl = 'DiffDelete', text = '_'},
      topdelete    = {hl = 'DiffDelete', text = '_'},
      changedelete = {hl = 'DiffChange', text = '~'},
    },
    watch_index = {
      enabled = true,
      interval = 1000
    }
  }
end

return M

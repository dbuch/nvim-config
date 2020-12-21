local M = {}

function M.setup()

end

function M.config()
  local telescope = require('telescope')
  local telescope_actions = require('telescope.actions')
  telescope.setup {
    defaults = {
      mappings = {
        i = {
          ["<M-j>"] = telescope_actions.move_selection_next,
          ["<M-k>"] = telescope_actions.move_selection_previous,
        },
      },
    }
  }
end

return M

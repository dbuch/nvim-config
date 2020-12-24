local M = {}

function M.setup()
end

function M.config()
  local telescope = require('telescope')
  local telescope_actions = require('telescope.actions')
  local sorters = require("telescope.sorters")


  telescope.setup {
    defaults = {
      mappings = {
        i = {
          ["<M-j>"] = telescope_actions.move_selection_next,
          ["<M-k>"] = telescope_actions.move_selection_previous,
        },
      },
      layout_strategy = "flex",
      layout_default = {
        horizontal = {
          width_padding = 0.1,
          height_padding = 0.1,
          preview_width = 0.6,
        },
        vertical = {
          width_padding = 0.05,
          height_padding = 1,
          preview_width = 0.5,
        },
      },
      preview_cutoff = 100,
      file_sorter = sorters.get_fzy_sorter,
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
  }
  telescope.load_extension('dap')
end

return M

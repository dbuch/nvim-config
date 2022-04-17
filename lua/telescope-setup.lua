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
      file_sorter = sorters.get_fzy_sorter,
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,

      },

      ["ui-select"] = {
        require("telescope.themes").get_cursor {
          -- even more opts
        }
      },

      frecency = {
        show_scores = false,
        show_unindexed = true,
        ignore_patterns = {"*.git/*", "*/tmp/*"},
        disable_devicons = false,
        workspaces = {
          ["conf"]    = "/home/$USER/.config",
          ["data"]    = "/home/$USER/.local/share",
          ["project"] = "/home/$USER/projects",
          ["wiki"]    = "/home/$USER/wiki"
        }
      }
    },
  }
  telescope.load_extension('dap')
  telescope.load_extension('fzy_native')
  telescope.load_extension('frecency')
  telescope.load_extension('projects')
  telescope.load_extension('ui-select')
end

return M

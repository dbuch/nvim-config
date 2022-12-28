local telescope = require 'telescope'
local telescope_actions = require 'telescope.actions'
local sorters = require 'telescope.sorters'

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<M-j>'] = telescope_actions.move_selection_next,
        ['<M-k>'] = telescope_actions.move_selection_previous,
      },
    },
    layout_strategy = 'flex',
    -- file_sorter = sorters.get_fzy_sorter,
  },

  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_cursor {
        -- even more opts
      },
    },
  },
}

telescope.load_extension 'fzf'
telescope.load_extension 'projects'

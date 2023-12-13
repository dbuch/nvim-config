return {
  {
    'nvim-lua/telescope.nvim',
    cmd = 'Telescope',
    version = false,
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
    },
    opts = function(_, opts)
      local telescope_actions = require 'telescope.actions'
      opts.defaults = {
        mappings = {
          i = {
            ['<M-j>'] = telescope_actions.move_selection_next,
            ['<M-k>'] = telescope_actions.move_selection_previous,
          },
        },
        layout_strategy = 'flex',
        file_ignore_patterns = { '!cargo-targets' },
        -- file_sorter = sorters.get_fzy_sorter,
      }

      opts.extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
        ['ui-select'] = {
          require('telescope.themes').get_cursor {
            -- even more opts
          },
        },
      }
    end,
    config = function(_, opts)
      require('telescope').load_extension 'fzf'
      require('telescope').setup(opts)
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'LazyFile' },
    opts = {
      debug_mode = false,
      max_file_length = 100000,
      signs = {
        add = { show_count = false },
        change = { show_count = false },
        delete = { show_count = true },
        topdelete = { show_count = true },
        changedelete = { show_count = true },
      },
      preview_config = {
        border = 'rounded',
      },
      count_chars = require('dbuch.icons').subscript_count,
      update_debounce = 50,
      _extmark_signs = true,
      _threaded_diff = true,
      word_diff = true,
      trouble = true,
    },
  },
  {
    'lewis6991/cleanfold.nvim',
    event = 'LazyFile',
  },
  {
    'lewis6991/foldsigns.nvim',
    event = 'LazyFile',
    opts = {
      exclude = { 'GitSigns.*' },
    },
  },
  {
    'folke/trouble.nvim',
    version = '*',
    opts = { use_diagnostic_signs = true },
    cmd = { 'TroubleToggle', 'Trouble' },
  },
  {
    'akinsho/toggleterm.nvim',
    cmd = 'ToggleTerm',
    opts = {
      shade_terminals = false,
      shell = 'nu',
    },
  },
  {
    'sindrets/diffview.nvim',
    cmd = {
      'DiffviewOpen',
      'DiffviewClose',
      'DiffviewToggleFiles',
      'DiffviewFocusFiles',
      'DiffviewRefresh',
      'DiffviewFileHistory',
    },
    opts = {},
  },
  {
    'lewis6991/hover.nvim',
    keys = {
      { 'K', '<Cmd>Hover<cr>' },
      { 'gK', '<Cmd>HoverSelect<cr>' },
    },
    config = function()
      vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
      vim.keymap.set('n', 'gK', require('hover').hover_select, { desc = 'hover.nvim (select)' })
      require('hover').setup {
        init = function()
          require 'hover.providers.lsp'
          --require('hover.providers.gh')
          require 'hover.providers.dictionary'
          --require('hover.providers.diagnostic')
          require 'hover.providers.man'
        end,
      }
    end,
  },
  {
    'echasnovski/mini.files',
    -- event = 'VeryLazy',
    lazy = false,
    version = false,
    opts = {
      content = {
        filter = function(fs_entry)
          ---@type string
          local basename = fs_entry.name
          if basename:sub(0, 1) == '.' then
            if basename:match '%.config' or basename:match '%.git' then
              return true
            end
            return false
          end
          return true
        end,
      },
      windows = {
        max_number = 3,
      },
    },
  },
  {
    'echasnovski/mini.cursorword',
    event = 'LazyFile',
    version = false,
    opts = {},
  },
  -- {
  --   'echasnovski/mini.colors',
  --   lazy = false,
  --   version = false,
  --   opts = {},
  -- },
  {
    'lewis6991/whatthejump.nvim',
    event = 'LazyFile',
    config = function()
      -- Jump backwards
      vim.keymap.set('n', '<M-k>', function()
        require('whatthejump').show_jumps(false)
        return '<C-o>'
      end, { expr = true })

      -- Jump forwards
      vim.keymap.set('n', '<M-j>', function()
        require('whatthejump').show_jumps(true)
        return '<C-i>'
      end, { expr = true })
    end,
  },
  {
    'brenoprata10/nvim-highlight-colors',
    cmd = { 'HighlightColorsOn', 'HighlightColorsOff', 'HighlightColorsToggle' },
    config = true,
  },
}

return {
  {
    'nvim-lua/telescope.nvim',
    cmd = 'Telescope',
    version = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'rcarriga/nvim-notify',
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
      require('telescope').load_extension 'notify'
      require('telescope').setup(opts)
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      debug_mode = false,
      max_file_length = 1000000000,
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
      count_chars = {
        '⒈',
        '⒉',
        '⒊',
        '⒋',
        '⒌',
        '⒍',
        '⒎',
        '⒏',
        '⒐',
        '⒑',
        '⒒',
        '⒓',
        '⒔',
        '⒕',
        '⒖',
        '⒗',
        '⒘',
        '⒙',
        '⒚',
        '⒛',
      },
      update_debounce = 50,
      _extmark_signs = true,
      _threaded_diff = true,
      word_diff = true,
      trouble = true,
    },
  },
  {
    'lewis6991/cleanfold.nvim',
    event = 'VeryLazy',
  },
  {
    'lewis6991/foldsigns.nvim',
    event = 'VeryLazy',
    opts = {
      exclude = { 'GitSigns.*' },
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = 'Neotree',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    opts = {
      filesystem = {
        bind_to_cwd = true,
        follow_current_file = true,
        hijack_netrw_behavior = 'disabled',
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
      },
    },
  },
  -- {
  --   'stevearc/oil.nvim',
  --   event = "BufEnter",
  --   config = true,
  -- },
  -- {
  --   'nvim-tree/nvim-tree.lua',
  --   commit = '8b8d457',
  --   cmd = 'NvimTreeFindFileToggle',
  --   dependencies = {
  --     'nvim-tree/nvim-web-devicons',
  --   },
  --   opts = {
  --     sync_root_with_cwd = true,
  --     respect_buf_cwd = true,
  --     update_focused_file = {
  --       enable = true,
  --       update_root = false,
  --     },
  --     view = {
  --       number = false,
  --       signcolumn = 'no',
  --     },
  --   },
  -- },
  {
    'simrat39/symbols-outline.nvim',
    cmd = 'SymbolsOutline',
    config = true,
  },
  {
    'folke/trouble.nvim',
    version = '*',
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
    'lewis6991/satellite.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },
  {
    'luukvbaal/statuscol.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      setopt = true,
    },
  },
  {
    'AndrewRadev/bufferize.vim',
    cmd = 'Bufferize',
    config = function()
      vim.g.bufferize_command = 'enew'
      local grp = vim.api.nvim_create_augroup('vimrc', {})
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'bufferize',
        group = grp,
        callback = function()
          vim.opt_local.wrap = true
        end,
      })
    end,
  },
  {
    'lewis6991/hover.nvim',
    keys = {
      { 'K',  '<Cmd>Hover<cr>' },
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
    'echasnovski/mini.surround',
    version = false,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('mini.surround').setup()
    end,
  },
  {
    'echasnovski/mini.align',
    version = false,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('mini.align').setup()
    end,
  },
  {
    -- TODO(Perhaps?): https://github.com/isaksamsten/nvim-config/blob/1500077595ac4848624c25f940f65706b1136813/lua/plugins/tasks.lua
    'stevearc/overseer.nvim',
    cmd = { 'OverseerRun', 'OverseerToggle' },
    dependencies = {
      'akinsho/toggleterm.nvim',
      'rcarriga/nvim-notify',
      'stevearc/dressing.nvim',
      'nvim-lua/telescope.nvim',
    },
    opts = {
      strategy = {
        "toggleterm",
        -- load your default shell before starting the task
        use_shell = false,
        -- overwrite the default toggleterm "direction" parameter
        direction = nil,
        -- overwrite the default toggleterm "highlights" parameter
        highlights = nil,
        -- overwrite the default toggleterm "auto_scroll" parameter
        auto_scroll = nil,
        -- have the toggleterm window close automatically after the task exits
        close_on_exit = false,
        -- open the toggleterm window when a task starts
        open_on_start = true,
        -- mirrors the toggleterm "hidden" parameter, and keeps the task from
        -- being rendered in the toggleable window
        hidden = false,
        -- command to run when the terminal is created. Combine with `use_shell`
        -- to run a terminal command before starting the task
        on_create = nil,
      }
    },
    config = true
  }
}

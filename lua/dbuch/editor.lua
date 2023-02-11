return {
  {
    'nvim-lua/telescope.nvim',
    cmd = 'Telescope',
    version = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
          --TODO: telescope.load_extension 'projects'
          require('telescope').load_extension 'fzf'
        end,
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
        -- file_sorter = sorters.get_fzy_sorter,
      }

      opts.extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_cursor {
            -- even more opts
          },
        },
      }
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
    },
  },
  {
    'nvim-tree/nvim-tree.lua',
    cmd = 'NvimTreeFindFileToggle',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      open_on_setup = false,
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
    },
  },
  {
    'simrat39/symbols-outline.nvim',
    opts = {
      highlight_hovered_item = true,
      show_guides = true,
      auto_preview = false,
      position = 'right',
      relative_width = true,
      width = 25,
      auto_close = false,
      show_numbers = false,
      show_relative_numbers = false,
      show_symbol_details = true,
      preview_bg_highlight = 'Pmenu',
      autofold_depth = nil,
      auto_unfold_hover = true,
      fold_markers = { '', '' },
      wrap = false,
      keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = { '<Esc>', 'q' },
        goto_location = '<Cr>',
        focus_location = 'o',
        hover_symbol = '<C-space>',
        toggle_preview = 'K',
        rename_symbol = 'r',
        code_actions = 'a',
        fold = 'h',
        unfold = 'l',
        fold_all = 'W',
        unfold_all = 'E',
        fold_reset = 'R',
      },
      lsp_blacklist = {},
      symbol_blacklist = {},
      symbols = {
        File = { icon = '', hl = 'TSURI' },
        Module = { icon = '', hl = 'TSNamespace' },
        Namespace = { icon = '', hl = 'TSNamespace' },
        Package = { icon = '', hl = 'TSNamespace' },
        Class = { icon = '𝓒', hl = 'TSType' },
        Method = { icon = 'ƒ', hl = 'TSMethod' },
        Property = { icon = '', hl = 'TSMethod' },
        Field = { icon = '', hl = 'TSField' },
        Constructor = { icon = '', hl = 'TSConstructor' },
        Enum = { icon = 'ℰ', hl = 'TSType' },
        Interface = { icon = 'ﰮ', hl = 'TSType' },
        Function = { icon = '', hl = 'TSFunction' },
        Variable = { icon = '', hl = 'TSConstant' },
        Constant = { icon = '', hl = 'TSConstant' },
        String = { icon = '𝓐', hl = 'TSString' },
        Number = { icon = '#', hl = 'TSNumber' },
        Boolean = { icon = '⊨', hl = 'TSBoolean' },
        Array = { icon = '', hl = 'TSConstant' },
        Object = { icon = '⦿', hl = 'TSType' },
        Key = { icon = '🔐', hl = 'TSType' },
        Null = { icon = 'NULL', hl = 'TSType' },
        EnumMember = { icon = '', hl = 'TSField' },
        Struct = { icon = '𝓢', hl = 'TSType' },
        Event = { icon = '🗲', hl = 'TSType' },
        Operator = { icon = '+', hl = 'TSOperator' },
        TypeParameter = { icon = '𝙏', hl = 'TSParameter' },
      },
    },
  },
  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    opts = {
      position = 'bottom', -- position of the list can be: bottom, top, left, right
      height = 10, -- height of the trouble list when position is top or bottom
      width = 50, -- width of the list when position is left or right
      icons = true, -- use devicons for filenames
      mode = 'workspace_diagnostics', -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
      fold_open = '', -- icon used for open folds
      fold_closed = '', -- icon used for closed folds
      group = true, -- group results by file
      padding = true, -- add an extra new line on top of the list
      action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = 'q', -- close the list
        cancel = '<esc>', -- cancel the preview and get back to your last window / buffer / cursor
        refresh = 'r', -- manually refresh
        jump = { '<cr>', '<tab>' }, -- jump to the diagnostic or open / close folds
        open_split = { '<c-x>' }, -- open buffer in new split
        open_vsplit = { '<c-v>' }, -- open buffer in new vsplit
        open_tab = { '<c-t>' }, -- open buffer in new tab
        jump_close = { 'o' }, -- jump to the diagnostic and close the list
        toggle_mode = 'm', -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = 'P', -- toggle auto_preview
        hover = 'K', -- opens a small popup with the full multiline message
        preview = 'p', -- preview the diagnostic location
        close_folds = { 'zM', 'zm' }, -- close all folds
        open_folds = { 'zR', 'zr' }, -- open all folds
        toggle_fold = { 'zA', 'za' }, -- toggle fold of current file
        previous = 'k', -- previous item
        next = 'j', -- next item
      },
      indent_lines = true, -- add an indent guide below the fold icons
      auto_open = false, -- automatically open the list when you have diagnostics
      auto_close = true, -- automatically close the list when you have no diagnostics
      auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
      auto_fold = false, -- automatically fold a file trouble list at creation
      auto_jump = { 'lsp_definitions' }, -- for the given modes, automatically jump if there is only a single result
    },
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
      setopt = true
    }
  },
}

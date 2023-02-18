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
        config = function(_, _)
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
      word_diff = false,
    },
  },
  {
    'lewis6991/cleanfold.nvim',
    config = true,
  },
  {
    'lewis6991/foldsigns.nvim',
    opts = {
      exclude = { 'GitSigns.*' },
    },
  },
  {
    'nvim-tree/nvim-tree.lua',
    commit = '8b8d457',
    cmd = 'NvimTreeFindFileToggle',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      view = {
        number = false,
        signcolumn = "no"
      }
    },
  },
  {
    'simrat39/symbols-outline.nvim',
    cmd = 'SymbolsOutline',
    config = true,
  },
  {
    'folke/trouble.nvim',
    version = "*",
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
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'bufferize',
        group = 'vimrc',
        callback = function()
          vim.opt_local.wrap = true
        end,
      })
    end,
  },
  {
    dir = '~/dev/nvim/hover.nvim/',
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
}

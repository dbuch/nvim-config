-- 'rafamadriz/friendly-snippets',

-- {
--   'ahmedkhalf/project.nvim',
--   init = function()
--     require('lazy').load { plugins = { 'project.nvim' } }
--   end,
--   cmd = 'Telescope projects',
--   opts = {
--     manual_mode = false,
--     detection_methods = { 'lsp', 'patterns' },
--     patterns = {
--       '.git',
--       '_darcs',
--       '.hg',
--       '.bzr',
--       '.svn',
--       'Makefile',
--       'package.json',
--       'Cargo.toml',
--     },
--     ignore_lsp = {},
--     exclude_dirs = {
--       '~/.local/share/*',
--       '~/.rustup/toolchains/*',
--       '~/.cargo/*',
--       '/',
--       '~/',
--     },
--     show_hidden = false,
--     silent_chdir = true,
--     datapath = vim.fn.stdpath 'data',
--   },
--   config = function(_, opts)
--     require('project_nvim').setup(opts)
--   end,
-- },

return {
  -- Init
  {
    'stevearc/dressing.nvim',
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.input(...)
      end
    end,
  },
  {
    'rcarriga/nvim-notify',
    init = function()
      require('lazy').load { plugins = { 'nvim-notify' } }
    end,
    config = function()
      vim.notify = require 'notify'
    end,
  },
  -- Editor
  -- Dap
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'mfussenegger/nvim-dap-python',
    },
  },
  { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap' } },
  -- Buffer
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
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup {
        check_ts = true,
      }
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
    dependencies = {
      'hrsh7th/nvim-cmp',
      'nvim-treesitter/nvim-treesitter',
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
  -- Coloring
  {
    'lewis6991/nvim-colorizer.lua',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      RGB = true,
      RRGGBB = true,
      names = true,
      RRGGBBAA = false,
      rgb_fn = false,
      hsl_fn = false,
      css = false,
      css_fn = false,
      mode = 'background', -- Set the display mode.
    },
    -- config = function()
    --   require('colorizer').setup()
    -- end,
  },
  -- LSP
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'ray-x/lsp_signature.nvim',
      'onsails/lspkind-nvim',
      {
        'j-hui/fidget.nvim',
        config = function()
          require('fidget').setup {
            text = {
              spinner = 'dots',
            },
            fmt = {
              stack_upwards = false,
              task = function(task_name, message, percentage)
                local pct = percentage and string.format(' (%s%%)', percentage) or ''
                if task_name then
                  return string.format('%s%s [%s]', message, pct, task_name)
                else
                  return string.format('%s%s', message, pct)
                end
              end,
            },
            sources = {
              ['null-ls'] = {
                ignore = true,
              },
            },
          }
        end,
      },
    },
    config = function()
      require 'dbuch.lsp'
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    version = false,
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
      'f3fora/cmp-spell',
      {
        'saecki/crates.nvim',
        event = 'BufRead Cargo.toml',
        config = true,
      },
    },
    config = function()
      require 'dbuch.cmp'
    end,
  },
  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      require 'dbuch.treesitter'
    end,
  },
}

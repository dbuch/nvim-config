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
    opts = {
      check_ts = true,
    },
    config = function(plug, opts)
      require('nvim-autopairs').setup(opts)
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
    dependencies = {
      'hrsh7th/nvim-cmp',
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

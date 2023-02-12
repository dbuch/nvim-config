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

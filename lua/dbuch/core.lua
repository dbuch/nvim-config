return {
  -- Core
  { 'folke/lazy.nvim', version = '*' },
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
}

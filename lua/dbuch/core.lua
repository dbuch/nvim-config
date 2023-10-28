return {
  -- Core
  {
    'folke/lazy.nvim',
    version = '*',
  },
  {
    'stevearc/dressing.nvim',
    lazy = false,
    config = true,
  },
  {
    'luukvbaal/statuscol.nvim',
    lazy = false,
    opts = {
      setopt = true,
    },
  },
  {
    'lewis6991/github_dark.nvim',
    lazy = false,
    config = function()
      vim.cmd.color 'github_dark'
    end,
  },
  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    opts = {
      render = 'compact',
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    config = function(_spec, _opts)
      vim.notify = require 'notify'
    end,
    init = function()
      require('dbuch.traits.nvim').defer_notify()
    end,
  },
}

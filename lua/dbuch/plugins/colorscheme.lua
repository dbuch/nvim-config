---@module 'lazy'
---@type LazyPluginSpec[]
return {
  {
    'lewis6991/github_dark.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.color 'github_dark'
    end,
  },
}

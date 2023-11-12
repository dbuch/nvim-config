return {
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'luukvbaal/statuscol.nvim',
    event = 'VeryLazy',
    -- lazy = false,
    opts = {
      setopt = true,
    },
  },
  {
    'j-hui/fidget.nvim',
    event = 'VeryLazy',
    opts = {
      notification = {
        override_vim_notify = true,
        window = {
          normal_hl = 'Normal',
          align_bottom = false,
        },
      },
    },
  },
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  { 'MunifTanjim/nui.nvim', lazy = true },
  { 'nvim-lua/plenary.nvim', lazy = true },
}

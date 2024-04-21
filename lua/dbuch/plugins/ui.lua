return {
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {
      input = {
        insert_only = false,
        start_in_insert = false,
      },
    },
  },
  {
    'luukvbaal/statuscol.nvim',
    branch = '0.10',
    event = 'VeryLazy',
    -- lazy = false,
    config = function(_, _)
      local builtin = require 'statuscol.builtin'
      local lnum_func = function(args)
        if args.rnu ~= 0 and not args.nu then
          return ''
        end

        if args.virtnum ~= 0 then
          return '%='
        end

        local highlight = ((args.relnum % 10 > 0) and '%#CurrentLineNr#' or '%#Normal#')

        if args.relnum == 0 then
          return highlight .. '%l%='
        else
          return highlight .. '%=%r'
        end
      end

      require('statuscol').setup {
        setopt = true,
        segments = {
          { text = { '%C' }, click = 'v:lua.ScFa' },
          { text = { '%s' }, click = 'v:lua.ScSa' },
          {
            text = { lnum_func, ' ' },
            condition = { true, builtin.not_empty },
            click = 'v:lua.ScLa',
          },
        },
      }
    end,
  },
  {
    'j-hui/fidget.nvim',
    event = 'VeryLazy',
    opts = {
      progress = {
        poll_rate = 400,
        ignore_done_already = true,
        ignore_empty_message = true,
        lsp = {
          progress_ringbuf_size = 2048,
        },
      },
      notification = {
        override_vim_notify = true,
        window = {
          normal_hl = 'Normal',
        },
      },
    },
  },
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  { 'MunifTanjim/nui.nvim', lazy = true },
  { 'nvim-lua/plenary.nvim', lazy = true },
}

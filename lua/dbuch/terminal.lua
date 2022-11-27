require('toggleterm').setup {
  shade_terminals = false,
  shell = 'nu',
}
-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function(args)
    if string.match(args.match, '#toggleterm') then
      local opts = { buffer = args.buf }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    end
  end,
})

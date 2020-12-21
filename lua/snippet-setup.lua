local M = {}

function M.config()
  local snip_plug = require("snippets")
  snip_plug.set_ux(require'snippets.inserters.floaty')

  local opts = {noremap = true, silent = true}
  vim.api.nvim_set_keymap("i", "<Tab>", "<cmd>lua require'snippets'.expand_or_advance(1)<CR>",  opts)
  vim.api.nvim_set_keymap("i", "<S-Tab>", "<cmd>lua require'snippets'.expand_or_advance(-1)<CR>", opts)
end

return M


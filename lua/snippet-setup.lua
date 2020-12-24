local M = {}

function M.setup()
end

function M.config()
  local snip_plug = require("snippets")
  --snip_plug.set_ux(require'snippets.inserters.floaty')
  snip_plug.set_ux(require'snippet-inserter')

  vim.g.completion_enable_snippet = 'snippets.nvim'
  vim.g.completion_auto_change_source = 1
end

return M


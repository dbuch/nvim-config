local null_ls = require("null-ls")
null_ls.setup({
  -- on_init = function(client, _)
  --   client.offset_encoding = "utf-32"
  -- end,
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.completion.spell,
  },
})

local mapping = {}
function table.merge(dest, src)
  for k, v in pairs(src) do
    dest[k] = v
  end
  return dest
end

function mapping.map(mode, key, result, opts)
  opts =
    table.merge(
    {
      noremap = true,
      silent = true,
      expr = false
    },
    opts or {}
  )

  vim.api.nvim_set_keymap(mode, key, result, opts)
end

function mapping.maplua(mode, key, result, opts)
  mapping.map(mode, key, "<cmd> lua " .. result .. "<CR>", opts)
end

return mapping

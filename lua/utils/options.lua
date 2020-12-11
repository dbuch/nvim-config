local api = vim.api
local options = {}
function options.set(opts_table)
  for k, v in pairs(opts_table) do
    local ok, _ = pcall(api.nvim_get_option, k)
    if ok then
      vim.o[k] = v
    else
      print("Couldn't insert in option")
    end
  end
end

function options.setw(opts_table)
  for k, v in pairs(opts_table) do
    if vim.wo[k] ~= nil then
      vim.wo[k] = v
    end
  end
end

function options.setg(opts_table)
  for k, v in pairs(opts_table) do
    vim.g[k] = v
  end
end

function options.setenv(opts_table)
  for k, v in pairs(opts_table) do
    vim.env[k] = v
  end
end

return options

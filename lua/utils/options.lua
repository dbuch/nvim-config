local api = vim.api
local options = {}
function options.set(opts_table)
  for k, v in pairs(opts_table) do
      vim.opt[k] = v
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

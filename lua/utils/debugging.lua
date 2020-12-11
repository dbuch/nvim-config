local debugging = {}
local epoch = {}

function debugging.Print(...)
  if select("#", ...) == 1 then
    vim.api.nvim_out_write(vim.inspect((...)))
  else
    vim.api.nvim_out_write(vim.inspect {...})
  end
  vim.api.nvim_out_write("\n")
end


function epoch.ms()
	local s, ns = vim.loop.gettimeofday()
	return s * 1000 + math.floor(ns / 1000)
end

function epoch.ns()
	local s, ns = vim.loop.gettimeofday()
	return s * 1000000 + ns
end

local debug = {
  debugging = debugging,
  epoch = epoch
}

return debug

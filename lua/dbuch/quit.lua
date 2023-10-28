local api = vim.api

local smart_quit = function()
end

api.nvim_create_user_command('SmartQuit', smart_quit, {})

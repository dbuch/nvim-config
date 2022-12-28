local api = vim.api

local function buf_is_modified(buf)
  return api.nvim_buf_get_option(buf, 'modified')
end

local function win_is_last()
  local n_wins = #api.nvim_list_wins()
  vim.pretty_print(n_wins)
  return #api.nvim_list_wins() == 1
end

local function buf_is_redundant(buf)
  local empty_line = true
  local lines = api.nvim_buf_get_lines(buf, 0, -1, false)
  if #lines == 0 then
    return empty_line
  end

  for _, line in ipairs(lines) do
    if not line:len() == 0 then
      empty_line = false
    end
  end
  return empty_line
end

local function wins_contain_current(current_buf)
  local current_win = api.nvim_get_current_win()
  local wins = api.nvim_list_wins()
  for _, win in ipairs(wins) do
    if current_win ~= win and api.nvim_win_get_buf(win) == current_buf then
      return true
    end
  end
  return false
end

local smart_quit = function()
  local current_win = api.nvim_get_current_win()
  local current_buf = api.nvim_win_get_buf(current_win)

  local win_should_quit = wins_contain_current(current_buf)
  if win_should_quit then
    api.nvim_win_close(current_win, false)
  elseif buf_is_modified(current_buf) and buf_is_redundant(current_buf) and not win_is_last() then
    api.nvim_win_close(current_win, false)
  else
    api.nvim_buf_delete(current_buf, {})
  end
end

vim.api.nvim_create_user_command('SmartQuit', smart_quit, {})

local M = {}

M.use_lazy_file = true
M.lazy_file_events = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
  local Config = require 'lazy.core.config'
  if Config.plugins[name] and Config.plugins[name]._.loaded then
    fn(name)
  else
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyLoad',
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

-- delay notifications till vim.notify was replaced or after 500ms
function M.lazy_notify()
  local notifs = {}
  local function temp(...)
    table.insert(notifs, vim.F.pack_len(...))
  end

  local orig = vim.notify
  vim.notify = temp

  local timer = vim.loop.new_timer()
  local check = assert(vim.loop.new_check())

  local replay = function()
    timer:stop()
    check:stop()
    if vim.notify == temp then
      vim.notify = orig -- put back the original notify if needed
    end
    vim.schedule(function()
      ---@diagnostic disable-next-line: no-unknown
      for _, notif in ipairs(notifs) do
        vim.notify(vim.F.unpack_len(notif))
      end
    end)
  end

  -- wait till vim.notify has been replaced
  check:start(function()
    if vim.notify ~= temp then
      replay()
    end
  end)
  -- or if it took more than 500ms, then something went wrong
  timer:start(500, 0, replay)
end

function M.on_very_lazy(fn)
  vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
      fn()
    end,
  })
end

function M.initialize_lazyfile()
  M.use_lazy_file = M.use_lazy_file and vim.fn.argc(-1) > 0

  local Event = require 'lazy.core.handler.event'

  if M.use_lazy_file then
    Event.mappings.LazyFile = { id = 'LazyFile', event = 'User', pattern = 'LazyFile' }
    Event.mappings['User LazyFile'] = Event.mappings.LazyFile
  else
    Event.mappings.LazyFile = { id = 'LazyFile', event = M.lazy_file_events }
    Event.mappings['User LazyFile'] = Event.mappings.LazyFile
    return
  end

  local done = false
  local events = {}
  local function load()
    if #events == 0 or done then
      return
    end
    done = true
    vim.api.nvim_del_augroup_by_name 'lazy_file'

    ---@type table<string, string[]>
    local skips = {}
    for _, event in ipairs(events) do
      skips[event.event] = skips[event.event] or Event.get_augroups(event.even)
    end

    vim.api.nvim_exec_autocmds('User', { pattern = 'LazyFile', modeline = false })
    ---@diagnostic disable-next-line: no-unknown
    for _, event in ipairs(events) do
      if vim.api.nvim_buf_is_valid(event.buf) then
        Event.trigger {
          event = event.event,
          exclude = skips[event.event],
          data = event.data,
          buf = event.buf,
        }
        if vim.bo[event.buf].filetype then
          Event.trigger {
            event = 'FileType',
            buf = event.buf,
          }
        end
      end
    end
    vim.api.nvim_exec_autocmds('CursorMoved', { modeline = false })
    events = {}
  end

  load = vim.schedule_wrap(load)

  vim.api.nvim_create_autocmd(M.lazy_file_events, {
    group = vim.api.nvim_create_augroup('lazy_file', { clear = true }),
    callback = function(event)
      table.insert(events, event)
      load()
    end,
  })
end

return M

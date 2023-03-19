local M = {}

M.root_patterns = { '.git', 'Cargo.toml', 'stylua.toml' }

---@type string?
M.current_root = nil

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

---comment
---@param base string?
---@param file string?
---@return boolean
function M.is_ancestor(base, file)
  if base == nil or file == nil then
    return false
  end

  local base_tokens = vim.split(base, '/')
  local file_tokens = vim.split(file, '/')

  if #base_tokens < #file_tokens then
    return false
  end

  for i, token in ipairs(base_tokens) do
    if file_tokens[i] ~= token then
      return false
    end
  end

  return true
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@param path string?
---@return string
function M.get_root(path)
  ---@type string?
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local wsf = client.config.workspace_folders
      local paths = wsf and vim.tbl_map(function(ws)
            return vim.uri_to_fname(ws.uri)
          end, wsf) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        ---@type string?
        local r = vim.loop.fs_realpath(p)
        if r ~= nil then
          if path:find(r, 1, true) then
            roots[#roots + 1] = r
          end
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
end

-- delay notifications till vim.notify was replaced or after 500ms
function M.defer_notify()
  local notifs = {}
  local function temp(...)
    table.insert(notifs, vim.F.pack_len(...))
  end

  local orig = vim.notify
  vim.notify = temp

  local timer = vim.loop.new_timer()
  local check = vim.loop.new_check()

  local replay = function()
    ---@diagnostic disable-next-line: need-check-nil
    timer:stop()
    ---@diagnostic disable-next-line: need-check-nil
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
  ---@diagnostic disable-next-line: need-check-nil
  check:start(function()
    if vim.notify ~= temp then
      replay()
    end
  end)
  -- or if it took more than 500ms, then something went wrong
  ---@diagnostic disable-next-line: need-check-nil
  timer:start(500, 0, replay)
end

M.has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

function M.DefineSigns(t)
  for name, text in pairs(t) do
    vim.fn.sign_define(name, { text = text, texthl = name })
  end
end

return M

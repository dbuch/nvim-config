local M = {}

M.root_patterns = { '.git', 'Cargo.toml', 'stylua.toml' }

function M.augroup(name)
  return vim.api.nvim_create_augroup('dbuch_' .. name, { clear = true })
end

---@param cb fun(client:vim.lsp.Client, buffer:integer)
function M.on_attach(cb)
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      ---@type integer
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client ~= nil then
        cb(client, buffer)
      end
    end,
  })
end

---@return boolean
function M.is_file_opened()
  return vim.fn.argc(-1) == 0
end

---comment
---@param base string?
---@param file string?
---@return boolean
function M.is_ancestor(base, file)
  if base == nil or file == nil then
    return false
  end

  if base == file then
    return true
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

---@type Map<string, string>
M.root_cache = {}

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@param path string?
---@return string
function M.get_root(path)
  ---@type string?
  path = path ~= '' and vim.loop.fs_realpath(path) or nil

  ---@type string
  local cached_root = M.root_cache[path]
  if cached_root ~= nil and path ~= nil then
    return cached_root
  end

  ---@type string[]
  local roots = {}
  if path then
    local active_clients = vim.lsp.get_clients { bufnr = 0 }
    for _, client in pairs(active_clients) do
      local wsf = client.config.workspace_folders
      ---@param ws lsp.WorkspaceFolder
      ---@return string?
      local filter_map = function(ws)
        return vim.uri_to_fname(ws.uri)
      end
      local paths = wsf and vim.tbl_map(filter_map, wsf) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        ---@type string?
        local r = vim.uv.fs_realpath(p)
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

  if M.root_cache ~= nil then
    M.root_cache[path] = root
  end

  ---@cast root string
  return root
end

M.has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

function M.init_printf()
  _G.printf = function(...)
    print(string.format(...))
  end

  local orig_print = print

  function _G.print(...)
    if vim.in_fast_event() then
      return orig_print(...)
    end
    for _, x in ipairs { ... } do
      if type(x) == 'string' then
        vim.api.nvim_out_write(x)
      else
        vim.api.nvim_out_write(vim.inspect(x, { newline = ' ', indent = '' }))
      end
    end
    vim.api.nvim_out_write '\n'
  end
end

function M.inlay_hint_toggle()
  local toggle_value = not vim.lsp.inlay_hint.is_enabled {}
  vim.lsp.inlay_hint.enable(toggle_value)
  return toggle_value
end

return M

---@param cb fun(_:vim.lsp.Client, _:integer): boolean?
local function on_lsp_attach(cb)
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      ---@type integer
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client ~= nil then
        return cb(client, buffer)
      end
    end,
  })
end

-- local function debounce(ms, fn)
--   local timer = assert(vim.uv.new_timer())
--   return function(...)
--     local argc, argv = select('#', ...), { ... }
--     timer:start(ms, 0, function()
--       timer:stop()
--       vim.schedule(function()
--         fn(unpack(argv, 1, argc))
--       end)
--     end)
--   end
-- end

on_lsp_attach(function(client, _buffer)
  if client:supports_method 'textDocument/foldingRange' then
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.lsp.foldexpr()'
    vim.wo.foldtext = 'v:lua.vim.lsp.foldtext()'
  end
end)

-- on_lsp_attach(function(client, buffer)
--   if client:supports_method 'textDocument/codeLens' then
--     vim.lsp.codelens.refresh { bufnr = buffer }
--     vim.api.nvim_create_autocmd({ 'FocusGained', 'WinEnter', 'BufEnter', 'CursorMoved' }, {
--       callback = debounce(200, function(args0)
--         vim.lsp.codelens.refresh { bufnr = args0.buf }
--       end),
--     })
--     -- Code lens setup, don't call again
--     return true
--   end
-- end)

require('dbuch.diagnostic').config()

local enabled_lsps = {
  -- Data/Exchangeable formats ls
  'html',
  'jsonls',
  'cssls',
  'taplo',

  -- Programming
  'clangd',
  'lua_ls',
  'pyright',
  'ruff',
  'zls',
  -- 'omnisharp',
  'wgsl',

  -- Shell
  'nushell',
  'bashls',
}

vim.lsp.config('*', {
  root_markers = { '.git' },
})

vim.lsp.enable(enabled_lsps)

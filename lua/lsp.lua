local attach_augroup = vim.api.nvim_create_augroup('dbuch.lsp', {})

---@param cb fun(client?:vim.lsp.Client, bufnr?:integer): boolean?
---@param augroup? number|nil
local function on_attach(cb, augroup)
  vim.api.nvim_create_autocmd('LspAttach', {
    group = augroup,
    callback = function(args)
      ---@type integer
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client ~= nil then
        return cb(client, bufnr)
      end
    end,
  })
end

on_attach(function(_client, _bufnr)
  if safe_require 'lsp_utils' then
    -- Detach on first succes require
    return true
  end
end, attach_augroup)

on_attach(function(client, bufnr)
  local map = vim.keymap.set
  map('n', 'ca', vim.lsp.buf.code_action, { silent = true, buffer = bufnr })
  map('n', 'cd', ':Trouble lsp_definitions<CR>', { silent = true, buffer = bufnr })
  map('n', 'cn', vim.lsp.buf.rename, { silent = true, buffer = bufnr })
  map('n', 't', ':Trouble diagnostics toggle<CR>', { silent = true, buffer = bufnr })
  map('n', 'cr', ':Trouble lsp toggle<CR>', { silent = true, buffer = bufnr })
  map('n', '<leader>i', function()
    if client.server_capabilities.inlayHintProvider then
      local enabled = require('dbuch.traits.nvim').inlay_hint_toggle()
      vim.notify(string.format('%s %s inlay hints!', client.name, enabled and 'enabled' or ' disabled'))
    else
      vim.notify(client.name .. ' doesnt support inlay hints')
    end
  end, { silent = true, buffer = bufnr })

  if client:supports_method 'textDocument/foldingRange' then
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.lsp.foldexpr()'
    vim.wo.foldtext = 'v:lua.vim.lsp.foldtext()'
  end
end, attach_augroup)

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
-- on_attach(function(client, buffer)
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
  'html', -- Html
  'jsonls', -- Json
  'cssls', -- Css
  'taplo', -- Toml
  'lemminx', -- XML

  -- Programming
  'lua_ls',
  'clangd',
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

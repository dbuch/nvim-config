local api = vim.api

local function augroup(name)
  return api.nvim_create_augroup('dbuch_' .. name, { clear = true })
end


local function autocmd(name)
  return function(opts)
    if opts[2] then
      vim.notify_once(vim.inspect(opts[2]))
      opts.group = opts[2]
    end
    if opts[1] then
      if type(opts[1]) == 'function' then
        opts.callback = opts[1]
      elseif type(opts[1]) == 'string' then
        opts.command = opts[1]
      end
      opts[1] = nil
    end
    vim.api.nvim_create_autocmd(name, opts)
  end
end

autocmd 'VimResized' { 'wincmd =' } augroup('resize')

-- api.nvim_create_autocmd('VimResized', {
--   group = augroup 'NvimSize',
--   command = 'wincmd ='
-- })

api.nvim_create_autocmd('BufReadPost', {
  group = augroup 'last_loc',
  callback = function()
    local mark = api.nvim_buf_get_mark(0, '"')
    local lcount = api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

api.nvim_create_autocmd('FileType', {
  group = augroup 'close_with_q',
  pattern = {
    'qf',
    'help',
    'man',
    'notify',
    'lspinfo',
    'tsplayground',
    'PlenaryTestPopup',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', {
      buffer = event.buf, --[[@as table]]
      silent = true,
    })
  end,
})

-- Disable autoformat for lua files
api.nvim_create_autocmd('FileType', {
  group = augroup 'diable_lua_format',
  pattern = { 'lua' },
  callback = function()
    vim.b.autoformat = false
  end,
})

api.nvim_create_autocmd('TermOpen', {
  group = augroup 'terminal',
  callback = function(args)
    if ('#toggleterm'):match(args.match) then
      local opts = {
        buffer = args.buf, --[[@as table]]
      }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    end
  end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  group = augroup 'nvim-tree-startup',
  callback = function(args)
    local file_stat = vim.loop.fs_stat(args.file)
    if file_stat == nil then
      return
    end

    if file_stat.type == 'directory' then
      -- change to the directory
      vim.cmd.cd(args.file)
      vim.cmd [[Neotree reveal]]
    end

  end,
})

---Valid for rooter
---@param buf integer
---@return boolean
local function is_invalid_buftype(buf)
  local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
  return vim.tbl_contains({
    'nofile',
    'help',
    'prompt',
    'terminal',
    'quickfix',
    'swapfile',
  }, buftype)
end

local function emit(ev, data)
  ---@type string|nil
  vim.api.nvim_exec_autocmds('User', { pattern = ev, data = data })
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup 'rooter',
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id) ---@type table
    local root = client.config.root_dir  ---@type string
    if root ~= vim.loop.cwd() then
      if vim.fn.chdir(root) ~= '' then
        local data = {
          ---@type string
          event = 'LSP',
          ---@type string
          root = root,
        }
        emit('Rooted', data)
      end
    end
  end
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'Rooted',
  callback = function(args)
    ---@type table
    local data = args.data
    if data.root ~= nil then
      -- local setby = event_to_string(data.event)
      vim.notify(data.root:gsub(vim.env.HOME, '~'), vim.log.levels.INFO, {
        title = ('New Working Directory (%s)'):format(data.event)
      })
    end
  end,
})

vim.api.nvim_create_user_command('VimLoaderReset', function()
  vim.loader.reset()
end, {})

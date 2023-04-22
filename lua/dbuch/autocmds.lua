local api = vim.api

local function augroup(name)
  return api.nvim_create_augroup('dbuch_' .. name, { clear = true })
end

api.nvim_create_autocmd('VimResized', {
  group = augroup 'wind_resize',
  command = 'wincmd =',
})

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
      ---@type number
      buffer = event.buf,
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
        ---@type number
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
      vim.fn.chdir(args.file)
      vim.cmd [[Neotree reveal float]]
    end
  end,
})

local function emit(ev, data)
  ---@type string|nil
  vim.api.nvim_exec_autocmds('User', { pattern = ev, data = data })
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup 'rooter',
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id) ---@type table
    local root = client.config.root_dir ---@type string
    if root ~= vim.loop.cwd() then
      if vim.fn.chdir(root) ~= '' then
        ---@type table
        local data = {
          ---@type string
          event = 'LSP',
          ---@type string
          root = root,
        }
        emit('Rooted', data)
      end
    end
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'Rooted',
  callback = function(args)
    ---@type table
    local data = args.data
    if data.root ~= nil then
      -- local setby = event_to_string(data.event)
      vim.notify(data.root:gsub(vim.env.HOME, '~'), vim.log.levels.INFO, {
        title = ('New Working Directory (%s)'):format(data.event),
      })
    end
  end,
})

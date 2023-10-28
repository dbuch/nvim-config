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
    'OverseerList',
    'oil',
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

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'comment',
  callback = function()
    vim.bo.commentstring = ''
  end,
})

---@return string?
local function get_injection_filetype()
  local ok, parser = pcall(vim.treesitter.get_parser)
  if not ok then
    return
  end

  local cpos = api.nvim_win_get_cursor(0)
  local row, col = cpos[1] - 1, cpos[2]
  local range = { row, col, row, col + 1 }

  local ft --- @type string?

  parser:for_each_child(function(tree, lang)
    if tree:contains(range) then
      local fts = vim.treesitter.language.get_filetypes(lang)
      for _, ft0 in ipairs(fts) do
        if vim.filetype.get_option(ft0, 'commentstring') ~= '' then
          ft = fts[1]
          break
        end
      end
    end
  end)

  return ft
end

local function enable_commenstrings()
  api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    buffer = 0,
    callback = function()
      local ft = get_injection_filetype() or vim.bo.filetype
      vim.bo.commentstring = vim.filetype.get_option(ft, 'commentstring') --[[@as string]]
    end,
  })
end

local function enable_foldexpr()
  vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  vim.opt_local.foldmethod = 'expr'
  vim.cmd.normal 'zx'
  vim.cmd.normal 'zR'
end

api.nvim_create_autocmd('FileType', {
  callback = function()
    if not pcall(vim.treesitter.start) then
      return
    end

    enable_foldexpr()
    enable_commenstrings()
  end,
})

api.nvim_create_user_command('OilFloat', function()
  if api.nvim_buf_is_valid(0) then
    if api.nvim_buf_get_name(0) ~= '' then
      vim.cmd 'Oil --float %:h'
    end
  end
end, {})

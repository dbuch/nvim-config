local api = vim.api


local function augroup(name)
  return api.nvim_create_augroup('dbuch_' .. name, { clear = true })
end

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
    local directory = vim.fn.isdirectory(args.file) == 1
    if not directory then
      return
    end
    -- change to the directory
    vim.cmd.cd(args.file)
    vim.cmd [[Neotree reveal]]
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

local function emit_rooted(new_root)
  ---@type string|nil
  vim.api.nvim_exec_autocmds('User', { pattern = 'Rooted', data = new_root })
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'LspAttach' }, {
  group = augroup 'rooter',
  callback = function(args)
    if args.file == '' or is_invalid_buftype(args.buf) then
      return
    end

    local cwd = vim.loop.cwd()
    local nvim_trait = require 'dbuch.traits.nvim'

    local function set_root(path)
      local root = nvim_trait.get_root(path)
      if cwd ~= root then
        if vim.fn.chdir(root) ~= '' then
          emit_rooted(root)
        end
      end
    end

    ---@type string
    local dir = vim.fs.dirname(args.file)
    if not nvim_trait.is_ancestor(cwd, dir) then
      set_root(dir)
    end
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'Rooted',
  callback = function(args)
    ---@type string|nil
    local cwd = args.data
    if cwd ~= nil then
      vim.notify('Rooted: ' .. cwd:gsub(vim.env.HOME, '~'))
    end
  end,
})

vim.api.nvim_create_user_command('VimLoaderReset', function()
  vim.loader.reset()
end, {})

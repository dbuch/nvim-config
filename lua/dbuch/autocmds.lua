local api = vim.api
local NvimTrait = require 'dbuch.traits.nvim'

api.nvim_create_autocmd('VimEnter', {
  group = NvimTrait.augroup 'paru_review',
  callback = function(data)
    ---@type string
    local path = data.file
    local is_dir = vim.fn.isdirectory(path)
    local is_tmp = path:sub(1, 5) == '/tmp/'
    if is_dir and is_tmp then
      ---@param p string
      ---@return boolean
      local function has_pkgbuild(p)
        return p:match 'PKGBUILD'
      end
      ---@param pkgbuild_file string
      for pkgbuild_file in vim.iter(vim.fs.dir(path)):filter(has_pkgbuild) do
        vim.cmd('e ' .. pkgbuild_file)
        vim.cmd 'setf sh'
      end
    end
  end,
})

api.nvim_create_autocmd('VimResized', {
  group = NvimTrait.augroup 'wind_resize',
  command = 'wincmd =',
})

api.nvim_create_autocmd('BufReadPost', {
  group = NvimTrait.augroup 'last_loc',
  callback = function()
    local mark = api.nvim_buf_get_mark(0, '"')
    local lcount = api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

api.nvim_create_autocmd('FileType', {
  group = NvimTrait.augroup 'close_with_q',
  pattern = {
    'qf',
    'help',
    'man',
    'notify',
    'lspinfo',
    'tsplayground',
    'query',
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
  group = NvimTrait.augroup 'terminal',
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
  group = NvimTrait.augroup 'rooter',
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id) ---@type table|nil
    if client == nil then
      return
    end
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
        annote = ('New Working Directory (%s)'):format(data.event),
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

  parser:for_each_tree(function(_tree, ltree)
    if ltree:contains(range) then
      local fts = vim.treesitter.language.get_filetypes(ltree:lang())
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

local ts_commentstring_group = api.nvim_create_augroup('ts_commentstring_group', {})
local function enable_commenstrings(buf)
  api.nvim_clear_autocmds { buffer = buf, group = ts_commentstring_group }
  api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    buffer = buf,
    group = ts_commentstring_group,
    callback = function()
      local ft = get_injection_filetype() or vim.bo.filetype
      vim.bo[buf].commentstring = vim.filetype.get_option(ft, 'commentstring') --[[@as string]]
    end,
  })
end

api.nvim_create_autocmd('FileType', {
  callback = function(args)
    if not pcall(vim.treesitter.start, args.buf) then
      return
    end

    enable_commenstrings(args.buf)
  end,
})

vim.api.nvim_create_autocmd('User', {
  once = true,
  pattern = 'LazyVimStarted',
  callback = function()
    local stats = require('lazy').stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    vim.notify(('It took %s ms to'):format(ms), vim.log.levels.INFO, {
      annote = 'Startup',
    })
  end,
})

local o, set = vim.opt, vim.keymap.set

require 'dbuch.theme'
require 'dbuch.status'
require 'dbuch.autocmds'

require('lazy').setup {
  spec = {
    { import = 'dbuch.core' },
    { import = 'dbuch.editor' },
    { import = 'dbuch.others' },
  },
  defaults = {
    lazy = true,
    version = '*',
  },
--  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        'netrw',
        'netrwPlugin',
        'tutor',
        'tohtml',
        'tarPlugin',
        'zipPlugin',
        'gzip',
      },
    },
  },
}

if 'Mappings' then
  set('', 'H', '^')
  set('', 'L', '$')

  set('n', '<C-d>', '<C-d>zz', { remap = false })
  set('n', '<C-u>', '<C-u>zz', { remap = false })

  -- set('n', 'n', 'nzz', { remap = false })
  -- set('n', 'N', 'Nzz', { remap = false })

  set('n', 'L', '$')

  set('n', 'Y', 'y$')

  set('n', 'q', '<nop>')

  set('n', 'j', 'v:count ? "j" : "gj"', { expr = true })
  set('n', 'k', 'v:count ? "k" : "gk"', { expr = true })
  set('n', '|', [[!v:count ? "<C-W>v<C-W><Right>" : '|']], { expr = true, silent = true })
  set('n', '_', [[!v:count ? "<C-W>s<C-W><Down>"  : '_']], { expr = true, silent = true })

  set('n', '<leader>T', ':Telescope<CR>', { nowait = true, silent = true })
  set('n', '<leader>t', ':ToggleTerm<CR>', { nowait = true, silent = true })
  set('n', '<leader>s', ':SymbolsOutline<CR>', { nowait = true, silent = true })
  set('n', '<leader>f', ':Telescope find_files<CR>')
  set('n', '<leader>b', ':Telescope buffers<CR>')
  set('n', '<leader>g', ':Telescope live_grep<CR>')

  set('n', '<c-q>', ':SmartQuit<CR>', { silent = true })

  set('n', 'ga', vim.lsp.buf.code_action, { silent = true })
  set('n', 'gD', ':Telescope lsp_definitions<CR>', { silent = true })
  -- set('n', 'gp', require('goto-preview').goto_preview_definition, { silent = true })
  set('n', 'gd', vim.lsp.buf.definition, { silent = true })
  set('n', 'gn', vim.lsp.buf.rename, { silent = true })
  set('n', 'gt', ':TroubleToggle<CR>', { silent = true })
  set('n', 'gr', ':TroubleToggle lsp_references<CR>', { silent = true })

  set('n', '<leader>p', ':Telescope projects<CR>', { silent = true })
  set('n', '<leader>e', ':NvimTreeFindFileToggle<CR>', { silent = true })

  set('n', '<leader>=', function()
    vim.lsp.buf.format { async = true }
  end)
  set('n', '<leader>w', '<esc>:w<CR>', { noremap = false })

  -- Clear search
  set('n', '<esc>', ':noh<return><esc>', { silent = true })
  set('n', '<esc>^[', '<esc>^[', { silent = true })
  set('t', '<esc>', '<C-\\><C-n>', { silent = true })

  set('n', '<leader><leader>', '<c-^>')

  local NS = { noremap = true, silent = true }
  set('x', 'aa', function()
    require('align').align_to_char(1, true)
  end, NS) -- Aligns to 1 character, looking left
  set('x', 'as', function()
    require('align').align_to_char(2, true, true)
  end, NS) -- Aligns to 2 characters, looking left and with previews
  set('x', 'aw', function()
    require('align').align_to_string(false, true, true)
  end, NS) -- Aligns to a string, looking left and with previews
  set('x', 'ar', function()
    require('align').align_to_string(true, true, true)
  end, NS) -- Aligns to a Lua pattern, looking left and with previews
end

if 'Folding' then
  vim.g.sh_fold_enabled = 1

  o.foldmethod = 'syntax'
  o.foldcolumn = '0'
  o.foldnestmax = 3
  o.foldopen:append 'jump'
end

require 'dbuch.diagnostic'
require 'dbuch.jumps'
require 'dbuch.quit'
require 'dbuch.options'

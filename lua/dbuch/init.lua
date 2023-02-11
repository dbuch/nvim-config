local o, api, set, expand = vim.opt, vim.api, vim.keymap.set, vim.fn.expand

require 'dbuch.theme'
require 'dbuch.status'

if 'Plugins' then
  -- Stop loading built in plugins
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  vim.g.loaded_tutor_mode_plugin = 1
  vim.g.loaded_2html_plugin = 1
  vim.g.loaded_zipPlugin = 1
  vim.g.loaded_tarPlugin = 1
  vim.g.loaded_gzip = 1

  vim.g.loaded_perl_provider = 0
  vim.g.loaded_node_provider = 0
  vim.g.loaded_ruby_provider = 0

  api.nvim_create_augroup('vimrc', {})
end

if 'Options' then
  o.backup = true
  o.backupdir:remove '.'
  o.breakindent = true
  --TODO  o.clipboard      = 'unnamedplus' Fix this when wl-copy behaves
  --OR https://github.com/neovim/neovim/pull/21091
  o.expandtab = true
  o.fillchars = { eob = ' ', diff = ' ' }
  o.hidden = true
  o.ignorecase = true
  o.inccommand = 'split'
  o.number = true
  o.relativenumber = true
  o.scrolloff = 6
  o.shiftwidth = 2
  o.tabstop = 2
  o.sidescroll = 6
  o.sidescrolloff = 6
  o.signcolumn = 'yes'
  o.smartcase = true
  o.softtabstop = 4
  o.startofline = false
  o.swapfile = false
  o.termguicolors = true
  o.textwidth = 80
  o.virtualedit = 'block'
  o.winblend = 6
  o.pumblend = 6
  o.wrap = false

  o.shortmess:append 'c'
  o.completeopt:append {
    'noinsert',
    'menuone',
    'noselect',
    'preview',
  }

  o.showbreak = '↳ '
  o.mouse = 'a'
  o.mousemodel = 'extend'

  o.diffopt:append {
    'vertical',
    'foldcolumn:0',
    'indent-heuristic',
  }

  o.undolevels = 10000
  o.undofile = true
  o.undodir = expand '~/.cache/nvim'
  o.splitright = true
  o.splitbelow = true
  -- o.spell = true

  local xdg_cfg = os.getenv 'XDG_CONFIG_HOME'
  if xdg_cfg then
    o.spellfile = xdg_cfg .. '/nvim/spell/en.utf-8.add'
  end

  o.formatoptions:append {
    r = true, -- Automatically insert comment leader after <Enter> in Insert mode.
    o = true, -- Automatically insert comment leader after 'o' or 'O' in Normal mode.
    l = true, -- Long lines are not broken in insert mode.
    t = true, -- Do not auto wrap text
    n = true, -- Recognise lists
  }

  o.cmdheight = 0
  o.laststatus = 3
  o.showmode = false
  o.showcmd = false
  o.numberwidth = 3
end

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

require 'dbuch.lazy'


--TODO(Perhaps use plugin): rebelot/heirline.nvim
require 'dbuch.diagnostic'
require 'dbuch.plugins'
require 'dbuch.jumps'
require 'dbuch.autocmds'
require 'dbuch.quit'

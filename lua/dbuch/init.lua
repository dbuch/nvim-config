require 'dbuch.plugins'

local o, api = vim.opt, vim.api

if 'Plugins' then
  -- Load any plugins which are work sensitive.
  for _, f in ipairs(vim.fn.globpath('~/gerrit/', '*', false, true)) do
    o.rtp:prepend(f)
  end

  -- Stop loading built in plugins
  vim.g.loaded_netrwPlugin = 1
  vim.g.loaded_tutor_mode_plugin = 1
  vim.g.loaded_2html_plugin = 1
  vim.g.loaded_zipPlugin = 1
  vim.g.loaded_tarPlugin = 1
  vim.g.loaded_gzip = 1

  api.nvim_create_augroup('vimrc', {})
end

if 'Options' then
  o.backup         = true
  o.backupdir:remove('.')
  o.breakindent    = true -- Indent wrapped lines to match start
  o.clipboard      = 'unnamedplus'
  o.expandtab      = true
  o.fillchars      = {eob=' ', diff = ' '}
  o.hidden         = true
  o.ignorecase     = true
  o.inccommand     = 'split'
  o.number         = true
  o.pumblend       = 10
  o.relativenumber = true
  o.scrolloff      = 6
  o.shiftwidth     = 4
  o.sidescroll     = 6
  o.sidescrolloff  = 6
  o.signcolumn     = 'auto:3'
  o.smartcase      = true
  o.softtabstop    = 4
  o.startofline    = false
  o.swapfile       = false
  o.tabstop        = 4
  o.termguicolors  = true
  o.textwidth      = 80
  o.virtualedit    = 'block' -- allow cursor to exist where there is no character
  o.winblend       = 10
  o.wrap           = false
  -- o.lazyredraw     = true

  -- Avoid showing message extra message when using completion
  o.shortmess:append('c')
  o.completeopt:append{
    'noinsert',
    'menuone',
    'noselect',
    'preview'
  }

  o.showbreak   = '↳ '
  -- o.showbreak   = '    ↳ '
  o.mouse       = 'a'

  o.diffopt:append{
    'vertical',
    'foldcolumn:0',
    'indent-heuristic',
  }

  o.undolevels = 10000
  o.undofile   = true
  o.splitright = true
  o.splitbelow = true
  o.spell      = true

  local xdg_cfg = os.getenv('XDG_CONFIG_HOME')
  if xdg_cfg then
    o.spellfile = xdg_cfg..'/nvim/spell/en.utf-8.add'
  end

  o.formatoptions:append{
    r = true, -- Automatically insert comment leader after <Enter> in Insert mode.
    o = true, -- Automatically insert comment leader after 'o' or 'O' in Normal mode.
    l = true, -- Long lines are not broken in insert mode.
    t = true, -- Do not auto wrap text
    n = true, -- Recognise lists
  }
end

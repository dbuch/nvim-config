-- This doens't work, likely due to: https://github.com/neovim/neovim/issues/13433
-- Update adapt this once merged: https://github.com/neovim/neovim/pull/13479

local utils = require('utils')
local options = utils.options
local expand = vim.fn.expand

options.set {
  -- Encoding
  encoding = 'utf-8',
  fileencoding = 'utf-8',
  fileencodings = 'utf-8',
  ttm = 10,

  -- Mouse
  mouse = 'a',

  -- Swap and Backup
  swapfile = false,
  backup = false,
  writebackup = false,

  showcmd = false,

  -- Undo
  undodir = expand('~/.cache/nvim'),
  undofile = true,

  lazyredraw = false,

  buflisted = true,
  autoread = true,

  laststatus = 3,
  showmode = false,

  -- Secure
  secure = true,

  -- Indent
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,

  -- Split
  splitright = true,
  splitbelow = true,

  -- Buffer
  hidden = true,

  --" Search Case settings
  incsearch = true,
  gdefault = true,
  ignorecase = true,
  smartcase = true,

  --" Smaller updatetime for CursorHold & CursorHoldI
  updatetime = 500,
  timeoutlen = 500,
  ttimeoutlen = 50,

  shortmess = 'filnxtToOFc',

  completeopt = {'menuone', 'noselect'},

  background = 'dark',
  termguicolors = true,
}

options.setw {
  number = true,
  colorcolumn = '100',
  relativenumber = true,
  signcolumn = 'yes',
  wrap = false,
}

options.setg {
  mapleader=' ',
  syntax = 'enable',
  cursorhold_updatetime = 100,
  diagnostic_enable_virtual_text = 0,
  diagnostic_trimmed_virtual_text = '20',
  diagnostic_insert_delay = 1,
  python3_host_prog = '/usr/bin/python',
  termguicolors = true,
  guifont = 'Droid Sans Mono For Powerline Plug Nerd File Types Mono:h22',
  tex_flavor = "latex",
  suda_smart_edit = 1,
  one_allow_italics = 1,
  fillchars = 'eob:~',
  showtabline = 0,
}

options.setenv {
  NVIM_TUI_ENABLE_TRUE_COLOR = 1,
}

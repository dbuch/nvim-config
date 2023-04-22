local o = vim.opt

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
o.numberwidth = 3
o.shiftwidth = 2
o.tabstop = 2
o.scrolloff = 6
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
o.pumheight = 10
o.wrap = false

o.shortmess:append { W = true, I = true, c = true, C = true }
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

o.timeoutlen = 300
o.updatetime = 200

o.undolevels = 10000
o.undofile = true
vim.opt.undodir = require 'dbuch.env'.undo_dir
o.splitright = true
o.splitbelow = true
o.splitkeep = 'screen'

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

-- Folding
vim.g.sh_fold_enabled = 1

o.foldmethod = 'syntax'
o.foldcolumn = '0'
o.foldnestmax = 3
o.foldopen:append 'jump'

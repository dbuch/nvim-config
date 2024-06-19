local opt = vim.opt

opt.backup = true
opt.backupdir:remove '.'
opt.breakindent = true
--TODO  o.clipboard      = 'unnamedplus' Fix this when wl-copy behaves
--OR https://github.com/neovim/neovim/pull/21091
opt.expandtab = true
opt.fillchars = { eob = ' ', diff = ' ' }
opt.hidden = true
opt.ignorecase = true
opt.inccommand = 'split'
opt.conceallevel = 3

opt.number = true
opt.relativenumber = true
opt.numberwidth = 3
opt.shiftround = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.scrolloff = 6
opt.sidescroll = 6
opt.sidescrolloff = 6
opt.signcolumn = 'yes'
opt.smartcase = true
opt.smoothscroll = true
opt.softtabstop = 4
opt.startofline = false
opt.swapfile = false
opt.termguicolors = true
opt.textwidth = 80
opt.virtualedit = 'block'
opt.winblend = 6
opt.pumblend = 6
opt.pumheight = 10
opt.wrap = false

opt.shortmess:append { W = true, I = true, c = true, C = true }
opt.completeopt:append {
  'noinsert',
  'menuone',
  'noselect',
  'preview',
}

opt.showbreak = '↳ '
opt.mouse = 'a'
opt.mousemodel = 'extend'
opt.mousemoveevent = true
opt.diffopt:append {
  'vertical',
  'foldcolumn:0',
  'indent-heuristic',
}

opt.timeoutlen = 300
opt.updatetime = 200

opt.undolevels = 10000
opt.undofile = true
vim.opt.undodir = require('dbuch.env').undo_dir
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = 'screen'

opt.formatoptions:append {
  r = true, -- Automatically insert comment leader after <Enter> in Insert mode.
  o = true, -- Automatically insert comment leader after 'o' or 'O' in Normal mode.
  l = true, -- Long lines are not broken in insert mode.
  t = true, -- Do not auto wrap text
  n = true, -- Recognise lists
}

opt.cmdheight = 0
opt.laststatus = 3
opt.showmode = false
opt.showcmd = false

-- Folding
vim.g.sh_fold_enabled = 1

opt.foldmethod = 'syntax'
opt.foldcolumn = '0'
opt.foldnestmax = 3
opt.foldopen:append 'jump'

-- grep
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'

-- session
opt.sessionoptions = { 'buffers', 'curdir', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }

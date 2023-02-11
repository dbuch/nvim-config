local o, expand = vim.opt, vim.fn.expand

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

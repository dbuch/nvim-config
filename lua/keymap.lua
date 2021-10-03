local mapping = require ('utils.mapping')
local map = mapping.map;
local maplua = mapping.maplua;

vim.g.mapleader = ' '

map('', 'H', '^')
map('', 'L', '$')

map('n', 'j', 'v:count ? "j" : "gj"', { expr = true})
map('n', 'k', 'v:count ? "k" : "gk"', { expr = true})

map('n', '<leader>t',  ':FloatermToggle<CR>', { nowait = true})
map('n', '<leader>f',  ':Telescope find_files<CR>')
map('n', '<leader>b',  ':Telescope buffers<CR>')
map('n', '<leader>g',  ':Telescope live_grep<CR>')

map('n', '<leader>ca', ':Lspsaga code_action<CR>')
map('n', '<leader>cr', ':Lspsaga rename<CR>')
map('n', 'K',          ':Lspsaga hover_doc<CR>')
map('n', '<c-k>',      ':Lspsaga show_line_diagnostics<CR>')

maplua('n', '<c-]>',      'vim.lsp.buf.definition()')
maplua('n', 'gD',         'vim.lsp.buf.implementation()')
maplua('n', '1gD',        'vim.lsp.buf.type_definition()')
maplua('n', 'gr',         'vim.lsp.buf.references()')
maplua('n', 'g0',         'vim.lsp.buf.document_symbol()')
maplua('n', 'gW',         'vim.lsp.buf.workspace_symbol()')
maplua('n', 'gd',         'vim.lsp.buf.declaration()')
maplua('n', '<leader>p',  'require"telescope".extensions.project.project{}')

maplua('n', '<leader>=', 'vim.lsp.buf.formatting()')
map('n', '<leader>w', '<esc>:w<CR>', { noremap = false })

-- Clear search
map('n', '<esc>',     ':noh<return><esc>')
map('n', '<esc>^[',   '<esc>^[')
map('t', '<esc>',     '<C-\\><C-n>')

map('n', '<leader><leader>', '<c-^>')

map('i', '<A-j>', 'pumvisible() ? "<C-n>" : "<Tab>"', { expr = true})
map('i', '<A-k>', 'pumvisible() ? "<C-p>" : "<S-Tab>"', { expr = true})
map('s', '<A-j>', 'pumvisible() ? "<C-n>" : "<Tab>"', { expr = true})
map('s', '<A-k>', 'pumvisible() ? "<C-p>" : "<S-Tab>"', { expr = true})

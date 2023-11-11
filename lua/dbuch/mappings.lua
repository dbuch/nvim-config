---@type function
local map = vim.keymap.set

map('n', '<C-d>', '<C-d>zz', { remap = false })
map('n', '<C-u>', '<C-u>zz', { remap = false })

map('n', 'n', 'nzz', { remap = false })
map('n', 'N', 'Nzz', { remap = false })

map('n', 'L', '$')
map('', 'L', '$')
map('n', 'H', '^')
map('', 'H', '^')

map('n', 'Y', 'y$')

map('n', 'q', '<nop>')
map('n', 'j', 'v:count ? "j" : "gj"', { expr = true })
map('n', 'k', 'v:count ? "k" : "gk"', { expr = true })
map('n', '|', [[!v:count ? "<C-W>v<C-W><Right>" : '|']], { expr = true, silent = true })
map('n', '_', [[!v:count ? "<C-W>s<C-W><Down>"  : '_']], { expr = true, silent = true })

map('n', '<leader>T', ':Telescope<CR>', { nowait = true, silent = true })
map('n', '<leader>t', ':ToggleTerm<CR>', { nowait = true, silent = true })
map('n', '<leader>s', ':SymbolsOutline<CR>', { nowait = true, silent = true })
map('n', '<leader>f', ':Telescope find_files<CR>', { nowait = true, silent = true })
map('n', '<leader>b', ':Telescope buffers<CR>', { nowait = true, silent = true })
map('n', '<leader>g', ':Telescope live_grep<CR>', { nowait = true, silent = true })
map('n', '<leader>n', ':Navbuddy<CR>', { nowait = true, silent = true })
map('n', '<leader>e', ':lua MiniFiles.open()<CR>', { silent = true })
map('n', '<c-q>', ':bd<CR>', { silent = true })

map('n', '<leader>ca', vim.lsp.buf.code_action, { silent = true })
map('n', '<leader>cD', ':Telescope lsp_definitions<CR>', { silent = true })
map('n', '<leader>cd', vim.lsp.buf.definition, { silent = true })
map('n', '<leader>cn', vim.lsp.buf.rename, { silent = true })
map('n', '<leader>ct', ':TroubleToggle<CR>', { silent = true })
map('n', '<leader>cr', ':TroubleToggle lsp_references<CR>', { silent = true })

map('n', '<leader>w', '<esc>:w<CR>', { noremap = false })

map('n', 'K', vim.lsp.buf.hover, { desc = 'hover.nvim' })

-- Clear search
map('n', '<esc>', ':noh<return><esc>', { silent = true })
map('n', '<esc>^[', '<esc>^[', { silent = true })
map('t', '<esc>', '<C-\\><C-n>', { silent = true })

map('n', '<leader><leader>', '<c-^>')

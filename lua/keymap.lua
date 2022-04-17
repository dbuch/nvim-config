local set = vim.keymap.set;

vim.g.mapleader = ' '

set('', 'H', '^')
set('', 'L', '$')

set('n', 'j', 'v:count ? "j" : "gj"', { expr = true })
set('n', 'k', 'v:count ? "k" : "gk"', { expr = true })

set('n', '<leader>t', ':FloatermToggle<CR>', { nowait = true, silent = true })
set('n', '<leader>f', function() require('telescope.builtin').find_files() end)
set('n', '<leader>b', function() require('telescope.builtin').buffers() end)
set('n', '<leader>g', function() require('telescope.builtin').live_grep() end)

set('n', '<c-q>', ':bd<CR>')

set('n', '<leader>ca', ':Lspsaga code_action<CR>')
set('n', '<leader>cr', ':Lspsaga rename<CR>')
set('n', 'K', ':Lspsaga hover_doc<CR>')
set('n', '<c-k>', ':Lspsaga show_line_diagnostics<CR>')

-- set('n', 'gd', vim.lsp.buf.definition)
set('n', 'gd', function() require('telescope.builtin').lsp_definitions() end)
set('n', 'gr', function() require('telescope.builtin').lsp_references() end)

set('n', '<leader>p', function() require "telescope".extensions.project.project {} end)

set('n', '<leader>=', vim.lsp.buf.formatting)
set('n', '<leader>w', '<esc>:w<CR>', { noremap = false })

-- Clear search
set('n', '<esc>', ':noh<return><esc>', { silent = true })
set('n', '<esc>^[', '<esc>^[', { silent = true })
set('t', '<esc>', '<C-\\><C-n>', { silent = true })

set('n', '<leader><leader>', '<c-^>')

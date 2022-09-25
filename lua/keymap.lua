local set = vim.keymap.set;

vim.g.mapleader = ' '

set('', 'H', '^')
set('', 'L', '$')

set('n', 'j', 'v:count ? "j" : "gj"', { expr = true })
set('n', 'k', 'v:count ? "k" : "gk"', { expr = true })

set('n', '<leader>t', ':ToggleTerm<CR>', { nowait = true, silent = true })
set('n', '<leader>f', function() require('telescope.builtin').find_files() end)
set('n', '<leader>b', function() require('telescope.builtin').buffers() end)
set('n', '<leader>g', function() require('telescope.builtin').live_grep() end)

set('n', '<c-q>', ':bd<CR>', { silent = true })

set('n', '<leader>la', ':Lspsaga code_action<CR>', { silent = true })
set('n', '<leader>ln', ':Lspsaga rename<CR>', { silent = true })
set('n', '<leader>ls', function() require('telescope.builtin').lsp_definitions() end)
set('n', '<leader>lr', function() require('telescope.builtin').lsp_references() end)
set('n', '<leader>ld', ':Lspsaga peek_definition<CR>', { silent = true })
set('n', '<leader>lt', ':TroubleToggle<CR>', { silent = true })

set('n', 'K', function ()
  if vim.fn.expand('%:t') == 'Cargo.toml' then
    require('crates').show_popup()
  else
    require('lspsaga.hover'):render_hover_doc()
  end
end, { silent = true })
set('n', '<c-k>', ':Lspsaga show_line_diagnostics<CR>', { silent = true })

-- set('n', 'gd', vim.lsp.buf.definition)

set('n', '<leader>p', ':Telescope projects<CR>', { silent = true })
set('n', '<leader>e', ':NvimTreeFindFileToggle<CR>', { silent = true })

set('n', '<leader>=', vim.lsp.buf.formatting)
set('n', '<leader>w', '<esc>:w<CR>', { noremap = false })

-- Clear search
set('n', '<esc>', ':noh<return><esc>', { silent = true })
set('n', '<esc>^[', '<esc>^[', { silent = true })
set('t', '<esc>', '<C-\\><C-n>', { silent = true })

set('n', '<leader><leader>', '<c-^>')

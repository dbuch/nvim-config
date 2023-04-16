---@type function
local map = vim.keymap.set

map('', 'H', '^')
map('', 'L', '$')

map('n', '<C-d>', '<C-d>zz', { remap = false })
map('n', '<C-u>', '<C-u>zz', { remap = false })

-- set('n', 'n', 'nzz', { remap = false })
-- set('n', 'N', 'Nzz', { remap = false })

map('n', 'L', '$')

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

map('n', 'åD', vim.diagnostic.goto_prev)
map('n', 'åd', vim.diagnostic.goto_next)

map('n', '<c-q>', ':SmartQuit<CR>', { silent = true })

map('n', 'ga', vim.lsp.buf.code_action, { silent = true })
map('n', 'gD', ':Telescope lsp_definitions<CR>', { silent = true })
-- set('n', 'gp', require('goto-preview').goto_preview_definition, { silent = true })
map('n', 'gd', vim.lsp.buf.definition, { silent = true })
map('n', 'gn', vim.lsp.buf.rename, { silent = true })
map('n', 'gt', ':TroubleToggle<CR>', { silent = true })
map('n', 'gr', ':TroubleToggle lsp_references<CR>', { silent = true })

map('n', '<leader>p', ':Telescope projects<CR>', { silent = true })
map('n', '<leader>e', ':Neotree toggle reveal<CR>', { silent = true })

map('n', '<leader>=', function()
  vim.lsp.buf.format { async = true }
end)
map('n', '<leader>w', '<esc>:w<CR>', { noremap = false })

-- Clear search
map('n', '<esc>', ':noh<return><esc>', { silent = true })
map('n', '<esc>^[', '<esc>^[', { silent = true })
map('t', '<esc>', '<C-\\><C-n>', { silent = true })

map('n', '<leader><leader>', '<c-^>')

local NS = { noremap = true, silent = true }
map('x', 'aa', function()
  require('align').align_to_char(1, true)
end, NS) -- Aligns to 1 character, looking left
map('x', 'as', function()
  require('align').align_to_char(2, true, true)
end, NS) -- Aligns to 2 characters, looking left and with previews
map('x', 'aw', function()
  require('align').align_to_string(false, true, true)
end, NS) -- Aligns to a string, looking left and with previews
map('x', 'ar', function()
  require('align').align_to_string(true, true, true)
end, NS) -- Aligns to a Lua pattern, looking left and with previews

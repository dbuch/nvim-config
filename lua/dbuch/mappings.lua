local NvimTrait = require 'dbuch.traits.nvim'
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
map('n', '<leader>t', ':ToggleTerm direction=vertical size=100<CR>', { nowait = true, silent = true })
map('n', '<leader>f', ':Telescope find_files<CR>', { nowait = true, silent = true })
map('n', '<leader>b', ':Telescope buffers<CR>', { nowait = true, silent = true })
map('n', '<leader>g', ':Telescope live_grep<CR>', { nowait = true, silent = true })
map('n', '<leader>e', ':lua MiniFiles.open()<CR>', { silent = true })
map('n', '<c-q>', ':bd<CR>', { silent = true })

NvimTrait.on_attach(function(client, buf)
  map('n', 'ca', vim.lsp.buf.code_action, { silent = true, buffer = buf })
  map('n', 'cD', ':Telescope lsp_definitions<CR>', { silent = true, buffer = buf })
  map('n', 'cd', vim.lsp.buf.definition, { silent = true, buffer = buf })
  map('n', 'cn', vim.lsp.buf.rename, { silent = true, buffer = buf })
  map('n', 'ct', ':TroubleToggle<CR>', { silent = true, buffer = buf })
  map('n', 'cr', ':TroubleToggle lsp_references<CR>', { silent = true, buffer = buf })
  map('n', '<leader>ci', function()
    if client.server_capabilities.inlayHintProvider then
      local enabled = require('dbuch.traits.nvim').inlay_hint_toggle()
      vim.notify(client.name .. enabled and ' enabled ' or ' disabled ' .. 'inlay hints')
    else
      vim.notify(client.name .. ' doesnt support inlay hints')
    end
  end, { silent = true, buffer = buf })
end)

map('n', '<leader>w', '<esc>:w<CR>', { noremap = false })

-- Clear search
map('n', '<esc>', ':noh<return><esc>', { silent = true })
map('n', '<esc>^[', '<esc>^[', { silent = true })
map('t', '<esc>', '<C-\\><C-n>', { silent = true })

map('n', '<leader><leader>', '<c-^>')

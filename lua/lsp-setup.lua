local nvim_lsp_config = require('lspconfig')
local nvim_lsp_status = require('lsp-status')
local telescope = require('telescope')
local telescope_actions = require('telescope.actions')
local capabilities = vim.lsp.protocol.make_client_capabilities()

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<M-j>"] = telescope_actions.move_selection_next,
        ["<M-k>"] = telescope_actions.move_selection_previous,
      },
    },
  }
}

capabilities.textDocument.completion.completionItem.snippetSupport = true

nvim_lsp_status.capabilities = vim.tbl_extend('force', nvim_lsp_status.capabilities or {}, capabilities)
nvim_lsp_status.register_progress()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

local dbuch_on_attach = function (client)
  local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

  vim.cmd(
    [[autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request { ]]
      .. [[prefix = '» ', highlight = "Comment", enabled = {"ChainingHint"} ]]
    .. [[} ]]
  )

--  vim.cmd [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]

  if vim.tbl_contains({"go", "rust"}, filetype) then
    vim.cmd [[autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()]]
  end

  require('completion').on_attach(client)
  nvim_lsp_status.on_attach(client)
end

nvim_lsp_config.rust_analyzer.setup({
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  on_attach = dbuch_on_attach,
  capabilities = nvim_lsp_status.capabilities,
})

nvim_lsp_config.texlab.setup({
  on_attach = dbuch_on_attach,
  capabilities=nvim_lsp_status.capabilities
})

nvim_lsp_config.clangd.setup({
  on_attach = dbuch_on_attach,
  capabilities=nvim_lsp_status.capabilities
})

nvim_lsp_config.sumneko_lua.setup({
  on_attach = dbuch_on_attach,
  capabilities=nvim_lsp_status.capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Get the language server to recognize LuaJIT globals like `jit` and `bit`
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
})

nvim_lsp_config.vimls.setup({
  on_attach = dbuch_on_attach,
  capabilities=nvim_lsp_status.capabilities
})

nvim_lsp_config.sqlls.setup({
  on_attach = dbuch_on_attach,
  capabilities=nvim_lsp_status.capabilities
})

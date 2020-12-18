local nvim_lsp_config = require('lspconfig')
local nvim_lsp_status = require('lsp-status')
local telescope = require('telescope')
local telescope_actions = require('telescope.actions')
local capabilities = vim.lsp.protocol.make_client_capabilities()
local lightbulb = require('lightbulb')

vim.lsp.handlers['textDocument/codeAction'] =     require'lsputil.codeAction'.code_action_handler
--vim.lsp.handlers['textDocument/references'] =     require'lsputil.locations'.references_handler
--vim.lsp.handlers['textDocument/definition'] =     require'lsputil.locations'.definition_handler
--vim.lsp.handlers['textDocument/declaration'] =    require'lsputil.locations'.declaration_handler
--vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
--vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
--vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
--vim.lsp.handlers['workspace/symbol'] =            require'lsputil.symbols'.workspace_handler

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

Indicator_errors = ' '
Indicator_warnings = ' '
Indicator_info = '🛈 '
Indicator_hint = '❗'

local function define_signs(opts_table)
  for k, v in pairs(opts_table) do
    vim.fn.sign_define(k, v)
  end
end

define_signs {
  LspDiagnosticsSignError = {
    text = Indicator_errors,
    texthl = 'LspDiagnosticsSignError'
  },
  LspDiagnosticsSignWarning = {
    text = Indicator_warnings,
    texthl = 'LspDiagnosticsSignWarning',
  },
  LspDiagnosticsSignInformation = {
    text = Indicator_info,
    texthl = 'LspDiagnosticsSignInformation',
  },
  LspDiagnosticsSignHint = {
    text = Indicator_hint,
    texthl = 'LspDiagnosticsSignHint',
  }
}

nvim_lsp_status.capabilities = vim.tbl_extend('force', nvim_lsp_status.capabilities or {}, capabilities)
nvim_lsp_status.config {
  select_symbol = function(cursor_pos, symbol)
    if symbol.valueRange then
      local value_range = {
        ["start"] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[1])
        },
        ["end"] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[2])
        }
      }

      return require("lsp-status.util").in_range(cursor_pos, value_range)
    end
  end
}
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

  lightbulb.register()

  vim.cmd(
         [[autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request { ]]
      .. [[prefix = '» ', highlight = "Comment", enabled = {"ChainingHint"} ]]
      .. [[} ]]
  )

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

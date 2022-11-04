--[[ require 'lsp_signature'.setup {
  hi_parameter = "Visual",
} ]]
require("neodev").setup({})

local lspconfig = require('lspconfig')

local done_st = false

local function make_on_attach(config)
  return function(client, bufnr)
    if config.before then
      config.before(client)
    end

    -- omni completion source
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    require('lsp_signature').on_attach({
      floating_window_above_first = true,
      hi_parameter = "Visual",
      bind = false,
    }, bufnr)

    if client.server_capabilities.code_lens then
      vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh
      })
      vim.lsp.codelens.refresh()
    end

    if not done_st then
      require("nvim-semantic-tokens").setup {
        preset = "default",
        highlighters = { require 'nvim-semantic-tokens.table-highlighter' }
      }
      vim.api.nvim_create_augroup('SemanticTokens', {})
      done_st = true
    end
    if client.server_capabilities.semanticTokensProvider and client.server_capabilities.semanticTokensProvider.full then
      vim.api.nvim_create_autocmd("TextChanged", {
        group = 'SemanticTokens',
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.semantic_tokens_full()
        end,
      })
      -- fire it first time on load as well
      vim.lsp.buf.semantic_tokens_full()
    end

    if config.after then
      config.after(client)
    end
  end
end

--[[
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end ]]

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = {
  html = {
    cmd = { "vscode-html-languageserver", "--stdio" },
    filetypes = { "html" },
    root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
  },
  yamlls = {},
  cssls = {
    cmd = { "vscode-css-languageserver", "--stdio" },
    filetypes = { "css" },
    root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
  },
  jsonls = {
    cmd = { "vscode-json-languageserver", "--stdio" },
    filetypes = { "json" },
    root_dir = lspconfig.util.root_pattern(".git", vim.fn.getcwd()),
  },

  tsserver = {},
  bashls = {},

  omnisharp = {
    cmd = { "omnisharp" },
    enable_editorconfig_support = true,
    enable_ms_build_load_projects_on_demand = false,
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
    sdk_include_prereleases = false,
    analyze_open_documents_only = false,
  },

  clangd = {
    cmd = {
      'clangd', '--offset-encoding=utf-32',
      '--clang-tidy', '--completion-style=bundled', '--header-insertion=iwyu',
      '--suggest-missing-includes', '--cross-file-rename'
    },
    init_options = {
      clangdFileStatus = true,
      usePlaceholders = true,
      completeUnimported = true
    },
    capabilities = vim.tbl_deep_extend("force", capabilities, { offsetEncoding = { 'utf-32' } })
  },

  texlab = {
    cmd = { "texlab" },
    latex = {
      build = {
        onSave = true;
      }
    }
  },

  pyright = {},

  rust_analyzer = {
    cmd = { "rust-analyzer" },
    settings = {
      ["rust-analyzer"] = {
        ["cargo"] = {
          features = "all",
          runBuildScripts = true,
        },
        checkOnSave = {
          command = "clippy"
        },
      }
    },
  },

  wgsl_analyzer = {
    cmd = { "wgsl_analyzer" }
  },

  sumneko_lua = {
    lspconfig = {
      cmd = { "lua-language-server" },
    }
  }
}

for server, config in pairs(servers) do
  config.on_attach = make_on_attach(config)
  config.flags = {
    debounce_text_changes = 150,
  }
  config.capabilities = capabilities

  if lspconfig[server] ~= nil then
    lspconfig[server].setup(config)
  else
    vim.notify("Failed to setup: " .. server, vim.log.levels.WARN)
  end
end

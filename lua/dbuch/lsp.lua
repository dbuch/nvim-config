require'lsp_signature'.setup{
  hi_parameter = "Visual",
}
require("neodev").setup({})

local lspconfig = require('lspconfig')
-- local lsp_status = require('lsp-status')

require('lspkind').init({
  mode = "text",
  symbol_map = {
    Text = '  ',
    Method = '  ',
    Function = '  ',
    Constructor = '  ',
    Field = '  ',
    Variable = '  ',
    Class = '  ',
    Interface = '  ',
    Module = '  ',
    Property = '  ',
    Unit = '  ',
    Value = '  ',
    Enum = '  ',
    Keyword = '  ',
    Snippet = '  ',
    Color = '  ',
    File = '  ',
    Reference = '  ',
    Folder = '  ',
    EnumMember = '  ',
    Constant = '  ',
    Struct = '  ',
    Event = '  ',
    Operator = '  ',
    TypeParameter = '  ',
  }
})

local function make_on_attach(config)
  return function(client, bufnr)
    if config.before then
      config.before(client)
    end

    -- omni completion source
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    require('lsp_signature').on_attach({
      floating_window_above_first = true,
      bind = false,
    }, bufnr)

    if config.after then
      config.after(client)
    end
  end
end

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
    vim.fn.sign_define(hl, { text = icon, texthl= hl, numhl = hl })
end



--[[ lsp_status.register_progress()
lsp_status.config {
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
} ]]

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
    sdk_include_prereleases = true,
    analyze_open_documents_only = false,
  },

  clangd = {
    cmd = {
      'clangd', '--offset-encoding=utf-32',
      '--clang-tidy', '--completion-style=bundled', '--header-insertion=iwyu',
      '--suggest-missing-includes', '--cross-file-rename'
    },
    -- handlers = lsp_status.extensions.clangd.setup(),
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
          runBuildScripts = "true",
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
    print("Server: " .. server)
  end
end

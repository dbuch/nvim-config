local NvimTrait = require 'dbuch.traits.nvim'

---@module 'lazy'
---@type LazyPluginSpec[]
return {
  -- {
  --   'folke/lazydev.nvim',
  --   ft = 'lua',
  --   cmd = 'LazyDev',
  --   enabled = false,
  --   dependencies = {
  --     { 'Bilal2453/luvit-meta', lazy = true },
  --   },
  --   opts = {
  --     library = {
  --       { path = 'luvit-meta/library', words = { 'vim%.uv' } },
  --     },
  --     integrations = {
  --       lspconfig = true,
  --       cmp = false,
  --     },
  --   },
  -- },
  -- {
  --   'neovim/nvim-lspconfig',
  --   event = 'VeryLazy',
  --   dependencies = {
  --     'saghen/blink.cmp',
  --   },
  --   opts = function(_, _)
  --     local _lspconfig = require 'lspconfig'
  --     return {
  --       yamlls = {},
  --       zls = {},
  --       ts_ls = {},
  --       bashls = {},
  --       omnisharp = {
  --         cmd = { 'omnisharp' },
  --         enable_editorconfig_support = true,
  --         enable_ms_build_load_projects_on_demand = false,
  --         enable_roslyn_analyzers = true,
  --         organize_imports_on_format = true,
  --         enable_import_completion = true,
  --         sdk_include_prereleases = true,
  --         analyze_open_documents_only = false,
  --       },
  --       lemminx = {},
  --       clangd = {
  --         cmd = {
  --           'clangd',
  --           '--clang-tidy',
  --           '--completion-style=bundled',
  --           '--header-insertion=iwyu',
  --           '--suggest-missing-includes',
  --           '--cross-file-rename',
  --         },
  --         init_options = {
  --           clangdFileStatus = true,
  --           usePlaceholders = true,
  --           completeUnimported = true,
  --         },
  --       },
  --       pyright = {},
  --       wgsl_analyzer = {
  --         cmd = { 'wgsl_analyzer' },
  --       },
  --     }
  --   end,
  --   config = function(_plugin, opts)
  --     -- Register LspAttach
  --     NvimTrait.on_lsp_attach(function(client, _buffer)
  --       -- vim.bo[buffer].omnifunc = 'v:lua.vim.lsp.omnifunc'
  --       if client:supports_method 'textDocument/foldingRange' then
  --         vim.wo.foldmethod = 'expr'
  --         vim.wo.foldexpr = 'v:lua.vim.lsp.foldexpr()'
  --         vim.wo.foldtext = 'v:lua.vim.lsp.foldtext()'
  --       end
  --     end)
  --
  --     require('dbuch.diagnostic').config()
  --
  --     local servers = opts --- @type table<string,table>
  --     for server, server_opts in pairs(servers) do
  --       local setup_data = {
  --         capabilities = require('blink.cmp').get_lsp_capabilities(server_opts.capabilities, true),
  --         settings = server_opts.settings or nil,
  --       }
  --       require('lspconfig')[server].setup(setup_data)
  --     end
  --   end,
  -- },
}

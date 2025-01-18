local NvimTrait = require 'dbuch.traits.nvim'

---@module 'lazy'
---@type LazyPluginSpec[]
return {
  {
    'folke/lazydev.nvim',
    dev = true,
    ft = 'lua',
    cmd = 'LazyDev',
    enabled = true,
    dependencies = {
      { 'Bilal2453/luvit-meta', lazy = true },
    },
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
      integrations = {
        lspconfig = false,
        cmp = false,
      },
    },
  },
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

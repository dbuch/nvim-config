local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

require 'nvim-treesitter'.define_modules {
  fold = {
    attach = function()
      vim.opt_local.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.opt_local.foldmethod = 'expr'
      vim.opt_local.foldenable = false
    end,
    detach = function() end,
  }
}

parser_config.wgsl = {
  install_info = {
    url = "https://github.com/szebniok/tree-sitter-wgsl",
    files = { "src/parser.c" }
  },
}

require 'treesitter-context'.setup {
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
  trim_scope = 'outer',
}

require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "c",
    "rust",
    "cpp",
    "lua",
    "css",
    "html",
    "javascript",
    "bash",
    "glsl",
    "wgsl"
  },

  highlight = {
    enable = true
  },

  refactor = {
    highlight_current_scope = { enable = true },
  },

  textobjects = {
    enable = true,
    lookahead = true
  },

  indent = {
    'enabled'
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  matchup = {
    enable = true,
  },

  fold = {
    enable = true,
    disable = { 'rst', 'make' }
  },

  context_commentstring = { enable = true, enable_autocmd = false }
}

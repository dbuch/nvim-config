local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

require("nvim-treesitter").define_modules({
  fold = {
    attach = function()
      vim.opt_local.spell = true
      vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt_local.foldmethod = "expr"
      vim.opt_local.foldenable = false
    end,
    detach = function() end,
  },
})

parser_config.wgsl = {
  install_info = {
    url = "https://github.com/szebniok/tree-sitter-wgsl",
    files = { "src/parser.c" },
  },
}

require("treesitter-context").setup({
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
  trim_scope = "outer",
})

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c",
    "c_sharp",
    "rust",
    "cpp",
    "lua",
    "css",
    "html",
    "javascript",
    "bash",
    "glsl",
    "wgsl",
    "nu",
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  refactor = {
    highlight_current_scope = { enable = true },
  },

  textobjects = {
    enable = true,
    lookahead = true,
    lsp_interop = {
      enable = true,
    },
  },

  indent = {
    "enabled",
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
    disable = { "rst", "make" },
  },

  context_commentstring = { enable = true, enable_autocmd = false },

  disable = function(_, buf)
    local max_filesize = 1024 * 1024 -- MiB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > max_filesize then
      vim.notify("Treesitter is disabled due to huge filesize (1MiB)", vim.log.levels.WARN)
      return true
    end
  end,
})

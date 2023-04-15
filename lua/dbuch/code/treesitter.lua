return {
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufReadPre',
    opts = {
      enable = true,
      max_lines = 5,
      trim_scope = 'outer',
    },
    config = true,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    -- event = { 'BufReadPost', 'BufNewFile' },
    event = 'BufReadPre',
    dependencies = {
      -- 'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-refactor',
    },
    opts = {
      ensure_installed = {
        'c',
        'css',
        'c_sharp',
        'cpp',
        'lua',
        'rust',
        'html',
        'javascript',
        'typescript',
        'bash',
        'wgsl',
        'sql',
        'markdown',
        'markdown_inline',
        'python',
        'regex',
        'query',
        -- 'help',
        'toml',
        'yaml',
        'json',
        'vim',
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
        'enabled',
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = 'gnn',
          node_incremental = 'grn',
          scope_incremental = 'grc',
          node_decremental = 'grm',
        },
      },
      matchup = {
        enable = true,
      },
      fold = {
        enable = true,
        disable = { 'rst', 'make' },
      },
      context_commentstring = { enable = true, enable_autocmd = false },
      disable = function(_, buf)
        local max_filesize = 1024 * 1024 -- MiB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          vim.notify('Treesitter is disabled due to huge filesize (1MiB)', vim.log.levels.WARN)
          return true
        end
      end,
    },
    config = function(_, opts)
      require('nvim-treesitter').define_modules {
        fold = {
          attach = function()
            vim.opt_local.spell = true
            vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.opt_local.foldmethod = 'expr'
            vim.opt_local.foldenable = false
          end,
          detach = function() end,
        },
      }

      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}

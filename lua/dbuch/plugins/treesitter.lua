---@return table
local function ensure()
  local base = {
    'c',
    'css',
    'c_sharp',
    'cpp',
    'lua',
    'rust',
    'html',
    'javascript',
    'typescript',
    'wgsl',
    'sql',
    'markdown',
    'markdown_inline',
    'python',
    'regex',
    'query',
    'toml',
    'yaml',
    'json',
    'vim',
  }
  if not vim.loop.os_uname().sysname:match 'Windows' then
    table.insert(base, 'bash')
  end
  return base
end

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
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-refactor',
    },
    opts = {
      ensure_installed = ensure(),
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
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
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
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}

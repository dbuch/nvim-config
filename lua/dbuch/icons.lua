return {
  file = {
    file = '',
    modified = '',
    readonly = '',
    new = '',
  },
  folder = {
    closed = '',
    open = '',
    empty = 'ﰊ',
    collapsed = '',
    expanded = '',
  },
  dap = {
    DapBreakpoint = '',
    DapBreakpointCondition = '',
    DapBreakpointRejected = '',
    DapLogPoint = '',
    DapStopped = '',
  },
  diagnostics = {
    DiagnosticSignError = '●',
    DiagnosticSignWarn = '●',
    DiagnosticSignInfo = '●',
    DiagnosticSignHint = '○',
  },
  count_chars = {
    '⒈',
    '⒉',
    '⒊',
    '⒋',
    '⒌',
    '⒍',
    '⒎',
    '⒏',
    '⒐',
    '⒑',
    '⒒',
    '⒓',
    '⒔',
    '⒕',
    '⒖',
    '⒗',
    '⒘',
    '⒙',
    '⒚',
    '⒛',
  },
  completion_source = {
    nvim_lsp = 'ﲳ',
    nvim_lua = '',
    treesitter = '',
    path = 'ﱮ',
    buffer = '﬘',
    zsh = '',
    vsnip = '',
    spell = '暈',
  },
  ---@param t table<string, string>
  define_sign = function(t)
    for name, text in pairs(t) do
      vim.fn.sign_define(name, { text = text, texthl = name })
    end
  end,
}

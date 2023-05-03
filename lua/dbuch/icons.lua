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
    empty = '󰜌',
    collapsed = '',
    expanded = '',
  },
  dap = {
    DapBreakpoint = '',
    DapBreakpointCondition = '',
    DapBreakpointRejected = '',
    DapLogPoint = '󰌑',
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
    nvim_lsp = '󰞵',
    nvim_lua = '',
    treesitter = '',
    path = '󰝰',
    buffer = '󱈛',
    zsh = '',
    vsnip = '',
    spell = '󰓆',
  },
  ---@param t table<string, string>
  define_signs = function(t)
    for name, text in pairs(t) do
      vim.fn.sign_define(name, { text = text, texthl = name })
    end
  end,
}

vim.diagnostic.config {
  virtual_text = { source = true },
  severity_sort = true,
  update_in_insert = true,
}

local function DefineSigns(t)
  for name, text in pairs(t) do
    vim.fn.sign_define(name, { text = text, texthl = name })
  end
end

vim.api.nvim_set_hl(0, 'LspCodeLens', { link = 'WarningMsg' })

DefineSigns {
  DiagnosticSignError = '●',
  DiagnosticSignWarn = '●',
  DiagnosticSignInfo = '●',
  DiagnosticSignHint = '○',
}

local orig_signs_handler = vim.diagnostic.handlers.signs

-- Override the built-in signs handler to aggregate signs
vim.diagnostic.handlers.signs = {
  show = function(ns, bufnr, _, opts)
    local diagnostics = vim.diagnostic.get(bufnr)

    -- Find the "worst" diagnostic per line
    local max_severity_per_line = {}
    for _, d in pairs(diagnostics) do
      local m = max_severity_per_line[d.lnum]
      if not m or d.severity < m.severity then
        max_severity_per_line[d.lnum] = d
      end
    end

    -- Pass the filtered diagnostics (with our custom namespace) to
    -- the original handler
    local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
    orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
  end,

  hide = orig_signs_handler.hide,
}

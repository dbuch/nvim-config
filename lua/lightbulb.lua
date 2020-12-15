local M = {}

--local dev = require('luadev')
--local icons = require('constants').icons['lightbulp']

vim.fn.sign_define('lsp_code_action_lightbulb', {text = '💡', texthl = '', linehl = '', numhl = ''})

function M.test()
  local bufnum = vim.api.nvim_get_current_buf()
  vim.fn.sign_unplace('ns_lightbulb', { buffer = bufnum})
  if #vim.lsp.buf_get_clients(0) == 0 then
    return
  end

  local params = vim.lsp.util.make_range_params()

  params.context = {
    diagnostics = vim.lsp.diagnostic.get_line_diagnostics()
  }

  local results_lsp, err = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 10000)
  if err then
    print("ERROR: " .. err)
    return
  end

  if not results_lsp or vim.tbl_isempty(results_lsp) then
    print("No results from textDocument/codeAction")
    return
  end

  local _, response = next(results_lsp)
  if not response then
    return
  end

  local results = response.result
  if not results or #results == 0 then
    return
  end

  local line, _ = unpack(vim.api.nvim_win_get_cursor(0))
  vim.fn.sign_place(0, 'ns_lightbulb', 'lsp_code_action_lightbulb', bufnum, { lnum = line, priority = 20 })
end

vim.cmd [[augroup lightbulp]]
vim.cmd [[  autocmd CursorHold <buffer> lua require('lightbulp').test()]]
vim.cmd [[augroup END]]

return M

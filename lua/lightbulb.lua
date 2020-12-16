local M = {}

local dev = require('luadev')
--local icons = require('constants').icons['lightbulb']

vim.fn.sign_define('lsp_code_action_lightbulb', {text = '💡', texthl = '', linehl = '', numhl = ''})

function M.show()
  local bufnum = vim.api.nvim_get_current_buf()
  vim.fn.sign_unplace('ns_lightbulb', { buffer = bufnum })
  if #vim.lsp.buf_get_clients(0) == 0 then
    return
  end

  local params = vim.lsp.util.make_range_params()

  params.context = {
    diagnostics = vim.lsp.diagnostic.get_line_diagnostics()
  }

  vim.lsp.buf_request(bufnum, "textDocument/codeAction", params, function(err, _, result, _, _)
    if err or not result then return end

    if not result or #result == 0 or vim.tbl_isempty(result) then
      return
    end

    local line, _ = unpack(vim.api.nvim_win_get_cursor(0))
    vim.fn.sign_place(0, 'ns_lightbulb', 'lsp_code_action_lightbulb', bufnum, { lnum = line, priority = 20 })
  end)
end


function M.register()
  vim.cmd [[augroup lightbulb]]
  --vim.cmd [[  autocmd CursorHold <buffer> lua require('lightbulb').test()]]
  vim.cmd [[  autocmd CursorHold * lua require('lightbulb').show()]]
  vim.cmd [[augroup END]]
end

return M

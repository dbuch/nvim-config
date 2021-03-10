local M = {}

local sign_group = 'ns_lightbulb'
local sign_name = 'lsp_code_action_lightbulb'

vim.fn.sign_define(sign_name, {text = '💡', texthl = '', linehl = 'CursorLine', numhl = ''})

function M.on_CursorHold()
  local bufnum = vim.api.nvim_get_current_buf()
  vim.api.sign_unplace(sign_group, { buffer = bufnum })
  if #vim.lsp.buf_get_clients(0) == 0 then
    return
  end

  local params = vim.lsp.util.make_range_params()
  params.context = {
    diagnostics = vim.lsp.diagnostic.get_line_diagnostics()
  }

  vim.lsp.buf_request(bufnum, "textDocument/codeAction", params, function(err, _, result, _, _)
    if err or not result or #result == 0 or vim.tbl_isempty(result) then return end

    local line, _ = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.sign_place(0, sign_group, sign_name, bufnum, { lnum = line, priority = 20 })
  end)
end


function M.on_attach(client)
  if client.resolved_capabilities['code_action'] then
    vim.api.nvim_command('augroup '.. sign_group)
      vim.api.nvim_command('au! * <buffer>')
      vim.api.nvim_command('au CursorHold <buffer> lua require(\'lightbulb\').on_CursorHold()')
    vim.api.nvim_command('augroup END')
  end
end

return M

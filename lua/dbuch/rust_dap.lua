---@class CargoArgs
---@field workspaceRoot string|nil
---@field cargoArgs string[]
---@field cargoExtraArgs string[]
---@field expectTest boolean|nil
---@field overrideCargo string|nil

---@class Runnable
---@field label string
---@field kind string
---@field args CargoArgs
---@field location any

M = {}

---comment
---@param callback function<Runnable[]>
function M.query_runnables(callback)
  local bufnum = vim.api.nvim_get_current_buf()
  vim.lsp.buf_request(
    bufnum,
    "experimental/runnables",
    { textDocument = vim.lsp.util.make_text_document_params(bufnum) },
    function(err, result)
      if err then
        vim.notify("Failed to retrive runnables: " .. vim.print(err.message))
        return
      end
      callback(result)
    end
  )
end

function M.test_query()
  M.query_runnables(
    ---@param runnables Runnable[]
    function(runnables)
      for _, runnable in ipairs(runnables) do
        vim.notify(vim.inspect(runnable))
      end
    end)
end

return M

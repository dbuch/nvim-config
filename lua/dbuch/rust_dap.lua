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

---@class RunnableJobArgs
---@field command string
---@field cwd string
---@field args string[]

M = {}

---@param job RunnableJobArgs
---@param on_exit function<string, integer>
local function spawn_cargo(job, on_exit)
  local process = require('plenary.job')
  process:new({
    command = job.command,
    args = job.args,
    cwd = job.cwd,
    on_exit = on_exit,
  }):start()
end

---@param runnable Runnable
---@return RunnableJobArgs
local function into_runnable_job(runnable)
  local message_json = "--message-format=json"
  local args = runnable.args.cargoArgs

  if vim.tbl_contains(args, 'test') then
    table.insert(args, '--no-run')
  end

  if not vim.tbl_contains(args, message_json) then
    table.insert(args, message_json)
  end

  for _, value in ipairs(runnable.args.cargoExtraArgs) do
    if not vim.tbl_contains(args, value) then
      table.insert(args, value)
    end
  end

  ---@type RunnableJobArgs
  local job_args = {
    command = runnable.kind,
    working_dir = runnable.args.workspaceRoot,
    args = args
  }

  return job_args
end

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
        local job = into_runnable_job(runnable)
        spawn_cargo(job, function (output, exit_code)
          if exit_code and exit_code > 0 then
            vim.notify('Failed to execute job: ' .. vim.print(job))
            return
          end

          vim.schedule(function ()
            local output_entries = output:result()
            for _, entry in pairs(output_entries) do
              if entry and entry ~= '' then
                local artifact = vim.fn.json_decode(entry)
                if artifact and artifact.reason == 'compiler-artifact' and artifact.executable ~= vim.NIL then
                  vim.print(vim.inspect(artifact.executable))
                end
              -- local reason = vim.tbl_get(entry, 'reason')
              -- if reason then
              --   vim.notify("hurray: "..vim.print(reason))
              -- end
              end
            end
          end)
        end)
        break
      end
    end)
end

return M

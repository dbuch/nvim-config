M = {}

---@param msg string
---@param level integer|nil
local function schedule_notify(msg, level)
  vim.schedule(function()
    vim.notify(msg, level or vim.log.INFO)
  end)
end

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

  if args[1]:match('test') then
    table.insert(args, '--no-run')
  end

  if not vim.tbl_contains(args, '--quiet') then
    table.insert(args, '--quiet')
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
---@param buffer integer|nil
function M.query_runnables(callback, buffer)
  local bufnum = buffer or vim.api.nvim_get_current_buf()
  vim.lsp.buf_request(
    bufnum,
    "experimental/runnables",
    { textDocument = vim.lsp.util.make_text_document_params(bufnum) },
    ---@param err ResponseError
    ---@param runnables Runnable[]
    function(err, runnables)
      if err then
        vim.notify("Failed to retrive runnables: " .. vim.print(err.message))
        return
      end
      callback(runnables)
    end
  )
end

---@param artifact table|nil
---@return string|nil
local function get_executable(artifact)
  if artifact ~= nil and
      artifact.reason == 'compiler-artifact' and
      artifact.executable and
      artifact.target and
      vim.tbl_contains(artifact.target.crate_types, "bin") then
    return artifact.executable
  end
end

---@class CompileMessage
---@class ArtifactMessage
---@class BuildScriptMessage
---@class BuildFinishedMessage


---@param input string|string[]
---@return boolean, table|nil
local function parse_json(input)
  if type(input) == "table" then
    input = table.concat(input, '\n')
  end
  local status, json = pcall(vim.json.decode, input, { luanil = { object = true, array = true } })
  return status, json
end

function M.test_metadata()
  ---comment
  ---@param metadata_callback function<CargoMetadata>
  local function spawn_metadata(metadata_callback)
    local process = require('plenary.job')
    process:new({
      command = 'cargo',
      args = { 'metadata', '--no-deps', '--format-version=1' },
      cwd = vim.fn.getcwd(),
      on_exit = function(stream, exit_code)
        if exit_code and exit_code ~= 0 then
          schedule_notify(('Failed to execute: `cargo metadata` (%s)'):format(exit_code))
        else
          local status, metadata = parse_json(stream:result())
          if not status then
            schedule_notify('Failed to parse metadata', vim.log.levels.ERROR)
          else
            metadata_callback(metadata)
          end
        end
      end,
    }):start()
  end

  spawn_metadata(
  ---@param metadata CargoMetadata
    function(metadata)
      for _, package in pairs(metadata.packages) do
        schedule_notify(vim.inspect(package))
      end
    end)
end


function M.test_query()
  M.query_runnables(
  ---@param runnables Runnable[]
    function(runnables)
      for _, runnable in ipairs(runnables) do
        local job = into_runnable_job(runnable)
        spawn_cargo(job, function(output, exit_code)
          if exit_code and exit_code > 0 then
            schedule_notify('Failed to execute job: ' .. vim.print(job), vim.log.levels.ERROR)
            return
          end
          ---@type string[]
          local lines = output:result()
          for _, line in pairs(lines) do
            if line then
              local success, artifact = parse_json(line)
              if not success then
                schedule_notify('Failed to parse: ' .. line)
              else
                local executable = get_executable(artifact)
                if executable then
                  schedule_notify(vim.inspect(executable))
                end
              end
            end
          end
        end)
      end
    end)
end

return M

local Job = require 'plenary.job'

local function cargo_metadata_on_exit(job, code)
  if code ~= 0 then
    return
  end
  vim.schedule(function()
    for _, value in pairs(job:result()) do
      local json = vim.fn.json_decode(value)
      if type(json) == 'table' then
        local packages = json.packages
        local target_dir = json.target_directory
        local targets = {}
        for _, package in ipairs(packages) do
          for _, target in ipairs(package.targets) do
            if vim.tbl_contains(target.kind, 'bin') then
              table.insert(targets, target)
            end
          end
        end
        vim.pretty_print(targets)
      end
    end
  end)
end

local function cargo_meta()
  Job:new({
    command = 'cargo',
    args = {
      'metadata',
      '--format-version=1',
      '--offline',
      '--no-deps',
    },
    on_exit = cargo_metadata_on_exit,
  }):start()
end

vim.api.nvim_create_user_command('CargoMeta', cargo_meta, {})

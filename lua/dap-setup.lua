local M = {}

function M.open_configs()
  require'telescope'.extensions.dap.commands{}
end

function M.config()
  local dap = require('dap')
  local set = vim.keymap.set;

  vim.fn.sign_define("DapBreakpoint", {text = "🛑", texthl = "", linehl = "", numhl = ""})
  vim.fn.sign_define("DapStopped", {text = "→", texthl = "", linehl = "NvimDapStopped", numhl = ""})

  -- C/C++/Rust
  local lldb_adapter = {
    name = "lldb";
    type = "executable";
    attach = {
      pidProperty = "pid",
      pidSelect = "ask"
    };
    command = "lldb-vscode",
    env = {
      LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
    };
  }

  dap.adapters.cpp = lldb_adapter
  dap.adapters.c = lldb_adapter
  dap.adapters.rust = lldb_adapter

  require('dap.ext.vscode').load_launchjs()

  local dapui = require("dapui")
  dapui.setup({})
  dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open({})
  end
  dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close({})
  end
  dap.listeners.after.event_exited['dapui_config'] = function()
      dapui.close({})
  end

  set('n', '<F5>', function () require'dap'.continue() end)
  set('n', '<leader>db', function () require'dap'.toggle_breakpoint() end)
  set('n', '<leader>dr', function () require'dap'.repl.open() end)
  set('n', '<F10>'     , function () require'dap'.step_over({}) end)
  set('n', '<F11>'     , function () require'dap'.step_into({}) end)
  set('n', '<F12>'     , function () require'dap'.step_out({}) end)
end

function M.setup()
  vim.g.dap_virtual_text = true
end

return M

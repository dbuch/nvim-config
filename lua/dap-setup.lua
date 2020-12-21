local M = {}

function M.config()
  local dap = require('dap')

    -- C/C++/Rust
  local lldb_adapter = {
      type = "executable",
      attach = {
        pidProperty = "pid",
        pidSelect = "ask"
      },
      command = "lldb-vscode", -- my binary was called 'lldb-vscode-11'
      env = {
        LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
      },
      name = "lldb"
    }

  dap.adapters.cpp = lldb_adapter
  dap.adapters.c = lldb_adapter
  dap.adapters.rust = lldb_adapter

  dap.configurations.rust = {
    {
      type = 'rust';
      request = 'launch';
      name = 'Launch';
      program = "${workspaceFolder}/target/debug/neovim-nightly-updater";
      cwd = "${workspaceFolder}";
      host = 'x86_64';
    },
  }

  require('telescope').load_extension('dap')
  require('dap.ext.vscode').load_launchjs()
end

function M.setup()
  vim.g.dap_virtual_text = true
  vim.fn.sign_define("DapBreakpoint", {text = "🛑", texthl = "", linehl = "", numhl = ""})
  vim.fn.sign_define("DapStopped", {text = "→", texthl = "", linehl = "NvimDapStopped", numhl = ""})
end

return M

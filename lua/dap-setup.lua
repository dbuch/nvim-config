local M = {}

function M.open_configs()
  require'telescope'.extensions.dap.commands{}
end

function M.config()
  local dap = require('dap')

  vim.fn.sign_define("DapBreakpoint", {text = "🛑", texthl = "", linehl = "", numhl = ""})
  vim.fn.sign_define("DapStopped", {text = "→", texthl = "", linehl = "NvimDapStopped", numhl = ""})
  vim.g.dap_virtual_text = true

    -- C/C++/Rust
  local lldb_adapter = {
      name = "lldb";
      type = "executable";
      attach = {
        pidProperty = "pid",
        pidSelect = "ask"
      };
      command = "lldb-vscode";
      env = {
        LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
      };
    }

  dap.adapters.cpp = lldb_adapter
  dap.adapters.c = lldb_adapter
  dap.adapters.rust = lldb_adapter

  require('dap.ext.vscode').load_launchjs()

  vim.cmd [[nnoremap <silent> <F5> :lua require'dap'.continue()<CR>]]
  vim.cmd [[nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>]]
  vim.cmd [[nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>]]
  vim.cmd [[nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>]]
  vim.cmd [[nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>]]
  vim.cmd [[nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>]]
end

function M.setup()
end

return M

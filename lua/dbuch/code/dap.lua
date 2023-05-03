--TODO: This module is rudimentary by any mean should set this up properly
return {
  {
    'mfussenegger/nvim-dap',
    lazy = false,
    dependencies = {
      'mfussenegger/nvim-dap-python',
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "󰌑", texthl = "DiagnosticHint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })

      local dap = require'dap'
      local ui = require'dapui'

      dap.listeners.after.event_initialized["dapui_config"] = function()
        ui.open()
      end

      dap.listeners.before.event_terminated["dapui_config"] = function()
        ui.close()
      end

      dap.listeners.before.event_exited["dapui_config"] = function()
        ui.close()
      end

      dap.adapters.lldb = {
        type = "executable",
        command = "lldb-vscode",
        name = "lldb",
      }

      ui.setup({
        library = { plugins = { "nvim-dap-ui" }, types = true },
      })

    end,
  },
}

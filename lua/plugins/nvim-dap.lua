return {
  {
    "mfussenegger/nvim-dap",
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      local dap_python = require("dap-python")
      
      -- Setup with uv (it will handle the python execution)
      dap_python.setup("uv")
      
      -- Configure pytest as test runner
      dap_python.test_runner = "pytest"
      
      -- Optional: Add custom pytest configurations
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'pytest: Current File',
        module = 'pytest',
        args = { '${file}', '-v' },
        console = 'integratedTerminal',
      })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { 
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      
      dapui.setup()
      
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}

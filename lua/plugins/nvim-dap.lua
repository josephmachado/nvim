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
      table.insert(require("dap").configurations.python, {
        type = "python",
        request = "launch",
        name = "pytest: Current File",
        module = "pytest",
        args = { "${file}", "-v" },
        console = "integratedTerminal",
      })
    end,
  },
  {
    -- Elixir (via ElixirLS debug adapter, install with :MasonInstall elixir-ls)
    "mfussenegger/nvim-dap",
    ft = "elixir",
    config = function()
      local dap = require("dap")

      dap.adapters.mix_task = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/elixir-ls/debug_adapter.sh",
        args = {},
      }

      local base = {
        type = "mix_task",
        request = "launch",
        task = "test",
        startApps = true,
        projectDir = "${workspaceFolder}",
        -- Uncomment to speed up startup on big projects:
        -- debugAutoInterpretAllModules = false,
        -- debugInterpretModulesPatterns = { "MyApp.*", "MyAppWeb.*" },
      }

      dap.configurations.elixir = {
        vim.tbl_extend("force", base, {
          name = "mix test: All",
          taskArgs = { "--trace" },
          requireFiles = { "test/**/test_helper.exs", "test/**/*_test.exs" },
        }),
        vim.tbl_extend("force", base, {
          name = "mix test: Current File",
          taskArgs = { "${file}", "--trace" },
          requireFiles = { "test/**/test_helper.exs", "${file}" },
        }),
        vim.tbl_extend("force", base, {
          name = "mix test: Test Under Cursor",
          taskArgs = function()
            return { vim.fn.expand("%:p") .. ":" .. vim.fn.line("."), "--trace" }
          end,
          requireFiles = { "test/**/test_helper.exs", "${file}" },
        }),
      }
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

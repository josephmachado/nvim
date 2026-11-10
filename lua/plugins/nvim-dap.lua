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
  -- {
  --   -- Elixir (via ElixirLS debug adapter, install with :MasonInstall elixir-ls)
  --   "mfussenegger/nvim-dap",
  --   ft = "elixir",
  --   config = function()
  --     local dap = require("dap")
  --
  --     dap.adapters.mix_task = {
  --       type = "executable",
  --       command = vim.fn.stdpath("data") .. "/mason/packages/elixir-ls/debug_adapter.sh",
  --       args = {},
  --     }
  --
  --     local base = {
  --       type = "mix_task",
  --       request = "launch",
  --       task = "test",
  --       startApps = true,
  --       projectDir = "${workspaceFolder}",
  --       -- Uncomment to speed up startup on big projects:
  --       -- debugAutoInterpretAllModules = false,
  --       -- debugInterpretModulesPatterns = { "MyApp.*", "MyAppWeb.*" },
  --     }
  --
  --     dap.configurations.elixir = {
  --
  --       vim.tbl_extend("force", base, {
  --         name = "phx.server",
  --         task = "phx.server",
  --         taskArgs = {},
  --         startApps = false, -- phx.server starts the apps itself
  --         exitAfterTaskReturns = false, -- keep the debugger attached while the server runs
  --         env = { MIX_ENV = "dev" },
  --       }),
  --
  --       vim.tbl_extend("force", base, {
  --         name = "mix test: All",
  --         taskArgs = { "--trace" },
  --         requireFiles = { "test/**/test_helper.exs", "test/**/*_test.exs" },
  --       }),
  --       vim.tbl_extend("force", base, {
  --         name = "mix test: Current File",
  --         taskArgs = { "${file}", "--trace" },
  --         requireFiles = { "test/**/test_helper.exs", "${file}" },
  --       }),
  --       vim.tbl_extend("force", base, {
  --         name = "mix test: Test Under Cursor",
  --         taskArgs = function()
  --           return { vim.fn.expand("%:p") .. ":" .. vim.fn.line("."), "--trace" }
  --         end,
  --         requireFiles = { "test/**/test_helper.exs", "${file}" },
  --       }),
  --     }
  --   end,
  -- },
  {
  -- Debugging UI (requires Neovim 0.11+)
  "igorlfs/nvim-dap-view",
  lazy = false, -- must be loaded before a session starts for auto_toggle to work
  dependencies = { "mfussenegger/nvim-dap" },
  opts = {
    winbar = {
      show = true,
      -- "console" merges nvim-dap's terminal into the view
      sections = { "scopes", "watches", "breakpoints", "threads", "exceptions", "repl", "console" },
      default_section = "scopes",
      show_keymap_hints = true, -- shows S/W/B/T/... next to each label
      controls = {
        enabled = true, -- clickable play/step/terminate buttons in the winbar
        position = "right",
      },
    },
    windows = {
      size = 0.5,         -- 30% of the editor width (vertical split)
      position = "right",  -- "left" | "right" | "above" | "below"
      terminal = {
        size = 0.5,
        position = "left",
        hide = {},        -- console is merged into the view, so this rarely matters
      },
    },
    -- Auto open when a session starts, auto close when all sessions finish
    -- Use "keep_terminal" if you want to read program output after it exits
    auto_toggle = true,
    -- Reopen dapview when switching tabs
    follow_tab = true,
  },
},
}

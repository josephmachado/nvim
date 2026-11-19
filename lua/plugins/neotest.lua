return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- adapters
    "nvim-neotest/neotest-python",
    "jfpedroza/neotest-elixir",
    -- optional: only needed for the "debug test" keymap
    "mfussenegger/nvim-dap",
  },
  config = function()
    require("neotest").setup {
      adapters = {
        require "neotest-python" {
          runner = "pytest",
          -- python = ".venv/bin/python", -- uncomment if you use a project venv
          dap = { justMyCode = false },
        },
        require "neotest-elixir" {
          -- mix_task = "test", -- the Mix task used to run tests (default)
        },
      },
    }
  end,
  keys = {
    {
      "<leader>ta",
      function()
        require("neotest").run.run(vim.fn.getcwd())
      end,
      desc = "Test: run all",
    },
    {
      "<leader>tn",
      function()
        require("neotest").run.run()
      end,
      desc = "Test: run nearest",
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run(vim.fn.expand "%")
      end,
      desc = "Test: run file",
    },
    {
      "<leader>tr",
      function()
        require("neotest").run.run_last()
      end,
      desc = "Test: run most recent",
    },
    {
      "<leader>td",
      function()
        require("neotest").run.run { strategy = "dap" }
      end,
      desc = "Test: debug nearest",
    },
    {
      "<leader>tS",
      function()
        require("neotest").run.stop()
      end,
      desc = "Test: stop",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Test: summary",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open { enter = true }
      end,
      desc = "Test: output",
    },
    {
      "<leader>tp",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Test: output panel",
    },
  },
}

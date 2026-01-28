return {
  "olimorris/codecompanion.nvim",
  event = "BufEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim"
  },
  opts = {
    interactions = {
      chat = {
        adapter = "ollama",
        model = "qwen2.5-coder:7b"
      },
      inline = {
        adapter = "ollama",
        model = "qwen2.5-coder:7b"
      },
      cmd = {
        adapter = "ollama",
        model = "qwen2.5-coder:7b"
      },
      background = {
        adapter = "ollama",
        model = "qwen2.5-coder:7b"
      },
    },
    adapters = {
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          schema = {
            num_ctx = {
              default = 16384,
            },
          },
        })
      end,
    },
    opts = {
      log_level = "INFO",
    },
  },
  config = function(_, opts)
    require("codecompanion").setup(opts)
    -- Keymaps
    local map = vim.keymap.set
    map("n", "<C-a>", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion actions" })
    map("v", "<C-a>", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion actions" })
    map("n", "<Leader><Leader>i", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle chat" })
    map("v", "<Leader><Leader>i", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle chat" })
    map("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add to chat" })
  end,
}

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
        adapter = "gemini",
        model = "gemini-2.0-flash-exp"
      },
      inline = {
        adapter = "gemini",
        model = "gemini-2.0-flash-exp"
      },
      cmd = {
        adapter = "gemini",
        model = "gemini-2.0-flash-exp"
      },
      background = {
        adapter = "gemini",
        model = "gemini-2.0-flash-exp"
      },
    },
    display = {
      chat = {
        window = {
          layout = "vertical", -- or "horizontal", "float"
          border = "rounded",
          width = 0.45,
          height = 0.8,
        },
        -- Show status indicators
        show_settings = false,      -- Shows adapter/model info
        show_token_count = true,   -- Shows token usage
        show_header_separator = false,
        render_headers = true,
        show_tools_processing = true,
        -- Status messages
        intro_message = "Welcome to CodeCompanion!",
        separator = "─",
        show_references = true,
      },
      action_palette = {
        width = 95,
        height = 10,
      },
      diff = {
        enabled = true,
      },
      icons = {
        chat_context = "📎️", -- You can also apply an icon to the fold
      },
      fold_context = true,
    },
    -- adapters = {
    --   ollama = function()
    --     return require("codecompanion.adapters").extend("ollama", {
    --       schema = {
    --         num_ctx = {
    --           default = 16384,
    --         },
    --       },
    --     })
    --   end,
    -- },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true
        }
      }
    },
    opts = {
      log_level = "DEBUG", -- Changed to DEBUG to see more info
      send_code = true,
      use_default_actions = true,
      use_default_prompt_library = true,
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

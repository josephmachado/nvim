-- plugins/quarto.lua
return {
  {
    "quarto-dev/quarto-nvim",
    dev = false,
    ft = { "quarto", "markdown" }, -- Add this line to trigger on quarto/markdown files
keys = {
  { "<leader>qp", "<cmd>QuartoPreview<cr>", desc = "Quarto Preview" },
},
    opts = {
      lspFeatures = {
        enabled = true,
        chunks = 'curly',
      },
      codeRunner = {
        enabled = true,
        default_method = 'slime',
      },
    },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
      "jpalardy/vim-slime",  -- Explicit dependency
    },

config = function(_, opts)
  require("quarto").setup(opts)
  -- Keymaps to open terminals
  vim.keymap.set("n", "<leader>tp", function()
  -- Look for common venv directories
  local venv_paths = {
    ".venv/bin/activate",
    "../.venv/bin/activate",
    "venv/bin/activate",
    "env/bin/activate",
  }
  
  local activate_cmd = ""
  for _, path in ipairs(venv_paths) do
    if vim.fn.filereadable(path) == 1 then
      activate_cmd = "source " .. path .. " && "
      break
    end
  end
  
  vim.cmd("vsplit term://" .. activate_cmd .. "python3")
end, { desc = "open python terminal" })


  vim.keymap.set("n", "<leader>tr", function()
    vim.cmd("vsplit term://R")
  end, { desc = "open R terminal" })

  vim.keymap.set("n", "<leader>tb", function()
    vim.cmd("vsplit term://bash")
  end, { desc = "open bash terminal" })

  vim.keymap.set("n", "<leader>te", function()
    vim.cmd("vsplit term://iex -S mix")
  end, { desc = "open elixir terminal" })

  -- Add runner keymaps
  local runner = require("quarto.runner")
  vim.keymap.set("n", "<localleader>rc", runner.run_cell,  { desc = "run cell", silent = true })
  vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
  vim.keymap.set("n", "<localleader>rA", runner.run_all,   { desc = "run all cells", silent = true })
  vim.keymap.set("n", "<localleader>rl", runner.run_line,  { desc = "run line", silent = true })
  vim.keymap.set("v", "<localleader>r",  runner.run_range, { desc = "run visual range", silent = true })
  vim.keymap.set("n", "<localleader>RA", function()
    runner.run_all(true)
  end, { desc = "run all cells of all languages", silent = true })
end,
  },

  { -- send code from python/r/qmd documents to a terminal REPL
    'jpalardy/vim-slime',
    lazy = false,
    init = function()
      vim.g.slime_target = 'neovim'
      vim.g.slime_no_mappings = true
      vim.g.slime_bracketed_paste = 1

      -- send an extra Enter after each paste so the Python REPL runs the block
      vim.cmd [[
        function! SlimeOverride_EscapeText_quarto(text)
          return [a:text, "\n"]
        endfunction
        function! SlimeOverride_EscapeText_python(text)
          return [a:text, "\n"]
        endfunction
      ]]
    end,
    config = function()
      vim.g.slime_input_pid = false
      vim.g.slime_suggest_default = true
      vim.g.slime_menu_config = false
      vim.g.slime_neovim_ignore_unlisted = true

      local function mark_terminal()
        local job_id = vim.b.terminal_job_id
        vim.print('job_id: ' .. job_id)
      end

      local function set_terminal()
        vim.fn.call('slime#config', {})
      end
      vim.keymap.set('n', '<leader>cm', mark_terminal, { desc = '[m]ark terminal' })
      vim.keymap.set('n', '<leader>cs', set_terminal, { desc = '[s]et terminal' })

      vim.keymap.set('n', '<localleader>ss', '<Plug>SlimeParagraphSend', { desc = 'slime send paragraph' })
      vim.keymap.set('n', '<localleader>sl', '<Plug>SlimeLineSend', { desc = 'slime send line' })
      vim.keymap.set('x', '<localleader>s', '<Plug>SlimeRegionSend', { desc = 'slime send selection' })
      vim.keymap.set('n', '<localleader>sc', '<Plug>SlimeConfig', { desc = 'slime config' })
    end,
  },

  { -- paste an image from the clipboard or drag-and-drop
    'HakonHarnes/img-clip.nvim',
    event = 'BufEnter',
    ft = { 'markdown', 'quarto', 'latex' },
    opts = {
      default = {
        dir_path = 'img',
      },
      filetypes = {
        markdown = {
          url_encode_path = true,
          template = '![$CURSOR]($FILE_PATH)',
          drag_and_drop = {
            download_images = false,
          },
        },
        quarto = {
          url_encode_path = true,
          template = '![$CURSOR]($FILE_PATH)',
          drag_and_drop = {
            download_images = false,
          },
        },
      },
    },
    config = function(_, opts)
      require('img-clip').setup(opts)
      vim.keymap.set('n', '<leader>ii', ':PasteImage<cr>', { desc = 'insert [i]mage from clipboard' })
    end,
  },
}

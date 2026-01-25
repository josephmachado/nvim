require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Telescope: Find markdown files
map("n", "<leader>fm", function()
  require('telescope.builtin').find_files({
    find_command = {'rg', '--files', '--glob', '*.md'}
  })
end, { desc = "Find markdown files" })

-- Telescope: Search in markdown files
map("n", "<leader>sm", function()
  require('telescope.builtin').live_grep({
    glob_pattern = '*.md'
  })
end, { desc = "Search in markdown files" })

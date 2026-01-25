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

-- add a word to Harper dictionary
vim.keymap.set('n', '<leader>da', function()
  local word = vim.fn.expand('<cword>')
  local dict_path = vim.fn.expand('~/.config/harper-ls/dictionary.txt')
  vim.fn.system('mkdir -p ~/.config/harper-ls')
  vim.fn.system(string.format('echo "%s" >> %s', word, dict_path))
  print('Added "' .. word .. '" to Harper dictionary')
  vim.cmd('LspRestart harper_ls')
end, { desc = 'Add word to Harper dictionary' })

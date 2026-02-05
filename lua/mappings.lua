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

map("n", "<leader>cd", "<cmd>CodeDiff<CR>", { desc = "Code Diffs" })

map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
map("n", "<leader>dc", "<cmd>DapContinue<CR>", { desc = "Start/Continue debugging" })
map("n", "<leader>di", "<cmd>DapStepInto<CR>", { desc = "Step into" })
map("n", "<leader>do", "<cmd>DapStepOver<CR>", { desc = "Step over" })
map("n", "<leader>dO", "<cmd>DapStepOut<CR>", { desc = "Step out" })
map("n", "<leader>dx", "<cmd>DapTerminate<CR>", { desc = "Terminate debugging" })
map("n", "<leader>du", function() require("dapui").toggle() end, { desc = "Toggle DAP UI" })
map("n", "<leader>dtn", function() require("dap-python").test_method() end, { desc = "Debug nearest test" })
map("n", "<leader>dtc", function() require("dap-python").test_class() end, { desc = "Debug test class" })
map("n", "<leader>dtf", function() require("dap-python").test_file() end, { desc = "Debug test file" })

vim.keymap.set('n', '<leader>tt', ':tabnew | term<CR>', { desc = 'Open terminal in new tab' })

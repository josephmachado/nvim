require "nvchad.autocmds"

-- Spell check only for prose files (markdown / quarto; .qmd -> ft=quarto)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "quarto", "qmd" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us" -- 'spelllang' is global, but setting it here is fine
  end,
})

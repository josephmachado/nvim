require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "pyright"}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 

vim.lsp.config.harper_ls = {
  filetypes = { "markdown", "qmd", "txt", "python", "sh" },
}
vim.lsp.enable("harper_ls")

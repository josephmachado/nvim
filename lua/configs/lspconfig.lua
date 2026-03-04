require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "pyright"}
vim.lsp.enable(servers)

-- Ruff setup with format on save
vim.lsp.config.ruff = {
  on_attach = function(client, bufnr)
    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
}
vim.lsp.enable("ruff")

-- Pyright config - disable organize imports since Ruff handles it
vim.lsp.config.pyright = {
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
  },
}

-- Harper LS
vim.lsp.config.harper_ls = {
  filetypes = { "markdown", "qmd", "txt", "python", "sh", "quarto" },
}
vim.lsp.enable("harper_ls")

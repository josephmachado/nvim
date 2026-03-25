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

-- ltex 
vim.lsp.config.ltex = {
  filetypes = { "markdown", "txt", "quarto", "qmd" },
  settings = {
    ltex = {
      language = "en-US",
      disabledRules = {},
      additionalRules = {
        enablePickyRules = true,
        motherTongue = "en-US",
      },
      checkFrequency = "save",
    },
  },
}
vim.lsp.enable("ltex")

-- vale linter for grammar 
vim.lsp.config.vale_ls = {
  cmd = { "/usr/local/bin/vale-ls" },
  filetypes = { "markdown", "txt", "quarto", "qmd" },
}
--vim.lsp.enable("vale_ls")

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.md", "*.qmd", "*.txt" },
  callback = function()
    vim.diagnostic.setqflist({ open = false })
  end,
})


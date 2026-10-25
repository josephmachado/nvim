require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "pyright" }
vim.lsp.enable(servers)

-- Ruff: one client for normal .py files (with hover + format on save),
-- a second one for otter's hidden buffers in .qmd files (no hover, so pyright answers K)
local function is_otter(bufnr)
  return vim.api.nvim_buf_get_name(bufnr):match("%.otter%.%w+$") ~= nil
end

local function ruff_root(bufnr)
  return vim.fs.root(bufnr, { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" })
    or vim.fn.getcwd()
end

vim.lsp.config.ruff = {
  root_dir = function(bufnr, on_dir)
    if not is_otter(bufnr) then
      on_dir(ruff_root(bufnr))
    end
  end,
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

vim.lsp.config.ruff_otter = {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_dir = function(bufnr, on_dir)
    if is_otter(bufnr) then
      on_dir(ruff_root(bufnr))
    end
  end,
  on_init = function(client)
    client.server_capabilities.hoverProvider = false
  end,
}

vim.lsp.enable({ "ruff", "ruff_otter" })

-- Elixir setup
vim.lsp.enable("elixirls")

-- vim.lsp.config("expert", {
--   settings = {
--     workspaceSymbols = {
--       minQueryLength = 0
--     }
--   }
-- })

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
-- vim.lsp.config.ltex = {
--   filetypes = { "markdown", "txt", "quarto", "qmd" },
--   settings = {
--     ltex = {
--       language = "en-US",
--       disabledRules = {},
--       additionalRules = {
--         enablePickyRules = true,
--         motherTongue = "en-US",
--       },
--       checkFrequency = "save",
--     },
--   },
-- }
-- vim.lsp.enable("ltex")

-- vale linter for grammar
-- vim.lsp.config.vale_ls = {
--   cmd = { "/usr/local/bin/vale-ls" },
--   filetypes = { "markdown", "txt", "quarto", "qmd" },
-- }
-- vim.lsp.enable("vale_ls")

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.md", "*.qmd", "*.txt" },
  callback = function()
    vim.diagnostic.setqflist({ open = false })
  end,
})

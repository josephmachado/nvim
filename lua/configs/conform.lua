local async_ft = { elixir = true, eelixir = true, heex = true }

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
  },

  -- Fast formatters: run before saving (blocks briefly)
  format_on_save = function(bufnr)
    if async_ft[vim.bo[bufnr].filetype] then
      return
    end
    return { timeout_ms = 1000, lsp_format = "fallback" }
  end,

  -- Elixir: save immediately, format in the background, then save again
  format_after_save = function(bufnr)
    if not async_ft[vim.bo[bufnr].filetype] then
      return
    end
    return { lsp_format = "fallback" }
  end,
}

return options

return {
  "3rd/image.nvim",
  build = false,
  ft = { "markdown", "quarto" },
  config = function()
    require("image").setup({
      backend = "kitty",
      processor = "magick_cli",
      integrations = {
        markdown = {
          enabled = true,
          filetypes = { "markdown", "quarto" },
        },
      },
    })
  end,
}

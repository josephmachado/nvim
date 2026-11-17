return {
  "stevearc/aerial.nvim",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
    layout = {
      default_direction = "right",
      min_width = 30,
    },
    show_guides = true,
  },
}

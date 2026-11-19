return {
  "stevearc/aerial.nvim",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    backends = { "treesitter", "lsp", "markdown", "asciidoc", "man", "org" },
    layout = {
      default_direction = "right",
      min_width = 40,
    },
    show_guides = true,
  },
}

return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  keys = {
    { "<leader>df", function() require('neogen').generate({ type = 'func' }) end, desc = "Generate function docstring" },
    { "<leader>dc", function() require('neogen').generate({ type = 'class' }) end, desc = "Generate class docstring" },
  },
  config = function()
    require('neogen').setup({
      enabled = true,
      languages = {
        python = {
          template = {
            annotation_convention = "google_docstrings",
          },
        },
      },
    })
  end,
}

return {
  'danymat/neogen',
  config = function()
    require('neogen').setup {
      enabled = true,
      languages = {
        python = {
          template = {
            annotation_convention = 'numpydoc', -- or "google" or "numpydoc"
            use_lsp_format = true, -- This is key - tells Neogen to use LSP type info
            include_parameters_type = true, -- Ensures parameter types are included
            include_return_type = true, -- Ensures return types are included
          },
        },
      },
    }
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap('n', '<Leader>nf', ":lua require('neogen').generate()<CR>", opts)
  end,
  -- Uncomment next line if you want to follow only stable versions
  -- version = "*"
}

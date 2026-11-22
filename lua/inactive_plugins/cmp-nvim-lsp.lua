return {
  "hrsh7th/cmp-nvim-lsp",
  config = function()
    local lsp_source = require("cmp_nvim_lsp.source")
    local orig_complete = lsp_source.complete
    lsp_source.complete = function(self, params, callback)
      return orig_complete(self, params, function(response)
        if response == vim.NIL then response = nil end
        callback(response)
      end)
    end
  end,
}

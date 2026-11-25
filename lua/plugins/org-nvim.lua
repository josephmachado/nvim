return {
  "xheisenbugx/org.nvim",
  main = "org",
  lazy = false,
  dependencies = { "hrsh7th/nvim-cmp" },
  config = function(_, opts)
    require("org").setup(opts)

    local cmp = require "cmp"
    cmp.register_source("org", require("org.completion.cmp").new())
    cmp.setup.filetype("org", {
      sources = {
        { name = "org" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "async_path" },
      },
    })
  end,
  opts = {
    org_directory = "~/org",
    agenda_files = { "~/org/**/*.org" },
    default_notes_file = "~/org/refile.org",
    todo_keywords = {
      "TODO(t) NEXT(n) WAITING(w) | DONE(d) CANCELLED(c)",
      "REPORT(r) BUG(b) KNOWNCAUSE(k) | FIXED(f)",
    },
    log_done = "time",
    log_into_drawer = true,
    -- startup_folded = "overview",

    capture = {
      window = "float",
      templates = {
        t = { description = "Task", template = "* TODO %?\n  %U", target = "~/org/refile.org" },
        n = { description = "Note", template = "* %?\n  %U\n  %a", target = "~/org/notes.org", headline = "Inbox" },
        j = { description = "Journal", template = "* %<%H:%M> %?", target = "~/org/journal.org", datetree = true },
      },
    },

    babel = { -- top level, NOT inside extensions
      languages = {
        elixir = { cmd = "elixir" },
      },
    },

    extensions = { -- only real extensions go here
      --lsp = true,
      src_lsp = { languages = { "elixir", "python" } },
      diagrams = { render_on_save = true },
    },
  },
}

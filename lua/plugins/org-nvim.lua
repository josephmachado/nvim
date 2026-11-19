return {
  "xheisenbugx/org.nvim",
  main = "org",
  lazy = false,
  opts = {
    org_directory = "~/org",
    agenda_files = { "~/org/**/*.org" },
    default_notes_file = "~/org/refile.org",
    todo_keywords = { "TODO(t) WIP(w) REVIEW(r) BLOCKED(b) | DONE(d)" },
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
  config = function(_, opts)
    require("org").setup(opts)
    require("org.capture").expansions["meal-calories"] = function(ctx)
      local d = ctx.date or require("org.date").today()
      return tostring(require("org_diet").calories_for(string.format("%04d-%02d-%02d", d.year, d.month, d.day)))
    end
  end,
}

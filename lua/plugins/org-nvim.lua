return {
  "xheisenbugx/org.nvim",
  main = "org",
  lazy = false, -- startup cost is small: heavy modules load on first use
  opts = {
    org_directory = "~/org",
    agenda_files = { "~/org/**/*.org" },
    default_notes_file = "~/org/refile.org",
    capture = {
      window = "float", -- or "split" (default-ish), "vsplit", "tab", "current"
      templates = {
        t = { description = "Task", template = "* TODO %?\n  %U", target = "~/org/refile.org" },
        n = { description = "Note", template = "* %?\n  %U\n  %a", target = "~/org/notes.org", headline = "Inbox" },
        j = { description = "Journal", template = "* %<%H:%M> %?", target = "~/org/journal.org", datetree = true },
      },
    },
    extensions = {
      lsp = true,
    },
  },
  config = function(_, opts)
    require("org").setup(opts)
    -- %(meal-calories): today's (or the capture date's) calories from meals.org
    require("org.capture").expansions["meal-calories"] = function(ctx)
      local d = ctx.date or require("org.date").today()
      return tostring(require("org_diet").calories_for(string.format("%04d-%02d-%02d", d.year, d.month, d.day)))
    end
  end,
}

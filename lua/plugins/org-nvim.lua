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
        f = {
          description = "Food Log",
          target = "~/org/meals.org",
          datetree = true,
          template = "* %<%H:%M> %^{Food}\n  %^{Calories}p",
        },
        m = {
          description = "Monthly review",
          target = "~/org/monthly-review.org",
          datetree = { tree_type = { "year", "month" } },
          template = table.concat({
            "* Monthly review",
            "  %U",
            "  - What could be better: %^{What could be better}",
            "  - What went well: %^{What went well}",
            "  - What am I grateful for: %^{What am I grateful for}",
            "  - Key priority for upcoming month: %^{One key priority upcoming month}",
          }, "\n"),
        },
        w = {
          description = "Weekly review",
          target = "~/org/weekly-review.org",
          datetree = { tree_type = { "year", "week" } },
          template = table.concat({
            "* Weekly review",
            "  %U",
            "  - What could be better: %^{What could be better}",
            "  - What went well: %^{What went well}",
            "  - What am I grateful for: %^{What am I grateful for}",
            "  - Key priority for upcoming week: %^{One key priority for upcoming week}",
          }, "\n"),
        },
        d = {
          description = "Daily metrics & review",
          target = "~/org/daily-metrics.org",
          datetree = true,
          template = table.concat({
            "* Daily metrics",
            "  %U",
            "  - Sleep: %^{Sleep (hours)}",
            "  - Diet: %^{Calories|%(meal-calories)} kcal",
            "  - Exercise: %^{Exercise|none|none|walk|run|gym|yoga|cycling}",
            "  - Mood: %^{Mood|3|1|2|3|4|5}",
            "* Daily review",
            "  %U",
            "  - What could be better: %^{What could be better}",
            "  - What went well: %^{What went well}",
            "  - What am I grateful for: %^{What am I grateful for}",
            "  - Key priority for tomorrow: %^{One key priority tomorrow}",
          }, "\n"),
        },
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

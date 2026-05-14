return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
 input = { enabled = true },
    scroll = {
      enabled = true,
      animate = {
        duration = { step = 15, total = 250 },
        easing = "linear",
      },
    },
    picker = {
      enabled = true,
      icons = {
        files = {
          -- "\u{f024b}" = folder, "\u{f0770}" = folder open
          -- chevron is rendered separately, right-aligned (see explorer.format)
          dir      = "\u{f024b}",
          dir_open = "\u{f0770}",
        },
        tree = {
          vertical = "│ ", -- only the vertical guide
          middle   = "│ ", -- drop the ├╴ arm
          last     = "  ", -- drop the └╴ arm
        },
      },
      sources = {
        explorer = {
          hidden = true,
          ignored = false,
          auto_close = false,
          jump = { close = false },
          layout = { preset = "sidebar", preview = false },
          -- git decoration in the tree
          git_status = true,
          git_status_open = true, -- recurse into open dirs to show child status
          git_untracked = true,
          -- Append open/closed chevron after the folder name.
          format = function(item, picker)
            local ret = require("snacks.picker.format").file(item, picker)
            if item.dir then
              ret[#ret + 1] = {
                item.open and "\u{eab4}" or "\u{eab6}",
                "SnacksPickerSpecial",
              }
            end
            return ret
          end,
          win = {
            list = {
              keys = {
                ["<BS>"] = "explorer_up",
                ["l"] = "confirm",
                ["h"] = "explorer_close",
                ["a"] = "explorer_add",
                ["d"] = "explorer_del",
                ["r"] = "explorer_rename",
                ["c"] = "explorer_copy",
                ["m"] = "explorer_move",
                ["y"] = "explorer_yank",
                ["o"] = "explorer_open", -- open with system app (Finder on macOS)
                ["."] = "explorer_focus",
                ["I"] = "toggle_ignored",
                ["H"] = "toggle_hidden",
                ["Z"] = "explorer_close_all",
                ["]g"] = "explorer_git_next",
                ["[g"] = "explorer_git_prev",
                ["]d"] = "explorer_diagnostic_next",
                ["[d"] = "explorer_diagnostic_prev",
              },
            },
          },
        },
        files = { hidden = true },
        grep = { hidden = true },
      },
      formatters = {
        file = {
          git_status_hl = true, -- color filename by git status (M/A/?/!)
          icon_width = 2,       -- folder/file icon only
        },
      },
    },
    -- git utilities (used by neogit/snacks pickers internally)
    git = { enabled = true },
    -- auto-disable expensive features (treesitter, LSP, syntax) for huge files
    bigfile = {
      enabled = true,
      notify = true,        -- show a notification when bigfile mode kicks in
      size = 1.5 * 1024 * 1024, -- 1.5 MB threshold
    },
    -- animation engine used by scroll, indent, dim, etc.
    animate = {
      enabled = true,
      duration = 20, -- ms per step
      easing = "linear",
      fps = 120,
    },
  },
  -- keymaps live in lua/mappings.lua (search "snacks.nvim")
}

return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
    "DiffviewFileHistory",
  },
  config = function(_, opts)
    require("diffview").setup(opts)
    -- Tighten panel spacing:
    --   1. Status badge (M/A/?/D ...) — the colored background covers only the
    --      letter, not the trailing space, so the badge looks narrow.
    --   2. Tree-mode indent — diffview hardcodes `depth*2 + 2` spaces of indent
    --      for files (and `depth*2` for dirs) after the status. Shave 1 cell
    --      off any pure-whitespace indent run so tree lines up tighter while
    --      keeping per-depth offset (shaving 2 collapsed depth-1 dirs onto
    --      their parent's column).
    local Renderer = require("diffview.renderer")
    local orig_add_text = Renderer.RenderComponent.add_text
    Renderer.RenderComponent.add_text = function(self, text, hl_group)
      if type(text) == "string" then
        -- (1) status badge: peel the trailing space out of the highlight
        if hl_group
          and type(hl_group) == "string"
          and hl_group:sub(1, 14) == "DiffviewStatus"
          and text:sub(-1) == " "
        then
          orig_add_text(self, text:sub(1, -2), hl_group) -- letter with badge bg
          return orig_add_text(self, " ", nil)           -- plain gap, no highlight
        end
        -- (2) tree indent: pure-whitespace, no highlight, >= 2 chars → shave 1
        if not hl_group and #text >= 2 and text:match("^ +$") then
          text = text:sub(2)
        end
      end
      return orig_add_text(self, text, hl_group)
    end
  end,
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = {
        layout = "diff2_horizontal",
        disable_diagnostics = true,
      },
      merge_tool = {
        layout = "diff3_mixed",
        disable_diagnostics = true,
      },
      file_history = {
        layout = "diff2_horizontal",
      },
    },
    file_panel = {
      listing_style = "list",
      tree_options = {
        flatten_dirs = true,
        folder_statuses = "only_folded",
      },
      win_config = {
        position = "left",
        width = 28,
        win_opts = {
          signcolumn = "no",
          numberwidth = 1,
          foldcolumn = "0",
          statuscolumn = " ", -- one cell of left padding
        },
      },
    },
  },
}

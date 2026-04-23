return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
    "DiffviewFileHistory",
  },
  opts = {
    enhanced_diff_hl = true,
    view = {
      default = {
        layout = "diff1_plain",      -- unified single-pane view
      },
      merge_tool = {
        layout = "diff3_mixed",
        disable_diagnostics = true,
      },
      file_history = {
        layout = "diff1_plain",      -- same for history view
      },
    },
  },
}

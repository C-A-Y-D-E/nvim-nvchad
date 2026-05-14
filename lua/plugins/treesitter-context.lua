return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    max_lines = 3,
    multiline_threshold = 1,
    trim_scope = "outer",
  },
   keys = {
    { "[c", function() require("treesitter-context").go_to_context() end, desc = "Jump to context" },
  },
}

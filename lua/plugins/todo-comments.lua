return {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  -- keymaps live in lua/mappings.lua (search "todo-comments.nvim")
}

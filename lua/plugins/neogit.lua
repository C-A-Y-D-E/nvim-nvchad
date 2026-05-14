return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "folke/snacks.nvim",
  },
  cmd = { "Neogit" },
  opts = {
    integrations = {
      diffview = true,
      snacks = true,
    },
    graph_style = "unicode",
    disable_commit_confirmation = false,
  },
  -- keymaps live in lua/mappings.lua (search "neogit")
}

return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = { "Neogit" },
  opts = {
    integrations = {
      diffview = true,
      telescope = true,
    },
    graph_style = "unicode",
    disable_commit_confirmation = false,
  },
  -- keymaps live in lua/mappings.lua (search "neogit")
}

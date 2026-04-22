return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = { "Neogit" },
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "neogit: open status" },
    { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "neogit: commit" },
    { "<leader>gp", "<cmd>Neogit pull<cr>", desc = "neogit: pull" },
    { "<leader>gP", "<cmd>Neogit push<cr>", desc = "neogit: push" },
    { "<leader>gl", "<cmd>Neogit log<cr>", desc = "neogit: log" },
  },
  opts = {
    integrations = {
      diffview = true,
      telescope = true,
    },
    graph_style = "unicode",
    disable_commit_confirmation = false,
  },
}

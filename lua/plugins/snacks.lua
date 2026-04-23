return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    scroll = {
      enabled = true,
      animate = {
        duration = { step = 15, total = 250 },
        easing = "linear",
      },
    },
    picker = { enabled = true },
  },
  -- keymaps live in lua/mappings.lua (search "snacks.nvim")
}

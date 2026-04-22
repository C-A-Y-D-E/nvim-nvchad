return {
  "rachartier/tiny-code-action.nvim",
  event = "LspAttach",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = require "configs.tiny-code-action",
}

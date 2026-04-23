return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("telescope").setup({
      extensions = {
        file_browser = {
          hijack_netrw = false,
          hidden = { file_browser = true, folder_browser = true },
          grouped = true,
          respect_gitignore = false,
          initial_mode = "normal",
        },
      },
    })
    require("telescope").load_extension("file_browser")
  end,
}

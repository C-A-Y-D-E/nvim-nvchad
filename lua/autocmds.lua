require "nvchad.autocmds"
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "DiffviewFiles", "DiffviewFileHistory", "DiffviewFileHistoryPanel" },
  callback = function()
    vim.opt_local.signcolumn = "no"
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.statuscolumn = ""
    vim.opt_local.foldcolumn = "0"
  end,
})

-- Kill prettierd on cwd change so the next save spawns a fresh daemon with
-- the new project's .prettierrc. Avoids "Could not connect" wedges and
-- stale-config cross-contamination between projects.
vim.api.nvim_create_autocmd("DirChanged", {
  callback = function()
    vim.system({ "prettierd", "restart" }, { detach = true })
  end,
})

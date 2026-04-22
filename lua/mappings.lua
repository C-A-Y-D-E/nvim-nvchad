require "nvchad.mappings"

local map = vim.keymap.set

-- ============================================================
-- Core
-- ============================================================

map("n", "<leader>b", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer: close all" })
map("n", "<leader>bb", function()
  require("nvchad.tabufline").closeAllBufs()
end, { desc = "buffer: close all" })

map("n", "<leader>bbb", function()
  require("nvchad.tabufline").closeAllBufs(false) -- keep current
end, { desc = "buffer: close others" })
map("t", "jk", "<C-\\><C-n>", { desc = "terminal: exit to normal mode" })
map("n", "<leader>e", function()
  local api = require "nvim-tree.api"
  local view = require "nvim-tree.view"

  if view.is_visible() then
    -- Tree is open
    if vim.bo.filetype == "NvimTree" then
      -- Already focused → close
      api.tree.close()
    else
      -- Open but not focused → focus it
      api.tree.focus()
    end
  else
    -- Not open → open and focus
    api.tree.open()
  end
end, { desc = "nvim-tree: smart toggle" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<C-t>", function()
  require("nvchad.themes").open()
end, { desc = "Theme picker" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Save file" })
-- Quick scratch terminal (toggle hide/show)
map({ "n", "t" }, "<leader>th", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm", size = 0.3 }
end, { desc = "terminal: toggle scratch horizontal" })

map({ "n", "t" }, "<leader>tv", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm", size = 0.3 }
end, { desc = "terminal: toggle scratch vertical" })

map({ "n", "t" }, "<leader>tf", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal: toggle scratch float" })

-- split window keybindings
map("n", "<leader>sv", "<C-w>v", { desc = "window: split vertical" })
map("n", "<leader>sh", "<C-w>s", { desc = "window: split horizontal" })
map("n", "<leader>sc", "<C-w>c", { desc = "window: close split" })
map("n", "<leader>so", "<C-w>o", { desc = "window: only (close others)" })
-- New terminal each time (for when you want multiple)
map("n", "<leader>H", function()
  require("nvchad.term").new { pos = "sp", size = 0.3 }
end, { desc = "terminal: new horizontal" })

map("n", "<leader>V", function()
  require("nvchad.term").new { pos = "vsp", size = 0.3 }
end, { desc = "terminal: new vertical" })
-- ============================================================
-- LSP (native)
-- ============================================================
map("n", "<leader>ih", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = 0 }, { bufnr = 0 })
end, { desc = "LSP: toggle inlay hints" })

-- ============================================================
-- tiny-code-action
-- ============================================================
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: code action (native)" })
map({ "n", "x" }, "<leader>ca", function()
  require("tiny-code-action").code_action()
end, { silent = true, desc = "tiny-code-action: code action" })

-- ============================================================
-- dropbar.nvim (breadcrumbs)
-- ============================================================
map("n", "<leader>;", function()
  require("dropbar.api").pick()
end, { desc = "dropbar: pick breadcrumb" })

-- ============================================================
-- outline.nvim
-- ============================================================
map("n", "<leader>o", "<cmd>Outline<cr>", { desc = "outline: toggle symbol outline" })

-- ============================================================
-- todo-comments.nvim
-- ============================================================
map("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "todo-comments: next todo" })
map("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "todo-comments: prev todo" })
map("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "todo-comments: search todos" })
map("n", "<leader>tt", "<cmd>TodoTrouble<cr>", { desc = "todo-comments: todos in trouble" })

-- ============================================================
-- inc-rename.nvim
-- ============================================================
map("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand "<cword>"
end, { expr = true, desc = "inc-rename: LSP rename with preview" })

-- ============================================================
-- glance.nvim (peek)
-- ============================================================
map("n", "<leader>pd", "<cmd>Glance definitions<cr>", { desc = "glance: peek definitions" })
map("n", "<leader>pr", "<cmd>Glance references<cr>", { desc = "glance: peek references" })
map("n", "<leader>pt", "<cmd>Glance type_definitions<cr>", { desc = "glance: peek type definitions" })
map("n", "<leader>pi", "<cmd>Glance implementations<cr>", { desc = "glance: peek implementations" })

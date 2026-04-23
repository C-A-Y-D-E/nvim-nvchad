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

-- ============================================================
-- flash.nvim (folke/flash.nvim)
-- Lightning-fast navigation: press s or S then type characters
-- to jump anywhere visible on screen. Like a supercharged f/t.
-- s  → jump to any match (type chars, pick label)
-- S  → select a treesitter node (select whole functions, blocks, etc.)
-- ============================================================
map({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "flash: jump" })
map({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "flash: treesitter select" })

-- ============================================================
-- trouble.nvim (folke/trouble.nvim)
-- A pretty list for showing diagnostics (errors/warnings),
-- references, quickfix items, etc. Think of it as a better
-- version of the quickfix/location list window.
-- <leader>xx → all diagnostics across your project
-- <leader>xX → diagnostics for current file only
-- <leader>cs → list all symbols (functions, vars, types) in file
-- <leader>cl → LSP definitions/references in a side panel
-- <leader>xL → vim's location list in Trouble format
-- <leader>xQ → vim's quickfix list in Trouble format
-- ============================================================
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "trouble: project diagnostics" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "trouble: buffer diagnostics" })
map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "trouble: symbols" })
map("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "trouble: LSP defs/refs" })
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "trouble: location list" })
map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "trouble: quickfix list" })

-- ============================================================
-- diffview.nvim (sindrets/diffview.nvim)
-- Opens a full diff view of all changed files (like a GUI git diff).
-- Also shows file history (git log) with diffs for each commit.
-- <leader>gd → toggle the diff view (open if closed, close if open)
-- <leader>gh → full repo git history (all commits)
-- <leader>gH → git history for the current file only
-- ============================================================
map("n", "<leader>gd", function()
  local lib = require("diffview.lib")
  
  -- Check each open diffview view
  for _, v in ipairs(lib.views) do
    if vim.api.nvim_get_current_tabpage() == v.tabpage then
      -- We're currently in a diffview tab — close it
      vim.cmd("DiffviewClose")
      return
    end
  end
  
  -- Not in a diffview tab. Is one open somewhere?
  if #lib.views > 0 then
    -- Focus the existing one instead of creating a new one
    vim.api.nvim_set_current_tabpage(lib.views[1].tabpage)
    return
  end
  
  -- No diffview exists — create one
  vim.cmd("DiffviewOpen")
end, { desc = "diff: toggle vs main" })
-- ============================================================
-- neogit (NeogitOrg/neogit)
-- A full git UI inside Neovim (like Magit for Emacs).
-- You can stage, commit, push, pull — all without leaving Neovim.
-- <leader>gg → open Neogit status (main dashboard, stage/unstage here)
-- <leader>gc → open commit popup (write commit message)
-- <leader>gp → git pull (fetch + merge from remote)
-- <leader>gP → git push (send commits to remote)
-- <leader>gl → git log (browse commit history)
-- ============================================================
map("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "neogit: open status" })
map("n", "<leader>gc", "<cmd>Neogit commit<cr>", { desc = "neogit: commit" })
map("n", "<leader>gp", "<cmd>Neogit pull<cr>", { desc = "neogit: pull" })
map("n", "<leader>gP", "<cmd>Neogit push<cr>", { desc = "neogit: push" })
map("n", "<leader>gl", "<cmd>Neogit log<cr>", { desc = "neogit: log" })

-- ============================================================
-- gitsigns.nvim (lewis6991/gitsigns.nvim)
-- Shows git change markers in the gutter (added/modified/deleted lines).
-- Lets you act on individual hunks (chunks of changes) without leaving Neovim.
-- ]h / [h → jump to next/prev hunk
-- <leader>ghs → stage hunk (add to git staging area)
-- <leader>ghr → reset hunk (discard changes, destructive!)
-- <leader>ghp → preview hunk (see the diff in a popup)
-- <leader>ghb → blame line (who wrote this line and when)
-- ============================================================
map("n", "]h", "<cmd>Gitsigns next_hunk<cr>", { desc = "gitsigns: next hunk" })
map("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", { desc = "gitsigns: prev hunk" })
map("n", "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "gitsigns: stage hunk" })
map("n", "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "gitsigns: reset hunk" })
map("n", "<leader>ghp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "gitsigns: preview hunk" })
map("n", "<leader>ghb", "<cmd>Gitsigns blame_line full=true<cr>", { desc = "gitsigns: blame line" })

-- ============================================================
-- snacks.nvim (folke/snacks.nvim)
-- A collection of small QoL plugins bundled together.
-- Currently using: smooth scroll, picker (fuzzy finder for projects).
-- <leader>pf → pick and switch to a project
-- ============================================================
map("n", "<leader>pf", function() Snacks.picker.projects() end, { desc = "snacks: projects" })

-- ============================================================
-- mini.surround (echasnovski/mini.surround)
-- NOTE: mini.surround keymaps live in lua/plugins/mini-surround.lua
-- because they are configured through the plugin's own opts.mappings
-- table, not through vim.keymap.set.
-- Keys: gsa (add), gsd (delete), gsr (replace), gsf (find),
--        gsF (find left), gsh (highlight)
-- Examples: gsaiw" → wrap word in "..."  |  gsd' → delete surrounding '
-- ============================================================
--

-- ============================================================
-- telescope-file-browser
-- ============================================================
map("n", "<leader>fb", function()
  require("telescope").extensions.file_browser.file_browser({
    path = "%:p:h",
    select_buffer = true,
  })
end, { desc = "file browser: current folder" })

map("n", "<leader>fB", function()
  require("telescope").extensions.file_browser.file_browser({
    path = vim.fn.getcwd(),
  })
end, { desc = "file browser: project root" })


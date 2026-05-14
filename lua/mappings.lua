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
map("n", "<leader>e", function()
  Snacks.explorer()
end, { desc = "snacks: explorer toggle" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<C-t>", function()
  require("nvchad.themes").open()
end, { desc = "Theme picker" })
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
map("i", "<C-s>", "<esc><cmd>w<cr>", { desc = "Save file (exit insert)" })
map("v", "<C-s>", "<esc><cmd>w<cr>", { desc = "Save file (exit visual)" })

-- ============================================================
-- Clipboard
--   Default behavior: yank/delete share the system clipboard
--   (vim.opt.clipboard = "unnamedplus" in options.lua).
--   <leader>cy → toggle clipboard sync on/off (off = isolated vim register)
--   <leader>y / <leader>Y → explicit yank to system clipboard (works either way)
--   <leader>p / <leader>P → explicit paste from system clipboard (works either way)
--   In visual mode `p` pastes over selection WITHOUT overwriting your register.
-- ============================================================
map("n", "<leader>cy", function()
  if vim.opt.clipboard:get()[1] == "unnamedplus" then
    vim.opt.clipboard = ""
    vim.notify("clipboard sync: OFF (vim register only)")
  else
    vim.opt.clipboard = "unnamedplus"
    vim.notify("clipboard sync: ON (system clipboard)")
  end
end, { desc = "clipboard: toggle system sync" })
map({ "n", "x" }, "<leader>y", '"+y',  { desc = "clipboard: yank to system" })
map("n",          "<leader>Y", '"+Y',  { desc = "clipboard: yank line to system" })
map({ "n", "x" }, "<leader>p", '"+p',  { desc = "clipboard: paste from system (after)" })
map({ "n", "x" }, "<leader>P", '"+P',  { desc = "clipboard: paste from system (before)" })
-- Visual paste-over: drop the replaced selection into the black hole so your
-- register survives. Lets you yank once and paste over many selections.
map("x", "p", '"_dP', { desc = "paste over selection without yanking it" })

-- $ in visual + operator-pending modes: stop at last non-blank char, not the
-- newline. So v$, d$, y$, c$ never grab the trailing \n.
map({ "x", "o" }, "$", "g_", { desc = "end of line (excludes newline)" })

-- split window keybindings
map("n", "<leader>sv", "<C-w>v", { desc = "window: split vertical" })
map("n", "<leader>sh", "<C-w>s", { desc = "window: split horizontal" })
map("n", "<leader>sc", "<C-w>c", { desc = "window: close split" })
map("n", "<leader>so", "<C-w>o", { desc = "window: only (close others)" })

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
  local m = vim.api.nvim_get_mode().mode
  local in_visual = m == "v" or m == "V" or m == "\22"
  require("tiny-code-action").code_action({
    filter = function(action, _)
      if in_visual or not action.kind then
        return true
      end
      -- vtsls/tsserver advertises extract/rewrite refactors at cursor positions
      -- where they have no real range to operate on. Resolve either crashes
      -- ("Expected to find a range to extract" / "Unrecognized action name")
      -- or returns a valid-looking edit on the wrong tokens. Require a visual
      -- selection for these kinds.
      if action.kind:sub(1, 17) == "refactor.extract." then
        return false
      end
      if action.kind:sub(1, 17) == "refactor.rewrite." then
        return false
      end
      return true
    end,
  })
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
map("n", "<leader>st", function()
  require("todo-comments") -- ensure snacks source is registered
  Snacks.picker.todo_comments()
end, { desc = "todo-comments: search todos" })
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
-- ]h / [h     → jump to next/prev hunk
-- <leader>ghs → stage hunk (n) or stage selected lines (v)
-- <leader>ghr → reset hunk (n) or reset selected lines (v) — undoes changes
-- <leader>ghR → reset whole file (undo all unsaved changes vs HEAD)
-- <leader>ghu → undo last stage
-- <leader>ghp → preview hunk diff in popup
-- <leader>ghb → blame line (full)
-- ============================================================
map("n", "]h", "<cmd>Gitsigns next_hunk<cr>", { desc = "gitsigns: next hunk" })
map("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", { desc = "gitsigns: prev hunk" })
map("n", "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>", { desc = "gitsigns: stage hunk" })
map("v", "<leader>ghs", function()
  require("gitsigns").stage_hunk { vim.fn.line("."), vim.fn.line("v") }
end, { desc = "gitsigns: stage selected lines" })
map("n", "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "gitsigns: reset hunk" })
map("v", "<leader>ghr", function()
  require("gitsigns").reset_hunk { vim.fn.line("."), vim.fn.line("v") }
end, { desc = "gitsigns: reset selected lines" })
map("n", "<leader>ghR", "<cmd>Gitsigns reset_buffer<cr>", { desc = "gitsigns: reset whole file" })
map("n", "<leader>ghu", "<cmd>Gitsigns undo_stage_hunk<cr>", { desc = "gitsigns: undo last stage" })
map("n", "<leader>ghp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "gitsigns: preview hunk" })
map("n", "<leader>ghb", "<cmd>Gitsigns blame_line full=true<cr>", { desc = "gitsigns: blame line" })

-- ============================================================
-- snacks.nvim (folke/snacks.nvim)
-- Smooth scroll + picker (fuzzy finder, file browser, grep, etc.)
-- File pickers
--   <leader>ff → find files (cwd)
--   <leader>fg → live grep (cwd)
--   <leader>fr → recent files
--   <leader>fw → grep word under cursor
--   <leader>fb → buffers
--   <leader>fh → help tags
--   <leader>fk → keymaps
--   <leader>fc → commands
--   <leader>f: → command history
--   <leader>fR → resume last picker
-- Explorer / project
--   <leader>fe → explorer (current file's folder)
--   <leader>fE → explorer (project root)
--   <leader>pf → pick and switch project
-- LSP / diagnostics
--   <leader>fd → diagnostics (project)
--   <leader>fD → diagnostics (buffer)
--   <leader>fs → LSP document symbols
--   <leader>fS → LSP workspace symbols
-- Git
--   <leader>fG → git status (changed files)
--   <leader>fl → git log
--   <leader>fL → git log (current file)
-- ============================================================
map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "picker: files" })
map("n", "<leader>fg", function() Snacks.picker.grep() end, { desc = "picker: live grep" })
map("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "picker: recent files" })
map({ "n", "x" }, "<leader>fw", function() Snacks.picker.grep_word() end, { desc = "picker: grep word" })
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "picker: buffers" })
map("n", "<leader>fh", function() Snacks.picker.help() end, { desc = "picker: help tags" })
map("n", "<leader>fk", function() Snacks.picker.keymaps() end, { desc = "picker: keymaps" })
map("n", "<leader>fc", function() Snacks.picker.commands() end, { desc = "picker: commands" })
map("n", "<leader>f:", function() Snacks.picker.command_history() end, { desc = "picker: command history" })
map("n", "<leader>fR", function() Snacks.picker.resume() end, { desc = "picker: resume last" })

map("n", "<leader>fe", function()
  Snacks.explorer({ cwd = vim.fn.expand("%:p:h") })
end, { desc = "explorer: current folder" })
map("n", "<leader>fE", function()
  Snacks.explorer({ cwd = vim.fn.getcwd() })
end, { desc = "explorer: project root" })
map("n", "<leader>pf", function() Snacks.picker.projects() end, { desc = "picker: projects" })

map("n", "<leader>fd", function() Snacks.picker.diagnostics() end, { desc = "picker: diagnostics" })
map("n", "<leader>fD", function() Snacks.picker.diagnostics_buffer() end, { desc = "picker: diagnostics buffer" })
map("n", "<leader>fs", function() Snacks.picker.lsp_symbols() end, { desc = "picker: document symbols" })
map("n", "<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "picker: workspace symbols" })

map("n", "<leader>fG", function() Snacks.picker.git_status() end, { desc = "picker: git status" })
map("n", "<leader>fl", function() Snacks.picker.git_log() end, { desc = "picker: git log" })
map("n", "<leader>fL", function() Snacks.picker.git_log_file() end, { desc = "picker: git log (file)" })
map("n", "<leader>fbr", function() Snacks.picker.git_branches() end, { desc = "picker: git branches" })
map("n", "<leader>fdf", function() Snacks.picker.git_diff() end, { desc = "picker: git diff (hunks)" })
map("n", "<leader>fgf", function() Snacks.picker.git_files() end, { desc = "picker: git files" })

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


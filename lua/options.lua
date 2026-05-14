require "nvchad.options"
vim.opt.sessionoptions:remove "terminal"
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
-- folding handled by nvim-ufo (lua/plugins/fold.lua)
-- fillchars must be set AFTER nvchad.options (which overwrites it)
-- using \u escapes to guarantee single codepoint (raw paste can include hidden variation selectors)
vim.opt.fillchars:append({
  foldopen = "\u{f078}",  -- nf-fa-chevron_down
  foldclose = "\u{f054}", -- nf-fa-chevron_right
  foldsep = " ",
  diff = "╱",             -- diagonal slash for diff filler regions
})
-- add yours here!
-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
vim.opt.diffopt:append({
  "algorithm:histogram",
  "linematch:60",
  "indent-heuristic",
})
-- yank/paste shares system clipboard by default (toggle with <leader>cy)
vim.opt.clipboard = "unnamedplus"

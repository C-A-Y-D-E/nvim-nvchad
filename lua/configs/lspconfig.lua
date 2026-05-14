require("nvchad.configs.lspconfig").defaults()

local ts_inlay_hints = {
  parameterNames = { enabled = "literals" },
  parameterTypes = { enabled = false },
  variableTypes = { enabled = true },
  propertyDeclarationTypes = { enabled = true },
  functionLikeReturnTypes = { enabled = false },
  enumMemberValues = { enabled = true },
}

vim.lsp.config("vtsls", {
  settings = {
    typescript = {
      inlayHints = ts_inlay_hints,
      -- bump tsserver heap (default ~3 GB) — main fix for "JS/TS service crashed"
      tsserver = {
        maxTsServerMemory = 8192,
        -- skip expensive watcher in big monorepos
        watchOptions = { watchFile = "useFsEventsOnParentDirectory" },
      },
      -- cap surface area tsserver has to chew through
      preferences = {
        includePackageJsonAutoImports = "off", -- huge win in monorepos
      },
      -- updates-as-you-type get throttled instead of flooding tsserver
      updateImportsOnFileMove = { enabled = "prompt" },
    },
    javascript = { inlayHints = ts_inlay_hints },
    vtsls = {
      experimental = {
        -- server-side fuzzy match is heavy; cmp/blink will fuzzy locally
        completion = { enableServerSideFuzzyMatch = false },
      },
    },
  },
})

local servers = { "html", "cssls", "vtsls","solidity_ls" }
vim.lsp.enable(servers)

local function apply_diff_highlights()
    -- ============================================================
    -- Diff highlights tuned to oldworld palette
    -- (https://github.com/dgox16/oldworld.nvim)
    -- ============================================================
    -- ============================================================
    -- Two-tier diff colors: lighter for whole-line, darker for the
    -- specific changed chunk inside it.
    -- ============================================================
    -- Add side: light teal-green for full added line, dark green for changed token
    vim.api.nvim_set_hl(0, "DiffAdd",    { bg = "#16221c", fg = "NONE" })
    -- Delete side: light wine-red for whole deleted line, dark wine for changed token
    vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#22161c", fg = "#e29eca" })
    -- Modified line bg: light wine (matches delete tier)
    vim.api.nvim_set_hl(0, "DiffChange", { bg = "#22161c", fg = "NONE" })
    -- The actual changed token within a DiffChange line: dark wine (saturated)
    vim.api.nvim_set_hl(0, "DiffText",   { bg = "#3a1c2c", fg = "NONE" })
    -- Diffview equivalents (RIGHT side modified line uses DiffviewDiffAdd → dark green)
    vim.api.nvim_set_hl(0, "DiffviewDiffAdd",     { bg = "#1d3026" })
    vim.api.nvim_set_hl(0, "DiffviewDiffChange",  { bg = "#22161c" })
    vim.api.nvim_set_hl(0, "DiffviewDiffText",    { bg = "#3a1c2c", fg = "NONE" })

    -- Diffview diagonal-slash empty regions (the ╱╱╱ pattern in screenshots).
    -- DiffviewDiffAddAsDelete = bg of the empty "add as delete" region.
    -- DiffviewDiffDelete fg = color of the diagonal-slash characters.
    vim.api.nvim_set_hl(0, "DiffviewDiffAddAsDelete", { bg = "NONE" })
    -- ENHANCED diff-hl: diffview links DiffviewDiffDelete → DiffviewDiffDeleteDim → Comment.
    -- Override the Dim variant directly so the slashes are dim, NOT the code.
    -- (DiffDelete keeps its colored fg for actual deleted-line content.)
    vim.api.nvim_set_hl(0, "DiffviewDiffDeleteDim",   { fg = "#2a2a2e", bg = "NONE" })

    -- Window separator / vertical grey box between diff panels
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#2a2a2c", bg = "#1a1a1c" })
    vim.api.nvim_set_hl(0, "VertSplit",    { fg = "#2a2a2c", bg = "#1a1a1c" })

    -- Sidebar / panel chrome
    vim.api.nvim_set_hl(0, "DiffviewFilePanelPath",      { fg = "#6c6874" })
    vim.api.nvim_set_hl(0, "DiffviewFilePanelRootPath",  { fg = "#6c6874" })
    vim.api.nvim_set_hl(0, "DiffviewFilePanelTitle",     { fg = "#92a2d5", bold = true })
    vim.api.nvim_set_hl(0, "DiffviewFilePanelCounter",   { fg = "#aca1cf", bold = true })
    vim.api.nvim_set_hl(0, "DiffviewFilePanelInsertions",{ fg = "#90b99f" })
    vim.api.nvim_set_hl(0, "DiffviewFilePanelDeletions", { fg = "#ea83a5" })
    vim.api.nvim_set_hl(0, "DiffviewStatusModified",     { fg = "#e6b99d", bold = true })
    vim.api.nvim_set_hl(0, "DiffviewStatusAdded",        { fg = "#90b99f", bold = true })
    vim.api.nvim_set_hl(0, "DiffviewStatusDeleted",      { fg = "#ea83a5", bold = true })
    vim.api.nvim_set_hl(0, "DiffviewStatusUntracked",    { fg = "#aca1cf", bold = true })

    -- Dim the snacks explorer tree connectors (│ ├╴ └╴)
    vim.api.nvim_set_hl(0, "SnacksPickerTree", { fg = "#2a2a30" })
end

-- Re-apply on every ColorScheme switch so it survives :colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_diff_highlights })
-- Apply once at startup AFTER everything has loaded (base46, lazy, etc.)
vim.api.nvim_create_autocmd("VimEnter", { callback = apply_diff_highlights })
-- Also re-apply on next tick in case VimEnter already fired
vim.schedule(apply_diff_highlights)
-- read :h vim.lsp.config for changing options of lsp servers

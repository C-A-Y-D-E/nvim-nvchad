local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- prettier first (formatting), then eslint --fix (rule-based cleanup
    -- like the `quotes` rule). NO stop_after_first — we want both to run.
    -- If a project has no .prettierrc, prettier uses defaults and eslint
    -- then rewrites to match `.eslintrc` (single quotes, etc).
    javascript = { "prettierd", "eslint_d" },
    javascriptreact = { "prettierd", "eslint_d" },
    typescript = { "prettierd", "eslint_d" },
    typescriptreact = { "prettierd", "eslint_d" },
    json = { "prettierd", "prettier", stop_after_first = true },
    jsonc = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", stop_after_first = true },
    html = { "prettierd", "prettier", stop_after_first = true },
    markdown = { "prettierd", "prettier", stop_after_first = true },
    yaml = { "prettierd", "prettier", stop_after_first = true },
    solidity = { "forge_fmt" },
  },

  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = true,
  },
}

return options

return {
  backend = "delta",
  picker = "telescope",
  backend_opts = {
    delta = {
      header_lines_to_remove = 4,
      args = {
        "--no-gitconfig",
        "--line-numbers",
      },
    },
  },
  resolve_timeout = 100,
  notify = {
    enabled = true,
    on_empty = true,
  },
  signs = {
    quickfix = { "", { link = "DiagnosticWarning" } },
    others = { "", { link = "DiagnosticWarning" } },
    refactor = { "", { link = "DiagnosticInfo" } },
    ["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
    ["refactor.extract"] = { "", { link = "DiagnosticError" } },
    ["source.organizeImports"] = { "", { link = "DiagnosticWarning" } },
    ["source.fixAll"] = { "󰃢", { link = "DiagnosticError" } },
    ["source"] = { "", { link = "DiagnosticError" } },
    ["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
    ["codeAction"] = { "", { link = "DiagnosticWarning" } },
  },
}

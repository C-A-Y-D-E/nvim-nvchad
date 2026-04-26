require("nvchad.configs.lspconfig").defaults()

vim.lsp.config("vtsls", {
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = false},
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = false},
        enumMemberValues = { enabled = true },
      },
    },
    javascript = {
      inlayHints = {
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = false},
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = false},
        enumMemberValues = { enabled = true },
      },
    },
  },
})
local servers = { "html", "cssls", "vtsls", "eslint" }
vim.lsp.enable(servers)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-inlay-hints", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method "textDocument/inlayHint" then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- Softer, richer green for added lines (like GitHub)
    vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#0d3819", fg = "NONE" })
    vim.api.nvim_set_hl(0, "DiffChange", { bg = "#2a2d3a", fg = "NONE" })
    vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#3a0d0d", fg = "#ff6b6b" })
    vim.api.nvim_set_hl(0, "DiffText", { bg = "#1a6b3a", bold = true })
    -- Sign column for +/- markers
    vim.api.nvim_set_hl(0, "DiffviewDiffAddAsDelete", { bg = "#3a0d0d" })
    vim.api.nvim_set_hl(0, "DiffviewDiffDelete", { fg = "#6b3a3a" })
  end,
})
vim.cmd("doautocmd ColorScheme")
-- read :h vim.lsp.config for changing options of lsp servers

return {
  'oribarilan/lensline.nvim',
  tag = '2.1.0',
  event = 'LspAttach',
  config = function()
    vim.api.nvim_set_hl(0, 'LenslineUsages',  { fg = '#8eb4d4', italic = true })
    vim.api.nvim_set_hl(0, 'LenslineAuthor',  { fg = '#a8c5a0', italic = true })
    vim.api.nvim_set_hl(0, 'LenslineDiag',    { fg = '#d4a373', italic = true })
    vim.api.nvim_set_hl(0, 'LenslineComplex', { fg = '#c9a3d6', italic = true })
    vim.api.nvim_set_hl(0, 'LenslineSep',     { fg = '#5c6370', italic = true })

    require("lensline").setup({
      profiles = {
        {
          name = "default",
          providers = {
            {
              name = "usages",
              enabled = true,
              include = { "refs" },
              show_zero = false,
              highlight = "LenslineUsages",
            },
            {
              name = "last_author",
              enabled = true,
              highlight = "LenslineAuthor",
            },
            {
              name = "diagnostics",
              enabled = true,
              min_level = "WARN",
              highlight = "LenslineDiag",
            },
            {
              name = "complexity",
              enabled = true,
              min_level = "L",
              highlight = "LenslineComplex",
            },
          },
          style = {
            separator = " • ",
            highlight = "LenslineSep",
            prefix = "┃ ",
            placement = "above",
            use_nerdfont = true,
            render = "all",
          },
        },
      },
      debounce_ms = 500,
      silence_lsp = true,
    })
  end,
}

-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "oldworld",

	hl_override = {
		Comment = { fg = "#9399b2", italic = true },
		["@comment"] = { fg = "#9399b2", italic = true },
		["@comment.documentation"] = { fg = "#cdd6f4", italic = true },
	},
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

return M

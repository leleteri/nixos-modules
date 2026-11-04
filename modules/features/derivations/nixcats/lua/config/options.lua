local o = vim.o
local g = vim.g

o.autoindent = true
o.shiftwidth = 2
o.tabstop = 2
o.termguicolors = true
o.splitright = true

o.spell = true
o.spelllang = "en"

o.number = true
o.relativenumber = true

o.cursorline = true
local function number_highlights()
	vim.api.nvim_set_hl(0, "LineNr", { fg = "#6c7086" }) -- other line numbers
	vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#6c7086" }) -- relative numbers above
	vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#6c7086" }) -- relative numbers below
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#f9e2af", bold = true }) -- current line number
end
number_highlights()
vim.api.nvim_create_autocmd("ColorScheme", { callback = number_highlights })

o.clipboard = "unnamed,unnamedplus"
g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = { "wl-paste", "--no-newline" },
		["*"] = { "wl-paste", "--no-newline" },
	},
}

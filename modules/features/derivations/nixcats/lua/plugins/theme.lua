local c = require("config.compat")

-- One entry per theme. The active one comes from `extra.colorscheme`, which
-- flake.nix sets per package (nixcatsGruvbox, nixcatsMellow, ...).
local themes = {
	tokyonight = function()
		c.setup("tokyonight", { style = "storm", transparent = true })
		vim.cmd.colorscheme("tokyonight")
	end,

	gruvbox = function()
		vim.o.background = "dark"
		c.setup("gruvbox", { transparent_mode = true })
		vim.cmd.colorscheme("gruvbox")
	end,

	-- sainnhe/everforest is configured through globals, set before :colorscheme
	everforest = function()
		vim.o.background = "dark"
		vim.g.everforest_background = "hard"
		vim.g.everforest_transparent_background = 1
		vim.cmd.colorscheme("everforest")
	end,

	mellow = function()
		vim.g.mellow_transparent = true
		vim.cmd.colorscheme("mellow")
	end,
}

local name = c.extra("colorscheme", nil)
if name == nil then
	return
end

local apply = themes[name]

if apply then
	apply()
else
	vim.notify(("unknown colorscheme: %s"):format(name), vim.log.levels.WARN)
end

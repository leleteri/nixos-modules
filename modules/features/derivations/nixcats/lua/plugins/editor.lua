local c = require("config.compat")
local map = vim.keymap.set

c.setup("which-key")
c.setup("nvim-autopairs")
c.setup("lualine", { options = { theme = "auto" } })

-- set floating window behavior
vim.api.nvim_set_hl(0, "NormalFloat", {
	bg = "none",
})
local border = vim.api.nvim_get_hl(0, { name = "FloatBorder" })
vim.api.nvim_set_hl(0, "FloatBorder", {
	fg = border.fg or "none",
	bg = "none",
})

-- oil
c.setup("oil", {
	delete_to_trash = true,
	view_options = { show_hidden = true },
	float = {
		padding = 1,
		border = "rounded",
		override = function(conf)
			local win = vim.api.nvim_get_current_win()
			local win_pos = vim.api.nvim_win_get_position(win)
			conf.relative = "editor"
			conf.width = math.floor(vim.api.nvim_win_get_width(win) * 0.8)
			conf.height = math.floor(vim.api.nvim_win_get_height(win) * 0.8)
			local col_offset = math.floor((vim.api.nvim_win_get_width(win) - conf.width) / 2)
			conf.col = win_pos[2] + col_offset
			return conf
		end,
	},
})

-- telescope
c.setup("telescope")
local ok_ts, builtin = pcall(require, "telescope.builtin")
if ok_ts then
	map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
	map("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
	map("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
	map("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
end

local telescope_groups = {
	"TelescopeNormal",
	"TelescopeBorder",
	"TelescopePromptNormal",
	"TelescopePromptBorder",
	"TelescopePromptTitle",
	"TelescopePreviewNormal",
	"TelescopePreviewBorder",
	"TelescopePreviewTitle",
	"TelescopeResultsNormal",
	"TelescopeResultsBorder",
	"TelescopeResultsTitle",
}
for _, group in ipairs(telescope_groups) do
	local border = vim.api.nvim_get_hl(0, { name = group, link = false })
	vim.api.nvim_set_hl(0, group, {
		fg = border.fg or "none",
		bg = "none",
	})
end

-- toggleterm + lazygit
c.setup("toggleterm", { open_mapping = [[<c-t>]] })
local ok_term, term = pcall(require, "toggleterm.terminal")
if ok_term then
	local lazygit = term.Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
	map("n", "<leader>gg", function()
		lazygit:toggle()
	end, { desc = "Lazygit" })
end

-- git
if c.cat("git") then
	c.setup("gitsigns")
	c.setup("neogit")
	map("n", "<leader>gn", "<cmd>Neogit<CR>", { desc = "Neogit" })
end

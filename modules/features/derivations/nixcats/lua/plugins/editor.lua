local c = require("config.compat")
local map = vim.keymap.set

c.setup("which-key")
c.setup("nvim-autopairs")
c.setup("ibl")
c.setup("cinnamon")
c.setup("hightlight-undo")
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
c.setup("toggleterm", {
	open_mapping = [[<c-t>]],
	direction = "float",
	float_opts = {
		border = "curved",
	},
})
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

-- fidget-nvim
c.setup("fidget", {
	-- Options related to LSP progress subsystem
	progress = {
		poll_rate = 0, -- How often to poll for progress messages
		suppress_on_insert = false, -- Suppress new messages while in insert mode
		ignore_done_already = false, -- Ignore new tasks that are already complete
		ignore_empty_message = false, -- Ignore new tasks that don't contain a message
		display = {
			render_limit = 16, -- How many LSP messages to show at once
			done_ttl = 3, -- How long a message stays visible when complete (in seconds)
			done_icon = "✔", -- Icon shown when all LSP progress tasks are complete
			done_style = "Constant", -- Highlight group for completed LSP tasks
			progress_ttl = math.huge, -- How long a message stays visible if not complete
			progress_icon = { pattern = "dots", period = 1 }, -- Animation for the progress spinner
		},
	},

	-- Options related to notification subsystem
	notification = {
		poll_rate = 10, -- How frequently to update and render notifications
		filter = vim.log.levels.INFO, -- Minimum notification level to display
		override_vim_notify = false, -- Set to true to route all vim.notify() calls through fidget
		window = {
			normal_hl = "Comment", -- Base highlight group in the notification window
			winblend = 100, -- Background color opacity (0 is fully opaque, 100 is fully transparent)
			border = "none", -- Border style: "none", "single", "double", "rounded", "solid", "shadow"
			zindex = 45, -- Stacking priority
			max_width = 0, -- Maximum width of the notification window
			max_height = 0, -- Maximum height of the notification window
			x_padding = 1, -- Padding from right edge of window boundary
			y_padding = 0, -- Padding from bottom edge of window boundary
			align = "bottom", -- Align notifications: "top" or "bottom"
		},
	},
})

-- noice-nvim
c.setup("notify", {
	background_color = "#000000",
	stages = "fade",
})
vim.notify = require("notify")

c.setup("noice", {
	lsp = {
		override = {
			["vim.lsp.utils.convert_input_to_markdown_lines"] = true,
			["vim.lsp.utils.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},

		presets = {
			bottom_search = true,
			command_pallete = true,
			long_message_to_split = true,
			inc_rename = false,
			lsp_doc_border = false,
		},
	},
})

-- otter nvim
c.setup("otter", {
	lsp = {
		diagnostic_update_events = { "BufWritePost" },
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "quarto" },
	callback = function()
		require("otter").activate({ "lua", "python", "bash", "nix", "cpp" }, true, true, nil)
	end,
})

-- markview
c.setup("markview", {
	modes = { "n", "no", "c" },
	hybrid_modes = { "i" },
})

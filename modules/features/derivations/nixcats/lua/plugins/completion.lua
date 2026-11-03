local c = require("config.compat")

c.setup("blink.cmp", {
	keymap = {
		preset = "none",
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
		["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
	},
	sources = { default = { "lsp", "path", "buffer" } },
	completion = {
		list = { selection = { preselect = false, auto_insert = true } },
	},
})

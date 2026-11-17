local c = require("config.compat")

c.setup("blink.cmp", {
	keymap = {
		preset = "none",
		["<CR>"] = { "accept", "fallback" },
		["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
	},
	sources = { default = { "lsp", "path", "buffer" } },
	completion = {
		list = { selection = { preselect = false, auto_insert = true } },
	},
})

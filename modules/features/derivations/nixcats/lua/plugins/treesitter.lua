local c = require("config.compat")

-- Highlighting: start the built-in treesitter highlighter whenever a parser exists.
vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		if pcall(vim.treesitter.start, ev.buf) then
			if vim.bo[ev.buf].filetype ~= "nix" then
				vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end
	end,
})

c.setup("treesitter-context", { max_lines = "25%" })

-- Transparent context bar, re-applied after every :colorscheme.
local function context_highlights()
	vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "#585b70" })
end
context_highlights()
vim.api.nvim_create_autocmd("ColorScheme", { callback = context_highlights })

-- local function extend_query(lang, group, extra)
-- 	local parts = {}
-- 	for _, f in ipairs(vim.treesitter.query.get_files(lang, group)) do
-- 		parts[#parts + 1] = table.concat(vim.fn.readfile(f), "\n")
-- 	end
-- 	vim.treesitter.query.set(lang, group, table.concat(parts, "\n") .. "\n" .. extra)
-- end

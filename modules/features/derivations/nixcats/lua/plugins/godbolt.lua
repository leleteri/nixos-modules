require("config.compat").setup("godbolt", {
	languages = {
		cpp = { compiler = "g132", options = { "-std=c++23 -O2" } },
		c = { compiler = "cg132", options = { "-O2" } },
		rust = { compiler = "r1700", options = { "-C opt-level=2" } },
		-- add other languages/compilers here
	},
	quickfix = {
		enable = true,
		auto_open = true,
	},
	url = "https://godbolt.org",
})

local function refresh_godbolt()
	local src = vim.api.nvim_get_current_win()

	-- close any existing asm windows; bail out if there are none
	local had_asm = false
	for _, w in ipairs(vim.api.nvim_list_wins()) do
		if vim.bo[vim.api.nvim_win_get_buf(w)].filetype == "asm" then
			had_asm = true
			vim.api.nvim_win_close(w, true)
		end
	end
	if not had_asm then
		return
	end

	-- the plugin opens its split after the compile finishes, so give focus
	-- back to the source window once the new asm buffer appears
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "asm",
		once = true,
		callback = function()
			vim.schedule(function()
				if vim.api.nvim_win_is_valid(src) then
					vim.api.nvim_set_current_win(src)
				end
			end)
		end,
	})

	vim.cmd("Godbolt")
end

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*.c", "*.cpp", "*.cc", "*.rs" },
	callback = refresh_godbolt,
})

local c = require("config.compat")

-- ---------------------------------------------------------------- formatting
-- nvf's formatOnSave -> conform.nvim, falling back to the LSP formatter.
c.setup("conform", {
	formatters_by_ft = {
		nix = { "alejandra" },
		lua = { "stylua" },
		python = { "black" },
		sh = { "shfmt" },
		bash = { "shfmt" },
		c = { "clang-format" },
		cpp = { "clang-format" },
	},
	format_on_save = { timeout_ms = 1000, lsp_format = "fallback" },
})

-- ----------------------------------------------------------------------- LSP
if not c.cat("lsp") then
	return
end

-- Uses Neovim 0.11+ vim.lsp.config / vim.lsp.enable; server definitions come
-- from nvim-lspconfig's lsp/*.lua files.
local ok_blink, blink = pcall(require, "blink.cmp")
if ok_blink then
	vim.lsp.config("*", { capabilities = blink.get_lsp_capabilities() })
end

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim", "nixCats" } },
			workspace = { library = { vim.env.VIMRUNTIME }, checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
})

vim.lsp.enable({
	"nil_ls",
	"lua_ls",
	"clangd",
	"bashls",
	"basedpyright",
	"yamlls",
	"jsonls",
	"html",
	"cssls",
	-- "harper_ls",
})

vim.diagnostic.config({ virtual_text = true, severity_sort = true })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
		vim.keymap.set(
			"n",
			"<leader>d",
			vim.diagnostic.open_float,
			vim.tbl_extend("force", opts, { desc = "Line diagnostics" })
		)
	end,
})

local map = vim.keymap.set

map("n", "<leader>w", ":w<CR>", { silent = true, desc = "Write" })
map("n", "<leader>q", ":q<CR>", { silent = true, desc = "Quit" })
map("t", "<esc><esc>", [[<c-\><c-n>]], { silent = true, desc = "Leave terminal mode" })
map("n", "-", ":Oil --float<CR>", { silent = true, desc = "Oil (float)" })
map("n", "<leader>x", ":source %<CR>", { silent = true, desc = "Exec script" })

-- Leader must be set before any plugin or mapping is defined.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("plugins") -- lua/plugins/init.lua
require("config.lsp")

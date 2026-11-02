local c = require("config.compat")

c.setup("blink.cmp", {
  keymap = { preset = "default" }, -- <C-space> open, <C-y> accept, <C-n>/<C-p> select
  sources = { default = { "lsp", "path", "buffer" } },
  completion = { documentation = { auto_show = true } },
})

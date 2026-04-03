require("options")

require("tokyonight").setup({
  style       = "night",
  transparent = true,
})
vim.cmd.colorscheme("tokyonight")

require("lsp")
require("plugins.treesitter")
require("plugins.completion")
require("plugins.telescope")
require("plugins.whichkey")
require("keymaps")

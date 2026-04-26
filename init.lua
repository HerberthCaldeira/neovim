require("options")

-- nvim-treesitter precisa que o diretório de parsers esteja no runtimepath
vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/site")

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
require("plugins.harpoon")
require("plugins.lazygit")
require("plugins.lazydocker")
require("plugins.autopairs")
require("plugins.gitsigns")
require("plugins.lualine")
require("plugins.render-markdown")
require("plugins.httpyac")
require("plugins.dap")
require("plugins.neotest")
require("plugins.toggleterm")
require("plugins.oil")
require("keymaps")

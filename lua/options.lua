local opt = vim.opt

-- Aparência
opt.number         = true
opt.relativenumber = true
opt.termguicolors  = true
opt.signcolumn     = "yes"
opt.cursorline     = true
opt.scrolloff      = 8

-- Indentação
opt.tabstop     = 4
opt.shiftwidth  = 4
opt.expandtab   = true
opt.smartindent = true

-- Busca
opt.ignorecase = true
opt.smartcase  = true
opt.hlsearch   = false
opt.incsearch  = true

-- Comportamento
opt.wrap        = false
opt.splitright  = true
opt.splitbelow  = true
opt.updatetime  = 250
opt.clipboard   = "unnamedplus"
opt.undofile    = true
opt.swapfile    = false

-- Leader
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- Auto save ao sair do modo insert ou ao alterar no modo normal
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = "*",
  command = "silent! write",
})

local opt = vim.opt

-- Aparência
opt.number         = true
opt.relativenumber = true
opt.termguicolors  = true
opt.signcolumn     = "yes"
opt.cursorline     = true
opt.scrolloff      = 8
opt.laststatus     = 3
opt.showtabline    = 0
opt.showmode       = false

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

-- Config local por projeto (.nvim.lua na raiz)
opt.exrc = true

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


-- Janela inativa mais escura para destacar o buffer ativo

-- Destaque visual ao entrar no modo command
vim.api.nvim_create_autocmd("CmdlineEnter", {
  callback = function()
    vim.api.nvim_set_hl(0, "MsgArea", { bg = "#1f1a0e" })
  end,
})
vim.api.nvim_create_autocmd("CmdlineLeave", {
  callback = function()
    vim.api.nvim_set_hl(0, "MsgArea", {})
  end,
})

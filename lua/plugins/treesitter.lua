local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then return end

configs.setup({
  ensure_installed = { "go", "bash", "lua", "vim", "vimdoc", "php", "javascript", "typescript", "tsx" },
  highlight        = { enable = true },
  indent           = { enable = true },
})

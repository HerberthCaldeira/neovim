local ok, telescope = pcall(require, "telescope")
if not ok then return end

telescope.setup({
  defaults = {
    layout_config = {
      horizontal = { width = 0.9 },
    },
    file_ignore_patterns = { "node_modules", ".git/" },
  },
})

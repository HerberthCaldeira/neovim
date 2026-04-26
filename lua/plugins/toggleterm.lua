local ok, toggleterm = pcall(require, "toggleterm")
if not ok then return end

toggleterm.setup({
  size = 15,
  open_mapping = [[<C-\>]],
  direction = "horizontal",
  shade_terminals = true,
  persist_size = true,
  close_on_exit = true,
})

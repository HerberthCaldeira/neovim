local ok, httpyac = pcall(require, "nvim-httpyac")
if not ok then return end

httpyac.setup({
  output_view = "vertical",
})

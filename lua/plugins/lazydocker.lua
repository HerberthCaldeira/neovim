local ok, ld = pcall(require, "lazydocker")
if not ok then return end

ld.setup({})

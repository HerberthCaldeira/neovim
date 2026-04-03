local ok, gitsigns = pcall(require, "gitsigns")
if not ok then return end

gitsigns.setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    -- Navegar entre hunks
    map("]g", gs.next_hunk,   "Próximo hunk")
    map("[g", gs.prev_hunk,   "Hunk anterior")

    -- Stage / undo
    map("<leader>gs", gs.stage_hunk,       "Stage hunk")
    map("<leader>gu", gs.undo_stage_hunk,  "Undo stage hunk")
    map("<leader>gS", gs.stage_buffer,     "Stage buffer")
    map("<leader>gr", gs.reset_hunk,       "Reset hunk")

    -- Visualizar
    map("<leader>gp", gs.preview_hunk,     "Preview hunk")
    map("<leader>gb", gs.blame_line,       "Blame linha")
  end,
})

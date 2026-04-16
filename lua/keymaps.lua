local ok_wk,  wk  = pcall(require, "which-key")
local ok_tel, tel = pcall(require, "telescope.builtin")
local ok_hp,  hp  = pcall(require, "harpoon")

-- Grupos do which-key
if ok_wk then
  wk.add({
    { "<leader>f", group = "Find" },
    { "<leader>l", group = "LSP" },
    { "<leader>d", group = "Diagnostics" },
    { "<leader>h", group = "Harpoon" },
    { "<leader>g", group = "Git" },
    { "<leader>r", group = "HTTP" },
    { "<leader>t", group = "Testes" },
  })
end

vim.keymap.set("n", "<leader>?", "<cmd>WhichKey<cr>", { desc = "Todos os keymaps" })
vim.keymap.set("n", "<leader>C", "<cmd>e ~/.config/nvim/cheatsheet.md<cr>", { desc = "Cheatsheet" })

-- Telescope / Find
if ok_tel then
  vim.keymap.set("n", "<leader>ff", tel.find_files,  { desc = "Find files" })
  vim.keymap.set("n", "<leader>fg", tel.live_grep,   { desc = "Live grep" })
  vim.keymap.set("n", "<leader>fb", tel.buffers,     { desc = "Buffers" })
  vim.keymap.set("n", "<leader>fh", tel.help_tags,   { desc = "Help tags" })
  vim.keymap.set("n", "<leader>fr", tel.oldfiles,    { desc = "Recent files" })
end

-- Diagnósticos (nativo, sempre disponível)
vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,          { desc = "Anterior" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next,          { desc = "Próximo" })
if ok_tel then
  vim.keymap.set("n", "<leader>dl", tel.diagnostics, { desc = "List (telescope)" })
end

-- LSP (ativados no LspAttach para ficarem ligados ao buffer)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = buf, desc = desc })
    end

    map("gd", vim.lsp.buf.definition,                              "Go to definition")
    map("gD", vim.lsp.buf.declaration,                             "Go to declaration")
    map("gi", vim.lsp.buf.implementation,                          "Go to implementation")
    map("K",  vim.lsp.buf.hover,                                   "Hover docs")
    map("<leader>lr", vim.lsp.buf.rename,                          "Rename")
    map("<leader>la", vim.lsp.buf.code_action,                     "Code action")
    map("<leader>lf", function() vim.lsp.buf.format({ async = false }) end, "Format")

    if ok_tel then
      map("gr",           tel.lsp_references,        "References")
      map("<leader>li",   tel.lsp_incoming_calls,    "Incoming calls")
      map("<leader>lo",   tel.lsp_outgoing_calls,    "Outgoing calls")
      map("<leader>ls",   tel.lsp_document_symbols,  "Symbols (documento)")
      map("<leader>lS",   tel.lsp_workspace_symbols, "Symbols (workspace)")
    end
  end,
})

-- Janelas
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Janela esquerda" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Janela direita" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Janela abaixo" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Janela acima" })

-- HTTP (httpyac)
vim.keymap.set("n", "<leader>rr", "<cmd>NvimHttpYac<cr>",      { desc = "Run request" })
vim.keymap.set("n", "<leader>ra", "<cmd>NvimHttpYacAll<cr>",   { desc = "Run all" })
vim.keymap.set("n", "<leader>rp", "<cmd>NvimHttpYacPicker<cr>",{ desc = "Pick request" })
vim.keymap.set("n", "<leader>re", "<cmd>NvimHttpYacEnv<cr>",   { desc = "Select env" })

-- Git
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>",    { desc = "LazyGit" })
vim.keymap.set("n", "<leader>D",  "<cmd>Lazydocker<cr>", { desc = "LazyDocker" })

-- Harpoon
if ok_hp then
  vim.keymap.set("n", "<leader>ha", function() hp:list():add() end,                        { desc = "Add file" })
  vim.keymap.set("n", "<leader>hm", function() hp.ui:toggle_quick_menu(hp:list()) end,     { desc = "Menu" })
  vim.keymap.set("n", "<leader>h1", function() hp:list():select(1) end,                    { desc = "Arquivo 1" })
  vim.keymap.set("n", "<leader>h2", function() hp:list():select(2) end,                    { desc = "Arquivo 2" })
  vim.keymap.set("n", "<leader>h3", function() hp:list():select(3) end,                    { desc = "Arquivo 3" })
  vim.keymap.set("n", "<leader>h4", function() hp:list():select(4) end,                    { desc = "Arquivo 4" })
end

-- Neotest
local ok_nt, nt = pcall(require, "neotest")
if ok_nt then
  vim.keymap.set("n", "<leader>tr", function() nt.run.run() end,                        { desc = "Run (próximo)" })
  vim.keymap.set("n", "<leader>tf", function() nt.run.run(vim.fn.expand("%")) end,      { desc = "Run arquivo" })
  vim.keymap.set("n", "<leader>ts", function() nt.run.stop() end,                       { desc = "Stop" })
  vim.keymap.set("n", "<leader>ta", function() nt.run.attach() end,                     { desc = "Attach" })
  vim.keymap.set("n", "<leader>to", function() nt.output.open({ enter = true }) end,    { desc = "Output" })
  vim.keymap.set("n", "<leader>tp", function() nt.output_panel.toggle() end,            { desc = "Painel" })
  vim.keymap.set("n", "<leader>tm", function() nt.summary.toggle() end,                 { desc = "Summary" })
  vim.keymap.set("n", "[t",         function() nt.jump.prev({ status = "failed" }) end, { desc = "Teste falho anterior" })
  vim.keymap.set("n", "]t",         function() nt.jump.next({ status = "failed" }) end, { desc = "Próximo teste falho" })
end

-- Buffers
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>",     { desc = "Buffer próximo" })
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Buffer anterior" })
vim.keymap.set("n", "<S-q>", "<cmd>bd<cr>",        { desc = "Buffer fechar" })

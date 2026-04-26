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
    { "<leader>T", group = "Terminal" },
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

-- DAP
local ok_dap, dap = pcall(require, "dap")
if ok_dap then
  if ok_wk then
    wk.add({ { "<leader>b", group = "Debug" } })
  end

  vim.keymap.set("n", "<F5>",  dap.continue,          { desc = "DAP: continue" })
  vim.keymap.set("n", "<F10>", dap.step_over,          { desc = "DAP: step over" })
  vim.keymap.set("n", "<F11>", dap.step_into,          { desc = "DAP: step into" })
  vim.keymap.set("n", "<F12>", dap.step_out,           { desc = "DAP: step out" })
  vim.keymap.set("n", "<leader>bb", dap.toggle_breakpoint,                                          { desc = "Toggle breakpoint" })
  vim.keymap.set("n", "<leader>bB", function() dap.set_breakpoint(vim.fn.input("Condição: ")) end, { desc = "Breakpoint condicional" })
  vim.keymap.set("n", "<leader>br", dap.restart,       { desc = "Restart" })
  vim.keymap.set("n", "<leader>bq", dap.terminate,     { desc = "Terminar" })
  vim.keymap.set("n", "<leader>bc", dap.run_to_cursor, { desc = "Run to cursor" })

  local ok_view, dapview = pcall(require, "dap-view")
  if ok_view then
    vim.keymap.set("n", "<leader>bv", dapview.toggle, { desc = "Toggle view" })
  end

  vim.keymap.set("n", "<leader>b?", function()
    local lines = {
      "  Debug — atalhos  ",
      "─────────────────────────────────────",
      " <F5>        Continuar / iniciar",
      " <F10>       Step over",
      " <F11>       Step into",
      " <F12>       Step out",
      "─────────────────────────────────────",
      " <leader>bb  Toggle breakpoint",
      " <leader>bB  Breakpoint condicional",
      " <leader>bc  Run to cursor",
      "─────────────────────────────────────",
      " <leader>br  Restart",
      " <leader>bq  Terminar sessão",
      " <leader>bv  Toggle painel",
      "─────────────────────────────────────",
      "  Go — debug  ",
      "─────────────────────────────────────",
      " F5 → escolha item 4 (Debug Package)",
      " <leader>bb  Marque o breakpoint",
      " <leader>td  Rode o teste com debug",
      "             (cursor dentro do Test)",
      "─────────────────────────────────────",
      "  q / <Esc>  Fechar",
    }
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable = false
    local width = 41
    local height = #lines
    local win = vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      row = math.floor((vim.o.lines - height) / 2),
      col = math.floor((vim.o.columns - width) / 2),
      width = width,
      height = height,
      style = "minimal",
      border = "rounded",
      title = " Debug ",
      title_pos = "center",
    })
    vim.wo[win].cursorline = false
    for _, key in ipairs({ "q", "<Esc>" }) do
      vim.keymap.set("n", key, "<cmd>close<cr>", { buffer = buf, nowait = true })
    end
  end, { desc = "Colinha de debug" })
end

-- Neotest
local ok_nt, nt = pcall(require, "neotest")
if ok_nt then
  vim.keymap.set("n", "<leader>tr", function() nt.run.run() end,                   { desc = "Run (próximo)" })
  vim.keymap.set("n", "<leader>td", function() nt.run.run({ strategy = "dap" }) end, { desc = "Debug (próximo)" })
  vim.keymap.set("n", "<leader>tf", function() nt.run.run(vim.fn.expand("%")) end, { desc = "Run arquivo" })
  vim.keymap.set("n", "<leader>ts", function() nt.run.stop() end,                       { desc = "Stop" })
  vim.keymap.set("n", "<leader>ta", function() nt.run.attach() end,                     { desc = "Attach" })
  vim.keymap.set("n", "<leader>to", function() nt.output.open({ enter = true }) end,    { desc = "Output" })
  vim.keymap.set("n", "<leader>tp", function() nt.output_panel.toggle() end,            { desc = "Painel" })
  vim.keymap.set("n", "<leader>tm", function() nt.summary.toggle() end,                 { desc = "Summary" })
  vim.keymap.set("n", "[t",         function() nt.jump.prev({ status = "failed" }) end, { desc = "Teste falho anterior" })
  vim.keymap.set("n", "]t",         function() nt.jump.next({ status = "failed" }) end, { desc = "Próximo teste falho" })
end

-- Oil
local ok_oil = pcall(require, "oil")
if ok_oil then
  vim.keymap.set("n", "-",          "<cmd>Oil<cr>",                              { desc = "Oil: abrir diretório" })
  vim.keymap.set("n", "<leader>e",  function() require("oil").open_float() end,  { desc = "Oil: flutuante" })
end

-- Terminal
local ok_tt, tt = pcall(require, "toggleterm.terminal")
if ok_tt then
  local float_term = tt.Terminal:new({ direction = "float" })
  local vert_term  = tt.Terminal:new({ direction = "vertical", size = 60 })

  vim.keymap.set("n", "<leader>Tt", "<cmd>ToggleTerm<cr>",                        { desc = "Toggle terminal" })
  vim.keymap.set("n", "<leader>Tf", function() float_term:toggle() end,           { desc = "Terminal flutuante" })
  vim.keymap.set("n", "<leader>Tv", function() vert_term:toggle() end,            { desc = "Terminal vertical" })
  vim.keymap.set("t", "<Esc>",      [[<C-\><C-n>]],                               { desc = "Sair do modo terminal" })
end

-- Buffers
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>",     { desc = "Buffer próximo" })
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Buffer anterior" })
vim.keymap.set("n", "<S-q>", "<cmd>bd<cr>",        { desc = "Buffer fechar" })

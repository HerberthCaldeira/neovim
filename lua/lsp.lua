-- LSP nativo do Neovim 0.11+ (sem nvim-lspconfig)

-- Go (requer: go install golang.org/x/tools/gopls@latest)
vim.lsp.config("gopls", {
  cmd          = { "gopls" },
  filetypes    = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    gopls = {
      analyses       = { unusedparams = true, shadow = true },
      staticcheck    = true,
      gofumpt        = true,
      usePlaceholders = true,
    },
  },
})
vim.lsp.enable("gopls")

-- Bash (requer: npm install -g bash-language-server)
vim.lsp.config("bashls", {
  cmd          = { "bash-language-server", "start" },
  filetypes    = { "sh", "bash" },
  root_markers = { ".git" },
})
vim.lsp.enable("bashls")

-- Diagnósticos
vim.diagnostic.config({
  virtual_text    = true,
  signs           = true,
  underline       = true,
  update_in_insert = false,
  severity_sort   = true,
})

-- Formato ao salvar
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern  = "*.go",
  callback = function()
    vim.lsp.buf.format({ async = false })

    -- organizeImports via code action
    local params = vim.lsp.util.make_range_params(0, "utf-16")
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    for cid, res in pairs(result or {}) do
      for _, action in pairs(res.result or {}) do
        if action.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(action.edit, enc)
        end
      end
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern  = "*.sh",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

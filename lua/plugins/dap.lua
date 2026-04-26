local ok_dap, dap = pcall(require, "dap")
if not ok_dap then return end

-- Cores dos símbolos de breakpoint
vim.api.nvim_set_hl(0, "DapBreakpoint",         { fg = "#ff5555" })           -- vermelho
vim.api.nvim_set_hl(0, "DapBreakpointCondition",{ fg = "#ffb86c" })           -- amarelo/laranja
vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#ff5555", italic = true })
vim.api.nvim_set_hl(0, "DapLogPoint",           { fg = "#f1fa8c" })           -- amarelo claro
vim.api.nvim_set_hl(0, "DapStopped",            { fg = "#50fa7b" })           -- verde
vim.api.nvim_set_hl(0, "DapStoppedLine",        { bg = "#1a3a1a" })

-- Símbolos de breakpoint
vim.fn.sign_define("DapBreakpoint",         { text = "●", texthl = "DapBreakpoint",         linehl = "",              numhl = "" })
vim.fn.sign_define("DapBreakpointCondition",{ text = "◆", texthl = "DapBreakpointCondition", linehl = "",              numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpointRejected",  linehl = "",              numhl = "" })
vim.fn.sign_define("DapLogPoint",           { text = "◉", texthl = "DapLogPoint",            linehl = "",              numhl = "" })
vim.fn.sign_define("DapStopped",            { text = "▶", texthl = "DapStopped",             linehl = "DapStoppedLine", numhl = "" })

local ok_view, dapview = pcall(require, "dap-view")
if ok_view then
  dapview.setup({
    auto_toggle = true,
    virtual_text = { enabled = true },
    windows = {
      size = 0.35,
      position = "right",
      terminal = { position = "bottom", size = 0.3 },
    },
  })
end

-- Go (usa Delve — instalar com: go install github.com/go-delve/delve/cmd/dlv@latest)
local ok_go, dapgo = pcall(require, "dap-go")
if ok_go then
  dapgo.setup({
    delve = { output_mode = "local" },
  })
end

-- PHP via Xdebug
-- Requer: bash install.sh (instala @xdebug/vscode-php-debug via npm)
-- No container, adicione ao xdebug.ini:
--   xdebug.mode=debug
--   xdebug.client_host=host.docker.internal
--   xdebug.client_port=9003
--   xdebug.start_with_request=yes   (para web) ou trigger (para CLI)
--
-- No docker-compose.yml, no serviço PHP:
--   extra_hosts:
--     - "host.docker.internal:host-gateway"
--
-- Por projeto, defina no .nvim.lua:
--   vim.g.dap_php_container_root = "/var/www/html"  (padrão)
dap.adapters.php = {
  type = "executable",
  command = "node",
  args = { vim.fn.expand("~/.local/share/nvim/dap/php-debug/extension/out/phpDebug.js") },
}

dap.configurations.php = {
  {
    name = "Xdebug (Docker)",
    type = "php",
    request = "launch",
    port = 9003,
    pathMappings = {},
  },
  {
    name = "Xdebug (host)",
    type = "php",
    request = "launch",
    port = 9003,
  },
}

-- pathMappings resolvido em runtime via dap.run, antes de qualquer coisa ser
-- enviada ao adapter. Garante que vim.g.dap_php_container_root (definido no
-- .nvim.lua do projeto via exrc) já esteja disponível.
local _dap_run = dap.run
dap.run = function(config, opts)
  if config.type == "php" and config.name == "Xdebug (Docker)" then
    config = vim.deepcopy(config)
    config.pathMappings = {
      [vim.g.dap_php_container_root or "/var/www/html"] = vim.fn.getcwd(),
    }
  end
  return _dap_run(config, opts)
end

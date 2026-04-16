# neovim

## Testes com Docker (neotest)

Os adapters de teste rodam os comandos dentro do container quando `vim.g.neotest_docker_service` está definido. Crie um `.nvim.lua` na raiz do projeto:

```lua
-- .nvim.lua
vim.g.neotest_docker_service = "app"  -- nome do serviço no docker-compose
```

O Neovim carrega esse arquivo via `exrc` (habilitado em `options.lua`). Na primeira abertura pedirá confirmação de segurança.

## Debug PHP com Xdebug (nvim-dap)

Requer o adapter instalado (`install.sh` instala via npm em `~/.local/share/nvim/dap/php-debug/`).

Crie um `.nvim.lua` na raiz do projeto com o path do container e o serviço Docker:

```lua
-- .nvim.lua
vim.g.neotest_docker_service = "laravel.test-1"  -- nome do serviço no docker-compose
vim.g.dap_php_container_root = "/var/www/html"    -- path do projeto dentro do container
```

### Como usar

1. Inicie a sessão: `:lua require('dap').continue()` → selecione **"Xdebug (Docker)"**
2. Coloque breakpoints nos arquivos
3. Dispare a execução (requisição HTTP ou `sail debug test --filter=...`)

O Xdebug conecta no adapter e o Neovim para no breakpoint.

### Diretrizes

**`pathMappings` usa wrap de `dap.run`, não listener.**
`dap.listeners.before.launch` não funciona para `pathMappings`: o nvim-dap já copiou os valores antes do listener rodar, então o adapter recebe `pathMappings` vazio e repassa o path local para o Xdebug sem remapear — os breakpoints ficam `unresolved`.

O `dap.run` é o lugar certo: é chamado antes de qualquer request ser enviado ao adapter. Ver `lua/plugins/dap.lua`.

**`start_with_request=yes` ativa Xdebug em toda requisição.**
Se o adapter não estiver escutando, o Xdebug falha silenciosamente e o código continua rodando sem erro visível. Verificar com `ss -tlnp | grep 9003`.

**`dap_php_container_root` é o path no container, não o nome do serviço.**
Errado: `"/var/www/html"` → correto para Sail. Não confundir com `neotest_docker_service`.

## Parsers do treesitter (PHP e outros que precisam compilar)

Requer o `tree-sitter-cli` instalado globalmente:

```bash
npm install -g tree-sitter-cli
```

Sem ele, `:TSInstall php` (e outros parsers sem binário pré-compilado) falha com erro `ENOENT: tree-sitter`.

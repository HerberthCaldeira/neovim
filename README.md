# neovim

## Testes com Docker (neotest)

Os adapters de teste rodam os comandos dentro do container quando `vim.g.neotest_docker_service` está definido. Crie um `.nvim.lua` na raiz do projeto:

```lua
-- .nvim.lua
vim.g.neotest_docker_service = "app"  -- nome do serviço no docker-compose
```

O Neovim carrega esse arquivo via `exrc` (habilitado em `options.lua`). Na primeira abertura pedirá confirmação de segurança.

## Parsers do treesitter (PHP e outros que precisam compilar)

Requer o `tree-sitter-cli` instalado globalmente:

```bash
npm install -g tree-sitter-cli
```

Sem ele, `:TSInstall php` (e outros parsers sem binário pré-compilado) falha com erro `ENOENT: tree-sitter`.

# Cheatsheet Neovim

## Motions

### Horizontal
| Keymap    | Ação                                             |
|---|---|
| `h` `l`   | Caractere esquerda / direita                     |
| `w`       | Início da próxima palavra                        |
| `b`       | Início da palavra anterior                       |
| `e`       | Final da próxima palavra                         |
| `0`       | Início da linha                                  |
| `^`       | Primeiro caractere não-vazio da linha            |
| `$`       | Final da linha                                   |
| `f{c}`    | Pula para o caractere `c` na linha (inclusive)   |
| `t{c}`    | Pula para antes do caractere `c` na linha        |
| `;`       | Repete o último `f` ou `t`                       |
| `,`       | Repete o último `f` ou `t` (direção oposta)      |

### Vertical
| Keymap    | Ação                                             |
|---|---|
| `j` `k`   | Linha abaixo / acima                             |
| `gg`      | Primeira linha do arquivo                        |
| `G`       | Última linha do arquivo                          |
| `{N}G`    | Ir para a linha N (ex: `42G`)                    |
| `{`       | Parágrafo anterior                               |
| `}`       | Próximo parágrafo                                |
| `<C-d>`   | Meia página abaixo                               |
| `<C-u>`   | Meia página acima                                |
| `<C-f>`   | Página inteira abaixo                            |
| `<C-b>`   | Página inteira acima                             |
| `zz`      | Centraliza a tela na linha atual                 |

### Operadores + Motions
| Keymap      | Ação                                           |
|---|---|
| `d{motion}` | Deletar (ex: `dw`, `d$`, `dd`)                 |
| `c{motion}` | Deletar e entrar no Insert (ex: `cw`, `c$`)    |
| `y{motion}` | Copiar (ex: `yw`, `y$`, `yy`)                  |
| `>{motion}` | Indentar                                       |
| `<{motion}` | Desindentar                                    |

### Text Objects
| Keymap    | Ação                                             |
|---|---|
| `iw`      | Palavra (sem espaços)                            |
| `aw`      | Palavra (com espaços)                            |
| `i"` `i'` | Conteúdo dentro das aspas                        |
| `a"` `a'` | Aspas e conteúdo                                 |
| `i(` `i)` | Conteúdo dentro dos parênteses                   |
| `i{` `i}` | Conteúdo dentro das chaves                       |
| `it`      | Conteúdo dentro de uma tag HTML                  |

> Combine operadores com text objects: `di"` deleta dentro das aspas, `ci(` muda dentro dos parênteses, `ya{` copia o bloco com as chaves.

---

## LSP

### Navegação
| Keymap       | Ação                                      |
|---|---|
| `gd`         | Ir para a definição                       |
| `gD`         | Ir para a declaração                      |
| `gi`         | Ir para a implementação                   |
| `gr`         | Listar referências (Telescope)            |
| `K`          | Documentação da função sob o cursor       |

### Modificação
| Keymap         | Ação                                    |
|---|---|
| `<leader>lr`   | Renomear em todos os arquivos           |
| `<leader>la`   | Code actions (importar, corrigir...)    |
| `<leader>lf`   | Formatar arquivo                        |

### Símbolos
| Keymap         | Ação                                    |
|---|---|
| `<leader>ls`   | Símbolos do arquivo atual               |
| `<leader>lS`   | Símbolos do projeto inteiro             |
| `<leader>li`   | Incoming calls                          |
| `<leader>lo`   | Outgoing calls                          |

---

## Diagnósticos

| Keymap         | Ação                                    |
|---|---|
| `<leader>dl`   | Listar todos os erros (Telescope)       |
| `<leader>dd`   | Detalhar erro da linha atual            |
| `]d`           | Próximo erro                            |
| `[d`           | Erro anterior                           |

---

## Find (Telescope)

| Keymap         | Ação                                    |
|---|---|
| `<leader>ff`   | Buscar arquivos                         |
| `<leader>fg`   | Buscar texto no projeto (live grep)     |
| `<leader>fw`   | Buscar palavra sob o cursor             |
| `<leader>fb`   | Listar buffers abertos                  |
| `<leader>fr`   | Arquivos recentes                       |
| `<leader>fh`   | Buscar na documentação do Neovim        |

### Dentro do Telescope
| Keymap    | Ação                                       |
|---|---|
| `<C-j>`   | Próximo resultado                          |
| `<C-k>`   | Resultado anterior                         |
| `<C-q>`   | Enviar todos para a quickfix               |
| `<Tab>`   | Selecionar item                            |
| `<Esc>`   | Fechar                                     |

---

## Git

| Keymap         | Ação                                    |
|---|---|
| `<leader>gg`   | Abrir LazyGit                           |
| `<leader>gc`   | Commits (Telescope)                     |
| `<leader>gb`   | Branches (Telescope)                    |
| `<leader>gs`   | Status (Telescope)                      |

---

## Harpoon

| Keymap         | Ação                                    |
|---|---|
| `<leader>ha`   | Adicionar arquivo atual                 |
| `<leader>hm`   | Abrir menu                              |
| `<leader>h1`   | Ir para arquivo 1                       |
| `<leader>h2`   | Ir para arquivo 2                       |
| `<leader>h3`   | Ir para arquivo 3                       |
| `<leader>h4`   | Ir para arquivo 4                       |

---

## Buffers

| Keymap    | Ação                                       |
|---|---|
| `<S-l>`   | Próximo buffer                             |
| `<S-h>`   | Buffer anterior                            |
| `<S-q>`   | Fechar buffer                              |

---

## Janelas

| Keymap    | Ação                                       |
|---|---|
| `<C-h>`   | Janela esquerda                            |
| `<C-l>`   | Janela direita                             |
| `<C-j>`   | Janela abaixo                              |
| `<C-k>`   | Janela acima                               |

---

## Busca

| Keymap    | Ação                                       |
|---|---|
| `/`       | Buscar no buffer (para frente)             |
| `?`       | Buscar no buffer (para trás)               |
| `n`       | Próxima ocorrência                         |
| `N`       | Ocorrência anterior                        |
| `*`       | Buscar palavra sob o cursor                |
| `#`       | Buscar palavra sob o cursor (para trás)    |

---

## Geral

| Keymap         | Ação                                    |
|---|---|
| `<leader>?`    | Todos os keymaps (WhichKey)             |
| `<leader>D`    | Abrir LazyDocker                        |






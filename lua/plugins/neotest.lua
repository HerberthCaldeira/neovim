local ok, neotest = pcall(require, "neotest")
if not ok then return end

-- Container docker: definido em .nvim.lua do projeto via vim.g.neotest_docker_service
-- Usa o nome do container (não o serviço do compose), ex: "laravel.test-1"
-- Exemplo no .nvim.lua do projeto:
--   vim.g.neotest_docker_service = "laravel.test-1"

-- Retorna string — para adapters que montam o comando via shell (jest, vitest)
local function docker(cmd)
  local container = vim.g.neotest_docker_service
  if not container or container == "" then return cmd end
  return "docker exec " .. container .. " " .. cmd
end

-- Retorna tabela — para adapters que passam argv direto ao jobstart (phpunit, pest)
local function docker_argv(...)
  local container = vim.g.neotest_docker_service
  local args = { ... }
  if container and container ~= "" then
    local result = { "docker", "exec", container }
    for _, v in ipairs(args) do result[#result + 1] = v end
    return result
  end
  return args
end

neotest.setup({
  adapters = {
    -- Go
    require("neotest-go")({
      args = { "-v", "-count=1" },
    }),

    -- Lua (usa plenary)
    require("neotest-plenary"),

    -- Jest (JS/TS)
    require("neotest-jest")({
      jestCommand = function() return docker("npx jest") end,
      jestConfigFile = function(file)
        if string.find(file, "/packages/") then
          return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
        end
        return vim.fn.getcwd() .. "/jest.config.ts"
      end,
      env = { CI = true },
      cwd = function() return vim.fn.getcwd() end,
    }),

    -- Vitest (JS/TS)
    require("neotest-vitest")({
      vitestCommand = function() return docker("npx vitest") end,
    }),

    -- Pest (PHP) — deve vir antes do phpunit para ter prioridade
    -- Sail é auto-detectado via vendor/bin/sail; quando ativo, results_path
    -- vai para storage/app/ (dentro do projeto, acessível do host via mount).
    require("neotest-pest")({
      sail_project_path = "/var/www/html",
    }),

    -- PHPUnit
    require("neotest-phpunit")({
      phpunit_cmd = function() return docker_argv("./vendor/bin/phpunit") end,
    }),
  },

  output       = { open_on_run = false },
  output_panel = { enabled = true, open = "botright split | resize 15" },
  summary      = { animated = true },
  status       = { enabled = true, virtual_text = true, signs = true },
  floating     = { border = "rounded", max_height = 0.7, max_width = 0.7 },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "neotest-output",
  callback = function()
    vim.wo.signcolumn  = "yes:2"
    vim.wo.scrolloff   = 3
    vim.wo.wrap        = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "neotest-output-panel",
  callback = function()
    vim.api.nvim_set_hl(0, "NeotestPanelNormal", { bg = "#13141f" })
    vim.wo.winhighlight = "Normal:NeotestPanelNormal"
  end,
})

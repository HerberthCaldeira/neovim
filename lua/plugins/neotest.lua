local ok, neotest = pcall(require, "neotest")
if not ok then return end

-- Prefixo docker: definido em .nvim.lua do projeto via vim.g.neotest_docker_service
-- Exemplo no .nvim.lua do projeto:
--   vim.g.neotest_docker_service = "app"
local function docker(cmd)
  local service = vim.g.neotest_docker_service
  if not service or service == "" then return cmd end

  local has_compose =
    vim.fn.filereadable("docker-compose.yml") == 1 or
    vim.fn.filereadable("docker-compose.yaml") == 1 or
    vim.fn.filereadable("compose.yml") == 1 or
    vim.fn.filereadable("compose.yaml") == 1

  if has_compose then
    return "docker compose exec " .. service .. " " .. cmd
  end
  return cmd
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

    -- PHPUnit
    require("neotest-phpunit")({
      phpunit_cmd = function() return docker("./vendor/bin/phpunit") end,
    }),

    -- Pest (PHP)
    require("neotest-pest")({
      pest_cmd = function() return docker("./vendor/bin/pest") end,
    }),
  },

  output       = { open_on_run = false },
  output_panel = { enabled = true, open = "botright split | resize 15" },
  summary      = { animated = true },
  status       = { enabled = true, virtual_text = true, signs = true },
})

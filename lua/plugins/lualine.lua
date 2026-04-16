require("lualine").setup({
  options = {
    theme                = "tokyonight",
    component_separators = { left = "", right = "" },
    section_separators   = { left = "", right = "" },
    globalstatus         = true,
  },
  sections = {
    lualine_a = { { "mode", icon = "" } },
    lualine_b = {
      { "branch", icon = "" },
      { "diff",
        symbols = { added = " ", modified = " ", removed = " " },
        source  = function()
          local gs = vim.b.gitsigns_status_dict
          if gs then
            return { added = gs.added, modified = gs.changed, removed = gs.removed }
          end
        end,
      },
    },
    lualine_c = {
      { "filename", path = 1, symbols = { modified = "●", readonly = "", unnamed = "[No Name]" } },
      { "diagnostics",
        sources  = { "nvim_lsp" },
        symbols  = { error = " ", warn = " ", info = " ", hint = " " },
      },
    },
    lualine_x = {
      { "filetype", icon_only = false },
    },
    lualine_y = { "progress" },
    lualine_z = { { "location", icon = "" } },
  },
  inactive_sections = {
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "location" },
  },
})

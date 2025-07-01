local prettier_config = { "prettierd", "prettier", stop_after_first = true }

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = prettier_config,
    html = prettier_config,
    markdown = prettier_config,
    json = prettier_config,
    jsonc = prettier_config,
    python = {
      -- Fix lint errors
      "ruff_fix",
      "ruff_format",
      "ruff_organize_imports",
    },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options

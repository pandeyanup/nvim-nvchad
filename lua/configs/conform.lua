local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    vue = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", stop_after_first = true },
    scss = { "prettierd", "prettier", stop_after_first = true },
    -- less = { "prettierd", "prettier",stop_after_first = true },
    html = { "prettierd", "prettier", stop_after_first = true },
    json = { "prettierd", "prettier", stop_after_first = true },
    jsonc = { "prettierd", "prettier", stop_after_first = true },
    yaml = { "prettierd", "prettier", stop_after_first = true },
    -- graphql = { "prettierd", "prettier" ,stop_after_first = true},
    -- handlebars = { "prettierd", "prettier",stop_after_first = true },
    -- analog = { "prettierd", "prettier" ,stop_after_first = true},
    -- ag = { "prettierd", "prettier",stop_after_first = true },
    rust = { "rust_analyzer" },
    python = { "black", "ruff" },
  },

  -- formatters_by_ft = {
  --   lua = { "stylua" },
  --   css = { "prettierd" },
  --   html = { "prettierd" },
  --   typescriptreact = { "prettierd" },
  --   rust = { "rust_analyzer" },
  -- },

  -- If this is set, Conform will run the formatter on save.
  -- format_on_save = {
  --   lsp_format = "fallback",
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
  -- If this is set, Conform will run the formatter asynchronously after save.
  format_after_save = {
    lsp_format = "fallback",
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options

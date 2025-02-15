local options = {
  formatters_by_ft = {
    javascript = { "prettierd", "prettier" },
    javascriptreact = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    typescriptreact = { "prettierd", "prettier" },
    vue = { "prettierd", "prettier" },
    css = { "prettierd", "prettier" },
    scss = { "prettierd", "prettier" },
    less = { "prettierd", "prettier" },
    html = { "prettierd", "prettier" },
    json = { "prettierd", "prettier" },
    jsonc = { "prettierd", "prettier" },
    yaml = { "prettierd", "prettier" },
    graphql = { "prettierd", "prettier" },
    handlebars = { "prettierd", "prettier" },
    analog = { "prettierd", "prettier" },
    ag = { "prettierd", "prettier" },
    rust = { "rust_analyzer" },
  },

  -- formatters_by_ft = {
  --   lua = { "stylua" },
  --   css = { "prettierd" },
  --   html = { "prettierd" },
  --   typescriptreact = { "prettierd" },
  --   rust = { "rust_analyzer" },
  -- },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options

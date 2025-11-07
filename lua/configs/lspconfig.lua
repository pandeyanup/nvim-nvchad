-- Load NvChad LSP defaults
local nvlsp = require "nvchad.configs.lspconfig"

-- Helper to extend NvChad's on_attach with custom mappings
local function on_attach(client, bufnr)
  if nvlsp.on_attach then
    nvlsp.on_attach(client, bufnr)
  end

  -- Global LSP keymaps
  local opts = { buffer = bufnr, silent = true, noremap = true }

  vim.keymap.set(
    "n",
    "<leader>ca",
    vim.lsp.buf.code_action,
    vim.tbl_extend("force", opts, {
      desc = "Code Action",
    })
  )

  -- You can also add other universal LSP shortcuts here if you want:
  -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
end

-- Register global defaults for all LSPs
vim.lsp.config("*", {
  on_attach = on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
})

-- Enable servers
vim.lsp.enable {
  "bashls",
  "html",
  "cssls",
  "clangd",
  "tailwindcss",
  "pyright",
  "ruff",
  "rust_analyzer",
  "vue_ls",
  "astro",
  "gopls",
}

-- Load TypeScript-specific setup
require("configs.typescript").setup()

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"

      vim.keymap.set(
        "n",
        "<leader>lr",
        "<cmd>lua vim.lsp.buf.rename()<CR>",
        { noremap = true, silent = true, desc = "LSP Rename" }
      )
      -- LSP code action
      vim.keymap.set(
        "n",
        "<leader>ca",
        "<cmd>lua vim.lsp.buf.code_action()<CR>",
        { noremap = true, silent = true, desc = "LSP Code action" }
      )
      vim.keymap.set(
        "n",
        "<leader>li",
        "<cmd>lua vim.lsp.buf.implementation()<CR>",
        { noremap = true, silent = true, desc = "LSP Implementation" }
      )
      vim.keymap.set(
        "n",
        "<leader>lR",
        "<cmd>lua vim.lsp.buf.rename()<CR>",
        { noremap = true, silent = true, desc = "LSP Rename" }
      )

      vim.keymap.set("n", "<leader>lt", "", { noremap = true, silent = true, desc = "Telescope LSP" })
      vim.keymap.set(
        "n",
        "<leader>lts",
        "<cmd>Telescope lsp_document_symbols<CR>",
        { noremap = true, silent = true, desc = "LSP Document symbols" }
      )

      vim.keymap.set("n", "<leader>lo", "", { noremap = true, silent = true, desc = "Other LSP" })
      vim.keymap.set(
        "n",
        "<leader>los",
        "<cmd>lua vim.lsp.buf.signature_help()<CR>",
        { noremap = true, silent = true, desc = "LSP Signature help" }
      )
      vim.keymap.set(
        "n",
        "<leader>lot",
        "<cmd>lua vim.lsp.buf.type_definition()<CR>",
        { noremap = true, silent = true, desc = "LSP Type definition" }
      )
      vim.keymap.set(
        "n",
        "<leader>low",
        "<cmd>lua vim.lsp.buf.document_symbol()<CR>",
        { noremap = true, silent = true, desc = "LSP Document symbol" }
      )
      vim.keymap.set(
        "n",
        "<leader>lor",
        "<cmd>lua vim.lsp.buf.references()<CR>",
        { noremap = true, silent = true, desc = "LSP References" }
      )
      -- vim.keymap.set(
      --   "n",
      --   "<leader>lf",
      --   "<cmd>lua vim.lsp.buf.formatting()<CR>",
      --   { noremap = true, silent = true, desc = "LSP Format" }
      -- )

      -- vim.keymap.set(
      --   "n",
      --   "<leader>ld",
      --   "<cmd>lua vim.lsp.buf.definition()<CR>",
      --   { noremap = true, silent = true, desc = "LSP Definition" }
      -- )
      -- vim.keymap.set(
      --   "n",
      --   "<leader>lh",
      --   "<cmd>lua vim.lsp.buf.hover()<CR>",
      --   { noremap = true, silent = true, desc = "LSP Hover" }
      -- )

      -- vim.keymap.set(
      --   "n",
      --   "<leader>lwa",
      --   "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
      --   { noremap = true, silent = true, desc = "Add workspace folder" }
      -- )
      -- vim.keymap.set(
      --   "n",
      --   "<leader>lwr",
      --   "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
      --   { noremap = true, silent = true, desc = "Remove workspace folder" }
      -- )
      -- vim.keymap.set(
      --   "n",
      --   "<leader>lwl",
      --   "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
      --   { noremap = true, silent = true, desc = "List workspace folders" }
      -- )
    end,
  },
}

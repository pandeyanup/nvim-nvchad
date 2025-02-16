require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set
local unmap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

unmap("n", "<leader>h")

-- Nvim Tabs
map("n", "<leader>ta", ":tabnew<CR>", { desc = "Create new tab" })
map("n", "<leader>tn", ":tabnext<CR>", { desc = "Next tab" })
map("n", "<leader>tp", ":tabprevious<CR>", { desc = "Previous tab" })
map("n", "<leader>tc", ":tabclose<CR>", { desc = "Close current tab" })

-- Remove Unused Imports (TS)
vim.api.nvim_set_keymap("n", "<leader>cr", "", {
  noremap = true,
  silent = true,
  callback = function()
    vim.lsp.buf.code_action {
      apply = true,
      context = {
        only = { "source.removeUnused.ts" },
        diagnostics = {},
      },
    }
  end,
  desc = "Remove unused imports",
})
-- Organize Imports (TS)
vim.api.nvim_set_keymap("n", "<leader>co", "", {
  noremap = true,
  silent = true,
  callback = function()
    vim.lsp.buf.code_action {
      apply = true,
      context = {
        only = { "source.organizeImports.ts" },
        diagnostics = {},
      },
    }
  end,
  desc = "Organize imports",
})

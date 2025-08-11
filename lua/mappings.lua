require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set
local unmap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

unmap("n", "<leader>h")

-- Misc
-- Select All (Ctrl+a)
vim.api.nvim_set_keymap("n", "<C-a>", "ggVG", { noremap = true, silent = true })

-- Nvim Tabs
map("n", "<leader>ta", ":tabnew<CR>", { desc = "Create new tab" })
map("n", "<leader>tn", ":tabnext<CR>", { desc = "Next tab" })
map("n", "<leader>tp", ":tabprevious<CR>", { desc = "Previous tab" })
map("n", "<leader>tc", ":tabclose<CR>", { desc = "Close current tab" })

-- Telescope Undo
-- map("n", "<leader>tu", "<cmd>Telescope undo<cr>", { desc = "Telescope undo" })
-- Telescope Jump
-- map("n", "<leader>tj", "<cmd>Telescope jumplist<cr>", { desc = "Telescope jumplist" })
-- Telescope buffer
-- map("n", "<leader>tb", "<cmd>Telescope buffers<cr>", { desc = "Telescope buffers" })

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

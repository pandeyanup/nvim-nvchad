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

-- Paste JSON as Typescript Type
do
  local ok, pj = pcall(require, "scripts.json-as-ts")
  if not ok then
    return
  end

  -- :PasteJsonAsTs [TypeName] (default: Root)
  vim.api.nvim_create_user_command("PasteJsonAsTs", function(opts)
    pj.paste_ts { name = (opts.args ~= "" and opts.args) or "Root" }
  end, { nargs = "?" })

  -- Keymaps
  vim.keymap.set("n", "<leader>cj", function()
    pj.paste_ts { name = "Root" } -- from system clipboard (+)
  end, { desc = "Paste JSON as TS type (clipboard)" })

  -- vim.keymap.set("v", "<leader>cj", function()
  --   pj.paste_ts { source = "selection", name = "Root" } -- from visual selection
  -- end, { desc = "Selection → TS type" })

  -- Nice group label in which-key (optional)
  pcall(function()
    require("which-key").add { { "<leader>c", group = "Custom Code" } }
  end)
end

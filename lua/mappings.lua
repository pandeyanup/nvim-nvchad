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

-- Toggle between insert and normal mode using 'jk'
-- vim.keymap.set({ "i", "n" }, "jk", function()
--   local mode = vim.api.nvim_get_mode().mode
--   if mode:find("i") then
--     -- If currently in insert mode → exit to normal mode
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
--   elseif mode == "n" then
--     -- If currently in normal mode → enter insert mode at cursor
--     vim.api.nvim_feedkeys("i", "n", false)
--   end
-- end, { desc = "Toggle insert/normal mode", silent = true, noremap = true })

-- Vertical split
vim.keymap.set("n", "<leader>cv", "<cmd>vsplit<CR>", {
  desc = "Vertical Split",
  silent = true,
  noremap = true,
})

-- Horizontal split
vim.keymap.set("n", "<leader>ch", "<cmd>split<CR>", {
  desc = "Horizontal Split",
  silent = true,
  noremap = true,
})

-- Exit insert mode with 'jk'
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode", silent = true })

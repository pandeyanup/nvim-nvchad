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
map("n", "<leader>cta", ":tabnew<CR>", { desc = "Create new tab" })
map("n", "<leader>ctn", ":tabnext<CR>", { desc = "Next tab" })
map("n", "<leader>ctp", ":tabprevious<CR>", { desc = "Previous tab" })
map("n", "<leader>ctc", ":tabclose<CR>", { desc = "Close current tab" })

-- Optional: which-key integration
pcall(function()
  require("which-key").add {
    { "<leader>ct", group = "Tabs" },
    {
      "<leader>ce",
      group = "Extra",
    },
    {
      "<leader>ch",
      group = "Harpoon",
    },
    {
      "<leader>cs",
      group = "Session",
    },
  }
end)

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
map("n", "<leader>cv", "<cmd>vsplit<CR>", {
  desc = "Vertical Split",
  silent = true,
  noremap = true,
})

-- map("n", "<leader>qq", "<cmd>quitall<CR>", {
--   desc = "Quit All",
--   silent = true,
--   noremap = true,
-- })
map("n", "<leader>qc", "<cmd>quit<CR>", {
  desc = "Quit Current",
  silent = true,
  noremap = true,
})

-- Horizontal split
map("n", "<leader>ceh", "<cmd>split<CR>", {
  desc = "Horizontal Split",
  silent = true,
  noremap = true,
})

-- Exit insert mode with 'jk'
map("i", "jk", "<Esc>", { desc = "Exit insert mode", silent = true })

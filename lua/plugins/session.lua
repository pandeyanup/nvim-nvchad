return {
  "rmagatti/auto-session",
  lazy = false,
  keys = {
    -- Will use Telescope if installed or a vim.ui.select picker otherwise
    { "<leader>bg", "<cmd>SessionSearch<CR>", desc = "Search session" },
    { "<leader>bs", "<cmd>SessionSave<CR>", desc = "Save session" },
    { "<leader>ba", "<cmd>SessionToggleAutoSave<CR>", desc = "Toggle autosave session" },
  },
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    load_on_setup = true,
    previewer = false,
    auot_save = true,
    lazy_support = true,
    auto_restore = true,
    auto_create = true,
    -- mappings = {
    --   -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
    --   delete_session = { "i", "<C-D>" },
    --   alternate_session = { "i", "<C-S>" },
    --   copy_session = { "i", "<C-Y>" },
    -- },
    theme_conf = {
      border = true,
      -- layout_config = {
      --   width = 0.8, -- Can set width and height as percent of window
      --   height = 0.5,
      -- },
    },
  },
}

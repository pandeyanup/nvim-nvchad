return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
    },
    config = function()
      require("telescope").setup {
        -- the rest of your telescope config goes here
        extensions = {
          undo = {
            -- telescope-undo.nvim config, see below
          },
          -- other extensions:
          -- file_browser = { ... }
        },
      }
      require("telescope").load_extension "undo"
      -- optional: vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
    end,
  },
}

-- return {
--   {
--     "mbbill/undotree",
--     lazy = false, -- needs to be explicitly set, because of the keys property
--     keys = {
--       {
--         "<leader>u",
--         vim.cmd.UndotreeToggle,
--         desc = "Toggle undotree",
--       },
--     },
--   },
-- }

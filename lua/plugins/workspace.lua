return {
  "natecraddock/workspaces.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>cwo", "<cmd>WorkspacesOpen<CR>", desc = "Open workspace" },
    { "<leader>cwa", "<cmd>WorkspacesAdd<CR>", desc = "Add current directory" },
    { "<leader>cwr", "<cmd>WorkspacesRemove<CR>", desc = "Remove workspace" },
  },
  config = function()
    require("workspaces").setup {
      hooks = {
        open = { "NvimTreeOpen" }, -- auto-open Nvim-tree when switching workspaces
      },
    }
  end,
}

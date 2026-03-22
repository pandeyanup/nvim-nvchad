return {
  "nvim-pack/nvim-spectre",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Optional: for file icons
  },
  config = function()
    require("spectre").setup {
      is_live = true, -- Auto-refresh search results as you type
      line_sep_start = "┌-----------------------------------------",
      result_padding = "¦  ",
      line_sep_end = "└-----------------------------------------",
      highlight = {
        ui = "String",
        search = "DiffDelete",
        replace = "DiffAdd",
      },
      mapping = {
        ["send_to_qf"] = {
          map = "<leader>sq",
          cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
          desc = "send all items to quickfix",
        },
        ["replace_cmd"] = {
          map = "<leader>sc",
          cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
          desc = "input replace command",
        },
        ["run_current_replace"] = {
          map = "<leader>rc",
          cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
          desc = "replace current line",
        },
        ["run_replace"] = {
          map = "<leader>R",
          cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
          desc = "replace all",
        },
      },
    }
  end,
}

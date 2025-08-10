return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        {
          "<leader>h",
          function()
            local harpoon = require "harpoon"
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon quick menu",
        },
        {
          "<leader>ha",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Add file to harpoon",
        },
        {
          "<leader>hh",
          function()
            local harpoon = require "harpoon"
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon quick menu",
        },
      }

      for i = 1, 5 do
        table.insert(keys, {
          "<leader>h" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to file " .. i,
        })
      end
      return keys
    end,
  },
}

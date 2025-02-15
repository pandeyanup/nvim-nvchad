return {
  {
    "stevearc/conform.nvim",
    event = "bufwritepre", -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, conf)
      conf.defaults.mappings.i = {
        ["<c-j>"] = require("telescope.actions").move_selection_next,
        ["<esc>"] = require("telescope.actions").close,
      }
      return conf
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint-lsp",
        "prettierd",
        "tailwindcss-language-server",
        "typescript-language-server",
        "prettier",
        "lua-language-server",
        "rust-analyzer",
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "bash",
      },
    },
  },
  -- {
  --   "luckasranarison/tailwind-tools.nvim",
  --   lazy = false,
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   opts = {
  --     document_color = {
  --       enabled = true, -- can be toggled by commands
  --       kind = "inline", -- "inline" | "foreground" | "background"
  --       inline_symbol = "󰝤 ", -- only used in inline mode
  --       debounce = 200, -- in milliseconds, only applied in insert mode
  --     },
  --     conceal = {
  --       enabled = false, -- can be toggled by commands
  --       min_length = nil, -- only conceal classes exceeding the provided length
  --       symbol = "󱏿", -- only a single character is allowed
  --       highlight = { -- extmark highlight options, see :h 'highlight'
  --         fg = "#38bdf8",
  --       },
  --     },
  --     custom_filetypes = {}, -- see the extension section to learn how it works
  --   }, },
}

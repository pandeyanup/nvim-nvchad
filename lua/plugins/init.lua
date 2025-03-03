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
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find plugin file",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        git_ignore = true,
      },
    },
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
  -- Auto install LSP servers
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   lazy = false,
  --   opts = {
  --     auto_install = true,
  --   },
  -- },
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

return {
  {
    "stevearc/conform.nvim",
    event = "bufwritepre", -- uncomment for format on save
    opts = require "configs.conform",
  },
  { "nvim-telescope/telescope-ui-select.nvim" },
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
        lsp_diagnostics = true,
        file_ignore_patterns = { ".git/*", "node_modules/*", ".cache/*" },
        lsp = {
          layout_config = {
            height = 0.85,
            width = 0.95,
          },
        },
        lsp_code_actions = {
          theme = "cursor",
        },
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
        "vue-language-server",
        "prettier",
        "lua-language-server",
        "rust-analyzer",
        "astro",
        "google-java-format",
        -- python
        "ruff",
        "pyright",
        "black",
        "go",
        "gomod",
      },
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
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
    ft = {
      "html",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "svelte",
      "vue",
      "xml",
      "jsx",
      "tsx",
      "astro",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "markdown",
        "astro",
        "javascript",
        "typescript",
        "vue",
        "tsx",
        "html",
        "css",
        "bash",
        "python",
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

local M = {}
local nvlsp = require "nvchad.configs.lspconfig"

local function setup_json_as_ts(bufnr)
  local ok, pj = pcall(require, "scripts.json-as-ts")
  if not ok then
    return
  end

  -- :PasteJsonAsTs [TypeName] (default: Root)
  vim.api.nvim_buf_create_user_command(bufnr, "PasteJsonAsTs", function(opts)
    pj.paste_ts { name = (opts.args ~= "" and opts.args) or "Root" }
  end, { nargs = "?", desc = "Paste JSON as TS type" })

  -- Normal mode keymap
  vim.keymap.set("n", "<leader>cej", function()
    pj.paste_ts { name = "Root" } -- from system clipboard (+)
  end, {
    buffer = bufnr,
    desc = "Paste JSON as TS type (clipboard)",
    silent = true,
    noremap = true,
  })

  -- Optional: Visual mode (uncomment if desired)
  -- vim.keymap.set("v", "<leader>cj", function()
  --   pj.paste_ts { source = "selection", name = "Root" }
  -- end, {
  --   buffer = bufnr,
  --   desc = "Selection → TS type",
  --   silent = true,
  --   noremap = true,
  -- })

  -- Optional: which-key integration
  pcall(function()
    require("which-key").add { { "<leader>c", group = "Custom Code" } }
  end)
end

local function run_code_action(context)
  local params = vim.lsp.util.make_range_params()
  params.context = context

  vim.lsp.buf_request_all(0, "textDocument/codeAction", params, function(results)
    for _, res in pairs(results or {}) do
      if res.result then
        for _, action in ipairs(res.result) do
          if action.edit or type(action.command) == "table" then
            vim.schedule(function()
              vim.lsp.buf.execute_command(action.command or action)
            end)
          end
        end
      end
    end
  end)
end

local function setup_ts_ls()
  vim.lsp.config("ts_ls", {
    on_attach = function(client, bufnr)
      if nvlsp.on_attach then
        nvlsp.on_attach(client, bufnr)
      end

      -- Disable formatting; Prettier will handle it
      client.server_capabilities.documentFormattingProvider = false

      -- Remove Unused Imports (TS)
      vim.api.nvim_set_keymap("n", "<leader>cr", "", {
        noremap = true,
        silent = true,
        callback = function()
          vim.lsp.buf.code_action {
            apply = true,
            context = {
              only = { "source.removeUnused.ts" },
              diagnostics = {},
            },
          }
        end,
        desc = "Remove unused imports",
      })
      -- Organize Imports (TS)
      vim.api.nvim_set_keymap("n", "<leader>co", "", {
        noremap = true,
        silent = true,
        callback = function()
          vim.lsp.buf.code_action {
            apply = true,
            context = {
              only = { "source.organizeImports.ts" },
              diagnostics = {},
            },
          }
        end,
        desc = "Organize imports",
      })
      -- JSON → TS helper
      setup_json_as_ts(bufnr)

      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.schedule(function()
            -- Organize imports
            vim.lsp.buf.code_action {
              apply = true,
              async = true,
              context = {
                only = { "source.organizeImports.ts" },
                diagnostics = {},
              },
            }
            -- Remove unused imports
            vim.lsp.buf.code_action {
              apply = true,
              async = true,
              context = {
                only = { "source.removeUnused.ts" },
                diagnostics = {},
              },
            }

            -- Format code
            local ok_conform, conform = pcall(require, "conform")
            if ok_conform then
              conform.format { async = true, lsp_fallback = true }
            elseif vim.lsp.buf.format then
              vim.lsp.buf.format { async = true }
            end
          end)
        end,
        desc = "Auto organize/remove/format before save",
      })
    end,

    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,

    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    root_markers = {
      "tsconfig.json",
      "jsconfig.json",
      "package.json",
      ".git",
    },
    init_options = { hostInfo = "neovim" },
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayVariableTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
        },
      },
    },
  })

  vim.lsp.enable "ts_ls"
end

-- local function setup_eslint()
--   vim.lsp.config("eslint", {
--     on_attach = function(client, bufnr)
--       if nvlsp.on_attach then
--         nvlsp.on_attach(client, bufnr)
--       end
--
--       -- Auto-fix on save
--       -- vim.api.nvim_create_autocmd("BufWritePre", {
--       --   buffer = bufnr,
--       --   command = "EslintFixAll",
--       -- })
--     end,
--
--     on_init = nvlsp.on_init,
--     capabilities = nvlsp.capabilities,
--
--     cmd = { "vscode-eslint-language-server", "--stdio" },
--     filetypes = {
--       "javascript",
--       "javascriptreact",
--       "javascript.jsx",
--       "typescript",
--       "typescriptreact",
--       "typescript.tsx",
--     },
--     root_markers = { ".eslintrc", ".eslintrc.js", "package.json", ".git" },
--   })
--
--   vim.lsp.enable "eslint"
-- end

function M.setup()
  setup_ts_ls()
  -- setup_eslint()
end

return M

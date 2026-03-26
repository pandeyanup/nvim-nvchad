-- Load NvChad LSP defaults
local nvlsp = require "nvchad.configs.lspconfig"
local ok_navic, navic = pcall(require, "nvim-navic")
local ok_devicons, devicons = pcall(require, "nvim-web-devicons")
local navic_icons = {
  File = "󰈙 ",
  Module = " ",
  Namespace = "󰌗 ",
  Package = " ",
  Class = "󰌗 ",
  Method = "󰆧 ",
  Property = " ",
  Field = " ",
  Constructor = " ",
  Enum = "󰕘",
  Interface = "󰕘",
  Function = "󰊕 ",
  Variable = "󰆧 ",
  Constant = "󰏿 ",
  String = "󰀬 ",
  Number = "󰎠 ",
  Boolean = "◩ ",
  Array = "󰅪 ",
  Object = "󰅩 ",
  Key = "󰌋 ",
  Null = "󰟢 ",
  EnumMember = " ",
  Struct = "󰌗 ",
  Event = " ",
  Operator = "󰆕 ",
  TypeParameter = "󰊄 ",
}

vim.diagnostic.config {
  virtual_text = {
    prefix = "●",
    spacing = 2,
    source = "if_many",
  },
  signs = true,
  underline = true,
  severity_sort = true,
  update_in_insert = false,
  float = {
    border = "rounded",
    source = true,
  },
}

vim.diagnostic.config {
  virtual_text = {
    prefix = "●",
    spacing = 2,
    source = "if_many",
  },
  signs = true,
  underline = true,
  severity_sort = true,
  update_in_insert = false,
  float = {
    border = "rounded",
    source = true,
  },
}

-- Helper to extend NvChad's on_attach with custom mappings
-- local function on_attach(client, bufnr)
--   if nvlsp.on_attach then
--     nvlsp.on_attach(client, bufnr)
--   end
--
--   -- Global LSP keymaps
--   -- local opts = { buffer = bufnr, silent = true, noremap = true }
--
--   -- vim.keymap.set(
--   --   "n",
--   --   "<leader>ca",
--   --   vim.lsp.buf.code_action,
--   --   vim.tbl_extend("force", opts, {
--   --     desc = "Code Action",
--   --   })
--   -- )
--
--   -- You can also add other universal LSP shortcuts here if you want:
--   -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
--   -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
--   -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
-- end

local function setup_navic_hl()
  local cursorline_hl = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false })
  local winbar_hl = vim.api.nvim_get_hl(0, { name = "WinBar", link = false })
  vim.api.nvim_set_hl(0, "NavicBar", {
    fg = winbar_hl.fg,
    bg = cursorline_hl.bg,
  })
  vim.api.nvim_set_hl(0, "NavicSeparator", {
    fg = "#89b4fa",
    bg = cursorline_hl.bg,
  })
  vim.api.nvim_set_hl(0, "NavicIcon", {
    fg = "#f9e2af",
    bg = cursorline_hl.bg,
  })
end

setup_navic_hl()
vim.api.nvim_create_autocmd("ColorScheme", { callback = setup_navic_hl })

_G.winbar_navic_location = function()
  local ft = vim.bo.filetype
  if ft == "NvimTree" or ft == "NvimTree_1" or ft == "neo-tree" or vim.bo.buftype ~= "" then
    return ""
  end

  local parts = {}
  local filename = vim.fn.expand "%:t"
  if filename == "" then
    filename = "[No Name]"
  end

  local safe_filename = filename:gsub("%%", "%%%%")
  local file_icon = "󰈔"
  local file_icon_hl = "NavicIcon"
  if ok_devicons then
    local ext = vim.fn.expand "%:e"
    local icon, hl = devicons.get_icon(filename, ext, { default = true })
    if icon and icon ~= "" then
      file_icon = icon
    end
    if hl and hl ~= "" then
      file_icon_hl = hl
    end
  end

  parts[#parts + 1] = "%#" .. file_icon_hl .. "#" .. file_icon .. " %#NavicBar#" .. safe_filename

  if not ok_navic or not navic.is_available() then
    return "%#NavicBar#  " .. table.concat(parts) .. "  %*"
  end

  local data = navic.get_data()
  if not data or vim.tbl_isempty(data) then
    return "%#NavicBar#  " .. table.concat(parts) .. "  %*"
  end

  parts[#parts + 1] = "%#NavicSeparator# 󰁔 "
  for i, item in ipairs(data) do
    local icon = navic_icons[item.type] or "> "
    local safe_name = (item.name or ""):gsub("%%", "%%%%")
    parts[#parts + 1] = "%#NavicIcon#" .. icon .. "%#NavicBar#" .. safe_name
    if i < #data then
      parts[#parts + 1] = "%#NavicSeparator# 󰁔 "
    end
  end

  return "%#NavicBar#  " .. table.concat(parts) .. "  %*"
end

local navic_winbar = "%{%v:lua.winbar_navic_location()%}"

local function set_buf_winbar(bufnr)
  for _, winid in ipairs(vim.fn.win_findbuf(bufnr)) do
    vim.wo[winid].winbar = navic_winbar
  end
end

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufEnter", "InsertLeave" }, {
  callback = function()
    vim.cmd "redrawstatus"
  end,
})

local function on_attach(client, bufnr)
  if nvlsp.on_attach then
    nvlsp.on_attach(client, bufnr)
  end

  if ok_navic and client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
    set_buf_winbar(bufnr)
  end
end

-- Register global defaults for all LSPs
vim.lsp.config("*", {
  on_attach = on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
})

-- Enable servers
vim.lsp.enable {
  "bashls",
  "html",
  "cssls",
  "clangd",
  "tailwindcss",
  "pyright",
  "ruff",
  "rust_analyzer",
  "vue_ls",
  "astro",
  "eslint",
  "gopls",
  "zls",
}

-- Load TypeScript-specific setup
require("configs.typescript").setup()

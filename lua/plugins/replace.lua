local function current_selection()
  return require("spectre.utils").get_visual_selection()
end

local function current_word()
  local word = vim.fn.expand "<cword>"
  return word == nil and "" or word
end

local function current_file_path()
  local path = vim.fn.fnameescape(vim.fn.expand "%:p:.")
  if path == "" then
    return ""
  end

  if vim.loop.os_uname().sysname == "Windows_NT" then
    path = path:gsub("\\", "/")
  end

  return path
end

local function open_replace_picker(opts)
  opts = opts or {}
  local scope = opts.path ~= "" and "File" or "Project"

  Snacks.input({
    prompt = scope .. " Search:",
    icon = " ",
    default = opts.search_text or "",
  }, function(search)
    search = vim.trim(search or "")
    if search == "" then
      return
    end

    Snacks.input({
      prompt = "Replace With:",
      icon = " ",
      default = opts.replace_text or "",
    }, function(replace)
      if replace == nil then
        return
      end

      require("spectre").open(vim.tbl_extend("force", opts, {
        search_text = search,
        replace_text = replace,
        is_close = true,
      }))
    end)
  end)
end

local function open_project_replace(seed)
  vim.schedule(function()
    open_replace_picker { search_text = seed or "" }
  end)
end

local function open_file_replace(seed)
  vim.schedule(function()
    open_replace_picker {
      path = current_file_path(),
      search_text = seed or "",
    }
  end)
end

return {
  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      "folke/snacks.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      {
        "<leader>ccr",
        function()
          open_project_replace(current_word())
        end,
        desc = "Replace In Project",
      },
      {
        "<leader>ccr",
        function()
          open_project_replace(current_selection())
        end,
        mode = "x",
        desc = "Replace Selection In Project",
      },
      {
        "<leader>ccf",
        function()
          open_file_replace(current_word())
        end,
        desc = "Replace In File",
      },
      {
        "<leader>ccf",
        function()
          open_file_replace(current_selection())
        end,
        mode = "x",
        desc = "Replace Selection In File",
      },
      {
        "<leader>cco",
        function()
          require("spectre").toggle { is_close = true }
        end,
        desc = "Open Replace Panel",
      },
    },
    init = function()
      pcall(function()
        require("which-key").add {
          { "<leader>cc", group = "Replace" },
        }
      end)
    end,
    config = function()
      require("spectre").setup {
        is_insert_mode = true,
        live_update = true,
        lnum_for_results = true,
        color_devicons = true,
        line_sep_start = "╭────────────────────────────────────────────────────────",
        result_padding = "│  ",
        line_sep = "╰────────────────────────────────────────────────────────",
        highlight = {
          headers = "FloatTitle",
          ui = "NormalFloat",
          filename = "Directory",
          filedirectory = "Comment",
          border = "FloatBorder",
          search = "DiffDelete",
          replace = "DiffAdd",
        },
        mapping = {
          ["send_to_qf"] = {
            map = "<leader>q",
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
            desc = "send all items to quickfix",
          },
          ["replace_cmd"] = {
            map = "<leader>c",
            cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
            desc = "input replace command",
          },
          ["run_current_replace"] = {
            map = "<leader>r",
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
  },
}

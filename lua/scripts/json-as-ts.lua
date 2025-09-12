local M = {}

local json_decode = vim.json and vim.json.decode or vim.fn.json_decode

local function is_array(t)
  if type(t) ~= "table" then
    return false
  end
  local n = 0
  for k, _ in pairs(t) do
    if type(k) ~= "number" then
      return false
    end
    n = n + 1
  end
  for i = 1, n do
    if t[i] == nil then
      return false
    end
  end
  return true
end

local function ts_ident(key)
  if key:match "^[_%a][_%w]*$" then
    return key
  end
  return string.format('["%s"]', key:gsub('"', '\\"'))
end

local function dedupe(list)
  local seen, out = {}, {}
  for _, v in ipairs(list) do
    if not seen[v] then
      seen[v] = true
      table.insert(out, v)
    end
  end
  table.sort(out)
  return out
end

local function indent(s, n)
  local pad = string.rep(" ", n or 2)
  return (s:gsub("\n", "\n" .. pad))
end

local function ts_type_inline(v)
  local t = type(v)
  if t == "string" then
    return "string"
  elseif t == "number" then
    return "number"
  elseif t == "boolean" then
    return "boolean"
  elseif v == vim.NIL or v == nil then
    return "null"
  elseif t == "table" then
    if is_array(v) then
      local kinds = {}
      for _, e in ipairs(v) do
        table.insert(kinds, ts_type_inline(e))
      end
      kinds = dedupe(kinds)
      local union = table.concat(kinds, " | ")
      -- wrap unions for array clarity
      if union:find "|" then
        union = "(" .. union .. ")"
      end
      return union .. "[]"
    else
      local parts = {}
      for k, val in pairs(v) do
        table.insert(parts, ts_ident(k) .. ": " .. ts_type_inline(val) .. ";")
      end
      if #parts == 0 then
        return "{}"
      end
      return "{ " .. table.concat(parts, " ") .. " }"
    end
  else
    return "unknown"
  end
end

local function ts_type_block(v, depth)
  depth = depth or 0
  local t = type(v)
  if t ~= "table" or is_array(v) then
    return ts_type_inline(v) -- primitives/arrays stay inline
  end
  -- pretty block for objects
  local lines = { "{" }
  local keys = {}
  for k, _ in pairs(v) do
    table.insert(keys, k)
  end
  table.sort(keys)
  for _, k in ipairs(keys) do
    local val = v[k]
    local rhs = ts_type_block(val, depth + 1)
    if rhs:sub(1, 1) == "{" then
      table.insert(
        lines,
        string.rep(" ", 2 * (depth + 1))
          .. ts_ident(k)
          .. ": "
          .. rhs:gsub("\n", "\n" .. string.rep(" ", 2 * (depth + 1)))
          .. ";"
      )
    else
      table.insert(lines, string.rep(" ", 2 * (depth + 1)) .. ts_ident(k) .. ": " .. rhs .. ";")
    end
  end
  table.insert(lines, string.rep(" ", 2 * depth) .. "}")
  return table.concat(lines, "\n")
end

local function get_visual_selection()
  local srow, scol = unpack(vim.api.nvim_buf_get_mark(0, "<"))
  local erow, ecol = unpack(vim.api.nvim_buf_get_mark(0, ">"))
  if srow == 0 or erow == 0 then
    return nil
  end
  local lines = vim.api.nvim_buf_get_lines(0, srow - 1, erow, false)
  if #lines == 0 then
    return nil
  end
  lines[1] = string.sub(lines[1], scol + 1)
  lines[#lines] = string.sub(lines[#lines], 1, ecol + 1)
  return table.concat(lines, "\n")
end

local function insert_lines_at_cursor(text)
  local lines = vim.split(text, "\n", { plain = true })
  vim.api.nvim_put(lines, "l", true, true) -- put below cursor, respect indent
end

local function from_text(json_text, name)
  local ok, tbl = pcall(json_decode, json_text)
  if not ok then
    vim.notify("Paste JSON as Code: invalid JSON", vim.log.levels.ERROR)
    return
  end
  name = name or "Root"
  local body = ts_type_block(tbl)
  insert_lines_at_cursor(("interface %s %s\n"):format(name, body))
end

--- Public: paste from clipboard (+) or visual selection
function M.paste_ts(opts)
  opts = opts or {}
  local src = opts.source or "clipboard" -- "clipboard" | "selection"
  local name = opts.name or "Root"
  local text

  if src == "selection" then
    text = get_visual_selection()
    if not text then
      vim.notify("No visual selection found", vim.log.levels.WARN)
      return
    end
  else
    text = vim.fn.getreg "+"
  end

  from_text(text, name)
end

return M

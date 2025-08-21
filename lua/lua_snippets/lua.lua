-- ~/.config/nvim/lua/lua_snippets/lua.lua
local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- type "fn" then expand
  s("fnos", {
    t "function ",
    i(1, "name"),
    t "(",
    i(2),
    t { ")", "  " },
    i(0, "-- body"),
    t { "", "end" },
  }),
}

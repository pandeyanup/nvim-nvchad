local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Function snippet
  s("fn", {
    t "function ",
    i(1, "name"),
    t "(",
    i(2, "params"),
    t { ") {", "  " },
    i(3, "// TODO: implement"),
    t { "", "}" },
  }),

  -- Console log
  s("clg", {
    t "console.log(",
    i(1, "value"),
    t ");",
  }),
}

local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
  -- TODO comment
  s("todo", {
    t "TODO: ",
    i(1, "value"),
  }),

  -- FIXME comment
  s("fix", {
    t "FIXME: ",
    i(1, "value"),
  }),

  -- NOTE comment
  s("note", {
    t "NOTE: ",
    i(1, "value"),
  }),

  -- Comment box
  s("cbox", {
    t { "#############################", "# " },
    i(1, "Title"),
    t { "", "#############################" },
  }),
}

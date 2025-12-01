local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local function pascal(str)
  return str:sub(1, 1):upper() .. str:sub(2)
end

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

  -- Zustand store
  s("zustand", {
    t { 'import { create } from "zustand";', "", "interface " },

    -- interface NameStates ans NameActions
    f(function(args)
      return pascal(args[1][1]) .. "States"
    end, { 1 }),
    t { " {}", "", "interface " },

    f(function(args)
      return pascal(args[1][1]) .. "Actions"
    end, { 1 }),
    t { " {", "  reset" },
    -- resetNamedState
    f(function(args)
      return pascal(args[1][1]) .. "Store"
    end, { 1 }),
    t { ": () => void;", "}", "", "" },

    -- initialStates
    t "const initialStates: ",
    f(function(args)
      return pascal(args[1][1]) .. "States"
    end, { 1 }),
    t { " = {};", "", "type I" },

    f(function(args)
      return pascal(args[1][1])
    end, { 1 }),
    t "Store = ",
    f(function(args)
      local name = pascal(args[1][1])
      return name .. "States & " .. name .. "Actions;"
    end, { 1 }),
    t { "", "", "export const use" },

    -- export const useNameStore
    f(function(args)
      return pascal(args[1][1])
    end, { 1 }),
    t "Store = create<I",
    f(function(args)
      return pascal(args[1][1])
    end, { 1 }),
    t { "Store>((set) => ({", "  ...initialStates,", "  reset" },

    -- resetNamedState implementation
    f(function(args)
      return pascal(args[1][1]) .. "Store"
    end, { 1 }),
    t ": () =>",
    t { "", "    set({", "      ...initialStates", "    }),", "}));", "" },
    i(1, "Named"),
  }),
}

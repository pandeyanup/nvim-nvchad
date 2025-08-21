local ls = require "luasnip"
local s, t, i, f = ls.snippet, ls.text_node, ls.insert_node, ls.function_node

return {
  s("tsfce", {
    -- imports
    t {
      'import type { FC } from "react";',
      'import { cn } from "@/lib/utils";',
      "",
      "interface ",
    },
    -- ComponentName
    i(1, "ComponentName"),
    -- interface body
    t {
      "Props {",
      "  className?: string;",
      "}",
      "",
      "export const ",
    },
    -- export const ComponentName
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t ": FC<",
    -- FC<ComponentNameProps>
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t {
      "Props> = ({ className }) => {",
      "  return (",
    },
    -- <div className={cn("...", className)}>
    t '    <div className={cn("',
    i(2, ""), -- optional base classes
    t '", className)}>',
    t { "", "      " },
    -- Inner text = ComponentName
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t {
      "",
      "    </div>",
      "  );",
      "};",
    },
  }),
}

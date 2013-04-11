local escape_table = {
   ["<" ] = "&lt;",
   [">" ] = "&gt;",
   ["&" ] = "&amp;",
   ["\"" ] = "&quot;",
   ["'" ] = "&#39;"
 }

local function escape(s)
  return s:gsub("[<>&\"']",
    function(x)
      return escape_table[x]
    end)
end

local function attributes(attr)
  local attr_table = {}
  for x,y in pairs(attr) do
    if y and y ~= "" then
      table.insert(attr_table, ' ' .. x .. '="' .. escape(y) .. '"')
    end
  end
  return table.concat(attr_table)
end


function Str(s)
  return escape(s)
end

function Space()
  return " "
end

function LineBreak()
  return "<br/>"
end

function Emph(s)
  return "<em>" .. s .. "</em>"
end

function Strong(s)
  return "<strong>" .. s .. "</strong>"
end

function Subscript(s)
  return "<sub>" .. s .. "</sub>"
end

function Superscript(s)
  return "<sup>" .. s .. "</sup>"
end

function SmallCaps(s)
  return '<span style="font-variant: small-caps;">' .. s .. '</span>'
end

function Strikeout(s)
  return '<del>' .. s .. '</del>'
end

function Link(s, src, tit)
  return "<a href='" .. escape(src) .. "' title='" .. escape(tit) .. "'>" .. s .. "</a>"
end

function Image(s, src, tit)
  return "<img src='" .. escape(src) .. "' title='" .. escape(tit) .. "'/>"
end

function Code(s, attr)
  return "<code" .. attributes(attr) .. ">" .. escape(s) .. "</code>"
end

function InlineMath(s)
  return "\\(" .. escape(s) .. "\\)"
end

function DisplayMath(s)
  return "\\[" .. escape(s) .. "\\]"
end

function Plain(s)
  return s
end

function Para(s)
  return "<p>" .. s .. "</p>"
end

function Blocksep()
  return "\n\n"
end

function Header(lev, s, attr)
  return "<h" .. lev .. attributes(attr) ..  ">" .. s .. "</h" .. lev .. ">"
end

function BlockQuote(s)
  return "<blockquote>\n" .. s .. "\n</blockquote>"
end

function HorizontalRule()
  return "<hr/>"
end

function CodeBlock(s, attr)
  return "<pre><code" .. attributes(attr) .. ">" .. escape(s) .. "</code></pre>"
end

function BulletList(items)
  local buffer = {}
  for _, item in pairs(items) do
    table.insert(buffer, "<li>" .. item .. "</li>")
  end
  return "<ul>\n" .. table.concat(buffer, "\n") .. "\n</ul>"
end

function OrderedList(items)
  local buffer = {}
  for _, item in pairs(items) do
    table.insert(buffer, "<li>" .. item .. "</li>")
  end
  return "<ol>\n" .. table.concat(buffer, "\n") .. "\n</ol>"
end

function DefinitionList(items)
  local buffer = {}
  for term,def in pairs(items) do
    table.insert(buffer, "<dt>" .. term .. "</dt>\n<dd>" .. table.concat(def,"</dd>\n<dd>") .. "</dd>")
  end
  return "<dl>\n" .. table.concat(buffer, "\n") .. "\n</dl>"
end

-- function Table(caption, aligns, widths, headers, rows)
--   local capt = "<caption>" .. caption .. "</caption>\n"
--   local cols = ""
--   local head = ""
--   local body = ""
--   return "<table>\n" .. capt ..  cols .. head .. body .. "</table>"
-- end

local meta = {}
meta.__index =
  function(_, key)
    io.stderr:write(string.format("WARNING: Undefined writer function '%s'\n",key))
    return function() return "" end
  end
setmetatable(_G, meta)


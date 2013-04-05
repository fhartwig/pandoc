function Str(s)
  return s
end

function Space()
  return " "
end

function Emph(s)
  return "<em>" .. s .. "</em>"
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

function Header(lev, attr, s)
  return "<h" .. lev .. " id='" .. attr['id'] .. "'>" .. s .. "</h" .. lev .. ">"
end

function BlockQuote(s)
  return "<blockquote>\n" .. s .. "\n</blockquote>"
end

function BulletList(items)
  local buffer = {}
  for _, item in pairs(items) do
    table.insert(buffer, "<li>" .. item .. "</li>")
  end
  return "<ul>\n" .. table.concat(buffer, "\n") .. "\n</ul>"
end

local meta = {}
meta.__index =
  function(_, key)
    io.stderr:write(string.format("WARNING: Undefined writer function '%s'\n",key))
    return ""
  end
setmetatable(_G, meta)


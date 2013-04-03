function Str(s)
  return s
end

function Space()
  return " "
end

function Emph(s)
  return "<em>" .. s .. "</em>"
end

function Para(s)
  return s
end

function Blocksep()
  return "\n\n"
end

function Header(lev, s)
  return "<h" .. lev .. ">" .. s .. "</h" .. lev .. ">"
end

local meta = {}
meta.__index =
  function(_, key)
    io.stderr:write(string.format("WARNING: Undefined writer function '%s'\n",key))
    return ""
  end
setmetatable(_G, meta)


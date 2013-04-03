writer = {}

writer.str = function(s)
  return s
end

writer.space = function()
  return " "
end

writer.emph = function(s)
  return "<em>" .. s .. "</em>"
end

writer.para = function(s)
  return s
end

writer.blocksep = function()
  return "\n\n"
end

local meta = {}
meta.__index =
  function(_, key)
    io.stderr:write(string.format("WARNING: Undefined writer function '%s'\n",key))
    return ""
  end
setmetatable(writer, meta)


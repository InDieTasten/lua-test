
function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

function getTermSize()
  return os.capture("tput cols"), os.capture("tput lines")
end

function clear()
  os.execute("clear")
end

clear()
print(getTermSize())

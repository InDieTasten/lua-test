
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
local w,h = getTermSize()

print(string.rep("*", w))
for i=1,h-2 do
  print("*"..string.rep(" ", w-2).."*")
end
io.write(string.rep("*", w))
io.flush()
os.execute("tput cup 1 1")

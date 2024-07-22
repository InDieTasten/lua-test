
function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s.."break"
end

function getTermSize()
  return os.capture("tput cols"), os.capture("tput lines")
end

function clear()
  os.execute("clear")
end

function main()
  clear()
  local w,h = getTermSize()
  print(string.rep("*", w))
  for i=1,h-2 do
    print("*"..string.rep(" ", w-2).."*")
  end
  io.write(string.rep("*", w))
  io.flush()
  os.execute("tput cup 1 1")
end

-- [[ TESTS ]] --
tests = tests or {}
tests.os = tests.os or {}
function tests.os.capture()
  local result = os.capture("echo test_string")
  assert(result == "test_string", "Exptected \"test_string\", got \""..result.."\".")
end

local args = {...}
if args[1] == "test" then
  function run_all_deep(prefix, testset)
    for k,v in pairs(testset) do
      if type(v) == "table" then
        run_all_deep(prefix.."."..k, v)
      elseif type(v) == "function" then
        io.write("[Test] "..prefix.."."..k.." >>> ")
        io.flush()
        v()
        print("PASSED")
      end
    end
  end
  run_all_deep("tests", tests)
else
  main()
end

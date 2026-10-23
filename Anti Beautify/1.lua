-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local f1, f2, f3 = function() return 1 end, function() return 2 end, function() return ("x") / 0 + ({})[1]() end
local l1, l2 = debug.info(f1, "l"), debug.info(f2, "l")
local ok, err = pcall(f3)
local el = tonumber(string.match(tostring(err), ":(%d+):"))
local tb = nil
xpcall(f3, function() tb = tonumber(string.match(debug.traceback("", 2), ":(%d+)")) end)
if ok or not l1 or l1 ~= l2 or l2 ~= el or el ~= tb then error("dtc", 0) end
print("ud")

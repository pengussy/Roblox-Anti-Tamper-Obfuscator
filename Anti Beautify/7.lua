-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local c1, c2, c3; c1 = function() local x = c2(); return x end; c2 = function() local y = c3(); return y end; c3 = function() return debug.traceback("", 1) end
local tb = c1()
local lines = {}
for m in string.gmatch(tb, ":(%d+)") do
    table.insert(lines, tonumber(m))
end

if #lines < 4 or lines[1] ~= lines[2] or lines[2] ~= lines[3] then
    error("dtc", 0)
end

print("ud")

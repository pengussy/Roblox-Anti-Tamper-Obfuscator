-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local p1, p2 = function() return 10 end, function() return 20 end
local p3 = function()
    return 30
end
local p4 = function() return ("sl") - {} end
local function p5()
    return debug.info(1, "l")
end

local a = debug.info(p1, "l")
local b = debug.info(p2, "l")
local c = debug.info(p3, "l")
local _, e = pcall(p4)
local d = tonumber(string.match(tostring(e), ":(%d+):"))
local f = p5()

if not a or not d or (b - a) ~= 0 or (c - b) ~= 1 or (d - c) ~= 3 or (f - d) ~= 2 then
    error("dtc", 0)
end

print("ud")

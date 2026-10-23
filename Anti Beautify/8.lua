-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local eA, eB = function() return ("a") - 1 end, function() return (true)() end
local function getLine(fn) local _, e = pcall(fn); return tonumber(string.match(tostring(e), ":(%d+):")) or -999 end
local eC = function() return (nil).k end

local lA, lB, lC = getLine(eA), getLine(eB), getLine(eC)
local a, b, c, d = 0x61707865, lB - lA, lC - lB, 0x3320646E

a = bit32.band(a + b, 0xFFFFFFFF); d = bit32.lrotate(bit32.bxor(d, a), 16)
c = bit32.band(c + d, 0xFFFFFFFF); b = bit32.lrotate(bit32.bxor(b, c), 12)
a = bit32.band(a + b, 0xFFFFFFFF); d = bit32.lrotate(bit32.bxor(d, a), 8)
c = bit32.band(c + d, 0xFFFFFFFF); b = bit32.lrotate(bit32.bxor(b, c), 7)

if bit32.bxor(a, b, c, d) ~= 0xC9FD6674 then
    error("dtc", 0)
end

print("ud")

-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local a1, a2, aE = function() return 1 end, function() return 2 end, function() return ("k") - {} end
local _, em = pcall(aE)
local el = tonumber(string.match(tostring(em), ":(%d+):")) or -999
local b1 = function() return 3 end

local d1 = (debug.info(a2, "l") or -99) - (debug.info(a1, "l") or 0)
local d2 = el - (debug.info(a1, "l") or 0)
local d3 = (debug.info(b1, "l") or -99) - el
local c1 = function() return 4 end
local d4 = (debug.info(c1, "l") or -99) - (debug.info(b1, "l") or 0)

local h = 0x811C9DC5
for _, v in ipairs({ d1, d2, d3, d4, 0x534C }) do
    h = bit32.bxor(h, bit32.band(v + 0x9E3779B9, 0xFFFFFFFF))
    h = bit32.band((h * 0x01000193) % 4294967296, 0xFFFFFFFF)
end

local ct = { 59, 33, 126, 188, 201, 20, 148, 85, 156, 163, 118, 41, 74, 35 }
local out = buffer.create(#ct)
local st = h
for i = 1, #ct do
    st = bit32.bxor(st, bit32.lshift(st, 13))
    st = bit32.bxor(st, bit32.rshift(st, 17))
    st = bit32.bxor(st, bit32.lshift(st, 5))
    buffer.writeu8(out, i - 1, bit32.bxor(ct[i], bit32.band(st, 0xFF)))
end

local dec = buffer.tostring(out)
if dec ~= "ud_verified_ok" then
    error("dtc", 0)
end

print(string.sub(dec, 1, 2))

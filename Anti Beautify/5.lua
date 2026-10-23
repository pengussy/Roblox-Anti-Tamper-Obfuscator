-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local pool = table.freeze({
    wm = "pengu / SL Source Leak | https://discord.gg/zNyHGU6eUK",
    k1 = 0xEDB88320,
    k2 = 0x045592B7,
})

if not table.isfrozen(pool) or pcall(function() pool.wm = "" end) then
    error("dtc", 0)
end

local u1, u2 = function() return pool.wm end, function() return pool.k1 end
if (debug.info(u2, "l") or -1) ~= (debug.info(u1, "l") or -2) then
    error("dtc", 0)
end

local s = u1()
local poly = u2()
local crc = 0xFFFFFFFF
for i = 1, #s do
    crc = bit32.bxor(crc, string.byte(s, i))
    for _ = 1, 8 do
        local m = -bit32.band(crc, 1)
        crc = bit32.bxor(bit32.rshift(crc, 1), bit32.band(poly, m))
    end
end
crc = bit32.bnot(crc)

if crc ~= pool.k2 then
    error("dtc", 0)
end

print("ud")

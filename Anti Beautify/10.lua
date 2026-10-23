-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local grid = {
    function() return 1 end, function() return 2 end,
    function() return 3 end,
    function() return 4 end, function() return 5 end, function() return 6 end,
}

local base = debug.info(grid[1], "l") or -999
local h = 0x13579BDF
for i = 1, #grid do
    local o = (debug.info(grid[i], "l") or -100) - base
    h = bit32.bxor(bit32.lrotate(h, 5), o * 257 + i * 17)
end

if h ~= 0xE466B67F then
    error("dtc", 0)
end

print("ud")

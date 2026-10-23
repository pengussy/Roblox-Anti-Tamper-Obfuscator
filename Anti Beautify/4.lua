-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function depthAt(n)
    if n <= 0 then
        local d = 0
        while debug.info(d + 1, "f") ~= nil do
            d += 1
        end
        return d
    end
    return depthAt(n - 1)
end

local base = depthAt(0)
local step8 = depthAt(8)
local step16 = depthAt(16)

if (step8 - base) ~= 8 or (step16 - step8) ~= 8 then
    error("dtc", 0)
end

print("ud")

-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function slAlpha(x, y) return x + y end
local function slBeta(x, ...) return select("#", ...) + x end
local function slGamma() return 1 end

local n1, l1, a1, v1 = debug.info(slAlpha, "nla")
local n2, l2, a2, v2 = debug.info(slBeta, "nla")
local n3, l3, a3, v3 = debug.info(slGamma, "nla")

if n1 ~= "slAlpha" or n2 ~= "slBeta" or n3 ~= "slGamma" then
    error("dtc", 0)
end

if a1 ~= 2 or v1 ~= false or a2 ~= 1 or v2 ~= true or a3 ~= 0 or v3 ~= false then
    error("dtc", 0)
end

if (l2 - l1) ~= 1 or (l3 - l2) ~= 1 then
    error("dtc", 0)
end

print("ud")

-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local hs = game:GetService("HttpService")
local g1 = hs:GenerateGUID(true)
local g2 = hs:GenerateGUID(false)
local g3 = hs:GenerateGUID(false)

if #g1 ~= 38 or #g2 ~= 36 or g2 == g3 then
    error("dtc", 0)
end

if string.sub(g1, 1, 1) ~= "{" or string.sub(g1, -1) ~= "}" then
    error("dtc", 0)
end

local pat = "^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$"
if not string.match(string.sub(g1, 2, -2), pat) or not string.match(g2, pat) then
    error("dtc", 0)
end

print("ud")

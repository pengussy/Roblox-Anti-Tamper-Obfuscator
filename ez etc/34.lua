-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local r = BrickColor.new("Really red")
local byId = BrickColor.new(1004)
local fallback = BrickColor.new("__invalid_brickcolor_sl__")

if typeof(r) ~= "BrickColor" or r ~= byId or r.Number ~= 1004 or r.Color ~= Color3.fromRGB(255, 0, 0) then
    error("dtc", 0)
end

if fallback.Number ~= 194 or fallback.Name ~= "Medium stone grey" then
    error("dtc", 0)
end

local p0 = BrickColor.palette(0)
local p127 = BrickColor.palette(127)
if typeof(p0) ~= "BrickColor" or typeof(p127) ~= "BrickColor" or p0 == p127 then
    error("dtc", 0)
end

print("ud")

-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local v = Vector3int16.new(32768, 2.9, -12)
local w = Vector3int16.new(10, 5, 20)
local s = Vector3int16.new(30000, 10, -5) + Vector3int16.new(10000, 20, 5)

if typeof(v) ~= "Vector3int16" or v.X ~= -32768 or v.Y ~= 2 or v.Z ~= -12 then
    error("dtc", 0)
end

if s.X ~= -25536 or s.Y ~= 30 or s.Z ~= 0 then
    error("dtc", 0)
end

if (w * 3).Z ~= 60 or Vector2int16.new(32768, -1).X ~= -32768 then
    error("dtc", 0)
end

print("ud")

-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local ray = Ray.new(Vector3.new(0, 0, 0), Vector3.new(10, 0, 0)).Unit
if ray.Direction ~= Vector3.new(1, 0, 0) then
    error("dtc", 0)
end

local cp1 = ray:ClosestPoint(Vector3.new(7, 3, 4))
local d1 = ray:Distance(Vector3.new(7, 3, 4))
if (cp1 - Vector3.new(7, 0, 0)).Magnitude > 1e-5 or math.abs(d1 - 5) > 1e-5 then
    error("dtc", 0)
end

local cp2 = ray:ClosestPoint(Vector3.new(-5, 12, 0))
local d2 = ray:Distance(Vector3.new(-5, 12, 0))
if (cp2 - Vector3.zero).Magnitude > 1e-5 or math.abs(d2 - 13) > 1e-5 then
    error("dtc", 0)
end

print("ud")

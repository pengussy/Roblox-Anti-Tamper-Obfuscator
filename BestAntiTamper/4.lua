-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

if type(vector) ~= "table" or type(vector.create) ~= "function" then
    fail(1)
end

local a = Vector3.new(3, -4, 12)
local b = vector.create(3, -4, 12)

if type(a) ~= "vector" or type(b) ~= "vector" then
    fail(2)
end

if typeof(a) ~= "Vector3" or typeof(b) ~= "Vector3" then
    fail(3)
end

if not rawequal(a, b) or a ~= b then
    fail(4)
end

if b:Abs() ~= Vector3.new(3, 4, 12) then
    fail(5)
end

if vector.magnitude(a) ~= 13 or vector.dot(a, Vector3.new(1, 2, 1)) ~= 7 then
    fail(6)
end

if vector.cross(Vector3.xAxis, Vector3.yAxis) ~= Vector3.zAxis then
    fail(7)
end

local hi = 1 + 2^-23
local lo = 1 + 2^-24

if lo == 1 then
    fail(8)
end

local q = Vector3.new(lo, hi, -0.0)
if q.X ~= 1 or q.Y == 1 or q.Y ~= hi or 1 / q.Z ~= -math.huge then
    fail(9)
end

local buf = buffer.create(12)
buffer.writef32(buf, 0, math.pi)
buffer.writef32(buf, 4, -math.exp(1))
buffer.writef32(buf, 8, 1 / 7)

local pv = Vector3.new(math.pi, -math.exp(1), 1 / 7)
if pv.X ~= buffer.readf32(buf, 0) or pv.Y ~= buffer.readf32(buf, 4) or pv.Z ~= buffer.readf32(buf, 8) then
    fail(10)
end

print("ud")

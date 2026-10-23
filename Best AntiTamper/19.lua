-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local part = Instance.new("Part")
local iv = Instance.new("IntValue")
local bv = Instance.new("BoolValue")
local nv = Instance.new("NumberValue")

local function drop(c)
    part:Destroy()
    iv:Destroy()
    bv:Destroy()
    nv:Destroy()
    fail(c)
end

part.Size = Vector3.new(-10, 0, 8)
if math.abs(part.Size.X - 0.001) > 1e-5 or math.abs(part.Size.Y - 0.001) > 1e-5 or math.abs(part.Size.Z - 8) > 1e-5 then
    drop(1)
end

iv.Value = 7.9
if iv.Value ~= 7 then
    drop(2)
end

iv.Value = -7.9
if iv.Value ~= -7 then
    drop(3)
end

if pcall(function() bv.Value = "true" end) or pcall(function() nv.Value = "123" end) then
    drop(4)
end

part:Destroy()
iv:Destroy()
bv:Destroy()
nv:Destroy()

print("ud")

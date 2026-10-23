-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local part = Instance.new("Part")
part.CFrame = CFrame.new(10, 20, 30) * CFrame.Angles(0, math.rad(90), 0)

local a1 = Instance.new("Attachment")
a1.CFrame = CFrame.new(4, 5, -6)
a1.Parent = part

local a2 = Instance.new("Attachment")
a2.CFrame = CFrame.new(0, 3, 2)
a2.Parent = a1

local function drop(c)
    part:Destroy()
    fail(c)
end

local expectedW1 = (part.CFrame * a1.CFrame).Position
local expectedW2 = (part.CFrame * a1.CFrame * a2.CFrame).Position

if (a1.WorldPosition - expectedW1).Magnitude > 1e-3 then
    drop(1)
end

if (a2.WorldPosition - expectedW2).Magnitude > 1e-3 then
    drop(2)
end

a2.WorldPosition = Vector3.new(-2, 40, 18)
local expectLocal = (part.CFrame * a1.CFrame):PointToObjectSpace(Vector3.new(-2, 40, 18))
if (a2.Position - expectLocal).Magnitude > 1e-3 then
    drop(3)
end

a1.SecondaryAxis = Vector3.new(1, 1, 0).Unit
a1.Axis = Vector3.new(1, 0, 0)
if math.abs(a1.Axis:Dot(a1.SecondaryAxis)) > 1e-4 or math.abs(a1.SecondaryAxis.Magnitude - 1) > 1e-4 then
    drop(4)
end

part:Destroy()
print("ud")

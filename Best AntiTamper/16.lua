-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local qCf = CFrame.new(3, -5, 7, 1, 2, -2, 4)
local rx, ry, rz = qCf.XVector, qCf.YVector, qCf.ZVector

if math.abs(rx.Magnitude - 1) > 1e-5 or math.abs(ry.Magnitude - 1) > 1e-5 or math.abs(rz.Magnitude - 1) > 1e-5 then
    fail(1)
end

if math.abs(rx:Dot(ry)) > 1e-5 or math.abs(ry:Dot(rz)) > 1e-5 or math.abs(rx:Dot(ry:Cross(rz)) - 1) > 1e-5 then
    fail(2)
end

local id = qCf:Inverse() * qCf
if (id.Position - Vector3.zero).Magnitude > 1e-5 or (id.LookVector - Vector3.new(0, 0, -1)).Magnitude > 1e-5 then
    fail(3)
end

local pt = Vector3.new(-11.5, 4.25, 9.75)
local roundPt = qCf:PointToObjectSpace(qCf:PointToWorldSpace(pt))
if (roundPt - pt).Magnitude > 1e-4 then
    fail(4)
end

local axis, ang = qCf:ToAxisAngle()
local rebuilt = CFrame.fromAxisAngle(axis, ang) + qCf.Position
if (rebuilt.LookVector - qCf.LookVector).Magnitude > 1e-4 or (rebuilt.UpVector - qCf.UpVector).Magnitude > 1e-4 then
    fail(5)
end

local ox, oy, oz = qCf:ToOrientation()
local fromOri = CFrame.fromOrientation(ox, oy, oz)
if (fromOri.RightVector - qCf.RightVector).Magnitude > 1e-4 then
    fail(6)
end

print("ud")

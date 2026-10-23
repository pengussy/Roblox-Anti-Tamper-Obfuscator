-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local cf = CFrame.fromMatrix(
    Vector3.new(4, -7, 11),
    Vector3.new(2, 0.3, 0),
    Vector3.new(-0.2, 3, 0.1),
    Vector3.new(0.1, -0.2, 1.5)
):Orthonormalize()

local rx, ry, rz = cf.XVector, cf.YVector, cf.ZVector
local det = rx:Dot(ry:Cross(rz))

if math.abs(rx.Magnitude - 1) > 1e-5
    or math.abs(ry.Magnitude - 1) > 1e-5
    or math.abs(rz.Magnitude - 1) > 1e-5
    or math.abs(rx:Dot(ry)) > 1e-5
    or math.abs(ry:Dot(rz)) > 1e-5
    or math.abs(rx:Dot(rz)) > 1e-5
    or math.abs(det - 1) > 1e-5
    or cf.Position ~= Vector3.new(4, -7, 11)
then
    error("dtc", 0)
end

print("ud")

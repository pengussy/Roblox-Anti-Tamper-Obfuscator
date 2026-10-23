-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local sg = Instance.new("ScreenGui")
sg.Parent = game:GetService("StarterGui")

local fr = Instance.new("Frame")
fr.Size = UDim2.fromOffset(200, 200)
fr.Parent = sg

local p2d = Instance.new("Path2D")
p2d.Parent = fr

local ok, res = pcall(function()
    local z = UDim2.new()
    p2d:SetControlPoints({
        Path2DControlPoint.new(UDim2.fromScale(0, 0), z, z),
        Path2DControlPoint.new(UDim2.fromScale(0.5, 0), z, z),
        Path2DControlPoint.new(UDim2.fromScale(0.5, 0.5), z, z),
    })
    return {
        len = p2d:GetLength(),
        mid = p2d:GetPositionOnCurveArcLength(0.5),
        endp = p2d:GetPositionOnCurveArcLength(1),
        cnt = #p2d:GetControlPoints(),
    }
end)

sg:Destroy()

if not ok or type(res) ~= "table" or res.cnt ~= 3 then
    fail(1)
end

if math.abs(res.len - 200) > 1e-2 then
    fail(2)
end

if math.abs(res.mid.X.Scale - 0.5) > 1e-3 or math.abs(res.mid.Y.Scale - 0) > 1e-3 then
    fail(3)
end

if math.abs(res.endp.X.Scale - 0.5) > 1e-3 or math.abs(res.endp.Y.Scale - 0.5) > 1e-3 then
    fail(4)
end

print("ud")

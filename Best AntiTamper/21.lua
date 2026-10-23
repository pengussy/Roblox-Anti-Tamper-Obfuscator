-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local vc = Instance.new("Vector3Curve")

local cx = vc:X()
local cy = vc:Y()
local cz = vc:Z()

local function drop(c)
    vc:Destroy()
    fail(c)
end

if not cx:IsA("FloatCurve") or not cy:IsA("FloatCurve") or not cz:IsA("FloatCurve") then
    drop(1)
end

if cx.Name ~= "X" or cy.Name ~= "Y" or cz.Name ~= "Z" or not rawequal(vc:X(), cx) then
    drop(2)
end

cx:SetKeys({
    FloatCurveKey.new(0, 2, Enum.KeyInterpolationMode.Linear),
    FloatCurveKey.new(1, 10, Enum.KeyInterpolationMode.Linear),
})
cy:SetKeys({
    FloatCurveKey.new(0, -4, Enum.KeyInterpolationMode.Linear),
    FloatCurveKey.new(1, 4, Enum.KeyInterpolationMode.Linear),
})

local s1 = vc:GetValueAtTime(0.5)
if type(s1) ~= "table" or math.abs((s1[1] or -99) - 6) > 1e-4 or math.abs((s1[2] or -99) - 0) > 1e-4 or s1[3] ~= nil then
    drop(3)
end

cz:SetKeys({
    FloatCurveKey.new(0, 100, Enum.KeyInterpolationMode.Constant),
    FloatCurveKey.new(1, 200, Enum.KeyInterpolationMode.Constant),
})

local s2 = vc:GetValueAtTime(0.75)
if math.abs((s2[1] or -99) - 8) > 1e-4 or math.abs((s2[2] or -99) - 2) > 1e-4 or s2[3] ~= 100 then
    drop(4)
end

vc:Destroy()
print("ud")

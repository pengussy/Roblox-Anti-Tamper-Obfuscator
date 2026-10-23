-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local fc = Instance.new("FloatCurve")

local n = fc:SetKeys({
    FloatCurveKey.new(2, 20, Enum.KeyInterpolationMode.Linear),
    FloatCurveKey.new(0, 0, Enum.KeyInterpolationMode.Linear),
    FloatCurveKey.new(2, 99, Enum.KeyInterpolationMode.Linear),
    FloatCurveKey.new(1, 10, Enum.KeyInterpolationMode.Constant),
})

if n ~= 3 or fc.Length ~= 3 then
    fc:Destroy()
    fail(1)
end

if fc:GetKeyAtIndex(1).Time ~= 0 or fc:GetKeyAtIndex(2).Time ~= 1 or fc:GetKeyAtIndex(3).Time ~= 2 then
    fc:Destroy()
    fail(2)
end

if math.abs((fc:GetValueAtTime(0.5) or -1) - 5) > 1e-4 or fc:GetValueAtTime(1.5) ~= 10 then
    fc:Destroy()
    fail(3)
end

local ins = fc:InsertKey(FloatCurveKey.new(1, 14, Enum.KeyInterpolationMode.Linear))
if type(ins) ~= "table" or ins[1] ~= false or ins[2] ~= 2 then
    fc:Destroy()
    fail(4)
end

if math.abs((fc:GetValueAtTime(1.5) or -1) - 17) > 1e-4 then
    fc:Destroy()
    fail(5)
end

local br = fc:GetKeyIndicesAtTime(1.5)
if type(br) ~= "table" or br[1] ~= 2 or br[2] ~= 3 then
    fc:Destroy()
    fail(6)
end

local rem = fc:RemoveKeyAtIndex(2, 1)
local finalLen = fc.Length
fc:Destroy()

if rem ~= 1 or finalLen ~= 2 then
    fail(7)
end

print("ud")

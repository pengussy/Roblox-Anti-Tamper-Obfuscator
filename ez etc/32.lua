-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local c1 = Color3.new(0.5, 0.5, 0.5)
local c2 = Color3.new(0.9999, 0, 0)
local c3 = Color3.fromHex("#FF8000")

if c1:ToHex() ~= "808080" or c2:ToHex() ~= "ff0000" or c3:ToHex() ~= "ff8000" then
    error("dtc", 0)
end

local h, s, v = Color3.fromHSV(0.25, 0.5, 0.8):ToHSV()
if math.abs(h - 0.25) > 1e-5 or math.abs(s - 0.5) > 1e-5 or math.abs(v - 0.8) > 1e-5 then
    error("dtc", 0)
end

local mid = Color3.new(0, 0, 0):Lerp(Color3.new(1, 0.5, 0.25), 0.5)
if math.abs(mid.R - 0.5) > 1e-6 or math.abs(mid.G - 0.25) > 1e-6 or math.abs(mid.B - 0.125) > 1e-6 then
    error("dtc", 0)
end

print("ud")

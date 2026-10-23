-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local a = UDim2.new(0.25, 10, 0.5, -20)
local b = UDim2.new(0.75, 30, 0.5, 60)
local s = a + b
local d = b - a
local m = a:Lerp(b, 0.5)

if s ~= UDim2.new(1, 40, 1, 40) or d ~= UDim2.new(0.5, 20, 0, 80) then
    error("dtc", 0)
end

if m ~= UDim2.new(0.5, 20, 0.5, 20) then
    error("dtc", 0)
end

if UDim.new(0.5, 8) + UDim.new(0.25, -3) ~= UDim.new(0.75, 5) then
    error("dtc", 0)
end

print("ud")

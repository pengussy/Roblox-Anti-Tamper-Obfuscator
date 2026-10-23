-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local r1 = NumberRange.new(7)
local r2 = NumberRange.new(-4, 12)
local r3 = NumberRange.new(1 + 2^-24, 2)

if typeof(r1) ~= "NumberRange" or r1.Min ~= 7 or r1.Max ~= 7 then
    error("dtc", 0)
end

if r2.Min ~= -4 or r2.Max ~= 12 or r3.Min ~= 1 then
    error("dtc", 0)
end

if pcall(NumberRange.new, 10, 2) then
    error("dtc", 0)
end

print("ud")

-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

if math.noise(0.5, 0.5, 0.5) ~= -0.25 then
    fail(1)
end

if math.noise(4, -7, 2) ~= 0 or math.noise(0, 0, 0) ~= 0 or math.noise(-13, 29, -5) ~= 0 then
    fail(2)
end

if math.abs(math.noise(1.25, -2.5, 3.75) - 0.0080366134643554688) > 1e-7 then
    fail(3)
end

if math.abs(math.noise(0.125, 0.375, -0.625) - 0.26450395584106445) > 1e-7 then
    fail(4)
end

if math.noise(1.375, 2.625, -0.75) ~= math.noise(1.375 + 256, 2.625 - 256, -0.75 + 512) then
    fail(5)
end

print("ud")

-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local r1 = Random.new(987654321)
r1:NextNumber()
r1:NextInteger(-500, 500)

local r2 = r1:Clone()
if rawequal(r1, r2) then
    fail(1)
end

for i = 1, 16 do
    if r1:NextNumber() ~= r2:NextNumber() then
        fail(2)
    end
    if r1:NextInteger(-100000, 100000) ~= r2:NextInteger(-100000, 100000) then
        fail(3)
    end
    if r1:NextUnitVector() ~= r2:NextUnitVector() then
        fail(4)
    end
end

local a = { 1, 2, 3, 4, 5, 6, 7, 8 }
local b = { 1, 2, 3, 4, 5, 6, 7, 8 }
r1:Shuffle(a)
r2:Shuffle(b)

local same = true
local moved = false
for i = 1, 8 do
    if a[i] ~= b[i] then
        same = false
    end
    if a[i] ~= i then
        moved = true
    end
end

if not same or not moved then
    fail(5)
end

if pcall(r1.NextInteger, r1, 50, 10) or pcall(r1.Shuffle, r1, "not_table") then
    fail(6)
end

print("ud")

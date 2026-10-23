-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local acc = 0
local closedRan = false

local victim = coroutine.create(function()
    acc += 10
    coroutine.yield("step1")
    closedRan = true
    acc += 999
end)

local ok1, v1 = coroutine.resume(victim)
if not ok1 or v1 ~= "step1" or acc ~= 10 or coroutine.status(victim) ~= "suspended" then
    fail(1)
end

local okClose = coroutine.close(victim)
if not okClose or coroutine.status(victim) ~= "dead" or closedRan or acc ~= 10 then
    fail(2)
end

if coroutine.resume(victim) then
    fail(3)
end

local errHits = 0
local okErr, msgErr = xpcall(function()
    error("boom", 0)
end, function()
    errHits += 1
    error("handler_boom", 0)
end)

if okErr or msgErr ~= "error in error handling" or errHits ~= 1 then
    fail(4)
end

local sharedBuf = buffer.create(8)
local workers = {}
for i = 1, 4 do
    workers[i] = coroutine.create(function(mult)
        local x = coroutine.yield(i * mult)
        buffer.writeu16(sharedBuf, (i - 1) * 2, x + i)
        return x * 2
    end)
end

for i = 1, 4 do
    local okA, rA = coroutine.resume(workers[i], 10)
    if not okA or rA ~= i * 10 then
        fail(5)
    end
end

for i = 4, 1, -1 do
    local okB, rB = coroutine.resume(workers[i], 100 * i)
    if not okB or rB ~= 200 * i or coroutine.status(workers[i]) ~= "dead" then
        fail(6)
    end
end

for i = 1, 4 do
    if buffer.readu16(sharedBuf, (i - 1) * 2) ~= 100 * i + i then
        fail(7)
    end
end

print("ud")

-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local seq = {}

local deadT = task.defer(function()
    table.insert(seq, "bad")
end)
task.cancel(deadT)

if coroutine.status(deadT) ~= "dead" then
    fail(1)
end

task.defer(function()
    table.insert(seq, "d1")
end)

table.insert(seq, "s0")

local spT = task.spawn(function(x, y)
    if x + y ~= 42 then
        fail(2)
    end
    table.insert(seq, "s1")
    task.wait()
    table.insert(seq, "s2")
end, 19, 23)

table.insert(seq, "s3")

if #seq ~= 3 or seq[1] ~= "s0" or seq[2] ~= "s1" or seq[3] ~= "s3" then
    fail(3)
end

if coroutine.status(spT) ~= "suspended" then
    fail(4)
end

local dt = task.wait()
if type(dt) ~= "number" or dt <= 0 then
    fail(5)
end

if #seq < 5 then
    game:GetService("RunService").Heartbeat:Wait()
end

if seq[4] ~= "d1" then
    fail(6)
end

for _, v in ipairs(seq) do
    if v == "bad" then
        fail(7)
    end
end

local mtObj = setmetatable({}, {
    __index = function()
        coroutine.yield("y")
    end,
})

local co = coroutine.create(function()
    return mtObj.k
end)
local okY, errY = coroutine.resume(co)
if okY or tostring(errY) ~= "attempt to yield across metamethod/C-call boundary" then
    fail(8)
end

local ts = game:GetService("TweenService")
if ts:GetValue(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In) ~= 0.25 then
    fail(9)
end
if ts:GetValue(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) ~= 0.75 then
    fail(10)
end
if ts:GetValue(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.In) ~= 0.015625 then
    fail(11)
end
if math.abs(ts:GetValue(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut) - 0.5) > 1e-6 then
    fail(12)
end

print("ud")

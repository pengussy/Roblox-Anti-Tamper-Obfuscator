-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local expectedErr = "attempt to yield across metamethod/C-call boundary"

local function mustFailYield(fn)
    local co = coroutine.create(fn)
    local ok, res = coroutine.resume(co)
    return (not ok) and tostring(res) == expectedErr and coroutine.status(co) == "dead"
end

if not mustFailYield(function()
    local o = setmetatable({}, {
        __tostring = function()
            coroutine.yield("hooked")
            return "s"
        end,
    })
    return tostring(o)
end) then
    fail(1)
end

if not mustFailYield(function()
    return string.gsub("a", "a", function()
        coroutine.yield("hooked")
        return "b"
    end)
end) then
    fail(2)
end

if not mustFailYield(function()
    local t = { 2, 1 }
    table.sort(t, function(x, y)
        coroutine.yield("hooked")
        return x < y
    end)
end) then
    fail(3)
end

if not mustFailYield(function()
    local o = setmetatable({}, {
        __index = function()
            coroutine.yield("hooked")
        end,
    })
    return o.k
end) then
    fail(4)
end

if not mustFailYield(function()
    local o = setmetatable({}, {
        __newindex = function()
            coroutine.yield("hooked")
        end,
    })
    o.k = 1
end) then
    fail(5)
end

if not mustFailYield(function()
    local mt = {
        __eq = function()
            coroutine.yield("hooked")
            return true
        end,
    }
    local a = setmetatable({}, mt)
    local b = setmetatable({}, mt)
    return a == b
end) then
    fail(6)
end

local coPcall = coroutine.create(function()
    local ok, v = pcall(function()
        return coroutine.yield("pcall_yield_ok")
    end)
    return ok and v == "resumed_ok"
end)
local ok1, y1 = coroutine.resume(coPcall)
local ok2, y2 = coroutine.resume(coPcall, "resumed_ok")
if not ok1 or y1 ~= "pcall_yield_ok" or not ok2 or y2 ~= true then
    fail(7)
end

print("ud")

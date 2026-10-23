-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local bf = Instance.new("BindableFunction")
local be = Instance.new("BindableEvent")
local inst = Instance.new("Folder")
inst.Name = "Ref"

local s1 = be.Event
local s2 = be.Event
if typeof(s1) ~= "RBXScriptSignal" or s1 ~= s2 or rawequal(s1, s2) then
    fail(1)
end

local sub = { k = 99 }
local mt = {
    __index = { f = function() return true end },
    __tostring = function() return "x" end,
    __metatable = "locked",
}

local payload = setmetatable({
    [1] = "alpha",
    [2] = sub,
    [0] = "z",
    extra = "d",
}, mt)

bf.OnInvoke = function(t, o)
    return t, o, getmetatable(t)
end

local rt, ro, rmt = bf:Invoke(payload, inst)

if type(rt) ~= "table" or rawequal(rt, payload) then
    fail(2)
end

if rmt ~= nil or getmetatable(rt) ~= nil then
    fail(3)
end

if type(rt[2]) ~= "table" or rawequal(rt[2], sub) or rt[2].k ~= 99 then
    fail(4)
end

if rt[1] ~= "alpha" or rt[0] ~= nil or rt.extra ~= nil then
    fail(5)
end

if not rawequal(ro, inst) then
    fail(6)
end

local cyc = {}
cyc.s = cyc
if pcall(bf.Invoke, bf, cyc) then
    fail(7)
end

local et, eo
local conn = be.Event:Connect(function(t, o)
    et = t
    eo = o
end)

be:Fire(payload, inst)
if et == nil then
    task.wait()
end
conn:Disconnect()

if type(et) ~= "table" or rawequal(et, payload) or getmetatable(et) ~= nil then
    fail(8)
end

if et.extra ~= nil or not rawequal(eo, inst) then
    fail(9)
end

bf:Destroy()
be:Destroy()
inst:Destroy()

print("ud")

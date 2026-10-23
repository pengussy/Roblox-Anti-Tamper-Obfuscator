-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local et = Enum.HashAlgorithm
local fn1 = et.FromName
local fn2 = et.FromName
local fv1 = et.FromValue
local fv2 = et.FromValue

if type(fn1) ~= "function" or rawequal(fn1, fn2) or rawequal(fv1, fv2) then
    fail(1)
end

local s, l, n, a, v, f = debug.info(fn1, "slnaf")
if s ~= "[C]" or l ~= -1 or n ~= "FromName" or a ~= 0 or v ~= true or not rawequal(f, fn1) then
    fail(2)
end

if et:FromName("Sha256") ~= Enum.HashAlgorithm.Sha256 or et:FromName("__none__") ~= nil then
    fail(3)
end

local be = Instance.new("BindableEvent")
local sg1 = be.Event
local sg2 = be.Event

if typeof(sg1) ~= "RBXScriptSignal" or sg1 ~= sg2 or rawequal(sg1, sg2) then
    be:Destroy()
    fail(4)
end

local cn = sg1:Connect(function() end)
if cn.Connected ~= true then
    cn:Disconnect()
    be:Destroy()
    fail(5)
end

local badDisc = false
local function noSelf()
    return cn.Disconnect()
end
local okNoSelf = xpcall(noSelf, function()
    local s2, l2 = debug.info(2, "sl")
    local f3 = debug.info(3, "f")
    if s2 == "[C]" and l2 == -1 and rawequal(f3, noSelf) then
        badDisc = true
    end
end)

if okNoSelf or not badDisc or cn.Connected ~= true then
    cn:Disconnect()
    be:Destroy()
    fail(6)
end

cn:Disconnect()
local deadState = cn.Connected == false
be:Destroy()

if not deadState then
    fail(7)
end

print("ud")

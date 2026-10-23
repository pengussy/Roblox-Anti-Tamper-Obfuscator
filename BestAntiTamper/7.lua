-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

if type(SharedTable) ~= "table" or type(SharedTable.new) ~= "function" then
    fail(1)
end

local leaf = { n = 10 }
local st = SharedTable.new({
    a = leaf,
    b = leaf,
    v = 5,
})

if type(st) ~= "userdata" or typeof(st) ~= "SharedTable" then
    fail(2)
end

local okL, errL = pcall(function()
    return #st
end)
if okL or not string.find(tostring(errL), "SharedTable", 1, true) then
    fail(3)
end

if pcall(next, st) then
    fail(4)
end

if pcall(function() st[true] = 1 end) then
    fail(5)
end
if pcall(function() st.fn = function() end end) then
    fail(6)
end
if pcall(function() st.inst = workspace end) then
    fail(7)
end

local old = SharedTable.increment(st, "v", 12)
if old ~= 5 or st.v ~= 17 then
    fail(8)
end

SharedTable.update(st, "v", function(x)
    return x * 2 + 1
end)
if st.v ~= 35 then
    fail(9)
end

st.a.n = 77
if st.b.n ~= 10 or leaf.n ~= 10 then
    fail(10)
end

if SharedTable.isFrozen(st) ~= false then
    fail(11)
end

local frz = SharedTable.cloneAndFreeze(st, true)
if typeof(frz) ~= "SharedTable" or SharedTable.isFrozen(frz) ~= true then
    fail(12)
end

if pcall(function() frz.v = 0 end) or pcall(SharedTable.clear, frz) then
    fail(13)
end

local reg = game:GetService("SharedTableRegistry")
local k = "_sl_" .. tostring(math.random(100000, 999999)) .. "_" .. tostring(os.clock())
reg:SetSharedTable(k, st)

local got = reg:GetSharedTable(k)
if typeof(got) ~= "SharedTable" or got.v ~= 35 then
    reg:SetSharedTable(k, nil)
    fail(14)
end

reg:SetSharedTable(k, nil)
local fresh = reg:GetSharedTable(k)
local sz = SharedTable.size(fresh)
reg:SetSharedTable(k, nil)

if sz ~= 0 then
    fail(15)
end

print("ud")

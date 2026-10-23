-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local opt = Instance.new("DataStoreSetOptions")
local inc = Instance.new("DataStoreIncrementOptions")

local function drop(c)
    opt:Destroy()
    inc:Destroy()
    fail(c)
end

local src = { tag = "sl", ver = 2, ok = true }
opt:SetMetadata(src)
src.tag = "mutated"

local got = opt:GetMetadata()
if type(got) ~= "table" or rawequal(got, src) or got.tag ~= "sl" or got.ver ~= 2 or got.ok ~= true then
    drop(1)
end

got.ver = 999
if opt:GetMetadata().ver ~= 2 then
    drop(2)
end

if pcall(opt.SetMetadata, opt, { fn = function() end }) then
    drop(3)
end

if pcall(opt.SetMetadata, opt, { inst = workspace }) then
    drop(4)
end

if pcall(inc.SetMetadata, inc, { huge = string.rep("X", 512) }) then
    drop(5)
end

opt:Destroy()
inc:Destroy()
print("ud")

-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local f1 = Instance.new("Folder")
local f2 = Instance.new("Folder")
local src = { f1 }

local rp = RaycastParams.new()
rp.FilterType = Enum.RaycastFilterType.Include
rp.FilterDescendantsInstances = src

table.insert(src, f2)
if #rp.FilterDescendantsInstances ~= 1 or not rawequal(rp.FilterDescendantsInstances[1], f1) then
    f1:Destroy()
    f2:Destroy()
    error("dtc", 0)
end

rp:AddToFilter(f2)
local ok = #rp.FilterDescendantsInstances == 2 and rawequal(rp.FilterDescendantsInstances[2], f2)

f1:Destroy()
f2:Destroy()

if not ok then
    error("dtc", 0)
end

print("ud")

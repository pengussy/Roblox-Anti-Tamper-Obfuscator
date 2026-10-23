-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local host = Instance.new("Folder")
local p = Instance.new("Part")
p.Name = "ProbePart"
p.Size = Vector3.new(3, 5, 7)
p.Archivable = false
p.Parent = host

local sub = Instance.new("Attachment")
sub.Parent = p

if type(Instance.fromExisting) ~= "function" then
    host:Destroy()
    fail(1)
end

if p:Clone() ~= nil then
    host:Destroy()
    fail(2)
end

local twin = Instance.fromExisting(p)
if typeof(twin) ~= "Instance"
    or twin == p
    or rawequal(twin, p)
    or twin.Parent ~= nil
    or twin.Name ~= "ProbePart"
    or twin.Size ~= Vector3.new(3, 5, 7)
    or #twin:GetChildren() ~= 0
then
    if twin then twin:Destroy() end
    host:Destroy()
    fail(3)
end
twin:Destroy()

p.Archivable = true
local cl = p:Clone()
if cl == nil or cl == p or cl.Parent ~= nil or #cl:GetChildren() ~= 1 then
    if cl then cl:Destroy() end
    host:Destroy()
    fail(4)
end
cl:Destroy()

p:Destroy()
if p.Parent ~= nil then
    host:Destroy()
    fail(5)
end

local okSet, errSet = pcall(function()
    p.Parent = host
end)
host:Destroy()

if okSet or not string.find(tostring(errSet), "locked", 1, true) then
    fail(6)
end

print("ud")

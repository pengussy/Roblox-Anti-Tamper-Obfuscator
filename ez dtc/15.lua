local C = game:GetService("CollectionService")
local t = "zz" .. tostring(math.random(1, 1e8))
local p = Instance.new("Part")
C:AddTag(p, t)

if #C:GetTagged(t) ~= 0 or not C:HasTag(p, t) then
    error("dtc", 0)
end

p.Parent = workspace
local g = C:GetTagged(t)

if #g ~= 1 or g[1] ~= p then
    error("dtc", 0)
end

p.Parent = nil

if #C:GetTagged(t) ~= 0 then
    error("dtc", 0)
end

C:RemoveTag(p, t)

if C:HasTag(p, t) or #C:GetTags(p) ~= 0 then
    error("dtc", 0)
end

print("ud")

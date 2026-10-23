-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local vpf = Instance.new("ViewportFrame")
local wm = Instance.new("WorldModel")
wm.Parent = vpf

local function mkPart(pos, sz)
    local p = Instance.new("Part")
    p.Anchored = true
    p.CanQuery = true
    p.Size = sz
    p.Position = pos
    p.Parent = wm
    return p
end

local pA = mkPart(Vector3.new(0, 0, 0), Vector3.new(4, 4, 4))
local pB = mkPart(Vector3.new(5, 0, 0), Vector3.new(4, 4, 4))
local pC = mkPart(Vector3.new(40, 0, 0), Vector3.new(4, 4, 4))

local function drop(c)
    vpf:Destroy()
    fail(c)
end

local op = OverlapParams.new()
op.FilterType = Enum.RaycastFilterType.Include
op.FilterDescendantsInstances = { pA, pB, pC }

local inBox = wm:GetPartBoundsInBox(CFrame.new(2.5, 0, 0), Vector3.new(8, 6, 6), op)
if #inBox ~= 2 then
    drop(1)
end

for _, hit in ipairs(inBox) do
    if rawequal(hit, pC) then
        drop(2)
    end
end

op.MaxParts = 1
local capped = wm:GetPartBoundsInBox(CFrame.new(2.5, 0, 0), Vector3.new(8, 6, 6), op)
if #capped ~= 1 then
    drop(3)
end

op.MaxParts = 0
local inRad = wm:GetPartBoundsInRadius(Vector3.new(40, 0, 0), 3, op)
if #inRad ~= 1 or not rawequal(inRad[1], pC) then
    drop(4)
end

vpf:Destroy()
print("ud")

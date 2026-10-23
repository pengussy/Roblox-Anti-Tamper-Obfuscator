-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local vpf = Instance.new("ViewportFrame")
local wm = Instance.new("WorldModel")
wm.Parent = vpf

local wall = Instance.new("Part")
wall.Anchored = true
wall.CanCollide = true
wall.CanQuery = true
wall.Size = Vector3.new(20, 20, 2)
wall.CFrame = CFrame.new(0, 0, -15) * CFrame.Angles(0, math.rad(45), 0)
wall.Parent = wm

local ball = Instance.new("Part")
ball.Anchored = true
ball.CanQuery = true
ball.Shape = Enum.PartType.Ball
ball.Size = Vector3.new(6, 6, 6)
ball.CFrame = CFrame.new(0, 0, -6)
ball.Parent = wm

local function drop(c)
    vpf:Destroy()
    fail(c)
end

if not wm:IsA("WorldRoot") then
    drop(1)
end

local pAll = RaycastParams.new()
pAll.FilterType = Enum.RaycastFilterType.Include
pAll.FilterDescendantsInstances = { wall, ball }

local h1 = wm:Raycast(Vector3.new(0, 0, 0), Vector3.new(0, 0, -30), pAll)
if not h1 or not rawequal(h1.Instance, ball) then
    drop(2)
end

if math.abs(h1.Distance - 3) > 1e-3 or (h1.Normal - Vector3.new(0, 0, 1)).Magnitude > 1e-3 then
    drop(3)
end

local pWall = RaycastParams.new()
pWall.FilterType = Enum.RaycastFilterType.Include
pWall.FilterDescendantsInstances = { wall }

local h2 = wm:Raycast(Vector3.new(0, 0, 0), Vector3.new(0, 0, -30), pWall)
if not h2 or not rawequal(h2.Instance, wall) then
    drop(4)
end

local s = math.sqrt(0.5)
local ed = 15 - math.sqrt(2)
local en = Vector3.new(s, 0, s)

if math.abs(h2.Distance - ed) > 1e-2 or (h2.Normal - en).Magnitude > 1e-2 then
    drop(5)
end

if wm:Raycast(Vector3.new(4, 0, 0), Vector3.new(0, 0, -12), pAll) ~= nil then
    drop(6)
end

local h3 = wm:Spherecast(Vector3.new(4, 0, 0), 2, Vector3.new(0, 0, -12), pAll)
if not h3 or not rawequal(h3.Instance, ball) then
    drop(7)
end

vpf:Destroy()
print("ud")

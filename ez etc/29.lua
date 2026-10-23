local u = Vector3.new(3,1,4)
local v = Vector3.new(2,7,1)
local w = Vector3.new(5,0,9)
local bac = u:Cross(v:Cross(w))
local cab = v * u:Dot(w) - w * u:Dot(v)
local dx = math.abs(bac.X - cab.X)
local dy = math.abs(bac.Y - cab.Y)
local dz = math.abs(bac.Z - cab.Z)
local maxErr = math.max(dx, dy, dz)
if maxErr < 1e-6 then
    print("pass")
else
    print("detected")
end

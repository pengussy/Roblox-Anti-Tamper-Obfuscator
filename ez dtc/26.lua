local u = Vector3.new(1,2,3)
local k = 2
local v = Vector3.new(4,5,6)
local a = (u * k):Cross(v)
local b = u:Cross(v) * k
if math.abs(a.X - b.X) < 1e-6
   and math.abs(a.Y - b.Y) < 1e-6
   and math.abs(a.Z - b.Z) < 1e-6 then
    print("pass")
else
    print("detected")
end

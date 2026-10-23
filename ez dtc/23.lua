local u = Vector3.new(2,3,4)
local v = Vector3.new(5,6,7)
local a = u:Cross(v)
local b = v:Cross(u)
if (a + b).Magnitude < 1e-6 then
    print("pass")
else
    print("detected")
end

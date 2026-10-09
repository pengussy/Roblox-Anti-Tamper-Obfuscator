local u = Vector3.new(1,2,3)
local v = Vector3.new(4,5,6)
local w = Vector3.new(7,8,9)
local triple = u:Dot(v:Cross(w))
local expected = (u.X * (v.Y * w.Z - v.Z * w.Y))
               - (u.Y * (v.X * w.Z - v.Z * w.X))
               + (u.Z * (v.X * w.Y - v.Y * w.X))
if math.abs(triple - expected) < 1e-6 then
    print("pass")
else
    print("detected")
end

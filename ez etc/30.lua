local u = Vector3.new(1,0,0)
local v = Vector3.new(0,1,0)
local w = Vector3.new(0,0,1)
local anti = Vector3.new(1,1,1)
local lhs = u:Cross(v) + v:Cross(w) + w:Cross(u)
local rhs = anti * (u:Dot(v:Cross(w)))
if math.sign(lhs.X) == math.sign(rhs.X)
   and math.sign(lhs.Y) == math.sign(rhs.Y)
   and math.sign(lhs.Z) == math.sign(rhs.Z) then
    print("pass")
else
    print("detected")
end

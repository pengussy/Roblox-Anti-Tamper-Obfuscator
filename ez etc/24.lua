local u = Vector3.new(1,2,3)
local v = Vector3.new(4,5,6)
local c = u:Cross(v)
if math.abs(c:Dot(u)) < 1e-6 and math.abs(c:Dot(v)) < 1e-6 then
    print("pass")
else
    print("detected")
end

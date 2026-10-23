local u = Vector3.new(2,3,4)
local v = Vector3.new(5,6,7)
local c = u:Cross(v)
local ok = true
for _, axis in ipairs({Vector3.new(1,0,0), Vector3.new(0,1,0), Vector3.new(0,0,1)}) do
    if math.abs(c:Dot(axis) - (u.Y*v.Z - u.Z*v.Y)*axis.X
                      - (u.Z*v.X - u.X*v.Z)*axis.Y
                      - (u.X*v.Y - u.Y*v.X)*axis.Z) > 1e-6 then
        ok = false
    end
end
if ok then
    print("pass")
else
    print("detected")
end

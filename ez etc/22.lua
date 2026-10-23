local c = Vector3.new(1,0,0):Cross(Vector3.new(0,1,0))
if math.abs(c.X) < 1e-6 and math.abs(c.Y) < 1e-6 and math.abs(c.Z - 1) < 1e-6 then
    print("pass")
else
    print("detected")
end

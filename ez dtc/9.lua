local u = Vector3.new(1, 0, 0)
local v = Vector3.new(0, 1, 0)
local cross = u:Cross(v)
local dotU = cross:Dot(u)
local dotV = cross:Dot(v)
local expectedZ = cross:Dot(Vector3.new(0, 0, 1))
if math.abs(dotU) < 1e-9 and math.abs(dotV) < 1e-9 and math.abs(expectedZ - 1) < 1e-9 then
    print("pass")
else
    print("detected")
end`

-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local r = Region3.new(Vector3.new(2, 4, 6), Vector3.new(10, 14, 22))
if typeof(r) ~= "Region3" or r.Size ~= Vector3.new(8, 10, 16) or r.CFrame.Position ~= Vector3.new(6, 9, 14) then
    error("dtc", 0)
end

local e = r:ExpandToGrid(4)
if e.Size.X < 8 or e.Size.Y < 10 or e.Size.Z < 16 or e.Size.X % 4 ~= 0 or e.Size.Y % 4 ~= 0 or e.Size.Z % 4 ~= 0 then
    error("dtc", 0)
end

local ri = Region3int16.new(Vector3int16.new(-2, 0, 3), Vector3int16.new(5, 8, 9))
if typeof(ri) ~= "Region3int16" or ri.Min.X ~= -2 or ri.Max.Z ~= 9 then
    error("dtc", 0)
end

print("ud")

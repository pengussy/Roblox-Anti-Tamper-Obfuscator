-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local lo = PhysicalProperties.new(-5, -2, -1, -10, -10)
local hi = PhysicalProperties.new(999, 9, 5, 500, 500)
local mat = PhysicalProperties.new(Enum.Material.Plastic)

if typeof(lo) ~= "PhysicalProperties" or math.abs(lo.Density - 0.0001) > 1e-6 or lo.Friction ~= 0 or lo.Elasticity ~= 0 or lo.FrictionWeight ~= 0 or lo.ElasticityWeight ~= 0 then
    error("dtc", 0)
end

if math.abs(hi.Density - 100) > 1e-4 or hi.Friction ~= 2 or hi.Elasticity ~= 1 or hi.FrictionWeight ~= 100 or hi.ElasticityWeight ~= 100 then
    error("dtc", 0)
end

if typeof(mat) ~= "PhysicalProperties" or mat.Density <= 0 then
    error("dtc", 0)
end

print("ud")

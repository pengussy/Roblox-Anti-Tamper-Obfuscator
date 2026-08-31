local v = Instance.new("IntValue")
local g = {}

v.Changed:Connect(function(x)
    g[#g + 1] = x
end)

v.Value = 7
v.Name = "Q"
v.Value = 8
task.wait()

if #g ~= 2 or g[1] ~= 7 or g[2] ~= 8 then
    error("dtc", 0)
end

local o = Instance.new("ObjectValue")
local h

o.Changed:Connect(function(x)
    h = x
end)

o.Value = workspace
task.wait()

if h ~= workspace then
    error("dtc", 0)
end

print("ud")

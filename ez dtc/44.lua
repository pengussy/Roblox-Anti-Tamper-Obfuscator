-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local f = Instance.new("Folder")
local hits = 0

local conn = f:GetAttributeChangedSignal("Token"):Connect(function()
    hits += 1
end)

f:SetAttribute("Token", Vector3.new(1, 2, 3))
f:SetAttribute("Token", Vector3.new(4, 5, 6))

if f:GetAttribute("Token") ~= Vector3.new(4, 5, 6) then
    conn:Disconnect()
    f:Destroy()
    error("dtc", 0)
end

if pcall(f.SetAttribute, f, "Bad1", {}) or pcall(f.SetAttribute, f, "Bad2", function() end) or pcall(f.SetAttribute, f, "Bad3", workspace) then
    conn:Disconnect()
    f:Destroy()
    error("dtc", 0)
end

if hits == 0 then
    task.wait()
end

conn:Disconnect()
f:Destroy()

if hits < 1 then
    error("dtc", 0)
end

print("ud")

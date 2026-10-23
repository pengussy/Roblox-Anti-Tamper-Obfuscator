-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local gs1 = game.GetService
local gs2 = game.GetService

if type(gs1) ~= "function" or type(gs2) ~= "function" then
    fail(1)
end

local p1 = game:GetService("Players")
local p2 = gs1(game, "Players")
if typeof(p1) ~= "Instance" or not rawequal(p1, p2) then
    fail(2)
end

if pcall(gs1) or pcall(gs1, {}, "Players") or pcall(gs1, newproxy(true), "Players") then
    fail(3)
end

local colonCheck = false
local function dotCall()
    return game.GetService("Players")
end
local okDot = xpcall(dotCall, function(err)
    local s2, l2 = debug.info(2, "sl")
    local f3 = debug.info(3, "f")
    if s2 == "[C]" and l2 == -1 and rawequal(f3, dotCall) and string.find(tostring(err), "Expected ':' not '.'", 1, true) then
        colonCheck = true
    end
end)

if okDot or not colonCheck then
    fail(4)
end

local folder = Instance.new("Folder")
local child = Instance.new("IntValue")
child.Name = "Probe"
child.Parent = folder

if not rawequal(folder:FindFirstChild("Probe"), folder.FindFirstChild(folder, "Probe")) then
    folder:Destroy()
    fail(5)
end

folder:Destroy()
print("ud")

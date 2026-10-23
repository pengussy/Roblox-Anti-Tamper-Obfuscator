-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

if type(game) ~= "userdata" or typeof(game) ~= "Instance" or getmetatable(game) ~= "The metatable is locked" then
    fail(1)
end

if not rawequal(game, workspace.Parent) or not rawequal(game:GetService("Workspace"), workspace) then
    fail(2)
end

local h1 = game:GetService("HttpService")
local h2 = game:GetService("HttpService")
if not rawequal(h1, h2) then
    fail(3)
end

local function checkCBridge(obj, m)
    local okFrame = false
    local function trig()
        if m == 1 then
            return obj.__sl_missing_99182
        elseif m == 2 then
            obj.__sl_missing_99182 = true
        else
            return obj:__sl_missing_99182()
        end
    end

    local ran = xpcall(trig, function()
        local s2, l2, f2 = debug.info(2, "slf")
        local f3 = debug.info(3, "f")
        if s2 == "[C]" and l2 == -1 and not rawequal(f2, error) and rawequal(f3, trig) then
            okFrame = true
        end
    end)

    return (not ran) and okFrame
end

local f = Instance.new("Folder")
local pass = checkCBridge(game, 1)
    and checkCBridge(game, 2)
    and checkCBridge(game, 3)
    and checkCBridge(workspace, 1)
    and checkCBridge(f, 1)
    and checkCBridge(f, 3)
f:Destroy()

if not pass then
    fail(4)
end

local _ = workspace.Name
local m0 = gcinfo()
local c = 0
for i = 1, 3000 do
    if #workspace.Name == 9 then
        c += 1
    end
end
local dm = gcinfo() - m0

if c ~= 3000 or dm > 96 then
    fail(5)
end

print("ud")

-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local okS, mtS = pcall(getmetatable, "")
local okV, mtV = pcall(getmetatable, Vector3.zero)
local okC, mtC = pcall(getmetatable, CFrame.identity)

if not okS or mtS ~= "The metatable is locked" then
    fail(1)
end

if not okV or mtV ~= "The metatable is locked" or not okC or mtC ~= "The metatable is locked" then
    fail(2)
end

if not rawequal(("x").byte, string.byte)
    or not rawequal(("x").sub, string.sub)
    or not rawequal(("x").gsub, string.gsub)
    or not rawequal(("x").format, string.format)
    or not rawequal(("x").pack, string.pack)
then
    fail(3)
end

local guard = table.freeze({ k = 7 })
if not table.isfrozen(guard) or pcall(function() guard.k = 8 end) or pcall(table.freeze, guard) then
    fail(4)
end

local cFrameOk = false
local function badSub()
    return string.sub("abc", {})
end
local ran = xpcall(badSub, function(msg)
    local s2, l2, f2 = debug.info(2, "slf")
    local f3 = debug.info(3, "f")
    if s2 == "[C]"
        and l2 == -1
        and rawequal(f2, string.sub)
        and rawequal(f3, badSub)
        and string.find(tostring(msg), "number expected, got table", 1, true)
    then
        cFrameOk = true
    end
end)

if ran or not cFrameOk then
    fail(5)
end

local b1, b2 = ("SL"):byte(1, 2)
if b1 ~= 83 or b2 ~= 76 then
    fail(6)
end

print("ud")

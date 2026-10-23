-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

if type(getfenv) ~= "function" or type(setfenv) ~= "function" then
    fail(1)
end

local natives = {
    pcall,
    xpcall,
    tostring,
    rawequal,
    getmetatable,
    setmetatable,
    debug.info,
    string.byte,
    buffer.create,
    task.spawn,
    Instance.new,
    game.GetService,
}

for i, fn in ipairs(natives) do
    local cErrOk = false
    local function trySet()
        return setfenv(fn, {})
    end
    local ran = xpcall(trySet, function(e)
        local s2, l2, f2 = debug.info(2, "slf")
        local f3 = debug.info(3, "f")
        if s2 == "[C]"
            and l2 == -1
            and rawequal(f2, setfenv)
            and rawequal(f3, trySet)
            and string.find(tostring(e), "cannot change environment", 1, true)
        then
            cErrOk = true
        end
    end)
    if ran or not cErrOk then
        fail(10 + i)
    end
end

local env0 = getfenv(0)
if type(env0) ~= "table" or rawequal(env0, _G) then
    fail(2)
end

local function box()
    return secretToken
end

local custom = { secretToken = 0x51A7E }
local ret = setfenv(box, custom)
if not rawequal(ret, box) or not rawequal(getfenv(box), custom) or box() ~= 0x51A7E then
    fail(3)
end

print("ud")

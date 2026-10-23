-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

if type(debug) ~= "table" or type(debug.info) ~= "function" or type(debug.traceback) ~= "function" then
    fail(1)
end

local selfOk = false
local function probeBadOpt()
    return debug.info(pcall, "z")
end
local ran = xpcall(probeBadOpt, function()
    local s2, l2, f2 = debug.info(2, "slf")
    local f3 = debug.info(3, "f")
    if s2 == "[C]" and l2 == -1 and rawequal(f2, debug.info) and rawequal(f3, probeBadOpt) then
        selfOk = true
    end
end)
if ran or not selfOk then
    fail(2)
end

local list = {
    { pcall, "pcall" },
    { xpcall, "xpcall" },
    { tostring, "tostring" },
    { tonumber, "tonumber" },
    { type, "type" },
    { typeof, "typeof" },
    { rawequal, "rawequal" },
    { rawget, "rawget" },
    { rawset, "rawset" },
    { getmetatable, "getmetatable" },
    { setmetatable, "setmetatable" },
    { select, "select" },
    { error, "error" },
    { assert, "assert" },
    { string.byte, "byte" },
    { string.sub, "sub" },
    { string.char, "char" },
    { bit32.bxor, "bxor" },
    { buffer.create, "create" },
    { debug.info, "info" },
    { debug.traceback, "traceback" },
    { coroutine.resume, "resume" },
    { game.GetService, "GetService" },
    { Instance.new, "new" },
}

for i, item in ipairs(list) do
    local fn, expected = item[1], item[2]
    if type(fn) ~= "function" then
        fail(100 + i)
    end
    local s, l, n, a, v, f = debug.info(fn, "slnaf")
    if s ~= "[C]" or l ~= -1 or n ~= expected or a ~= 0 or v ~= true or not rawequal(f, fn) then
        fail(200 + i)
    end
end

local function luaFn(x, y)
    return x + y
end
local ls, ll, ln, la, lv, lf = debug.info(luaFn, "slnaf")
if ls == "[C]" or ll <= 0 or ln ~= "luaFn" or la ~= 2 or lv ~= false or not rawequal(lf, luaFn) then
    fail(3)
end

print("ud")

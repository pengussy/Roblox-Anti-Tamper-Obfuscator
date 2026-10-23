-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local function checkNoWrapper(fn, callBad)
    local direct = false
    local function trig()
        return callBad(fn)
    end
    local ok = xpcall(trig, function()
        local s2, l2, f2 = debug.info(2, "slf")
        local f3 = debug.info(3, "f")
        if s2 == "[C]" and l2 == -1 and rawequal(f2, fn) and rawequal(f3, trig) then
            direct = true
        end
    end)
    return (not ok) and direct
end

local b = buffer.create(4)

if not checkNoWrapper(tonumber, function(f) return f("10", 99) end) then
    fail(1)
end
if not checkNoWrapper(string.sub, function(f) return f("x", {}) end) then
    fail(2)
end
if not checkNoWrapper(string.pack, function(f) return f("!99I4", 1) end) then
    fail(3)
end
if not checkNoWrapper(buffer.readu8, function(f) return f(b, 99) end) then
    fail(4)
end
if not checkNoWrapper(bit32.extract, function(f) return f(1, 31, 5) end) then
    fail(5)
end
if not checkNoWrapper(utf8.char, function(f) return f(0x200000) end) then
    fail(6)
end
if not checkNoWrapper(Instance.new, function(f) return f("__InvalidClass_SL_99__") end) then
    fail(7)
end
if not checkNoWrapper(game.GetService, function(f) return f(game, "__InvalidService_SL_99__") end) then
    fail(8)
end

local fTonum, fByte, fXor, fRawEq = tonumber, string.byte, bit32.bxor, rawequal
local _ = fTonum("42")
local m0 = gcinfo()
local acc = 0
for _ = 1, 4000 do
    if fRawEq(fXor(fByte("A"), 3), 66) and fTonum("7") == 7 then
        acc += 1
    end
end
if acc ~= 4000 or (gcinfo() - m0) > 64 then
    fail(9)
end

print("ud")

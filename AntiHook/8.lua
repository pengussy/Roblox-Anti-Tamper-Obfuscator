-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local t = setmetatable({ 10, 20, 30 }, {
    __len = function() return 999 end,
    __index = { ghost = 123 },
})

if #t ~= 999 or rawlen(t) ~= 3 or rawlen("abcd") ~= 4 then
    fail(1)
end

if pcall(rawlen, 123) or pcall(rawlen, newproxy(true)) then
    fail(2)
end

local count = 0
for k, v in next, t do
    if k == "ghost" then
        fail(3)
    end
    count += v
end
if count ~= 60 then
    fail(4)
end

local nextFrameOk = false
local function badNext()
    return next({ a = 1 }, "nonexistent_key_sl")
end
local ranNext = xpcall(badNext, function(e)
    local s2, l2, f2 = debug.info(2, "slf")
    local f3 = debug.info(3, "f")
    if s2 == "[C]" and l2 == -1 and rawequal(f2, next) and rawequal(f3, badNext) and string.find(tostring(e), "invalid key", 1, true) then
        nextFrameOk = true
    end
end)
if ranNext or not nextFrameOk then
    fail(5)
end

if select(-1, 5, 8, 13) ~= 13 or select("#", nil, nil, nil) ~= 3 then
    fail(6)
end

if pcall(select, 0, 1, 2) then
    fail(7)
end

print("ud")

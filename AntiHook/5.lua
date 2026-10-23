-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local seen = {}
local prefixes = {
    { function() return {} end, "table: 0x" },
    { function() return function() end end, "function: 0x" },
    { function() return newproxy(false) end, "userdata: 0x" },
    { function() return coroutine.create(function() end) end, "thread: 0x" },
    { function() return buffer.create(4) end, "buffer: 0x" },
}

for i, entry in ipairs(prefixes) do
    local make, pref = entry[1], entry[2]
    local x = make()
    local y = make()
    if rawequal(x, y) then
        fail(10 + i)
    end
    local sx = tostring(x)
    local sy = tostring(y)
    if sx == sy then
        fail(20 + i)
    end
    if string.sub(sx, 1, #pref) ~= pref or string.sub(sy, 1, #pref) ~= pref then
        fail(30 + i)
    end
    if seen[sx] or seen[sy] then
        fail(40 + i)
    end
    seen[sx] = true
    seen[sy] = true
end

local nan = 0 / 0
if nan == nan or rawequal(nan, nan) then
    fail(1)
end

if not rawequal(-0.0, 0.0) or 1 / -0.0 == 1 / 0.0 then
    fail(2)
end

local p1 = newproxy(true)
local p2 = newproxy(false)
if type(getmetatable(p1)) ~= "table" or getmetatable(p2) ~= nil then
    fail(3)
end

local spoof = setmetatable({ real = 11 }, {
    __index = { real = 22, fake = 33 },
    __eq = function() return true end,
})
local other = setmetatable({}, getmetatable(spoof))

if spoof ~= other or rawequal(spoof, other) then
    fail(4)
end

if rawget(spoof, "real") ~= 11 or rawget(spoof, "fake") ~= nil or spoof.fake ~= 33 then
    fail(5)
end

print("ud")

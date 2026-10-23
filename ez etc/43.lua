-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local mt = { __index = { extra = 91 } }
local src = setmetatable({ 10, 20, 30, k = "v" }, mt)
table.freeze(src)

if not table.isfrozen(src) then
    error("dtc", 0)
end

local cl = table.clone(src)
if rawequal(cl, src) or table.isfrozen(cl) or not rawequal(getmetatable(cl), mt) or cl.extra ~= 91 then
    error("dtc", 0)
end

cl[2] = 99
if src[2] ~= 20 or cl[2] ~= 99 or cl.k ~= "v" then
    error("dtc", 0)
end

local p = table.pack("a", nil, "c")
if p.n ~= 3 or p[1] ~= "a" or p[2] ~= nil or p[3] ~= "c" then
    error("dtc", 0)
end

print("ud")

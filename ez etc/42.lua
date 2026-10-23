-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local fmt = "<i2I4f>d"
if string.packsize(fmt) ~= 18 then
    error("dtc", 0)
end

local blob = string.pack(fmt, -12345, 0xDEADBEEF, 1.5, -3.25)
if #blob ~= 18 then
    error("dtc", 0)
end

local v1, v2, v3, v4, nxt = string.unpack(fmt, blob)
if v1 ~= -12345 or v2 ~= 0xDEADBEEF or v3 ~= 1.5 or v4 ~= -3.25 or nxt ~= 19 then
    error("dtc", 0)
end

print("ud")

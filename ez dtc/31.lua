-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local b = buffer.create(16)
if type(b) ~= "buffer" or typeof(b) ~= "buffer" or buffer.len(b) ~= 16 then
    error("dtc", 0)
end

buffer.writef32(b, 0, 1.0)
buffer.writef32(b, 4, -2.5)
if buffer.readu32(b, 0) ~= 0x3F800000 or buffer.readu32(b, 4) ~= 0xC0200000 then
    error("dtc", 0)
end

local s = buffer.fromstring("ABCDEFGH")
buffer.copy(s, 2, s, 0, 6)
if buffer.tostring(s) ~= "ABABCDEF" then
    error("dtc", 0)
end

local ok, err = pcall(buffer.readu8, b, 16)
if ok or tostring(err) ~= "buffer access out of bounds" then
    error("dtc", 0)
end

print("ud")

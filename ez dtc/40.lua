-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

if bit32.countlz(0) ~= 32 or bit32.countrz(0) ~= 32 then
    error("dtc", 0)
end

if bit32.countlz(1) ~= 31 or bit32.countrz(0x80000000) ~= 31 then
    error("dtc", 0)
end

if bit32.byteswap(0x12345678) ~= 0x78563412 then
    error("dtc", 0)
end

if bit32.extract(0xABCD1234, 8, 8) ~= 0x12 then
    error("dtc", 0)
end

if bit32.replace(0xABCD1234, 0xFF, 8, 8) ~= 0xABCDFF34 then
    error("dtc", 0)
end

if bit32.arshift(0x80000000, 4) ~= 0xF8000000 then
    error("dtc", 0)
end

print("ud")

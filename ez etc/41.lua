-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local s = "A\xC3\xA9\xF0\x9F\x94\xA5Z"
if utf8.len(s) ~= 4 or #s ~= 8 then
    error("dtc", 0)
end

local cps = { utf8.codepoint(s, 1, #s) }
if #cps ~= 4 or cps[1] ~= 65 or cps[2] ~= 233 or cps[3] ~= 128293 or cps[4] ~= 90 then
    error("dtc", 0)
end

if utf8.offset(s, 3) ~= 4 or utf8.char(65, 233, 128293, 90) ~= s then
    error("dtc", 0)
end

local badLen, badPos = utf8.len("ok\xFFbad")
if badLen ~= nil or badPos ~= 3 then
    error("dtc", 0)
end

print("ud")

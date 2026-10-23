local h = game:GetService("HttpService")

if h:JSONEncode({}) ~= "[]" or next(h:JSONDecode("{}")) ~= nil then
    error("dtc68", 0)
end

if h:JSONEncode({ [1] = 1, [3] = 3 }) ~= "[1]" or h:JSONEncode({ [2] = 5 }) ~= '{"2":5}' then
    error("dtc68", 0)
end

if h:JSONEncode({ a = 1, [1] = 2 }) ~= "[2]" or h:JSONEncode({ ["1"] = "a", [1] = "b" }) ~= '["b"]' then
    error("dtc68", 0)
end

if h:JSONEncode({ 0 / 0 }) ~= '[{"m":null,"t":"numeric","v":"nan"}]' then
    error("dtc68", 0)
end

if h:JSONEncode({ math.huge }) ~= '[{"m":null,"t":"numeric","v":"inf"}]' then
    error("dtc68", 0)
end

if h:JSONEncode({ -math.huge }) ~= '[{"m":null,"t":"numeric","v":"-inf"}]' then
    error("dtc68", 0)
end

if h:JSONEncode({ 1.5, -0.0, 1e300 }) ~= "[1.5,-0,1e300]" then
    error("dtc68", 0)
end

if h:JSONDecode('{"a":null}').a ~= nil or h:JSONDecode("5") ~= 5 then
    error("dtc68", 0)
end

local o, e = pcall(h.JSONDecode, h, "nope")

if o or tostring(e) ~= "Can't parse JSON" then
    error("dtc68", 0)
end

local x = {}
x.s = x
local a, b = pcall(h.JSONEncode, h, x)

if a or tostring(b) ~= "tables cannot be cyclic" then
    error("dtc68", 0)
end

print("ud")

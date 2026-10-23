-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local iso = DateTime.fromIsoDate("2026-10-23T12:34:56Z")
if typeof(iso) ~= "DateTime" or iso.UnixTimestamp ~= 1792758896 or iso.UnixTimestampMillis ~= 1792758896000 then
    fail(1)
end

local ut = DateTime.fromUniversalTime(2026, 10, 23, 12, 34, 56, 789)
if ut.UnixTimestampMillis ~= 1792758896789 then
    fail(2)
end

local t = ut:ToUniversalTime()
if t.Year ~= 2026 or t.Month ~= 10 or t.Day ~= 23 or t.Hour ~= 12 or t.Minute ~= 34 or t.Second ~= 56 or t.Millisecond ~= 789 then
    fail(3)
end

if iso:ToIsoDate() ~= "2026-10-23T12:34:56Z" then
    fail(4)
end

if iso:FormatUniversalTime("YYYY-MM-DD HH:mm:ss", "en-us") ~= "2026-10-23 12:34:56" then
    fail(5)
end

if pcall(DateTime.fromUniversalTime, 1200, 1, 1) or pcall(DateTime.fromUniversalTime, 10500, 1, 1) then
    fail(6)
end

print("ud")

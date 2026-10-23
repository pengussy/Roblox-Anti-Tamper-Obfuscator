-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local function packRet(...)
    return select("#", ...), { ... }
end

local n1, t1 = packRet(pcall(function(a, b, c)
    if a ~= 11 or b ~= nil or c ~= 33 then
        error("arg", 0)
    end
    return nil, "ok", nil, 77, nil
end, 11, nil, 33))

if n1 ~= 6 or t1[1] ~= true or t1[2] ~= nil or t1[3] ~= "ok" or t1[4] ~= nil or t1[5] ~= 77 or t1[6] ~= nil then
    fail(1)
end

local n2, t2 = packRet(xpcall(function(x, y, z)
    if x ~= "a" or y ~= nil or z ~= "c" then
        error("xarg", 0)
    end
    return nil, 42, nil
end, function(e)
    return e
end, "a", nil, "c"))

if n2 ~= 4 or t2[1] ~= true or t2[2] ~= nil or t2[3] ~= 42 or t2[4] ~= nil then
    fail(2)
end

local hits = 0
local okE, msgE = xpcall(function()
    error("first", 0)
end, function()
    hits += 1
    error("second", 0)
end)

if okE or msgE ~= "error in error handling" or hits ~= 1 then
    fail(3)
end

print("ud")

-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local f1, f2, f3, f4
f1 = function(a)
    f2 = function(a, b)
        f3 = function(a, b, c)
            f4 = function(a, b, c, d) return a + b + c + d end
        end
    end
end
f1(1); f2(1, 2); f3(1, 2, 3)

local list = { f1, f2, f3, f4 }
local base = debug.info(f1, "l")
if not base then error("dtc", 0) end

for i = 1, 4 do
    local ln, ar, va = debug.info(list[i], "la")
    if (ln - base) ~= (i - 1) or ar ~= i or va ~= false then
        error("dtc", 0)
    end
end

print("ud")

-- ts actually kinda tuff
local getmetatable = getmetatable
local success, mt = pcall(getmetatable, "")
if not success or typeof(mt) ~= "table" or mt.__index ~= string or mt.__metatable ~= "The metatable is locked" then
    error("Kvms: Fail", 0)
else
    print("Pass")
end

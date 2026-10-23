-- I actually don't know if ts even good
local _, e = pcall(function() error("TEST") end)
if tostring(e):find('luau%.load') then return end
print("Protected")

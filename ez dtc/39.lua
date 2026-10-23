-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

if type(Content) ~= "table" or typeof(Content.none) ~= "Content" then
    error("dtc", 0)
end

local u = Content.fromUri("rbxassetid://1848354536")
local e = Content.fromUri("")
local a = Content.fromAssetId(1848354536)

if typeof(u) ~= "Content" or u.SourceType ~= Enum.ContentSourceType.Uri or u.Uri ~= "rbxassetid://1848354536" then
    error("dtc", 0)
end

if e.SourceType ~= Enum.ContentSourceType.None or Content.none.SourceType ~= Enum.ContentSourceType.None then
    error("dtc", 0)
end

if a.SourceType ~= Enum.ContentSourceType.Uri or a.Uri ~= "rbxassetid://1848354536" then
    error("dtc", 0)
end

print("ud")

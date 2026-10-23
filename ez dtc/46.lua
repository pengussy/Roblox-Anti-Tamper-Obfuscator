-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local ax = Axes.new(Enum.NormalId.Right, Enum.NormalId.Bottom)
local fc = Faces.new(Enum.NormalId.Front, Enum.NormalId.Left)

if typeof(ax) ~= "Axes" or not ax.X or not ax.Y or ax.Z or not ax.Right or ax.Left or not ax.Bottom or ax.Top then
    error("dtc", 0)
end

if typeof(fc) ~= "Faces" or not fc.Front or fc.Back or not fc.Left or fc.Right or fc.Top or fc.Bottom then
    error("dtc", 0)
end

print("ud")

-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local ts = game:GetService("TweenService")

if ts:GetValue(0, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out) ~= 0 then
    error("dtc", 0)
end

if ts:GetValue(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out) ~= 1 then
    error("dtc", 0)
end

if ts:GetValue(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut) ~= 0.5 then
    error("dtc", 0)
end

if ts:GetValue(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In) ~= 0.0625 then
    error("dtc", 0)
end

if ts:GetValue(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In) ~= 0.03125 then
    error("dtc", 0)
end

print("ud")

-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local ns = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 2),
    NumberSequenceKeypoint.new(0.5, 6, 1),
    NumberSequenceKeypoint.new(1, 10),
})

if typeof(ns) ~= "NumberSequence" or #ns.Keypoints ~= 3 or ns.Keypoints[2].Envelope ~= 1 then
    error("dtc", 0)
end

if pcall(NumberSequence.new, {
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.8, 2),
}) then
    error("dtc", 0)
end

if pcall(NumberSequence.new, {
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.7, 2),
    NumberSequenceKeypoint.new(0.3, 3),
    NumberSequenceKeypoint.new(1, 4),
}) then
    error("dtc", 0)
end

if pcall(ColorSequence.new, {
    ColorSequenceKeypoint.new(0.2, Color3.new(1, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.new(0, 1, 0)),
}) then
    error("dtc", 0)
end

print("ud")

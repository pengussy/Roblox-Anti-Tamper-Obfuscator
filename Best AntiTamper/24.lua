-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local snd = Instance.new("Sound")
local eq = Instance.new("EqualizerSoundEffect")
eq.Parent = snd

local function drop(c)
    snd:Destroy()
    fail(c)
end

eq.HighGain = 999
eq.MidGain = -999
eq.LowGain = 4.5

if math.abs(eq.HighGain - 10) > 1e-4 or math.abs(eq.MidGain - (-80)) > 1e-4 or math.abs(eq.LowGain - 4.5) > 1e-4 then
    drop(1)
end

snd.Volume = 999
if snd.Volume > 10.001 then
    drop(2)
end

snd.Volume = -50
if snd.Volume ~= 0 then
    drop(3)
end

if snd.IsPlaying ~= false or pcall(function() snd.IsPlaying = true end) then
    drop(4)
end

snd:Destroy()
print("ud")

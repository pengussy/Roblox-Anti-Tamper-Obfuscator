-- ExoEnv Killer
local startClock = os.clock()
repeat until os.clock() - startClock >= 1
-- End Killer

local EncodingService = game:GetService("EncodingService")
local LogService = game:GetService("LogService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Flags = {}
local _, InvalidHashAlgorithm = pcall(function()
	return EncodingService:ComputeStringHash("", Enum.Material.SmoothPlastic)
end)
if InvalidHashAlgorithm ~= "Unable to cast Material to HashAlgorithm" then
	table.insert(Flags, "InvalidHashAlgorithmErrorMismatch_EncodingService")
end
local InvalidInputStringSuccess, InvalidInputString = pcall(function()
	return EncodingService:ComputeStringHash(1, Enum.HashAlgorithm.Sha256)
end)
if InvalidInputStringSuccess == false then
	table.insert(Flags, "InvalidInputStringSuccess_EncodingService")
end

-- Infinite Yield
local capturedWarning
local conn
conn = LogService.MessageOut:Connect(function(message, messageType)
	if message:find("Infinite yield possible") then
		capturedWarning = message
	end
end)

task.spawn(function()
	task.wait(6)
	Instance.new("Frame", game.Lighting).Name = "flag_killinfyield"
end)

game.Lighting:WaitForChild("flag_killinfyield")

conn:Disconnect()
if game.Lighting:FindFirstChild("flag_killinfyield") then
	game.Lighting["flag_killinfyield"]:Destroy()
end
if capturedWarning ~= "Infinite yield possible on 'Lighting:WaitForChild(\"flag_killinfyield\")'" then
	table.insert(Flags, "InfYieldWarningMismatch_Engine")
end

local LogHistory = LogService:GetLogHistory()
print("1")
print("2")
if #LogHistory < 2 then
	table.insert(Flags, "LogHistoryError_Engine")
end

-- Physics Check
if not RunService:IsRunning() then
	table.insert(Flags, "NotRunning_EditModeOrPaused")
end

local char = Players:CreateHumanoidModelFromUserIdAsync(1)
char.Parent = workspace
char.PrimaryPart.CFrame = CFrame.new(Vector3.new(0, 50000, 0))

RunService.Heartbeat:Wait()

local samples = {}
local startClock = os.clock()

for i = 1, 10 do
	RunService.Heartbeat:Wait()
	table.insert(samples, {
		time = os.clock() - startClock,
		y = char.PrimaryPart.Position.Y,
	})
end

local elapsedRealTime = os.clock() - startClock

if elapsedRealTime < 0.05 then
	table.insert(Flags, "PhysicsNotStepping_NoRealTimeElapsed")
end

local isFalling = true
for i = 2, #samples do
	if samples[i].y >= samples[i-1].y then
		isFalling = false
		break
	end
end

if not isFalling then
	table.insert(Flags, "PhysicsFrozenOrFaked_Engine")
end

char:Destroy()

local function binaryToHex(binaryString: string): string
	local hex, _ = string.gsub(binaryString, ".", function(char)
		return string.format("%02x", string.byte(char))
	end)
	return hex
end

local FinalJson = game:GetService("HttpService"):JSONEncode(Flags)
if #Flags <= 1 then
	print("wowie you passed the env check :) good job ig bro")
else
	print("HOLY SHIT THIS GUY IS HAXXING FAKE ENV OMG AHHHHHHHHHHHHH")
	print("env check flags: " .. FinalJson)
end

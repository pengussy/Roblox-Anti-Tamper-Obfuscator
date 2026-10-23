-- 25ms Obfuscator Anti Tamper | Idk New/Old
local env = getfenv and getfenv() or _ENV

local AntiTamper = {}
local failures = {}

local function resetFailures()
	for i = #failures, 1, -1 do
		failures[i] = nil
	end
end

local function fail(name, detail)
	if detail ~= nil then
		failures[#failures + 1] = string.format("%s: %s", name, tostring(detail))
	else
		failures[#failures + 1] = name
	end
end

local function expectOk(name, fn)
	local ok, result = pcall(fn)
	if not ok then
		fail(name, result)
		return false, result
	end
	return true, result
end

local function expectError(name, fn)
	local ok, result = pcall(fn)
	if ok then
		fail(name, "expected an error, but call succeeded")
		return false
	end
	return true, result
end

local function destroyIfInstance(obj)
	if typeof(obj) == "Instance" then
		pcall(function()
			obj:Destroy()
		end)
	end
end

local function installMarker()
	pcall(function()
		local genv = getgenv and getgenv()
		if type(genv) == "table" then
			genv["25ms was here :)"] = function()
				-- marker only
			end
		end
	end)
end

local function getLoader()
	local loader = loadstring or load
	if type(loader) == "function" then
		return loader
	end
	return nil
end

local function getPcallErrorLine(loader, source)
	local okCompile, chunkOrErr = pcall(loader, source)
	if not okCompile or type(chunkOrErr) ~= "function" then
		return nil, "compile failed"
	end

	local okRun, pcallOk, pcallErr = pcall(chunkOrErr)
	if not okRun then
		return nil, "chunk crashed before returning"
	end

	if pcallOk ~= false then
		return nil, "expected inner pcall to fail"
	end

	local line = tonumber(tostring(pcallErr):match(":(%d+):"))
	if not line then
		return nil, "could not parse line from error"
	end

	return line
end

local function checkLoaderFingerprint()
	local loader = getLoader()
	if not loader then
		return true
	end

	local line1, err1 = getPcallErrorLine(loader, [[
return pcall(function()
	return 1 / "abc"
end)
]])

	local line2, err2 = getPcallErrorLine(loader, [[

return pcall(function()
	return 1 / "abc"
end)
]])

	if not line1 then
		fail("loader fingerprint", err1)
		return false
	end

	if not line2 then
		fail("loader fingerprint", err2)
		return false
	end

	if line2 ~= line1 + 1 then
		fail("loader fingerprint", string.format("unexpected line delta (%d -> %d)", line1, line2))
		return false
	end

	return true
end

local function checkDebugApi()
	local infoFn = debug and (debug.getinfo or debug.info)
	if type(infoFn) ~= "function" then
		fail("debug api", "debug.getinfo/debug.info missing")
		return false
	end

	return expectOk("debug api", function()
		local probe = function()
			return true
		end

		local result = infoFn(probe, "f")
		if result == nil then
			error("debug api returned nil")
		end
	end)
end

local function checkTaskApi()
	expectError("task.spawn(table)", function()
		task.spawn({})
	end)

	expectOk("task.delay(function)", function()
		local ran = false
		local ev = Instance.new("BindableEvent")

		task.delay(0, function()
			ran = true
			ev:Fire()
		end)

		ev.Event:Wait()
		ev:Destroy()

		if not ran then
			error("delay callback never ran")
		end
	end)
end

local function checkRobloxApiSurface()
	expectError("invalid workspace member call", function()
		return workspace["subgmaballshaha"](workspace)
	end)

	expectError("invalid DataModel member access", function()
		return game["__definitely_not_a_real_member__"](game)
	end)

	expectOk("fake service lookup", function()
		local service = game:FindFirstChild("__DefinitelyNotARealService__")
		if service ~= nil then
			error("fake service unexpectedly exists")
		end
	end)

	expectOk("fake class lookup", function()
		local obj = workspace:FindFirstChildOfClass("__DefinitelyNotARealClass__")
		if obj ~= nil then
			error("fake class unexpectedly exists")
		end
	end)

	expectOk("workspace children count", function()
		local children = workspace:GetChildren()
		local count = #children
		local s = tostring(count)
		local n = tonumber(s)

		if type(count) ~= "number" or type(s) ~= "string" or type(n) ~= "number" then
			error("children count conversion failed")
		end
	end)

	expectOk("Instance.new(Part)", function()
		local p1 = Instance.new("Part")
		local p2 = Instance.new("Part")

		destroyIfInstance(p1)
		destroyIfInstance(p2)
	end)
end

local function checkProxyMetatable()
	if type(newproxy) ~= "function" then
		return true
	end

	return expectOk("proxy/metatable", function()
		local proxy = newproxy(true)
		local mt = getmetatable(proxy)

		if type(mt) ~= "table" then
			error("proxy metatable missing")
		end

		local backing = {
			Name = "probe",
		}

		mt.__index = backing
		mt.__len = function()
			return 1000159
		end
		mt.__metatable = false

		if proxy.Name ~= "probe" then
			error("__index probe failed")
		end

		if #proxy ~= 1000159 then
			error("__len probe failed")
		end
	end)
end

function AntiTamper.Run()
	resetFailures()

	installMarker()
	checkLoaderFingerprint()
	checkDebugApi()
	checkTaskApi()
	checkRobloxApiSurface()
	checkProxyMetatable()

	return #failures == 0, failures
end

return AntiTamper

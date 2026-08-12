-- @exvak ask me to add ts so I decided as wyn are popular rn but ts is only I think 5% of their whole anti tamper
do
	local function abort()
		error("wYnFuscate environment integrity check failed", 0)
	end

	local function checkRoblox()
		local env = getfenv and getfenv(0) or nil
		local gameOk = game ~= nil and type(game) ~= type({})
		local newInstance = Instance and Instance.new or nil
		local instanceOk = newInstance ~= nil and type(newInstance) == type(pcall)
		local isolatedEnv = getfenv ~= nil and env ~= nil and type(env) == type({}) and (_G == nil or env ~= _G)

		if not gameOk or not instanceOk or not isolatedEnv then
			abort()
		end

		local getService = game.GetService

		if type(getService) ~= type(pcall) then
			abort()
		end

		local ok, players = pcall(getService, game, "Players")

		if not ok or players == nil or type(players) ~= type(game) then
			abort()
		end
	end

	local function readErrorLine(message)
		if type(message) ~= "string" then
			return nil
		end

		local lastLine
		local cursor = 1

		while cursor <= #message do
			if string.byte(message, cursor) == 58 then
				local digitAt = cursor + 1
				local value = 0
				local found = false
				local byte = string.byte(message, digitAt)

				while digitAt <= #message and byte and byte >= 48 and byte <= 57 do
					value = value * 10 + byte - 48
					found = true
					digitAt = digitAt + 1
					byte = string.byte(message, digitAt)
				end

				if found and byte == 58 then
					lastLine = value
				end
			end

			cursor = cursor + 1
		end

		return lastLine
	end

	local function getLineReader()
		local info = debug and debug.info or nil
		local getInfo = debug and debug.getinfo or nil

		if type(info) == "function" then
			return function(level)
				if type(level) ~= "number" or level < 1 or level > 5 then
					return nil
				end

				return info(level + 1, "l")
			end
		end

		if type(getInfo) == "function" then
			return function(level)
				if type(level) ~= "number" or level < 1 or level > 5 then
					return nil
				end

				local frame = getInfo(level + 1, "l")
				return frame and frame.currentline or nil
			end
		end

		return nil
	end

	local function makeSeed()
		local _, message = pcall(function(...)
			return (...)()
		end)
		local line = readErrorLine(message) or 0
		local readLine = getLineReader()

		if readLine then
			local stackLine = (function()
				return readLine(1)
			end)() or 0

			if stackLine > 0 then
				line = stackLine
			end
		end

		if line <= 0 or line > 49157 then
			line = 0
		end

		local lineFlag = line > 0 and 1 or 0
		local vectorOk, vector = pcall(function()
			local vectorType = Vector3int16
			return vectorType and vectorType.new and vectorType.new(1, 2, 3)
		end)
		local vectorValue = 0
		local hasVector = 0

		if vectorOk and vector ~= nil then
			vectorValue = vector.X * 31 + vector.Y * 17 + vector.Z * 13
			hasVector = 1
		end

		local modulus = 2147483647
		local seed = 1273961148 % modulus
		seed = (seed * 48271 + lineFlag + 81) % modulus
		seed = (seed * 48271 + 82) % modulus
		seed = (seed * 48271 + vectorValue + 81) % modulus

		if seed == 0 then
			seed = 1
		end

		return seed, line, vectorValue, hasVector
	end

	local function checkDebug()
		local issues = 0
		local uncertain = 0
		local passes = 0
		local badStack = false
		local debugLib = debug and type(debug) == type({}) and debug or nil
		local info = debugLib and debugLib.info or nil
		local traceback = debugLib and debugLib.traceback or nil
		local stringLib = string and type(string) == type({}) and string or nil
		local match = stringLib and stringLib.match or nil

		if info and traceback and match then
			local function checkNative(value)
				local ok, source = pcall(function()
					return info(value, "s")
				end)

				if ok and source == "[C]" then
					passes = passes + 1
				else
					issues = issues + 1
				end
			end

			local function checkPattern(text, pattern, expected)
				local ok, result = pcall(function()
					return match(text, pattern)
				end)

				if ok and result == expected then
					passes = passes + 1
				else
					issues = issues + 1
				end
			end

			checkNative(info)
			checkNative(traceback)

			local luaFunction = function()
				return 1
			end
			local lineOk, line = pcall(function()
				return info(luaFunction, "l")
			end)

			if lineOk and type(line) == "number" then
				passes = passes + 1
			else
				uncertain = uncertain + 1
			end

			checkNative(pcall)
			checkNative(match)

			local rawOk, rawError = pcall(rawget)

			if rawOk then
				issues = issues + 1
			elseif type(rawError) == "string" then
				if match(rawError, "^[^:]+:%d+:") then
					issues = issues + 1
				end

				if match(rawError, "missing argument") or match(rawError, "bad argument") then
					passes = passes + 1
				else
					issues = issues + 1
				end
			else
				issues = issues + 1
			end

			local marker = "rwr8f:153:oesr3c"
			checkPattern(marker, "^[^:]+:(%d+):", "153")
			checkPattern("98475:-37:oesr3c", ".*:%s*(%-%d+):%s", "-37")
			checkPattern("oejn5:oesr3c", "^[^:]+:([a-z0-9]+)$", "oesr3c")
			checkPattern("oejn5:oesr3c", "^__no_match__$", nil)

			if readErrorLine(marker) == 153 then
				passes = passes + 1
			else
				issues = issues + 1
				badStack = true
			end

			if passes >= 5 then
				local frameOk, source = pcall(function()
					return info(4, "s")
				end)

				if frameOk and source == "[C]" then
					issues = issues + 1
					badStack = true
				elseif frameOk and source ~= nil then
					uncertain = uncertain + 1
				end
			end

			local expectedFrames = 11
			local traceOk, trace = pcall(traceback)

			if traceOk and type(trace) == "string" then
				local lines = 1

				for cursor = 1, #trace do
					if string.byte(trace, cursor) == 10 then
						lines = lines + 1
					end
				end

				expectedFrames = lines + 5
			end

			local countOk, frameCount = pcall(function()
				local count = 0

				for level = 1, 24 do
					local ok, source = pcall(function()
						return info(level, "s")
					end)

					if not ok or source == nil then
						break
					end

					count = count + 1
				end

				return count
			end)

			if countOk and type(frameCount) == "number" and frameCount > expectedFrames then
				issues = issues + 1
				badStack = true
			end
		else
			issues = issues + 1
		end

		if info and traceback then
			local hits = { 0, 0, 0, 0, 0 }
			local crossHits = 0

			local function sample(wrapper)
				wrapper(function()
					local ok3, source3 = pcall(function()
						return info(3, "s")
					end)
					local ok4, source4 = pcall(function()
						return info(4, "s")
					end)
					local ok6, source6 = pcall(function()
						return info(6, "s")
					end)
					local ok8, source8 = pcall(function()
						return info(8, "s")
					end)
					local ok11, source11 = pcall(function()
						return info(11, "s")
					end)

					if ok3 and source3 == "[C]" then
						hits[1] = hits[1] + 1
					end
					if ok4 and source4 == "[C]" then
						hits[2] = hits[2] + 1
					end
					if ok6 and source6 == "[C]" then
						hits[3] = hits[3] + 1
					end
					if ok8 and source8 == "[C]" then
						hits[4] = hits[4] + 1
					end
					if ok11 and source11 == "[C]" then
						hits[5] = hits[5] + 1
					end

					if ok11 and source11 ~= nil then
						if ok4 and source4 == "[C]" then
							crossHits = crossHits + 1
						end
						if ok6 and source6 == "[C]" then
							crossHits = crossHits + 1
						end
						if ok8 and source8 == "[C]" then
							crossHits = crossHits + 1
						end
					end
				end)
			end

			local function direct(callback)
				callback()
			end

			local function nested(callback)
				local function first()
					local function second()
						local function third()
							callback()
						end

						third()
					end

					second()
				end

				first()
			end

			local function threaded(callback)
				local create = coroutine and coroutine.create or nil
				local resume = coroutine and coroutine.resume or nil

				if create and resume then
					local thread = create(function()
						callback()
					end)
					resume(thread)
				else
					callback()
				end
			end

			sample(direct)
			sample(nested)
			sample(threaded)

			local repeated = 0

			for index = 1, #hits do
				if hits[index] >= 2 then
					repeated = repeated + 1
				end
			end

			if repeated >= 1 then
				issues = issues + 1
				badStack = true
			elseif crossHits >= 2 then
				uncertain = uncertain + 1
			end

			if repeated * 2 + crossHits > 0 then
				badStack = true
			end
		end

		if badStack or (issues >= 2 and passes >= 4) or (uncertain >= 2 and passes >= 5) then
			abort()
		end
	end

	local function restoreBuiltins()
		local call = pcall
		local read = rawget
		local getGlobalEnv = getgenv

		if not call or not read or not getGlobalEnv then
			return
		end

		local ok, env = call(getGlobalEnv)

		if not ok or type(env) ~= "table" then
			return
		end

		local restore = read(env, "restorefunction")

		if type(restore) ~= "function" then
			return
		end

		local function restoreOne(value)
			if value then
				call(restore, value)
			end
		end

		restoreOne(string and string.byte)
		restoreOne(setmetatable)
		restoreOne(pcall)
		restoreOne(rawget)
		restoreOne(rawset)
		restoreOne(pairs)
		restoreOne(type)
		restoreOne(getfenv)
		restoreOne(setfenv)
	end

	checkRoblox()
	checkDebug()
	restoreBuiltins()
	makeSeed()
end

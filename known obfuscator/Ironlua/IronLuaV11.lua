-- Anti Tamper From IronLua V11
local isSafe = true
local securityReason = ""

local isRobloxEnvironment = game ~= nil and typeof ~= nil

local function verifyGetfenvHook()
    if getfenv ~= nil then
        local getfenvType = type(getfenv)
        if getfenvType ~= "function" then
            isSafe = false
            securityReason = "getfenv is not a function â€” it's a " .. getfenvType .. " (spoofed)"
            return
        end

        local success, environmentTable = pcall(getfenv, 0)
        if not success then
            isSafe = false
            securityReason = "getfenv(0) threw an error â€” likely hooked"
            return
        end

        if isRobloxEnvironment then
            if environmentTable.game == nil or environmentTable.workspace == nil then
                isSafe = false
                securityReason = "Roblox environment missing core globals â€” possibly spoofed"
                return
            end
            
            if environmentTable.getfenv ~= getfenv then
                isSafe = false
                securityReason = "getfenv function was replaced in environment"
                return
            end
        else
            if environmentTable ~= _G then
                isSafe = false
                securityReason = "getfenv(0) returned a different table than _G â€” environment proxied/sandboxed"
                return
            end
        end

        local successLevelOne, environmentLevelOne = pcall(getfenv, 1)
        if successLevelOne then
            if isRobloxEnvironment then
                if type(environmentLevelOne) ~= "table" then
                    isSafe = false
                    securityReason = "getfenv(1) didn't return a table"
                    return
                end
            else
                if environmentLevelOne ~= _G then
                    isSafe = false
                    securityReason = "getfenv(1) returned a sandboxed environment â€” injection detected"
                    return
                end
            end
        end
    end
end

local function verifyEnvironmentProxy()
    local metatable = getmetatable(_G)
    if metatable ~= nil then
        if isRobloxEnvironment then
            local testSuccess = pcall(function()
                local oldWriteCheck = _G._TEST_WRITE_CHECK
                _G._TEST_WRITE_CHECK = true
                _G._TEST_WRITE_CHECK = oldWriteCheck
            end)
            if testSuccess then
                return
            end
        end
        
        isSafe = false
        securityReason = "_G has a suspicious metatable â€” environment is proxied"
        return
    end
end

local function verifyEnvironmentLeak()
    local suspiciousKeys = {
        "fenv", "env", "_fenv", "__fenv",
        "genv", "globalenv", "_env", "rawenv",
        "hookenv", "scriptenv"
    }
    for _, key in ipairs(suspiciousKeys) do
        if rawget(_G, key) ~= nil then
            isSafe = false
            securityReason = "Suspicious environment variable found in _G: '" .. key .. "'"
            return
        end
    end
end

local function verifyBytecodeIntegrity()
    if string and string.dump then
        local success, dumpedBytecode = pcall(string.dump, verifyBytecodeIntegrity)
        if not success then
            if not isRobloxEnvironment then
                isSafe = false
                securityReason = "string.dump failed â€” bytecode may be obfuscated or hooked"
            end
            return
        end
        
        if type(dumpedBytecode) == "string" and #dumpedBytecode < 10 then
            isSafe = false
            securityReason = "Bytecode dump suspiciously small â€” possible hook"
            return
        end
    end
end

local function verifySetfenvSwap()
    if setfenv and getfenv then
        local success, functionEnv = pcall(getfenv, verifySetfenvSwap)
        if success then
            if isRobloxEnvironment then
                if type(functionEnv) ~= "table" then
                    isSafe = false
                    securityReason = "Function environment is not a table"
                    return
                end
            else
                if functionEnv ~= _G then
                    isSafe = false
                    securityReason = "setfenv was used to swap this function's environment"
                    return
                end
            end
        end
    end
end

local function verifyDebugUpvalueInjection()
    if debug and debug.getupvalue then
        local index = 1
        local maxIterations = 1
        while index <= maxIterations do
            local success, name, value = pcall(debug.getupvalue, verifyDebugUpvalueInjection, index)
            if not success or name == nil then break end
            
            if name == "isSafe" and value == false then
                securityReason = "Upvalue 'isSafe' was set to false externally before check"
            end
            index = index + 1
        end
    end
end

local function executeSecurityChecks()
    verifyGetfenvHook()
    if isSafe then verifyEnvironmentProxy() end
    if isSafe then verifyEnvironmentLeak() end
    if isSafe then verifyBytecodeIntegrity() end
    if isSafe then verifySetfenvSwap() end
    if isSafe then verifyDebugUpvalueInjection() end

    if not isSafe then
        error("\n\n" ..
            "â•”â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•—\n" ..
            "â•‘        â›”  INJECTION DETECTED  â›”        â•‘\n" ..
            "â• â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•£\n" ..
            "â•‘  Reason: " .. securityReason .. string.rep(" ", math.max(0, 32 - #securityReason)) .. "â•‘\n" ..
            "â•‘  Script execution has been halted.       â•‘\n" ..
            "â•šâ•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•\n",
        0)
    else
        print("[Security] âœ… Environment clean â€” no injection detected.")
    end
end

executeSecurityChecks()
print("Script Pass p1.")

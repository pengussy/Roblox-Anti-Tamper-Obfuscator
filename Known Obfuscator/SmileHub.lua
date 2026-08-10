-- Smile Hub Obfuscator Anti Tamper

local rawGet = rawget
local setMetatable = setmetatable
local getMetatable = getmetatable
local rawEqual = rawequal
local pCall = pcall
local toString = tostring
local bitOperations = bit32
local stringLib = string
local mathLib = math
local tableLib = table
local typeOf = type
local setFEnv = setfenv
local getFEnv = getfenv
local loadString = loadstring
local ipairsFunc = ipairs
local selectFunc = select
local rawLen = rawlen
local typeOfInstance = typeof
local debugLib = debug
local dummyString = 'mmmmm'
local identityFunc = (function(value) return value + 0 end)(1)
local floorValueA = mathLib.floor(373.0)
local floorValueB = mathLib.floor(283.0)
local constantValue = 5639
local xorValue = bitOperations.bxor(57, 17)
local mmmString = 'mmm'
local floorValueC = mathLib.floor(879.0)
local xorData = {179, 177, 170, 181, 162, 183, 166, 172, 161, 165}
local decodedData = {}

for index = 1, #xorData do
    decodedData[index] = stringLib.char(bitOperations.bxor(xorData[index], 195))
end

local waterMark = tableLib.concat(decodedData)

local function getObfuscatedKeyA()
    local data = {43, 206, 106, 103, 231, 224, 160, 98, 52, 92, 216, 115, 196, 179, 253, 170, 29, 114, 165, 83, 131, 7, 122, 41, 127, 160, 46, 50, 83, 14, 62, 113, 151, 108, 149, 244, 201, 159, 144}
    local key = {220, 229, 160, 45, 109, 139, 137, 97}
    local state = {}
    for i = 0, 255 do
        state[i] = i
    end
    local j = 0
    for i = 0, 255 do
        j = (j + state[i] + key[(i % #key) + 1]) % 256
        state[i], state[j] = state[j], state[i]
    end
    local i = 0
    local k = 0
    local result = {}
    for index = 1, #data do
        i = (i + 1) % 256
        k = (k + state[i]) % 256
        state[i], state[k] = state[k], state[i]
        result[index] = bitOperations.bxor(data[index], state[(state[i] + state[k]) % 256])
    end
    return result
end

local function getObfuscatedKeyB()
    local data = {154, 38, 169, 206, 15, 143, 226, 175, 36, 63, 169, 104, 90, 100, 120, 171, 251, 56, 76, 60, 128, 19, 41, 27, 64, 72, 149, 109, 190, 58, 81, 86}
    local key = {163, 16, 190, 199, 228, 253, 73, 39}
    local state = {}
    for i = 0, 255 do
        state[i] = i
    end
    local j = 0
    for i = 0, 255 do
        j = (j + state[i] + key[(i % #key) + 1]) % 256
        state[i], state[j] = state[j], state[i]
    end
    local i = 0
    local k = 0
    local result = {}
    for index = 1, #data do
        i = (i + 1) % 256
        k = (k + state[i]) % 256
        state[i], state[k] = state[k], state[i]
        result[index] = bitOperations.bxor(data[index], state[(state[i] + state[k]) % 256])
    end
    return result
end

local checkIO = (rawGet(_G, 'io') == nil and mathLib.floor(210.0) or 0)
local checkDump = (rawGet(stringLib, 'dump') == nil and (function() return 39 end)() or 0)
local checkNewProxy = (typeOf(rawGet(_G, 'newproxy')) == 'function' and (bitOperations.bxor(177, 0xA5)) or 0)
local className = (function() local success, value = pCall(function() return typeOf(rawGet(game, 'ClassName')) end) return success and value or '' end)()
local stringCheck = (className == 'string' and (function() return 151 end)() or 0)
local instanceTableCheck = (typeOf(rawGet(_G, 'Instance')) == 'table' and mathLib.floor(183.0) or 0)
local timeNow = (function() local success, value = pCall(function() return os.time() end) return success and (value or 0) or 0 end)()
local timeCheck = (timeNow > 1700000000 and (function() return 23 end)() or 0)
local builtInsCheck = (rawGet(_G, '__builtins__') == nil and rawGet(_G, '__name__') == nil and (50 + 134) or 0)
local utf8Check = (typeOf(rawGet(_G, 'utf8')) == 'table' and (73 + 138) or 0)
local pCallCheck = (rawEqual(pCall, pcall) and (bitOperations.bxor(242, 0xA5)) or 0)
local toStringCheck = (rawEqual(toString, tostring) and (bitOperations.bxor(5, 0xA5)) or 0)
local ipairsCheck = (rawEqual(ipairsFunc, ipairs) and (bitOperations.bxor(35, 0xA5)) or 0)
local selectCheck = (rawEqual(selectFunc, select) and mathLib.floor(37.0) or 0)
local rawGetCheck = (rawEqual(rawGet, rawget) and (function() return 50 end)() or 0)
local setMetaCheck = (rawEqual(setMetatable, setmetatable) and (bitOperations.bxor(163, 0xA5)) or 0)
local gameCheck = (typeOf(game) == 'userdata' and (bitOperations.bxor(44, 0xA5)) or 0)
local workspaceCheck = (typeOf(workspace) == 'userdata' and mathLib.floor(98.0) or 0)
local instanceCheck = ((typeOfInstance and typeOfInstance(game) == 'Instance') and (bitOperations.bxor(235, 0xA5)) or 0)
local tickNow = (function() local success, value = pCall(tick) return success and (value or 0) or 0 end)()
local tickCheck = (tickNow > 1000000000 and mathLib.floor(121.0) or 0)
local clockNow = (function() local success, value = pCall(os.clock) return success and (value or -1) or -1 end)()
local clockCheck = (clockNow >= 0 and (2 + 91) or 0)
local floatHugeCheck = (mathLib.huge > mathLib.floor(mathLib.huge - 1) and (function() return 137 end)() or 0)
local xorIdentityCheck = (bitOperations.bxor(57005, 57005) == 0 and (function() return 134 end)() or 0)
local bitMaskCheck = (bitOperations.band(255, 15) == 15 and (function() return 197 end)() or 0)
local floorMathCheck = (mathLib.floor(1.9) == 1 and (37 + 7) or 0)
local stringByteCheck = (stringLib.byte('A') == 65 and (function() return 205 end)() or 0)
local coroutineCheck = (typeOf(coroutine.wrap) == 'function' and (98 + 45) or 0)
local formatCheck = (stringLib.format('%d', 1) == '1' and (99 + 136) or 0)
local typeOfCheck = (typeOf(typeOfInstance) == 'function' and mathLib.floor(16.0) or 0)
local enumCheck = (typeOf(rawGet(_G, 'Enum')) == 'userdata' and (98 + 59) or 0)
local getGEnvCheck = (typeOf(rawGet(_G, 'getgenv')) == 'function' and (bitOperations.bxor(213, 0xA5)) or 0)
local getFEnvCheck = (typeOf(rawGet(_G, 'getfenv')) == 'function' and (function() return 101 end)() or 0)
local setFEnvCheck = (typeOf(rawGet(_G, 'setfenv')) == 'function' and (102 + 21) or 0)
local traceBackCheck = (typeOf(debugLib and debugLib.traceback) == 'function' and (function() return 22 end)() or 0)

local function bxorAll(...)
    local args = {...}
    local result = 0
    for i = 1, #args do
        result = bitOperations.bxor(result, args[i])
    end
    return result
end

local totalVerificationSum = bxorAll(
    checkIO, checkDump, checkNewProxy, stringCheck, instanceTableCheck, timeCheck,
    builtInsCheck, utf8Check, pCallCheck, toStringCheck, ipairsCheck, selectCheck,
    rawGetCheck, setMetaCheck, gameCheck, workspaceCheck, instanceCheck, tickCheck,
    clockCheck, floatHugeCheck, xorIdentityCheck, bitMaskCheck, floorMathCheck,
    stringByteCheck, coroutineCheck, formatCheck, typeOfCheck, enumCheck,
    getGEnvCheck, getFEnvCheck, setFEnvCheck, traceBackCheck
)

local keySegmentA = {126, 75, 15, 46, 32, 86, 150, 30}
local keySegmentB = {219, 247, 252, 32, 229, 228, 164, 114}
local keySegmentC = {109, 23, 207, 251, 156, 78, 77, 250}
local keySegmentD = {93, 243, 173, 146, 58, 119, 204, 87}
local baseValueA = (39 + 113)
local baseValueB = (function() return 86 end)()
local baseValueC = (50 + 33)
local baseValueD = (function() return 99 end)()
local transformedKeyA = bitOperations.bxor(baseValueA, (totalVerificationSum == 230 and (function() return 37 end)() or 0))
local transformedKeyB = bitOperations.bxor(baseValueB, (totalVerificationSum == 230 and (bitOperations.bxor(232, 0xA5)) or 0))
local transformedKeyC = bitOperations.bxor(baseValueC, (totalVerificationSum == 230 and (18 + 82) or 0))
local transformedKeyD = bitOperations.bxor(baseValueD, (totalVerificationSum == 230 and (function() return 94 end)() or 0))
local finalKey = {}

for i = 1, 32 do
    local offset = (i - 1) % 4 + 1
    if offset == 1 then finalKey[i] = bitOperations.bxor(keySegmentA[((i - 1) // 4) + 1], transformedKeyA) end
    if offset == 2 then finalKey[i] = bitOperations.bxor(keySegmentB[((i - 1) // 4) + 1], transformedKeyB) end
    if offset == 3 then finalKey[i] = bitOperations.bxor(keySegmentC[((i - 1) // 4) + 1], transformedKeyC) end
    if offset == 4 then finalKey[i] = bitOperations.bxor(keySegmentD[((i - 1) // 4) + 1], transformedKeyD) end
end

local encryptedData = {241, 56, 14, 208, 220, 59, 227, 115, 188, 61, 136}
local dataIndexTable = {1}
local masterData = {encryptedData}
local processedData = {}
local counter = 0

for i = 1, 1 do
    local index = dataIndexTable[i]
    local target = masterData[index]
    local xorKey = ((index - 1) * 13 + 19) % 256
    for j = 1, #target do
        counter = counter + 1
        processedData[counter] = bitOperations.bxor(target[j], xorKey)
    end
end

local function decryptStream(data, key)
    local stream = {}
    for i = 0, 255 do
        stream[i] = i
    end
    local j = 0
    for i = 0, 255 do
        j = (j + stream[i] + key[(i % #key) + 1]) % 256
        stream[i], stream[j] = stream[j], stream[i]
    end
    local i = 0
    local k = 0
    local decrypted = {}
    for index = 1, #data do
        i = (i + 1) % 256
        k = (k + stream[i]) % 256
        stream[i], stream[k] = stream[k], stream[i]
        decrypted[index] = bitOperations.bxor(data[index], stream[(stream[i] + stream[k]) % 256])
    end
    return decrypted
end

if totalVerificationSum == 230 then
    local decryptedBytes = decryptStream(processedData, finalKey)
    for i = 1, #finalKey do
        finalKey[i] = 0
    end
    local partA = {}
    for i = 1, mathLib.min((210 + 174), #decryptedBytes) do
        partA[i] = stringLib.char(decryptedBytes[i])
    end
    local partB = {}
    for i = mathLib.min((335 + 49), #decryptedBytes) + 1, #decryptedBytes do
        partB[i - mathLib.min((bitOperations.bxor(293, 0xA5)), #decryptedBytes)] = stringLib.char(decryptedBytes[i])
    end
    local finalScript = tableLib.concat(partA) .. tableLib.concat(partB)
    local loadedFunc, errorMsg = loadString(finalScript)
    if loadedFunc then
        setFEnv(loadedFunc, getFEnv())
        pCall(loadedFunc)
    end
else
    local msg = 'ðŸ’’ nice try lil bro | $mile Hub'
    pCall(print, msg)
    pCall(warn, msg)
    pCall(print, stringLib.rep('-', 40))
end

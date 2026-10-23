local pcall0 = pcall -- fully by me pengu ts is v0.6.5
local getmetatable0 = getmetatable -- renamed by AI for better name
local setmetatable0 = setmetatable
local tostring0 = tostring
local tonumber0 = tonumber
local type0 = type
local ipairs0 = ipairs
local tableInsert = table.insert
local stringSub = string.sub
local stringByte = string.byte
local stringGsub = string.gsub
local stringLen = string.len
local mathRandom = math.random
local debugLibrary = debug
local debugInfo = debugLibrary and debugLibrary.info
local debugTraceback = debugLibrary and debugLibrary.traceback
local nativeMarker = "[C]"
local expectedSubError = "invalid argument #2 to 'sub' (number expected, got function)"
local digits = {
    [0] = true,
    [1] = true,
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true
}
local function trap()
    while true do
    end
end
local function extractNumbers(text)
    local result = {}
    local afterColon = false
    local inNumber = false
    local numberStart = 1
    for index = 1, #text do
        local character = stringSub(text, index, index)
        if stringByte(character) == 58 and not afterColon then
            afterColon = true
            inNumber = false
        end
        if afterColon then
            local isDigit = digits[tonumber0(character)]
            if isDigit then
                if not inNumber then
                    inNumber = true
                    numberStart = index
                end
            elseif inNumber then
                local raw = stringSub(text, numberStart, index - 1)
                tableInsert(result, tonumber0(raw) or raw)
                afterColon = false
            end
        end
    end
    return result
end
local function subProbe(first, second)
    return stringSub("", first, second)
end
local function maximumNumber(values)
    local maximum = 1
    for _, value in ipairs0(values) do
        local number = tonumber0(value)
        if number and maximum < number then
            maximum = tonumber0(value)
        end
    end
    return maximum
end
local function descriptor(target)
    local source, line, name, _, _, fn = debugInfo(target, "slnaf")
    return setmetatable0({}, {
        __id = function()
            return {
                what = source,
                source = line,
                name = name,
                ["function"] = fn
            }
        end
    })
end
local function descriptorData(target)
    local object = descriptor(target)
    local metadata = getmetatable0(object)
    if not metadata or type0(metadata.__id) ~= "function" then
        return nil
    end
    return metadata.__id()
end
local function nativeFunctionIsValid(target)
    local information = descriptorData(target)
    return type0(information) == "table"
        and information.what == nativeMarker
        and information["function"] == target
        and type0(information.name) == "string"
        and stringLen(information.name) > 1
end
local function lineGate(traceMaximum, maximumLines, token, errorMaximum)
    if traceMaximum < maximumLines then
        return token
    end
    if errorMaximum < maximumLines then
        return token
    end
    return tostring0(mathRandom(-10000, -100))
end
local function verify(configObject)
    if type0(pcall0) ~= "function"
        or type0(getmetatable0) ~= "function"
        or type0(setmetatable0) ~= "function"
        or type0(tostring0) ~= "function"
        or type0(debugInfo) ~= "function"
        or type0(debugTraceback) ~= "function"
        or type0(stringSub) ~= "function"
        or type0(stringGsub) ~= "function"
        or type0(stringLen) ~= "function" then
        return nil
    end
    local config = getmetatable0(configObject)
    if type0(config) ~= "table"
        or type0(config.__xml) ~= "string"
        or type0(config.__maxlines) ~= "number" then
        return nil
    end
    local tracebackText = debugTraceback("", 2)
    local probeSucceeded, probeError = pcall0(subProbe, debugLibrary, {})
    if probeSucceeded or not probeError then
        return nil
    end
    local errorText = tostring0(probeError)
    local normalized = stringGsub(errorText, expectedSubError, "::")
    if not normalized then
        return nil
    end
    local traceMaximum = maximumNumber(extractNumbers(tracebackText))
    local errorMaximum = maximumNumber(extractNumbers(errorText))
    local gateToken = tostring0(mathRandom(1, 1000))
    local gateSucceeded, gateResult = pcall0(
        lineGate,
        traceMaximum,
        config.__maxlines,
        gateToken,
        errorMaximum
    )
    if not gateSucceeded or gateResult ~= gateToken then
        return nil
    end
    local protectedFunctions = {
        stringGsub,
        debugInfo,
        debugTraceback,
        setmetatable0,
        pcall0
    }
    for _, protectedFunction in ipairs0(protectedFunctions) do
        if not nativeFunctionIsValid(protectedFunction) then
            return nil
        end
    end
    return config.__xml
end
local token = tostring0(mathRandom(100, 10000))
local result = verify(setmetatable0({}, {
    __maxlines = 275,
    __xml = token,
    lrm = 0,
    lrm1 = 1,
    olm = 1,
    oml = 0,
    fml = 1,
    etl = 1
}))
if result ~= token then
    trap()
end
local rawsetInformation = descriptorData(rawset)
if not rawsetInformation or rawsetInformation.what ~= nativeMarker then
    trap()
end

-- lph v15 anti tamper I think ts is replica only 
-- I get from R3E and ts might false positive
local failures = {}
local passed = 0

local function fail(message)
    error(tostring(message), 0)
end

local function expect(condition, message)
    if not condition then
        fail(message)
    end
end

local function exact(label, actual, expected)
    if actual ~= expected then
        fail(string.format("%s: expected %.17g, got %.17g", label, expected, actual))
    end
end

local function exactUDim2(label, actual, xScale, xOffset, yScale, yOffset)
    exact(label .. ".X.Scale", actual.X.Scale, xScale)
    exact(label .. ".X.Offset", actual.X.Offset, xOffset)
    exact(label .. ".Y.Scale", actual.Y.Scale, yScale)
    exact(label .. ".Y.Offset", actual.Y.Offset, yOffset)
end

local function exactVector2(label, actual, x, y)
    exact(label .. ".X", actual.X, x)
    exact(label .. ".Y", actual.Y, y)
end

local function check(name, callback)
    local ok, result = xpcall(callback, function(message)
        return tostring(message)
    end)

    if ok then
        passed += 1
    else
        table.insert(failures, name .. ": " .. result)
    end
end

local function checkCMetadata(label, callback, expectedName)
    local source, line, name, argumentCount, isVariadic, identity = debug.info(callback, "slnaf")
    expect(source == "[C]", label .. " source was " .. tostring(source))
    expect(line == -1, label .. " line was " .. tostring(line))
    expect(name == expectedName, label .. " name was " .. tostring(name))
    expect(argumentCount == 0, label .. " argument count was " .. tostring(argumentCount))
    expect(isVariadic == true, label .. " was not variadic")
    expect(rawequal(identity, callback), label .. " function identity changed")
end

check("core globals", function()
    expect(type(game) == "userdata", "game is not userdata")
    expect(type(workspace) == "userdata", "workspace is not userdata")
    expect(rawequal(game:GetService("Workspace"), workspace), "Workspace identity split")
    expect(type(Instance) == "table" and type(Instance.new) == "function", "Instance.new missing")
    expect(type(task) == "table", "task missing")
    expect(type(buffer) == "table", "buffer missing")
    expect(type(debug) == "table" and type(debug.info) == "function", "debug.info missing")
end)

check("loader language semantics", function()
    for _, callback in {
        assert, error, getmetatable, ipairs, next, pairs, pcall, rawequal, rawget, rawset, select, setmetatable,
        tonumber, tostring, type, typeof, xpcall,
    } do
        expect(type(callback) == "function", "core callback missing")
    end
    for _, name in { "create", "pack", "unpack", "move", "freeze", "isfrozen", "clear", "clone" } do
        expect(type(table[name]) == "function", "table." .. name .. " missing")
    end
    for _, name in { "byte", "char", "find", "format", "gmatch", "gsub", "len", "lower", "match", "rep", "reverse", "sub", "upper" } do
        expect(type(string[name]) == "function", "string." .. name .. " missing")
    end
    for _, name in { "band", "bnot", "bor", "bxor", "lshift", "rshift", "arshift", "extract", "replace" } do
        expect(type(bit32[name]) == "function", "bit32." .. name .. " missing")
    end

    local protected, first, second, third = pcall(function()
        return 17, nil, 29
    end)
    expect(protected and first == 17 and second == nil and third == 29, "pcall return pack mismatch")
    local xprotected, transformed = xpcall(function()
        error("anti-env-sentinel", 0)
    end, function(message)
        return "caught:" .. tostring(message)
    end)
    expect(not xprotected and transformed == "caught:anti-env-sentinel", "xpcall handler mismatch")

    local packed = table.pack("a", nil, "c")
    expect(packed.n == 3 and packed[1] == "a" and packed[2] == nil and packed[3] == "c", "table.pack mismatch")
    local created = table.create(3, 7)
    expect(#created == 3 and created[1] == 7 and created[3] == 7, "table.create mismatch")
    expect(not pcall(table.create, -1), "negative table.create did not fail")
    local frozen = table.freeze({ marker = true })
    expect(table.isfrozen(frozen), "table.freeze did not freeze")
    expect(not pcall(function()
        frozen.marker = false
    end), "frozen table accepted a write")

    local substituted, replacements = string.gsub("u-v-w", "[uvw]", { u = "1", v = "2", w = "3" })
    expect(substituted == "1-2-3" and replacements == 3, "string.gsub table replacement mismatch")
    expect(bit32.bxor(0x12345678, 0xFFFFFFFF) == 0xEDCBA987, "bit32 operation mismatch")
    expect(rawequal(string.byte, ("A").byte), "primitive string method identity split")
    expect(tostring({}) ~= tostring({}), "distinct tables share a tostring identity")
end)

check("constructor metadata", function()
    checkCMetadata("UDim2.new", UDim2.new, "new")
    checkCMetadata("Instance.new", Instance.new, "new")
    checkCMetadata("Random.new", Random.new, "new")
end)

check("function environments", function()
    expect(type(getfenv) == "function", "getfenv missing")
    expect(type(setfenv) == "function", "setfenv missing")
    local globalEnvironment = getfenv(UDim2.new)
    expect(type(globalEnvironment) == "table", "C function environment missing")

    local changedC = pcall(setfenv, UDim2.new, {})
    expect(not changedC, "setfenv changed a C closure")

    local function localClosure()
        return true
    end
    local privateEnvironment = { marker = "private" }
    setfenv(localClosure, privateEnvironment)
    expect(rawequal(getfenv(localClosure), privateEnvironment), "Luau closure environment identity split")
end)

check("executor metatable boundary", function()
    local environment = if type(getgenv) == "function" then getgenv() else getfenv(0)
    local rawMetatable = rawget(environment, "getrawmetatable")
    if type(rawMetatable) ~= "function" then
        return
    end

    local metatable = rawMetatable(game)
    expect(type(metatable) == "table", "game raw metatable missing")
    expect(rawequal(metatable.__index(game, "Workspace"), workspace), "raw __index Workspace identity split")

    local isCClosure = rawget(environment, "iscclosure")
    if type(isCClosure) == "function" then
        expect(isCClosure(metatable.__index), "game __index is not a C closure")
        expect(isCClosure(metatable.__namecall), "game __namecall is not a C closure")
    end

    local getScriptClosure = rawget(environment, "getscriptclosure")
    if type(getScriptClosure) == "function" then
        local scriptObject = Instance.new("LocalScript")
        local result = getScriptClosure(scriptObject)
        scriptObject:Destroy()
        expect(result == nil, "fresh LocalScript unexpectedly has a script closure")
    end
end)

check("legacy scheduler surface", function()
    local environment = if type(getgenv) == "function" then getgenv() else getfenv(0)
    local legacyWait = rawget(environment, "wait")
    local legacySpawn = rawget(environment, "spawn")
    local legacyDelay = rawget(environment, "delay")
    local legacyDefer = rawget(environment, "defer")

    expect(type(legacyWait) == "function", "legacy wait missing")
    expect(type(legacySpawn) == "function", "legacy spawn missing")
    expect(type(legacyDelay) == "function", "legacy delay missing")
    expect(legacyDefer == nil, "legacy defer should be absent")
    expect(not rawequal(legacyWait, task.wait), "legacy wait aliases task.wait")
    expect(not rawequal(legacySpawn, task.spawn), "legacy spawn aliases task.spawn")
    expect(not rawequal(legacyDelay, task.delay), "legacy delay aliases task.delay")
end)

check("task closure metadata", function()
    checkCMetadata("task.spawn", task.spawn, "spawn")
    checkCMetadata("task.defer", task.defer, "defer")
    checkCMetadata("task.delay", task.delay, "delay")
    checkCMetadata("task.wait", task.wait, "wait")
    checkCMetadata("task.cancel", task.cancel, "cancel")
end)

check("buffer and coroutine surface", function()
    for _, name in {
        "create", "fromstring", "tostring", "len", "readu8", "readu16", "readi16", "readi32", "readu32",
        "readf32", "readf64", "readstring", "writeu8", "writeu16", "writei16", "writei32", "writeu32",
        "writef32", "writef64", "writestring", "fill", "copy",
    } do
        expect(type(buffer[name]) == "function", "buffer." .. name .. " missing")
    end

    for _, name in { "close", "isyieldable", "running", "status", "create", "resume", "yield" } do
        expect(type(coroutine[name]) == "function", "coroutine." .. name .. " missing")
    end

    local bytes = buffer.create(40)
    buffer.writeu8(bytes, 0, 0xFE)
    buffer.writeu16(bytes, 1, 0xBEEF)
    buffer.writei16(bytes, 3, -1234)
    buffer.writei32(bytes, 5, -123456789)
    buffer.writeu32(bytes, 9, 0x89ABCDEF)
    buffer.writef32(bytes, 13, 1.5)
    buffer.writef64(bytes, 17, math.pi)
    buffer.writestring(bytes, 25, "LPH}")
    expect(buffer.len(bytes) == 40, "buffer.len mismatch")
    expect(buffer.readu8(bytes, 0) == 0xFE, "buffer u8 mismatch")
    expect(buffer.readu16(bytes, 1) == 0xBEEF, "buffer u16 mismatch")
    expect(buffer.readi16(bytes, 3) == -1234, "buffer i16 mismatch")
    expect(buffer.readi32(bytes, 5) == -123456789, "buffer i32 mismatch")
    expect(buffer.readu32(bytes, 9) == 0x89ABCDEF, "buffer u32 mismatch")
    exact("buffer f32", buffer.readf32(bytes, 13), 1.5)
    exact("buffer f64", buffer.readf64(bytes, 17), math.pi)
    expect(buffer.readstring(bytes, 25, 4) == "LPH}", "buffer string mismatch")

    local source = buffer.fromstring("LPH}")
    local destination = buffer.create(4)
    buffer.copy(destination, 0, source, 0, 4)
    expect(buffer.tostring(destination) == "LPH}", "buffer.copy mismatch")
    buffer.fill(destination, 0, string.byte("A"), 4)
    expect(buffer.tostring(destination) == "AAAA", "buffer.fill mismatch")
end)

check("vector and Roblox datatype surface", function()
    expect(type(vector) == "table" and type(vector.create) == "function", "vector.create missing")
    local nativeVector = vector.create(1.25, -2.5, 3.75)
    expect(typeof(nativeVector) == "Vector3", "vector.create result type mismatch")
    exact("vector.x", nativeVector.x, 1.25)
    exact("vector.y", nativeVector.y, -2.5)
    exact("vector.z", nativeVector.z, 3.75)

    local vector2Value = Vector2.new(3, 4)
    local vector3Value = Vector3.new(1, 2, 3)
    exact("Vector2 magnitude", vector2Value.Magnitude, 5)
    exactVector2("Vector2 addition", vector2Value + Vector2.new(2, -1), 5, 3)
    expect(vector3Value.X == 1 and vector3Value.Y == 2 and vector3Value.Z == 3, "Vector3 components mismatch")
end)

check("Random deterministic stream", function()
    local random = Random.new(1515359100)
    local expected = {
        763,
        0.52705833430898807,
        0.44671507908619318,
        397,
        847,
        0.61786750792918488,
        788,
        81,
        0.37417195152223198,
        1008,
    }
    local actual = {
        random:NextInteger(532, 1117),
        random:NextNumber(),
        random:NextNumber(),
        random:NextInteger(299, 786),
        random:NextInteger(784, 1062),
        random:NextNumber(),
        random:NextInteger(695, 1094),
        random:NextInteger(30, 107),
        random:NextNumber(),
        random:NextInteger(999, 1013),
    }
    for index, expectedValue in expected do
        exact("Random[" .. index .. "]", actual[index], expectedValue)
    end

    local clone = random:Clone()
    exact("Random clone integer", clone:NextInteger(-1000000, 1000000), random:NextInteger(-1000000, 1000000))
    exact("Random clone number", clone:NextNumber(), random:NextNumber())
end)

check("signal and connection identity", function()
    local event = Instance.new("BindableEvent")
    local first = event.Event
    local second = event.Event
    expect(first == second, "repeated signal lookup lost semantic identity")
    expect(not rawequal(first, second), "repeated signal lookup reused raw userdata identity")
    expect(typeof(first) == "RBXScriptSignal", "signal typeof mismatch")

    local connection = first:Connect(function() end)
    expect(connection.Connected == true, "new connection is disconnected")
    local missingSelf = pcall(connection.Disconnect)
    expect(not missingSelf, "Disconnect accepted a missing receiver")
    expect(connection.Connected == true, "missing-receiver call changed connection state")
    connection:Disconnect()
    expect(connection.Connected == false, "Disconnect did not clear Connected")
    connection:Disconnect()
    event:Destroy()
end)

check("RunService context", function()
    local runService = game:GetService("RunService")
    checkCMetadata("RunService.IsStudio", runService.IsStudio, "IsStudio")
    checkCMetadata("RunService.IsClient", runService.IsClient, "IsClient")
    checkCMetadata("RunService.IsServer", runService.IsServer, "IsServer")
    local isStudio = runService:IsStudio()
    local isClient = runService:IsClient()
    local isServer = runService:IsServer()
    expect(type(isStudio) == "boolean", "IsStudio did not return boolean")
    expect(type(isClient) == "boolean", "IsClient did not return boolean")
    expect(type(isServer) == "boolean", "IsServer did not return boolean")
    expect(not (isClient and isServer), "runtime reports both client and server")
    expect(not pcall(runService.IsStudio), "IsStudio accepted dot-call without receiver")
    expect(not pcall(runService.IsClient), "IsClient accepted dot-call without receiver")
    expect(not pcall(runService.IsServer), "IsServer accepted dot-call without receiver")
end)

check("Enum behavior", function()
    local enumType = Enum.HumanoidStateType
    checkCMetadata("EnumType.FromName", enumType.FromName, "FromName")
    checkCMetadata("EnumType.FromValue", enumType.FromValue, "FromValue")
    expect(not rawequal(enumType.FromName, enumType.FromName), "FromName lookup should produce a fresh closure")
    expect(not rawequal(enumType.FromValue, enumType.FromValue), "FromValue lookup should produce a fresh closure")
    expect(enumType:FromName("X") == nil, "unknown Enum name did not return nil")
    expect(enumType:FromValue(0) == Enum.HumanoidStateType.FallingDown, "Enum value 0 mismatch")
    expect(typeof(Enum.HumanoidStateType.FallingDown) == "EnumItem", "Enum item typeof mismatch")
    expect(not pcall(enumType.FromName), "FromName accepted a missing receiver")
    expect(not pcall(enumType.FromValue), "FromValue accepted a missing receiver")
end)

check("Instance lifecycle", function()
    local folder = Instance.new("Folder")
    checkCMetadata("Instance.IsA", folder.IsA, "IsA")
    checkCMetadata("Instance.Destroy", folder.Destroy, "Destroy")
    checkCMetadata("Instance.GetChildren", folder.GetChildren, "GetChildren")
    checkCMetadata("DataModel.GetService", game.GetService, "GetService")
    folder.Name = "AntiEnvFolder"
    expect(folder:IsA("Folder"), "Folder:IsA('Folder') failed")
    expect(folder:IsA("Instance"), "Folder:IsA('Instance') failed")
    expect(not folder:IsA("Part"), "Folder:IsA('Part') succeeded")
    folder:SetAttribute("marker", 17)
    folder:Destroy()
    expect(folder.Parent == nil, "destroyed reference retained Parent")
    expect(folder.Name == "AntiEnvFolder", "destroyed reference lost Name")
    expect(folder:GetAttribute("marker") == 17, "destroyed reference lost attributes")
    expect(#folder:GetChildren() == 0, "destroyed reference returned children")
end)

check("Path2D release-729 precision", function()
    local holder = Instance.new("ScreenGui")
    holder.Name = "LuraphAntiEnvReplica"
    holder.Parent = game:GetService("StarterGui")
    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromOffset(100, 100)
    frame.Parent = holder
    local path = Instance.new("Path2D")
    path.Parent = frame
    local zero = UDim2.new()

    local ok, result = pcall(function()
        path:SetControlPoints({
            Path2DControlPoint.new(UDim2.new(0.125, -5, 0, -2), UDim2.new(0, 4, 0, 7), zero),
            Path2DControlPoint.new(UDim2.new(0, -9, 0.1875, 1), zero, UDim2.new(0, 7, 0, 6)),
            Path2DControlPoint.new(UDim2.new(0, 3, 0.25, -8), UDim2.new(0, 4, 0, -2), zero),
            Path2DControlPoint.new(UDim2.new(0, 0, 0, -1), UDim2.new(0, 5, 0, -7), zero),
            Path2DControlPoint.new(UDim2.new(0, -3, 0.25, -6), zero, zero),
        })
        return {
            length = path:GetLength(),
            tangent = path:GetTangentOnCurve(0.699999988079071),
            arcPositionA = path:GetPositionOnCurveArcLength(0.7142857313156128),
            arcPositionB = path:GetPositionOnCurveArcLength(0.8888888955116272),
            arcTangentA = path:GetTangentOnCurveArcLength(0.8666666746139526),
            arcTangentB = path:GetTangentOnCurveArcLength(0.6153846383094788),
            endpoint = path:GetPositionOnCurveArcLength(1),
        }
    end)

    holder:Destroy()
    expect(ok, result)
    exact("Path2D length", result.length, 86.37268829345703)
    exactVector2("Path2D tangent", result.tangent, -7.19999885559082, 1.1999969482421875)
    exactUDim2("Path2D arc A", result.arcPositionA, 0.030102645978331566, 0, -0.01087619736790657, 0)
    exactUDim2("Path2D arc B", result.arcPositionB, -0.015763826668262482, 0, 0.09509218484163284, 0)
    exactVector2("Path2D arc tangent A", result.arcTangentA, -3, 20)
    exactVector2("Path2D arc tangent B", result.arcTangentB, 0.8667373657226563, -35.676513671875)
    exactUDim2("Path2D endpoint wrap", result.endpoint, 0.07500000298023224, 0, -0.019999999552965164, 0)
end)

print(if #failures > 0 then "dtc" else "ud")

-- we use ultra pro Tools to get all anti tamper frm moonveil beta 2-0-15
-- by @pengu ~ @amxviolet0101
local type = type
local typeof = typeof
local pcall = pcall
local error = error
local tostring = tostring
local select = select
local string = string
local table = table
local bit32 = bit32
local debug = debug
local game = game
local Enum = Enum
local workspace = workspace
local byte = string.byte
local find = string.find
local gmatch = string.gmatch
local format = string.format
local rep = string.rep
local band = bit32.band
local bxor = bit32.bxor
local rshift = bit32.rshift
local lshift = bit32.lshift
local traceback = debug.traceback
local info = debug.info
local Antitamper = {} -- all hash below is different every build so u need to rewrite if u want use
local H_MAIN = "9df3b145489f87a5592d012156ad27fd" -- hash main proto 9
local N_FIND = "\x04\x76\x29\x21\x63\x1e\x2d\x6e\x0d" -- hash
local H_ENV1 = "0fd9a6cad3bdc28c34cd8c9344751429" -- hash
local H_ENV2 = "520783d8ead08f10518bbf11162ea711"
local H_MAT = "e6b71c737ced67367eda2a7a7326947e"
local H_P1B = "e4037fa157e6117fbd261eb7ea5d2cf6"
local H_P2A = "816f849d7386976393"
local H_P2B = "263d6833d0a4fb2aba60856562144cfa"
local H_P2C = "27760a02633d0e6e2e"
local H_P2D = "7f1f7fbdcc7d0d7fa1bd85abea41b76d"
local H_P3A = "ee65ddfa65dbdf69cacc"
local H_P3B = "3366e2b98bb1ee7130eade70774fc670"
local H_P3C = "7f6b525a7e65567376"
local H_P3D = "ae9ec98b2494b4f02055db2b5df86684"
local H_P5 = "f3f5d0d1efe4f0d2e5d4dad1edfbf4"
local H_P6 = "797127d3ca7b6327cfbb83c5b22fb16b"
local H_FONT_A = "98b7620d7c93193600a42a040d26ea00"
local H_FONT_B = "8195aca4809ba88d88"
local H_FONT_C = "d906e511bddbc3500d79f465125873a9"
local H_P8 = "21297f8b92233b7f97e3db9dea77e933"
local LINE_PAT = ":(%d*)\n"
local LINE_PAT_FALLBACK = ":(%d*)"
local PROTO10_KEY = "8c3faa453c567439e3c53e92" -- key
local sealed = {}
local tampered = false
local onTamper = nil
local silent = false
Antitamper.hashes = table.freeze({
    main = H_MAIN,
    findNeedle = N_FIND,
    env1 = H_ENV1,
    env2 = H_ENV2,
    material = table.freeze({ H_MAT, H_P1B }),
    font = table.freeze({ H_FONT_A, H_FONT_B, H_FONT_C }),
    proto2 = table.freeze({ H_P2A, H_P2B, H_P2C, H_P2D }),
    proto3 = table.freeze({ H_P3A, H_P3B, H_P3C, H_P3D }),
    proto5 = H_P5,
    proto6 = H_P6,
    proto8 = H_P8,
    proto10Key = PROTO10_KEY,
})
local function tohex(n: number, width: number): string
    local s = format("%x", band(n, 0xFFFFFFFF))
    if #s < width then
        s = rep("0", width - #s) .. s
    end
    return s
end
local function digest(s: string): string
    local h1 = 2166136261
    local h2 = 0x811C9DC5
    local h3 = 0xCBF29CE4
    local h4 = 0x84222325
    for i = 1, #s do
        local b = byte(s, i)
        h1 = band(bxor(h1, b) * 16777619, 0xFFFFFFFF)
        h2 = band(bxor(h2, b) * 0x01000193, 0xFFFFFFFF)
        h3 = bxor(h3, band(b * 0x45D9F3B + i, 0xFFFFFFFF))
        h3 = band(h3 * 0x45D9F3B, 0xFFFFFFFF)
        h4 = bxor(lshift(h4, 5), rshift(h4, 27))
        h4 = band(h4 + b + i, 0xFFFFFFFF)
    end
    return tohex(h1, 8) .. tohex(h2, 8) .. tohex(h3, 8) .. tohex(h4, 8)
end
local function fingerprint(fn: any): string
    local parts = table.create(8)
    local okS, src = pcall(info, fn, "s")
    local okL, line = pcall(info, fn, "l")
    local okN, name = pcall(info, fn, "n")
    local okA, nparam, vararg = pcall(info, fn, "a")
    parts[1] = tostring(type(fn))
    parts[2] = if okS then tostring(src) else "?"
    parts[3] = if okL then tostring(line) else "?"
    parts[4] = if okN then tostring(name) else "?"
    parts[5] = if okA then tostring(nparam) else "?"
    parts[6] = if okA then tostring(vararg) else "?"
    parts[7] = tostring(fn)
    return digest(table.concat(parts, "|"))
end
function Antitamper.configure(opts: { silent: boolean?, onTamper: ((string) -> ())? }?)
    if opts == nil then
        return
    end
    if opts.silent ~= nil then
        silent = opts.silent
    end
    if opts.onTamper ~= nil then
        onTamper = opts.onTamper
    end
end
function Antitamper.fail(reason: string?)
    tampered = true
    local msg = reason or "tamper"
    if onTamper then
        pcall(onTamper, msg)
    end
    if silent then
        return
    end
    error(msg, 2)
end
function Antitamper.isTampered(): boolean
    return tampered
end
function Antitamper.eq(got: string?, expected: string, reason: string?)
    if got ~= expected then
        Antitamper.fail(reason or "hash")
    end
end
function Antitamper.hash(s: string): string
    return digest(s)
end
function Antitamper.seal(fn: any): string
    if type(fn) ~= "function" then
        Antitamper.fail("seal")
    end
    local fp = fingerprint(fn)
    sealed[fn] = fp
    return fp
end
function Antitamper.verify(fn: any): boolean
    local expected = sealed[fn]
    if expected == nil then
        Antitamper.fail("unsealed")
        return false
    end
    if fingerprint(fn) ~= expected then
        Antitamper.fail("verify")
        return false
    end
    return true
end
function Antitamper.checkEnvironment()
    if type(bit32) ~= "table" or type(band) ~= "function" then
        Antitamper.fail("bit32")
    end
    if band(0xF0, 0x0F) ~= 0 or band(0xFF, 0x0F) ~= 0x0F then
        Antitamper.fail("band")
    end
    if type(debug) ~= "table" then
        Antitamper.fail("debug")
    end
    if type(traceback) ~= "function" or type(info) ~= "function" then
        Antitamper.fail("debugfn")
    end
    if type(gmatch) ~= "function" or type(find) ~= "function" then
        Antitamper.fail("string")
    end
    if type(byte) ~= "function" or type(string.sub) ~= "function" then
        Antitamper.fail("string2")
    end
    if type(pcall) ~= "function" then
        Antitamper.fail("pcall")
    end
    if type(type) ~= "function" then
        Antitamper.fail("type")
    end
    if select("#", pcall(function()
        return true
    end)) < 1 then
        Antitamper.fail("pcall2")
    end
end
function Antitamper.checkGlobals()
    if game == nil then
        Antitamper.fail("game")
    end
    if Enum == nil then
        Antitamper.fail("enum")
    end
    if typeof ~= nil and typeof(game) ~= "Instance" then
        Antitamper.fail("typeof_game")
    end
    if typeof ~= nil and typeof(Enum) ~= "Enums" then
        Antitamper.fail("typeof_enum")
    end
end
function Antitamper.checkGameSurface()
    if game.GetService == nil then
        Antitamper.fail("GetService")
    end
    local ok, ws = pcall(function()
        return game:GetService("Workspace")
    end)
    if not ok or ws == nil then
        Antitamper.fail("Workspace")
    end
    if workspace == nil then
        Antitamper.fail("workspace")
    end
    return game
end
function Antitamper.checkTraceback(): number
    local tb = traceback()
    if type(tb) ~= "string" or #tb == 0 then
        Antitamper.fail("traceback")
        return 0
    end
    local count = 0
    for _ in gmatch(tb, LINE_PAT) do
        count += 1
    end
    if count == 0 then
        for _ in gmatch(tb, LINE_PAT_FALLBACK) do
            count += 1
        end
    end
    if count == 0 then
        Antitamper.fail("lines")
    end
    return count
end
function Antitamper.checkInfo(fn: any): number?
    if type(fn) ~= "function" then
        Antitamper.fail("info_fn")
        return nil
    end
    local ok, line = pcall(info, fn, "l")
    if not ok then
        Antitamper.fail("info")
        return nil
    end
    return line
end
function Antitamper.checkFind(haystack: string): number?
    local ok, pos = pcall(find, haystack, N_FIND, 1, true)
    if not ok then
        Antitamper.fail("find")
        return nil
    end
    return pos
end
function Antitamper.checkMainHash(digestHex: string)
    Antitamper.eq(digestHex, H_MAIN, "main")
end
function Antitamper.checkNamed(holder: any, name: string): any
    if holder == nil then
        Antitamper.fail("holder")
        return nil
    end
    local value = holder[name]
    if value == nil then
        Antitamper.fail(name)
        return nil
    end
    return value
end
function Antitamper.checkMaterial(): any
    return Antitamper.checkNamed(Enum, "Material")
end
function Antitamper.checkFont(): any
    return Antitamper.checkNamed(Enum, "Font")
end
function Antitamper.pcallChild(fn: any): boolean
    if type(fn) ~= "function" then
        Antitamper.fail("child")
        return false
    end
    local ok = pcall(fn)
    if not ok then
        Antitamper.fail("child_fail")
        return false
    end
    return true
end
function Antitamper.protect<T...>(fn: (T...) -> ...any): (T...) -> ...any
    if type(fn) ~= "function" then
        Antitamper.fail("protect")
        return fn
    end
    Antitamper.seal(fn)
    return function(...)
        Antitamper.verify(fn)
        Antitamper.checkEnvironment()
        return fn(...)
    end
end
function Antitamper.run(): boolean
    Antitamper.checkEnvironment()
    Antitamper.checkGlobals()
    Antitamper.checkGameSurface()
    Antitamper.checkMaterial()
    Antitamper.checkFont()
    Antitamper.checkTraceback()
    Antitamper.checkInfo(Antitamper.run)
    Antitamper.pcallChild(function()
        local _ = band(1, 1)
    end)
    if sealed[Antitamper.run] then
        Antitamper.verify(Antitamper.run)
    else
        Antitamper.seal(Antitamper.run)
    end
    return not tampered
end
Antitamper.seal(Antitamper.run)
Antitamper.seal(Antitamper.checkEnvironment)
Antitamper.seal(Antitamper.fail) -- proto 9 is MAIN proto here might be different every build
return table.freeze(Antitamper) -- lmfao

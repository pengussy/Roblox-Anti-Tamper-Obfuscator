-- by Pengu / Penga @amxviolet0101 
local band, bxor, rshr = bit32.band, bit32.bxor, bit32.rshift

local function u32(v) return band(v, 0xFFFFFFFF) end
local function u16(v) return band(v, 0xFFFF) end

local env, fe
local ok, fev = pcall(function() if getfenv then return getfenv(0) end end)
if ok then fe = fev end
local ge
local gk = pcall(function() ge = getgenv end)
if gk and ge then
    local c, g = pcall(ge)
    if c and type(g) == "table" then env = g end
end
if not env and type(fe) == "table" then env = fe end
env = env or _G

local bg
if fe then
    bg = fe
else
    bg = { string = string, math = math, type = type, tostring = tostring, rawget = rawget, pcall = pcall, pairs = pairs, getmetatable = getmetatable, debug = debug }
end
if type(env) == "table" and bg ~= env and getmetatable(bg) == nil then
    pcall(function() setmetatable(bg, { __index = function(_, k) return env[k] end }) end)
end

local rd, sd = debug, {}
for _, f in ipairs({ "traceback", "profilebegin", "profileend", "setmemorycategory", "resetmemorycategory", "dumpcodesize", "getmetatable", "setmetatable" }) do
    if rd[f] then sd[f] = rd[f] end
end
if rd.setlocal then sd.setlocal = rd.setlocal end
if rd.getupvalue then sd.getupvalue = rd.getupvalue end
if rd.setupvalue then sd.setupvalue = rd.setupvalue end
pcall(function() rawset(env, "debug", sd) end)

local ch = {}
for i = 0, 255 do ch[i] = string.char(i) end

if ch[77] .. ch[108] .. ch[55] ~= "Ml7" then error("", 0) end
if ch[82] .. ch[106] .. ch[57] ~= "Rj9" then error("", 0) end
if type(type) ~= "function" then error("", 0) end
if #tostring(true) + #tostring(false) ~= 9 then error("", 0) end
if string.byte(tostring(true)) == string.byte(tostring(false)) then error("", 0) end

if (3095 * 2 + 1) % 2 == 0 then error(1) end
if 6177 * 707 / 707 > 6177 then error(2) end
if 88331 % 3220 >= 3220 then error(3) end
if (4260 * 2 + 1) % 2 == 0 then error(4) end
if 23736 % 6335 >= 6335 then error(5) end

local function hb(s)
    local t = {}
    do
        local h = 2665125564
        for i = 1, 6 do
            local g = s[i]
            h = (h * 1750009 + g[1] + 1) % 2^32
            h = (h * 1750009 + g[2] + 1) % 2^32
            h = (h * 1750009 + g[3] + 1) % 2^32
            h = (h * 1750009 + g[4] + 1) % 2^32
        end
        t[1] = h
    end
    do
        local h = 3992985600
        for i = 7, 12 do
            local g = s[i]
            h = (h * 1299721 + g[1] + 1) % 2^32
            h = (h * 1299721 + g[2] + 1) % 2^32
            h = (h * 1299721 + g[3] + 1) % 2^32
            h = (h * 1299721 + g[4] + 1) % 2^32
        end
        t[2] = h
    end
    local a = 356072198
    a = (a * 1390009 + t[1] + 1) % 2^32
    a = (a * 1390009 + t[2] + 1) % 2^32
    if a ~= 2482355392 then error("attempt to call a table value") end
end

local function hs(s)
    local v = 1787819906
    for i = 1, #s do
        local g = s[i]
        v = u32(v * 1390009 + (g[4] or 0) + 1)
        v = u32(v * 1390009 + (g[5] or 0) + 1)
        v = u32(v * 1390009 + (g[2] or 0) + 1)
        v = u32(v * 1390009 + (g[3] or 0) + 1)
    end
    return v
end

local function kw(q, x, h)
    return u32(u16(q) * 40503 + rshr(q, 16) * 59743 + u16(x) * 34981 + rshr(x, 16) * 61927 + u16(h) * 40503 + rshr(h, 16) * 59743 + 3237998080)
end

local sb = { 489295109,3677009531,2519381523,1546318967,489341858,3676995880,2519368056,1546297169,489347711,3676979318,2519351341,1546317940,489326377,3676996707,2519368951,1546282563,489308598,3676974904,2519347083,1546274734,489317569,3677007239,2519379215,1546303906,489335611,3676974699,2519346713,1546319733,489342789,3677011403,2519383299,1546258611,489339399,3677024078,2519396227,1546316794,489300236,3677010746,2519382970,1546266950,489306351,3677023425,2519395336,1546308702,489318600,3677017808,2519389773,1546275372,489296543,3677028037,2519400032,1546262193,489339932,3677001434,2519373354,1546257084,489346020,3677017994,2519390011,1546266309,489294693,3676993303,2519365605,1546314200,489331358,3676976494,2519348675,1546307805,489333794,3676987956,2519360048,1546288148,489343753,3676997155,2519369344,1546311905,489293438,3676999544,2519371560,1546306085,489312921,3677014617,2519386739,1546288409,489334223,3676994486,2519366646,1546296887,489350355,3676971666,2519343840,1546300591,489328780,3677007865,2519379924,1546306019,489343327,3676980610,2519352660,1546294248,489297906,3676983574,2519355750,1546285449,489292638,3679802843,2522174870,1549085432,492144451,3679824433,2522196504,1549081101,492160936,3679801089,2522173423,1549111667,492126845,3679833466,2522205531,1549089264,492167370,3679832983,2522205037,1549080686,492117333,3679813676,2522185893,1549091069,492133605,3679819121,2522191111,1549089299,492122770,3679840466,2522212508,1549092123,492125385,3679841423,2522213505,1549086750,492174259,3679796556,2522168604,1549100414,492166484,3679808771,2522181067,1549083199,492119288,3679796206,2522168144,1549100585,492155511,3679829124,2522201339,1549103316,492159865,3679813620,2522185493,1549096616,492154163,3679843175,2522215403,1549098552,492129527,3679838905,2522210963,1549137808,492144069,3679820691,2522192825,1549084524,492145781,3679812947,2522185065,1549121119,492171307,3679818457,2522190511,1549106402,492118384,3679793578,2522165696,1549122550,492172883,3679829772,2522202025,1549118551,492120428,3679807475,2522179333,1549083993,492151418,3679799947,2522171960,1549138396,492168068,3679799292,2522171257,1549131623,492164655,3679827125,2522199240,1549084748,492143434,3679801825,2522173766,1549122171,492157233,3679799413,2522171454,1549082698,492139224,3679842262,2522214223,1549098410,492110286,3679840981,2522213073,1549101704,492140466,3679816272,2522188526,1549135495,492156970,3679787833,2522159926,1549099457,492160683,3679785834,2522158014,1549097058,492173966,3679809941,2522181934,1549129051,492148981,3679816522,2522188560,1549124214,492111373,3679822776,2522194763,1549101906,492169096,3679784127,2522156192,1549122947,492141394,3679818999,2522190947,1549130707,492129675,3679784722,2522157041,1549104834 }

local function mx(x)
    return u32(u16(rshr(x, 16)) * 16777619) * 65536 + u16(x) * 16777619 -- why did Astro banned me lmfao
end

local function ci(s)
    local e = u32(bxor(155, 83) + bxor(238, 28) * 256 + bxor(88, 58) * 65536 + bxor(75, 123) * 16777216)
    local a = bxor(sb[#s % 256 + 1], 49952)
    for i = 1, #s do
        local g = s[i]
        a = u32(bxor(mx(a), i))
        a = u32(bxor(mx(a), g[1]))
        a = u32(bxor(mx(a), g[4]))
        a = u32(bxor(mx(a), g[5]))
        a = u32(bxor(mx(a), g[2]))
        a = u32(bxor(mx(a), g[3]))
    end
    if a ~= e then
        for i = 1, #s do s[i][1] = 0 end
        error("", 0)
    end
    if #s ~= 12 then error("", 0) end
    return bxor(3851150996, a)
end

local EH = 2935199155

local function eh(s, pc, up, ix, iq)
    local h = 302530789
    h = u32(h * 1048583 + #s)
    h = u32(h * 1048583 + (pc or 0))
    h = u32(h * 1048583 + (up and #up or 0))
    h = u32(h * 1500007 + ix)
    h = u32(h * 1500007 + iq)
    for i = 1, #s do
        local g = s[i]
        h = u32(h * 1048583 + (g[1] or 0) + 1)
        h = u32(h * 1048583 + (g[4] or 0) + 1)
        h = u32(h * 1048583 + (g[5] or 0) + 1)
        h = u32(h * 1048583 + (g[2] or 0) + 1)
    end
    return h
end

local function ve(s, pc, up, ix, iq)
    if eh(s, pc, up, ix, iq) ~= EH then error("invalid key to 'next'") end
end

local function vc(b)
    if type(b) ~= "table" then return nil end
    return (b[1] or 0) + (b[2] or 0) * 256
end

return { hb = hb, hs = hs, kw = kw, ci = ci, eh = eh, ve = ve, vc = vc, EH = EH }

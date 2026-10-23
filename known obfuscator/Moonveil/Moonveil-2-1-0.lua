-- Made By Pengu @Amxviolet
-- https://discord.gg/zNyHGU6eUK
local m = {}

local a = "xQMVeMyxSOkZHOOrP"
local b = ":(%d*)\n"
local c = "3685eff6903edc0deb3fc6c24d06a552a24fc19a165b5a776a3e984660cd7096"
local d = "2124b0c0d2729c4d92025c4c27db0d46b9ed68ae8432cff2bf3a37df6bd7bfe0"
local e = "2a3cda2d605a37ecc9aec579a22f597a4c101f53d7afa06ea5c60da491ee77ae"
local f = "a8c0498598e9df89cd09685be78aef9726723f435fd60de38f26d343254298c3"

local g = debug
local h = g and g.traceback
local i = g and g.info
local j = string.find
local k = string.sub
local l = string.gmatch
local n = string.byte
local o = string.char
local p = table.concat
local q = bit32.bxor

local function r(s)
    local t = table.create(math.floor(#s / 2))
    for u = 1, #s, 2 do
        t[#t + 1] = o(tonumber(k(s, u, u + 1), 16))
    end
    return p(t)
end

local function s(...)
    local t = { ... }
    local u = #t[1]
    local v = table.create(u)
    for w = 1, u do
        local x = 0
        for y = 1, #t do
            if #t[y] ~= u then
                return nil
            end
            x = q(x, n(t[y], w))
        end
        v[w] = o(x)
    end
    return p(v)
end

local function t()
    if type(h) ~= "function" or type(i) ~= "function" then
        return false
    end

    local u, v, w = pcall(function() local x = h(a); local y = i(1, "l"); return x, y end)
    if not u or type(v) ~= "string" or type(w) ~= "number" then
        return false
    end

    local x = j(v, "\n", 1, true)
    if not x or k(v, 1, x - 1) ~= a then
        return false
    end

    local y = {}
    for z in l(v, b) do
        local A = tonumber(z)
        if A then
            y[#y + 1] = A
        end
    end

    return y[1] == w
end

local u = s(r(c), r(d), r(e), r(f))

function m.c()
    return t()
end

function m.k()
    if t() then
        return u
    end
end

function m.h()
    return (u:gsub(".", function(v)
        return string.format("%02x", n(v))
    end))
end

m.m = a
m.x = "955dcc9ebaffa8257d9a37ac2f781ef971c089241a103808ffe4717ebfb6201b"

return m

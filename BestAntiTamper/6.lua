-- Made BY pengu / SL Source Leak
-- https://discord.gg/zNyHGU6eUK

local function fail(c)
    error("dtc_" .. tostring(c), 0)
end

local es = game:GetService("EncodingService")
local hs = game:GetService("HttpService")

local function bhex(b)
    local n = buffer.len(b)
    local t = table.create(n)
    for i = 0, n - 1 do
        t[i + 1] = string.format("%02x", buffer.readu8(b, i))
    end
    return table.concat(t)
end

local function shex(s)
    local t = table.create(#s)
    for i = 1, #s do
        t[i] = string.format("%02x", string.byte(s, i))
    end
    return table.concat(t)
end

local ms = "abc"
local mb = buffer.fromstring(ms)

local vecs = {
    { Enum.HashAlgorithm.Md5,     16, "900150983cd24fb0d6963f7d28e17f72" },
    { Enum.HashAlgorithm.Sha1,    20, "a9993e364706816aba3e25717850c26c9cd0d89d" },
    { Enum.HashAlgorithm.Sha256,  32, "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad" },
    { Enum.HashAlgorithm.Blake2b, 32, "bddd813c634239723171ef3fee98579b94964e3bb1cb3e427262c8c068d52319" },
    { Enum.HashAlgorithm.Blake3,  32, "6437b3ac38465133ffb63b75273a8db548c558465d79db03fd359c6cd5bd9d85" },
}

for i, v in ipairs(vecs) do
    local db = es:ComputeBufferHash(mb, v[1])
    local ds = es:ComputeStringHash(ms, v[1])
    if type(db) ~= "buffer" or buffer.len(db) ~= v[2] then
        fail(10 + i)
    end
    if type(ds) ~= "string" or #ds ~= v[2] or buffer.tostring(db) ~= ds then
        fail(20 + i)
    end
    if bhex(db) ~= v[3] or shex(ds) ~= v[3] then
        fail(30 + i)
    end
end

local raw = buffer.fromstring("\x00\xFF\x28\xB5\x2F\xFDRblx\x7F")
local b64 = es:Base64Encode(raw)
if type(b64) ~= "buffer" or buffer.tostring(es:Base64Decode(b64)) ~= buffer.tostring(raw) then
    fail(41)
end
if pcall(es.Base64Decode, es, buffer.fromstring("!!!bad_b64===")) then
    fail(42)
end

local txt = string.rep("RblxZstdCheck_SL_2026!", 12)
local sb = buffer.fromstring(txt)
local zb = es:CompressBuffer(sb, Enum.CompressionAlgorithm.Zstd, 3)

if type(zb) ~= "buffer" or buffer.len(zb) >= buffer.len(sb) then
    fail(43)
end

if buffer.readu32(zb, 0) ~= 0xFD2FB528 then
    fail(44)
end

if es:GetDecompressedBufferSize(zb, Enum.CompressionAlgorithm.Zstd) ~= #txt then
    fail(45)
end

if buffer.tostring(es:DecompressBuffer(zb, Enum.CompressionAlgorithm.Zstd)) ~= txt then
    fail(46)
end

local js = hs:JSONEncode(sb)
local zb64 = string.match(js, '"zbase64":"([^"]+)"')
if not zb64 or string.sub(zb64, 1, 5) ~= "KLUv/" then
    fail(47)
end

local decHttp = hs:JSONDecode(js)
if type(decHttp) ~= "buffer" or buffer.tostring(decHttp) ~= txt then
    fail(48)
end

local zFromHttp = es:Base64Decode(buffer.fromstring(zb64))
if buffer.tostring(es:DecompressBuffer(zFromHttp, Enum.CompressionAlgorithm.Zstd)) ~= txt then
    fail(49)
end

print("ud")

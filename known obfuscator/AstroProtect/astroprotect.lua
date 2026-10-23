-- F all astro lol
local sl1 = {}

local sl2 = 4294967296
local sl3 = "vswomdyj"
local sl4 = "Ka(X;SY4KmwcyK5^QtJc1k_J"

local function sl5(sl6)
	return sl6 - math.floor(sl6 / sl2) * sl2
end

local function sl7(sl6)
	return sl6 % 65536
end

local function sl8(sl6)
	return sl5(sl7(math.floor(sl6 / 65536) * 16777619) * 65536 + sl7(sl6) * 16777619)
end

local function sl9(sl6, sl10, sl11)
	return (sl6 * sl10 + sl11 + 1) % sl2
end

function sl1.fp(sl12, ...)
	local sl13 = type(sl12) == "number" and sl12 or type(sl12) == "string" and #sl12 * 2654435761 or 2654435761
	local sl14 = #type(nil) * 101 + #type(true) * 173 + #tostring(true) * 85 + #tostring(false) * 102 + string.byte("A") * 175
	return bit32.bxor(3415066061, bit32.bxor(bit32.bxor(sl13, sl14), select("#", ...) * 2246822519)) % sl2
end

function sl1.rc()
	local sl15
	local sl16, sl17 = pcall(getmetatable, "")
	if sl16 and type(sl17) == "table" and type(sl17.__index) == "table" then
		sl15 = sl17.__index.char
	end
	sl15 = sl15 or (string and string.char)
	if not sl15 then
		error("")
	end
	if sl15(67) .. sl15(104) .. sl15(50) ~= "Ch2" then
		local sl18, sl19 = pcall(getmetatable, "")
		if sl18 and type(sl19) == "table" and sl19.__index then
			local sl20 = rawget(sl19.__index, "char")
			if sl20 then
				sl15 = sl20
			end
		end
	end
	return sl15
end

function sl1.sy()
	if type(type) ~= "function" then
		error("")
	end
	if #tostring(true) + #tostring(false) ~= 9 then
		error("")
	end
	if 9105 + 8212 ~= 8212 + 9105 or 7036 + 5422 ~= 5422 + 7036 then
		error("")
	end
	if 9750 * 9750 < 9750 * 9750 - 750 or 7065 * 498 / 498 > 7065 then
		error("")
	end
	if 3993 % 2931 >= 2931 then
		error("")
	end
end

function sl1.tf()
	local sl21 = 0
	sl21 = sl7(sl21 * 28 + #tostring(nil) + 129)
	sl21 = sl7(sl21 * 28 + #type(nil) + 129)
	sl21 = sl7(sl21 * 28 + string.byte(tostring(true)) + 129)
	sl21 = sl7(sl21 * 28 + #type(0) + 129)
	sl21 = sl7(sl21 * 28 + #type(true) + 129)
	sl21 = sl7(sl21 * 28 + #tostring(false) + 129)
	sl21 = sl7(sl21 * 28 + #type("") + 129)
	return sl21
end

function sl1.be()
	local sl22, sl23 = pcall(function()
		return getfenv and getfenv(0)
	end)
	local sl24
	local sl25 = (sl22 and type(sl23) == "table" and rawget(sl23, "getgenv")) or rawget(_G, "getgenv")
	if type(sl25) == "function" then
		local sl16, sl21 = pcall(sl25)
		if sl16 and type(sl21) == "table" then
			sl24 = sl21
		end
	end
	sl24 = sl24 or (sl22 and type(sl23) == "table" and sl23) or _G
	local sl26 = (sl22 and type(sl23) == "table") and sl23 or {}
	sl26[sl3] = sl4
	if type(sl24) == "table" and sl26 ~= sl24 and getmetatable(sl26) == nil then
		pcall(function()
			setmetatable(sl26, {
				__index = function(_, sl27)
					return sl24[sl27]
				end,
				__newindex = function(sl21, sl27, sl11)
					sl24[sl27] = sl11
					rawset(sl21, sl27, sl11)
				end,
			})
		end)
	end
	return sl26
end

function sl1.wk(sl26)
	local sl28 = sl26[sl3]
	local sl6 = 0
	if type(sl28) == "string" then
		sl6 = 2166136261
		for sl29 = 1, #sl28 do
			sl6 = sl8(sl6)
			sl6 = sl5(sl6 + string.byte(tostring(sl28), sl29) + 1)
		end
	end
	return bit32.bxor(1438713455, sl6)
end

function sl1.hd(sl26)
	local sl30 = debug
	if not sl30 then
		return
	end
	local self
	if sl30.getinfo then
		local sl21 = sl30.getinfo(1, "S")
		self = sl21 and sl21.source
	elseif sl30.info then
		self = sl30.info(1, "s")
	end
	local sl31, sl32 = sl30.info, sl30.getinfo
	local sl33, sl34 = sl30.getlocal, sl30.setlocal
	local sl35, sl36 = sl30.getupvalue, sl30.setupvalue
	local function sl37(sl38, sl39)
		if sl32 then
			local sl21 = sl32(sl39 and sl38 + 1 or sl38, "S")
			return sl21 ~= nil and self ~= nil and sl21.source == self
		elseif sl31 then
			local sl40 = sl31(sl39 and sl38 + 1 or sl38, "s")
			return sl40 ~= nil and self ~= nil and sl40 == self
		end
		return false
	end
	local sl41 = {}
	if sl31 then
		sl41.info = function(sl38, sl42)
			if type(sl38) == "number" then
				local sl40 = sl31(sl38 + 1, "s")
				if sl40 and self and sl40 == self then
					return nil
				end
				return sl31(sl38 + 1, sl42)
			elseif type(sl38) == "function" then
				local sl40 = sl31(sl38, "s")
				if sl40 and self and sl40 == self then
					return nil
				end
			end
			return sl31(sl38, sl42)
		end
	end
	if sl32 then
		sl41.getinfo = function(sl38, sl42)
			if type(sl38) == "number" then
				return sl32(sl38 + 1, sl42)
			end
			return sl32(sl38, sl42)
		end
	end
	if sl33 then
		sl41.getlocal = function(sl43, sl44)
			if type(sl43) == "number" then
				if sl37(sl43, true) then
					return nil
				end
				return sl33(sl43 + 1, sl44)
			end
			return sl33(sl43, sl44)
		end
	end
	if sl34 then
		sl41.setlocal = function(sl43, sl44, sl45)
			if type(sl43) == "number" then
				if sl37(sl43, true) then
					return nil
				end
				return sl34(sl43 + 1, sl44, sl45)
			end
			return sl34(sl43, sl44, sl45)
		end
	end
	if sl35 then
		sl41.getupvalue = function(sl46, sl44)
			if type(sl46) == "function" and sl37(sl46, false) then
				return nil
			end
			return sl35(sl46, sl44)
		end
	end
	if sl36 then
		sl41.setupvalue = function(sl46, sl44, sl45)
			if type(sl46) == "function" and sl37(sl46, false) then
				return nil
			end
			return sl36(sl46, sl44, sl45)
		end
	end
	local sl47 = pcall(function()
		for sl48, sl49 in pairs(sl41) do
			sl30[sl48] = sl49
		end
	end)
	if not sl47 then
		for _, sl48 in ipairs({ "traceback", "profilebegin", "profileend", "setmemorycategory", "resetmemorycategory", "dumpcodesize", "getmetatable", "setmetatable" }) do
			if sl30[sl48] then
				sl41[sl48] = sl30[sl48]
			end
		end
		if sl26 then
			pcall(function()
				sl26.debug = sl41
			end)
			pcall(function()
				rawset(sl26, "debug", sl41)
			end)
		end
	end
	return sl41
end

local function sl50(sl51)
	local sl52 = {}
	for sl29 = 1, #sl51 do
		sl52[sl29] = string.char(bit32.bxor(sl51[sl29], 213))
	end
	return table.concat(sl52)
end

function sl1.re()
	local function sl53(sl48)
		local sl16, sl11 = pcall(function()
			return _G[sl48]
		end)
		if sl16 and type(sl11) == "function" then
			return sl11, false
		end
		return nil, not sl16
	end
	local sl54, sl55 = sl53(sl50({ 178, 176, 161, 167, 180, 162, 184, 176, 161, 180, 161, 180, 183, 185, 176 }))
	local _, sl57 = sl53(sl50({ 166, 176, 161, 167, 180, 162, 184, 176, 161, 180, 161, 180, 183, 185, 176 }))
	local sl58, sl59 = sl53(sl50({ 189, 186, 186, 190, 179, 160, 187, 182, 161, 188, 186, 187 }))
	local sl60 = (sl55 and 1 or 0) + (sl57 and 2 or 0) + (sl59 and 4 or 0)
	local function sl61(sl21)
		if type(sl21) ~= "table" then
			return sl21
		end
		for _ = 1, 16 do
			local sl17
			if sl54 then
				local sl16, sl62 = pcall(sl54, sl21)
				sl17 = sl16 and sl62 or getmetatable(sl21)
			else
				sl17 = getmetatable(sl21)
			end
			if type(sl17) ~= "table" then
				return sl21
			end
			local sl44 = rawget(sl17, "__index")
			if type(sl44) ~= "table" then
				return sl21
			end
			sl21 = sl44
		end
		return sl21
	end
	local sl63 = {}
	if getfenv then
		local sl16, sl21 = pcall(getfenv, 0)
		if sl16 and type(sl21) == "table" then
			sl63[#sl63 + 1] = sl21
		end
	end
	for _, sl51 in ipairs({ { 178, 176, 161, 178, 176, 187, 163 }, { 178, 176, 161, 167, 176, 187, 163 } }) do
		local sl16, sl21 = pcall(function()
			return _G[sl50(sl51)]()
		end)
		if sl16 and type(sl21) == "table" then
			sl63[#sl63 + 1] = sl21
		end
	end
	sl63[#sl63 + 1] = _G
	local sl64
	for sl29 = 1, #sl63 do
		local sl21 = sl61(sl63[sl29])
		if type(sl21) == "table" then
			sl64 = sl21
			break
		end
	end
	sl64 = sl64 or _G
	local sl17
	if sl54 then
		local sl16, sl62 = pcall(sl54, sl64)
		sl17 = sl16 and sl62 or getmetatable(sl64)
	else
		sl17 = getmetatable(sl64)
	end
	local sl65 = {
		rt = sl64,
		hf = sl58 ~= nil,
		lx = sl60,
		ih = type(sl17) == "table" and type(rawget(sl17, "__index")) == "function",
		nh = type(sl17) == "table" and type(rawget(sl17, "__newindex")) == "function",
		fz = false,
	}
	local sl66 = { g = sl64, rg = rawget, rs = rawset, gm = getmetatable, sm = setmetatable, pc = pcall, ty = type }
	if table.freeze and table.isfrozen then
		if pcall(table.freeze, sl66) then
			local sl16, sl11 = pcall(table.isfrozen, sl66)
			sl65.fz = sl16 and sl11 == true
		end
	end
	sl65.sb = sl66
	return sl65
end

local function sl46(sl67, sl29)
	return sl67[sl29] or 0
end

function sl1.ch(sl68)
	local sl6 = 1766132420
	for sl29 = 1, #sl68 do
		local sl67 = sl68[sl29]
		for sl69 = 1, 4 do
			sl6 = sl5(sl6 * 1900009 + sl46(sl67, sl69) + 1)
		end
	end
	return sl6
end

local function sl70(sl68, sl71, sl10, sl72, sl73)
	local sl6 = sl71
	for sl29 = sl72, sl73 do
		local sl67 = sl68[sl29] or {}
		for sl69 = 1, 4 do
			sl6 = (sl6 * sl10 + sl46(sl67, sl69) + 1) % sl2
		end
	end
	return sl6
end

local function sl74(sl75)
	local sl72 = math.floor(sl75 * 208 / 240)
	local sl73 = math.floor(sl75 * 231 / 240)
	return sl72, sl73
end

function sl1.sh(sl68)
	local sl75 = #sl68
	local sl72, sl73 = sl74(sl75)
	local sl76 = sl70(sl68, 2892503457, 1390009, 1, sl72)
	local sl77 = sl70(sl68, 2064748228, 1520003, sl72 + 1, sl73)
	local sl78 = sl70(sl68, 3121317946, 1720001, sl73 + 1, sl75)
	local sl6 = 786374279
	sl6 = sl9(sl6, 1610099, sl76)
	sl6 = sl9(sl6, 1610099, sl77)
	sl6 = sl9(sl6, 1610099, sl78)
	return sl6
end

function sl1.fh(sl68)
	local sl6 = bit32.bxor(2166136261, 43915)
	for sl29 = 1, #sl68 do
		local sl67 = sl68[sl29]
		sl6 = sl5(bit32.bxor(sl8(sl6), sl29))
		sl6 = sl5(bit32.bxor(sl8(sl6), sl46(sl67, 5)))
		for sl69 = 1, 4 do
			sl6 = sl5(bit32.bxor(sl8(sl6), sl46(sl67, sl69)))
		end
	end
	return sl6
end

function sl1.pk(sl68, sl79, sl80, sl81, sl82)
	local sl6 = 4144483266
	sl6 = sl5(sl6 * 1048583 + #sl68)
	sl6 = sl5(sl6 * 1048583 + (sl79 or 0))
	sl6 = sl5(sl6 * 1048583 + (sl80 or 0))
	sl6 = sl5(sl6 * 1500007 + sl81)
	sl6 = sl5(sl6 * 1500007 + sl82)
	for sl29 = 1, #sl68 do
		local sl67 = sl68[sl29]
		sl6 = sl5(sl6 * 1048583 + sl46(sl67, 5) + 1)
		for sl69 = 1, 3 do
			sl6 = sl5(sl6 * 1048583 + sl46(sl67, sl69) + 1)
		end
	end
	return sl6
end

local function sl83(sl68, sl84, sl85)
	local sl6 = 2166136261
	for sl29 = sl84, sl84 + sl85 - 1 do
		local sl67 = sl68[sl29 + 1]
		if sl67 then
			for sl69 = 1, 4 do
				sl6 = sl8(bit32.bxor(sl6, sl46(sl67, sl69)))
			end
		end
	end
	return sl6
end

local function sl86(sl75)
	local sl87 = {}
	local sl88 = math.max(1, sl75 - 16)
	for sl29 = 1, 15 do
		sl87[sl29] = (sl29 * 97 + 1) % sl88
	end
	return sl87
end

function sl1.sk(sl82, sl81, sl89)
	local sl6 = 0
	sl6 = sl5(sl6 + sl7(sl82) * 40503 + sl7(math.floor(sl82 / 65536)) * 59743)
	sl6 = sl5(sl6 + sl7(sl81) * 34981 + sl7(math.floor(sl81 / 65536)) * 61927)
	sl6 = sl5(sl6 + sl7(sl89) * 40503 + sl7(math.floor(sl89 / 65536)) * 59743)
	return sl5(sl6 + 3237998080)
end

function sl1.vt(sl90)
	local sl71 = 0
	pcall(function()
		sl71 = math.random(1, 2147483646)
	end)
	local sl91 = 0
	pcall(function()
		sl91 = os.time()
	end)
	local sl92 = (sl71 * 1103515245 + sl91 + 910426833) % 2147483647
	local sl93, sl94 = {}, {}
	local sl95 = "__s_movkx3bf"
	rawset(sl93, sl95, "n194bgk915o")
	local function sl96(sl44, sl21)
		if sl21 ~= sl92 or rawget(sl93, sl95) ~= "n194bgk915o" then
			return nil
		end
		local sl11 = sl93[sl44]
		if sl11 == sl94 then
			return nil
		end
		if sl11 == nil then
			sl11 = sl90[sl44]
			sl93[sl44] = sl11 == nil and sl94 or sl11
		end
		return sl11
	end
	return sl96, sl92
end

function sl1.se(sl68, sl79, sl80, sl26)
	sl26 = sl26 or sl1.be()
	local sl81 = sl1.wk(sl26)
	local sl82 = sl1.tf()
	local sl87 = sl86(#sl68)
	local sl97 = {}
	for sl29 = 1, 15 do
		sl97[sl29] = sl83(sl68, sl87[sl29], 16)
	end
	return {
		le = #sl68,
		sq = sl1.sh(sl68),
		fv = sl1.fh(sl68),
		ck = sl1.pk(sl68, sl79, sl80, sl81, sl82),
		wn = sl97,
		md = sl83(sl68, 16, 11),
		np = sl79 or 0,
		nu = sl80 or 0,
	}
end

function sl1.vf(sl68, sl98, sl26)
	sl26 = sl26 or sl1.be()
	local sl81 = sl1.wk(sl26)
	local sl82 = sl1.tf()
	if sl1.sh(sl68) ~= sl98.sq then
		error("attempt to call a table value")
	end
	local sl99 = sl1.fh(sl68)
	if sl99 ~= sl98.fv then
		for sl29 = 1, #sl68 do
			sl68[sl29][5] = 0
		end
		error("", 0)
	end
	if #sl68 ~= sl98.le then
		error("", 0)
	end
	if sl1.pk(sl68, sl98.np, sl98.nu, sl81, sl82) ~= sl98.ck then
		error("bad argument #2 to 'unpack'")
	end
	local sl100 = bit32.bxor(2905716201, sl99)
	return sl100, sl1.sk(sl82, sl81, sl1.ch(sl68))
end

local sl101 = {}
sl101.__index = sl101

function sl1.sg(sl68, sl98, sl100, sl102)
	local sl103 = function() return 0 end
	if sl102 == nil and debug and debug.info then
		local sl16, sl104 = pcall(debug.info, sl103, "l")
		sl102 = sl16 and sl104 or 1
	end
	return setmetatable({
		cd = sl68,
		se = sl98,
		ky = sl100,
		st = sl86(#sl68),
		bl = sl102 or 1,
		a = 0, b = 0, c = 0, d = 0,
		lg = 146752,
		pr = sl103,
	}, sl101)
end

function sl101:tk(sl105, sl106)
	self.a = self.a + 1
	if self.a >= 53 then
		self.a = 0
		local sl44 = sl105 * 37241 % 15 + 1
		if sl83(self.cd, self.st[sl44], 16) ~= self.se.wn[sl44] then
			self.ky = 1287236683
			error("", 0)
		end
	end
	self.b = self.b + 1
	if self.b >= 51 then
		self.b = 0
		self.ky = sl5(self.ky + math.floor((sl106 + 1) / 2097152) * 3700888541)
		local sl107 = sl83(self.cd, 16, 11)
		self.ky = sl5(self.ky + (sl107 - self.se.md) * 730499874)
	end
	self.c = self.c + 1
	if self.c >= 60 then
		self.c = 0
		local sl108 = 0
		if debug and debug.info then
			local sl16, sl104 = pcall(debug.info, self.pr, "l")
			if sl16 then
				sl108 = (sl104 or self.bl) - self.bl
			end
		end
		self.ky = sl5(self.ky + sl108 * 1269456891)
	end
	self.d = self.d + 1
	if self.d >= 63 then
		self.d = 0
		self.lg = (self.lg * 1103515245 + 12345) % 16777216
	end
	return self.ky
end

function sl1.rn(sl68, sl98, sl12, ...)
	local sl109 = sl1.fp(sl12, ...)
	local sl15 = sl1.rc()
	sl1.sy()
	local sl26 = sl1.be()
	sl1.hd(sl26)
	local sl110 = sl1.re()
	local sl100, sl111 = sl1.vf(sl68, sl98, sl26)
	return {
		fp = sl109,
		char = sl15,
		en = sl26,
		rw = sl110,
		ky = sl100,
		ss = sl111,
		gd = sl1.sg(sl68, sl98, sl100),
	}
end

return sl1

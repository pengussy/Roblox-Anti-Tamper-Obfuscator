local sl1 = {} -- wow beta version

local sl2 = 4294967296
local sl3 = 3026497704
local sl4 = 321877750
local sl5 = 3557286987

local function sl6()
	local sl7, sl8 = {}, {}
	local function sl9(sl10)
		if type(sl10) == "table" and not sl8[sl10] then
			sl8[sl10] = true
			sl7[#sl7 + 1] = sl10
		end
	end
	local sl11 = getfenv and getfenv(0)
	local sl12 = (type(sl11) == "table" and rawget(sl11, "getgenv")) or rawget(_G, "getgenv")
	if type(sl12) == "function" then
		local sl13, sl10 = pcall(sl12)
		if sl13 then
			sl9(sl10)
		end
	end
	sl9(sl11)
	sl9(_G)
	if #sl7 == 0 then
		return nil
	elseif #sl7 == 1 then
		return sl7[1]
	end
	local sl14 = false
	return setmetatable({}, {
		__index = function(_, sl15)
			for sl16 = 1, #sl7 do
				local sl17 = rawget(sl7[sl16], sl15)
				if sl17 ~= nil then
					return sl17
				end
			end
			if sl14 then
				return nil
			end
			sl14 = true
			local sl18
			for sl16 = 1, #sl7 do
				local sl13, sl17 = pcall(function()
					return sl7[sl16][sl15]
				end)
				if sl13 and sl17 ~= nil then
					sl18 = sl17
					break
				end
			end
			sl14 = false
			return sl18
		end,
		__newindex = function(_, sl15, sl19)
			rawset(sl7[1], sl15, sl19)
		end,
	})
end

local sl20 = sl6()

local function sl21(sl22)
	local sl23 = sl20
	for sl24 in string.gmatch(sl22, "[^%.]+") do
		if sl23 == nil then
			break
		end
		sl23 = sl23[sl24]
	end
	return sl23
end

local sl25 = {
	dg = sl21("debug"),
	nf = sl21("debug.info"),
	gi = sl21("debug.getinfo"),
	cg = {
		sl21("string.char"),
		sl21("select"),
		sl21("tostring"),
		sl21("next"),
		sl21("rawget"),
		sl21("string.byte"),
		sl21("setmetatable"),
	},
}

local function sl26(sl27, sl28, sl9)
	local sl29 = sl27 % 65536
	local sl30 = (sl27 - sl29) / 65536
	sl29 = sl29 * sl28
	sl30 = (sl30 * sl28) % 65536
	return ((sl30 * 65536) + sl29 + sl9) % sl2
end

local function sl31(sl32, sl28, sl33, sl34)
	local sl27 = sl34 or sl32
	if sl33 then
		for sl16 = 1, #sl33 do
			local sl35 = sl33[sl16]
			for sl36 = 1, #sl35 do
				sl27 = sl26(sl27, sl28, sl35[sl36] + 1)
			end
		end
	end
	return sl27
end

local function sl37(sl38)
	if sl25.nf then
		local sl13, sl39 = pcall(sl25.nf, sl38, "s")
		if sl13 and type(sl39) == "string" then
			if sl39 == "[C]" then
				return "C"
			end
			return "[C]"
		end
	elseif sl25.gi then
		local sl13, sl10 = pcall(sl25.gi, sl38, "S")
		if sl13 and type(sl10) == "table" and type(sl10.what) == "string" and #sl10.what > 0 then
			return sl10.what
		end
	end
	return nil
end

local function sl40(sl38)
	if sl25.nf then
		local sl13, sl41 = pcall(sl25.nf, sl38, "l")
		if sl13 then
			return sl41
		end
	elseif sl25.gi then
		local sl13, sl10 = pcall(sl25.gi, sl38)
		if sl13 and sl10 then
			return sl10.linedefined
		end
	end
	return nil
end

local function sl42(sl43, sl44)
	local sl45, sl46 = sl40(sl43), sl40(sl44)
	return sl45 ~= nil and sl46 ~= nil and sl45 ~= sl46
end

local function sl47(sl39, sl9, sl48)
	sl39.k = sl26(sl39.k, 1441001169, sl9)
	sl39.k2 = (sl39.k2 + sl48) % sl2
end

local sl49 = {}

function sl49.gl(sl39)
	for sl16 = 1, #sl25.cg do
		local sl38 = sl25.cg[sl16]
		if sl38 then
			local sl50 = sl37(sl38)
			if sl50 ~= nil and sl50 ~= "C" then
				sl39.po = sl39.po + 3322510690
			end
		end
	end
	sl47(sl39, 1232327995, 1002568588)
	return 790449 - 761145 - sl39.po
end

function sl49.ye(sl39)
	local sl51 = 1251818509
	sl51 = sl31(sl51, 8191, sl39.i1, sl51)
	sl51 = sl31(sl51, 8191, sl39.i2, sl51)
	sl51 = sl31(sl51, 8191, sl39.i3, sl51)
	sl51 = sl31(sl51, 8191, sl39.i4, sl51)
	sl51 = sl31(sl51, 8191, sl39.i5, sl51)
	sl39.po = sl39.po + (sl51 - sl39.ex) % sl2
	sl39.h = sl51
	sl47(sl39, 2334947746, 822820319)
	if (sl39.po + 371904) > 371904 then
		return 476054 - 424585 - sl39.po
	end
	return 222002 - 180584 - sl39.po
end

function sl49.t2(sl39)
	local sl52 = { "hookfunction", "hookmetamethod", "getgc" }
	for sl16 = 1, #sl52 do
		if type(sl39.ev) == "table" and rawget(sl39.ev, sl52[sl16]) ~= nil then
			sl39.po = sl39.po + 1
		end
	end
	sl47(sl39, 2986135570, 2147680913)
	if (sl39.po + 406202) > 406202 then
		return 876447 - 847848 - sl39.po
	end
	return 682571 - 623328 - sl39.po
end

function sl49.s1(sl39)
	local sl43, sl44 = function() return 0 end, function() return 0 end
	if sl42(sl43, sl44) then
		sl39.po = sl39.po + 1
	end
	sl47(sl39, 2747322579, 1053807107)
	if (sl39.po + 134714) > 134714 then
		return 247219 - 210232 - sl39.po
	end
	return 353769 - 298394 - sl39.po
end

function sl49.by(sl39)
	local sl53 = sl39.db
	if sl53 then
		local self
		if sl53.getinfo then
			local sl10 = sl53.getinfo(1, "S")
			if sl10 then
				self = sl10.source
			end
		elseif sl53.info then
			self = sl53.info(1, "s")
		end
		local sl54, sl55 = sl53.info, sl53.getinfo
		local sl56, sl57 = sl53.getlocal, sl53.setlocal
		local sl58, sl59 = sl53.getupvalue, sl53.setupvalue
		local function sl60(sl61)
			if sl55 then
				local sl10 = sl55(sl61 + 1, "S")
				return sl10 and self and sl10.source == self
			elseif sl54 then
				local sl62 = sl54(sl61 + 1, "s")
				return sl62 and self and sl62 == self
			end
			return false
		end
		local function sl63(sl38)
			if sl55 then
				local sl10 = sl55(sl38, "S")
				return sl10 and self and sl10.source == self
			elseif sl54 then
				local sl62 = sl54(sl38, "s")
				return sl62 and self and sl62 == self
			end
			return false
		end
		local sl50 = {}
		if sl54 then
			sl50.info = function(sl64, sl65)
				if type(sl64) == "number" then
					local sl62 = sl54(sl64 + 1, "s")
					if sl62 and self and sl62 == self then
						return nil
					end
					return sl54(sl64 + 1, sl65)
				elseif type(sl64) == "function" then
					local sl62 = sl54(sl64, "s")
					if sl62 and self and sl62 == self then
						return nil
					end
				end
				return sl54(sl64, sl65)
			end
		end
		if sl55 then
			sl50.getinfo = function(sl64, sl65)
				if type(sl64) == "number" then
					return sl55(sl64 + 1, sl65)
				end
				return sl55(sl64, sl65)
			end
		end
		if sl56 then
			sl50.getlocal = function(sl61, sl66)
				if type(sl61) == "number" then
					if sl60(sl61) then
						return nil
					end
					return sl56(sl61 + 1, sl66)
				end
				return sl56(sl61, sl66)
			end
		end
		if sl57 then
			sl50.setlocal = function(sl61, sl66, sl19)
				if type(sl61) == "number" then
					if sl60(sl61) then
						return nil
					end
					return sl57(sl61 + 1, sl66, sl19)
				end
				return sl57(sl61, sl66, sl19)
			end
		end
		if sl58 then
			sl50.getupvalue = function(sl38, sl66)
				if type(sl38) == "function" and sl63(sl38) then
					return nil
				end
				return sl58(sl38, sl66)
			end
		end
		if sl59 then
			sl50.setupvalue = function(sl38, sl66, sl19)
				if type(sl38) == "function" and sl63(sl38) then
					return nil
				end
				return sl59(sl38, sl66, sl19)
			end
		end
		pcall(function()
			for sl67, sl68 in pairs(sl50) do
				sl53[sl67] = sl68
			end
		end)
	end
	sl47(sl39, 1382699692, 3804928290)
	return 304841 - 258604 - sl39.po
end

local function sl69(sl39, sl33, sl32, sl28)
	local sl43 = sl31(sl32, sl28, sl33)
	local sl44 = sl31(sl32, sl28, sl33)
	sl39.po = sl39.po + (sl43 - sl44) % sl2
end

local function sl70(sl39)
	local sl71 = type(sl39.ev) == "table" and sl39.ev.string and sl39.ev.string.byte
	if sl71 then
		local sl43, sl44 = sl37(sl71), sl37(sl71)
		if sl43 ~= nil and sl44 ~= nil and sl43 ~= sl44 then
			sl39.po = sl39.po + 1
		end
	end
end

function sl49.ry(sl39)
	sl69(sl39, sl39.i3, 1718687210, 8191)
	return 618731 - 567262 - sl39.po
end

function sl49.sn(sl39)
	sl69(sl39, sl39.i2, 2131302230, 6151)
	return 750982 - 738192 - sl39.po
end

function sl49.wm(sl39)
	sl69(sl39, sl39.i4, 1679875963, 1543)
	return 168456 - 139857 - sl39.po
end

function sl49.yq(sl39)
	sl69(sl39, sl39.i2, 2114870148, 3079)
	return 781780 - 774567 - sl39.po
end

function sl49.ho(sl39)
	local sl43, sl44 = function() return 0 end, function() return 4 end
	if sl42(sl43, sl44) then
		sl39.po = sl39.po + 1
	end
	if (sl39.po + 183783) > 183783 then
		error("attempt to call a nil value", 0)
	end
	return 571145 - 525219 - sl39.po
end

function sl49.fj(sl39)
	local sl43, sl44 = function() return 3 end, function() return 8 end
	if sl42(sl43, sl44) then
		sl39.po = sl39.po + 1
	end
	return 767929 - 743022 - sl39.po
end

function sl49.h7(sl39)
	local sl43, sl44 = function() return 2 end, function() return 3 end
	if sl42(sl43, sl44) then
		sl39.po = sl39.po + 1
	end
	return 53131 - 24532 - sl39.po
end

function sl49.kr(sl39)
	sl70(sl39)
	return 600553 - 549084 - sl39.po
end

function sl49.vz(sl39)
	sl70(sl39)
	return 652860 - 624261 - sl39.po
end

function sl49.vp(sl39)
	local sl52 = { "newcclosure", "hookfunction", "getcallingscript", "hookmetamethod" }
	for sl16 = 1, #sl52 do
		if type(sl39.ev) == "table" and rawget(sl39.ev, sl52[sl16]) ~= nil then
			sl39.po = sl39.po + 1
		end
	end
	return 858126 - 845336 - sl39.po
end

local sl72 = {
	[48078] = sl49.gl,
	[29304] = sl49.ye,
	[41418] = sl49.t2,
	[59243] = sl49.s1,
	[55375] = sl49.by,
	[36987] = sl49.ry,
	[24907] = sl49.ho,
	[45926] = sl49.sn,
	[1242] = sl49.vz,
	[12790] = sl49.fj,
	[51469] = sl49.wm,
	[7213] = sl49.h7,
	[3441] = sl49.yq,
	[26286] = sl49.vp,
	[28599] = sl49.kr,
}

local sl73 = 46237

function sl1.ns(sl33, sl74)
	sl33 = sl33 or {}
	return {
		i1 = sl33[1] or {},
		i2 = sl33[2] or {},
		i3 = sl33[3] or {},
		i4 = sl33[4] or {},
		i5 = sl33[5] or {},
		ev = sl20,
		db = sl25.dg,
		po = 0,
		k = 1525003850,
		k2 = 80007125,
		h = 0,
		ex = sl74 or sl5,
	}
end

function sl1.hs(sl33)
	local sl51 = 1251818509
	for sl16 = 1, 5 do
		sl51 = sl31(sl51, 8191, sl33[sl16], sl51)
	end
	return sl51
end

function sl1.rn(sl33, sl74)
	local sl39 = sl1.ns(sl33, sl74)
	local sl75 = (sl3 - sl39.ex) % sl2
	local sl76 = (sl4 - sl39.ex) % sl2
	local sl77, sl78
	local sl79 = 48078
	while sl79 ~= 0 do
		if sl79 == sl73 then
			sl77 = (sl39.po + (sl39.k - sl39.h - sl75) % sl2) % sl2
			sl78 = (sl39.k2 - sl39.h - sl76) % sl2
			sl79 = 0
		else
			local sl38 = sl72[sl79]
			if sl38 then
				sl79 = sl38(sl39)
			end
		end
	end
	return sl77, sl78
end

function sl1.sc(sl33, sl74)
	local sl80 = {}
	for _, sl67 in ipairs({ "gl", "ye", "t2", "s1", "ry", "sn", "wm", "yq", "fj", "h7", "kr", "vz", "vp" }) do
		local sl39 = sl1.ns(sl33, sl74)
		pcall(sl49[sl67], sl39)
		sl80[sl67] = sl39.po
	end
	return sl80
end

local sl81 = {}
sl81.__index = sl81

function sl1.sg(sl82, sl83, sl84, sl85, sl86, sl87)
	return setmetatable({
		n = 0,
		ln = sl82,
		ne = sl83 or 51,
		c = { sl84 or 1928778202, sl85 or 2853080353, sl86 or 3643175576, sl87 or 264124876 },
		pa = function() return 0 end, pb = function() return 0 end,
	}, sl81)
end

function sl81:tk(sl15, sl88, sl89)
	self.n = self.n + 1
	if self.n < self.ne then
		return sl15
	end
	self.n = 0
	local sl90 = self.c
	sl15 = (sl15 + math.floor((sl88 + 1) / 2097152) * sl90[1] + math.floor(sl89 / (self.ln + 1)) * sl90[2]) % sl2
	local sl91 = sl42(self.pa, self.pb) and 1 or 0
	sl15 = (sl15 + sl91 * sl90[3]) % sl2
	local sl92 = 0
	local sl53 = sl25.dg
	if sl53 and sl53.gethook then
		local sl13, sl51 = pcall(sl53.gethook)
		if sl13 and sl51 ~= nil then
			sl92 = 1
		end
	end
	return (sl15 + sl92 * sl90[4]) % sl2
end

return sl1

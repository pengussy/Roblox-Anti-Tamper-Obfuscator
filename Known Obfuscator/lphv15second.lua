-- luraph v15 anti tamper
local q0="LPH:"
local o0=":(%d+)[:\13\10]"
local l0="[ -&|-~]"
local I0=39
local EO={52200625,614125,7225,85,1}
local C0=163112689
local A0=4294967296
local D0=4294967295
local g0="The metatable is locked"
local S0="The debug library is required on Luau platforms. Please open a support ticket."
local tO={43,15,40,86}
local eO=99
local B0=65535
local jO=16384
local O0=2097152

local function d0(x)return x%A0 end
local function U(a,b)return bit32.bxor(d0(a),d0(b)) end
local function y(a,b)return bit32.band(d0(a),d0(b)) end
local function i(a)return bit32.bnot(d0(a)) end
local function Z(a,b)return bit32.rshift(d0(a),b) end
local function N(a,b)return bit32.lshift(d0(a),b) end

local function H0(a,b)
	a=d0(a)b=d0(b)
	local p,h=a%B0,Z(a,16)
	local q,k=b%B0,Z(b,16)
	return d0(p*q+y(p*k+q*h,B0)*(B0+1))
end

local function A(p)
	local t,a,k={},0,1
	for n=1,#p do
		local c=p:sub(n,n)
		if c:find(l0)then
			a=a+(p:byte(n)-I0)*EO[k]
			k=k+1
			if k>#EO then
				t[#t+1]=string.pack(">I4",a%A0)
				a,k=0,1
			end
		end
	end
	return table.concat(t)
end

local function R(t,p)
	local a=t[p]
	if a<128 then return a,p+1 end
	local b=t[p+1]
	if b<128 then return a-128+b*128,p+2 end
	local c=t[p+2]
	if c<128 then return a-128+(b-128)*128+c*16384,p+3 end
	local d=t[p+3]
	return a-128+(b-128)*128+(c-128)*16384+d*2097152,p+4
end

local function uO(p)
	if p:sub(1,#q0)~=q0 then error("Luraph: corrupted header",2)end
	local t={}
	for n in p:gmatch(o0)do t[#t+1]=tonumber(n) end
	return t
end

local function S(t)
	return setmetatable(t,{
		__metatable=g0,
		__newindex=function()error(g0,2)end,
	})
end

local function E(rd)
	local m={}
	return S(setmetatable({},{
		__index=function(_,k)
			local v=m[k]
			if v==nil then v=rd(k)m[k]=v end
			return v
		end,
	}))
end

local function hO(l)
	if not debug or not debug.getinfo then error(S0,2)end
	local n=debug.getinfo(l,"Sln")
	if not n or n.source=="[C]" or n.what=="C" or not n.currentline or n.linedefined==-1 then
		error(g0,2)
	end
	return n
end

local function JO()
	if type(identifyexecutor)=="function"then return identifyexecutor() end
	return "unknown"
end

local function kO(w,e)
	local D=w
	local s=D.V[e]<O0 and 7 or 14
	local t=y(D.V[e],N(1,s)-1)
	local b=Z(D.V[e],s)
	local m=d0(D.M[e])
	local q=d0(D.C[e])
	D.M[e]=d0(H0(2147483649,D0)+H0(2147483648,m)+H0(2147483648,57)+H0(2147483647,i(U(m,57))))
	D.C[e]=d0(H0(2147483649,D0)+H0(2147483648,q)+H0(2147483648,22)+H0(2147483647,i(U(q,22))))
	D.V[e]=d0(U(t,81)+H0(1232880779,D0)+H0(3062086517,m)+H0(3062086517,i(m)))
	D.j[e]=d0(U(b,99)+H0(80222685,D0)+H0(4214744611,q)+H0(4214744611,i(q)))
	return e-1
end

local function yO(w,e)
	local D=w
	local v=D.C[e]
	local s=v<jO and 7 or(v<O0 and 14 or 21)
	local t=y(v,N(1,s)-1)
	local b=Z(v,s)
	D.M[e]=d0(U(D.M[e],6)+H0(1196699960,D0)+H0(3098267336,d0(D.V[e]))+H0(3098267336,i(d0(D.V[e]))))
	D.V[e]=d0(U(d0(D.V[e]),117)+H0(1516861425,D0)+H0(2778105871,d0(t))+H0(2778105871,i(d0(t))))
	D.C[e]=d0(H0(2147483649,D0)+H0(2147483648,d0(t))+H0(2147483648,106)+H0(2147483647,i(U(d0(t),106))))
	D.j[e]=d0(U(d0(b),53)+H0(1305409224,D0)+H0(2989558072,d0(t))+H0(2989558072,i(d0(t))))
	return e-1
end

local function sO(w,e,a,m,k)
	local D=w
	local u=a[e]+1
	for q=1,m[e]do
		local v=y(U(k[e],q),127)
		D.j[u]=U(D.j[u],v)
		D.C[u]=U(D.C[u],v)
		D.M[u]=U(D.M[u],v)
		D.V[u]=U(D.V[u],v)
		u=u+1
	end
end

local function rO(w,e)
	local D=w
	local g=D.g
	local q=g[1]
	local o=q[7]
	local b=U(o.cursor,C0)
	o.cursor=b
	local p=q[6]
	local l,n=R(p,b+1)
	local k=D.C[e]
	for x=n,n+l-1 do
		p[x]=U(p[x],k)
	end
	D.j[e],D.C[e]=72,40
	D.M[e],D.V[e]=29,66
end

local function wO(w,e)
	local D=w
	D.h=D.M[e]
	D.e=D.V[e]+1
	D.s=true
end

local function nO(g,v)
	return function(_,k)
		g.e=k
		while g.h do
			local fn=v[g.h]
			if not fn then break end
			fn(g)
		end
		return g.r
	end
end

local function m0(h)
	return S(table.create(h))
end

local Y={}

Y.N=function()end
Y.MV=function(w,e)w.L[w.C[e]]=w.L[w.V[e]] end
Y.NV=function(w,e)w.L[w.V[e]]=w.M[e] end
Y.NC=function(w,e)w.L[w.C[e]]=w.M[e] end
Y.NM=function(w,e)w.L[w.M[e]]=w.j[e] end
Y.NJ=function(w,e)w.L[w.C[e]]=w.j[e] end
Y.KV=function(w,e)w.L[w.V[e]]=w.X[0]+w.z[e] end
Y.KC=function(w,e)w.L[w.C[e]]=w.X[0]+w.z[e] end
Y.GM=function(w,e)w.L[w.M[e]]=w.k[e] end
Y.BM=function(w,e)w.L[w.M[e]]=w.G[w.k[e]] end
Y.IV=function(w,e)w.L[w.V[e]]=w.v[w.M[e]] end
Y.JV=function(w,e)w.e=w.V[e] end
Y.RJ=function(w,e)w.e=w.j[e] end
Y.DV=function(w,e)w.e=w.L[w.V[e]] end
Y.DC=function(w,e)w.e=w.L[w.C[e]] end
Y.CM=function(w,e)w.e=not not(w.L[w.M[e]]<=w.C[e])and w.j[e]or w.e end
Y.FB=function(w,e)w.e=not not(w.L[w.M[e]]<=w.C[e])and w.V[e]or w.e end
Y.FL=function(w,e)w.e=not not(w.L[w.V[e]]<=w.C[e])and w.M[e]or w.e end
Y.EV=function(w,e)w.L[w.V[e]]=w.L[w.M[e]]==w.L[w.C[e]] end
Y.XM=function(w,e)w.L[w.M[e]]=not w.L[w.V[e]] end
Y.QC=function(w,e)w.L[w.C[e]]=w.L[w.V[e]]%w.X[0] end
Y.TM=function(w,e)w.L[w.M[e]]=w.L[w.V[e]]*w.C[e] end
Y.SV=function(w,e)w.L[w.V[e]]=w.M[e]-w.L[w.C[e]] end
Y.SC=function(w,e)w.L[w.C[e]][w.L[w.V[e]]]=w.L[w.M[e]] end
Y.SN=function(w,e)w.L[w.C[e]][w.M[e]]=w.L[w.V[e]] end
Y.SJ=function(w,e)w.L[w.M[e]][w.L[w.C[e]]]=w.L[w.V[e]] end
Y.SZ=function(w,e)w.L[w.M[e]][w.z[e]]=w.L[w.V[e]] end
Y.SX=function(w,e)w.L[w.C[e]][w.z[e]]=w.L[w.V[e]] end
Y.TM2=function(w,e)w.L[w.M[e]]=w.L[w.V[e]][w.L[w.C[e]]] end
Y.AM=function(w,e)w.L[w.M[e]]()end
Y.A1=function(w,e)w.L[w.M[e]]=w.L[w.C[e]](w.L[w.V[e]]) end
Y.AK=function(w,e)w.L[w.M[e]]=w.L[w.V[e]](w.z[e]) end
Y.AE=function(w,e)
	local b=w.C[e]
	local m=w.j[e]
	local t=table.move(w.L,b+1,b+m-1,1,{})
	w.L[b]=w.L[b](table.unpack(t))
end
Y.PC=function(w,e)
	local b={}
	table.move(w.L,w.C[e],w.M[e],1,b)
	b[0]=w.F
	w.L[w.F]=b
end
Y.UM=function(w,e)w.u[w.z[e]]=w.L[w.M[e]] end
Y.UX=function(w,e)w.u[w.z[e]]=w.X[0] end
Y.RM=function(w,e)
	local u=w.c[w.M[e]]
	u[3][u[5]]=w.k[e]
end
Y.GC=function(w,e)w.L[w.C[e]]=w.G end
Y.LM=function(w,e)return"x",w.L[w.M[e]] end
Y.SW=wO
Y.DW=kO
Y.DD=yO
Y.T4=function(w,e)sO(w,e,w.V,w.M,w.C)w.j[e]=65 end
Y.T5=function(w,e)sO(w,e,w.j,w.C,w.M)end
Y.T6=function(w,e)sO(w,e,w.V,w.M,w.C)w.j[e]=10 end
Y.T7=rO

local qO={
	[43]={ [0]=Y.DD,[4]=Y.T6,[9]=Y.GM,[10]=Y.N,[15]=Y.DW,[16]=Y.EV,[17]=Y.FL,[18]=Y.XM,[19]=Y.MV,[20]=Y.IV,[22]=Y.DV,[23]=Y.GC,[24]=Y.JV,[26]=Y.NV,[27]=Y.DD,[28]=Y.AE,[29]=Y.FB,[32]=Y.A1,[33]=Y.GM,[34]=Y.SW,[35]=Y.LM },
	[15]={ [3]=Y.SW,[5]=Y.AK,[8]=Y.RM,[9]=Y.GM,[10]=Y.N,[13]=Y.GM,[14]=Y.AM,[22]=Y.T4,[23]=Y.RM,[24]=Y.JV,[27]=Y.DW,[31]=Y.LM,[32]=Y.A1,[34]=Y.TM2,[37]=Y.PC,[46]=Y.T7,[48]=Y.JV,[49]=Y.KV,[55]=Y.SN,[56]=Y.DW,[58]=Y.MV,[62]=Y.CM,[66]=Y.DW,[67]=Y.DC,[71]=Y.GM,[78]=Y.NC,[79]=Y.FB },
	[40]={ [15]=Y.KC,[27]=Y.DD,[53]=Y.AK },
	[86]={ [5]=Y.T5,[7]=Y.T7,[9]=Y.BM,[14]=Y.DC,[19]=Y.UM,[21]=Y.CM,[26]=Y.SN,[33]=Y.KV,[34]=Y.SN,[47]=Y.GM,[51]=Y.SJ,[61]=Y.NM,[69]=Y.UX,[70]=Y.SJ,[72]=Y.AE,[85]=Y.RJ },
}

local bO={[43]="j",[15]="j",[40]="V",[86]="V"}

local function vO(w,h,e)
	w.h=h
	w.e=e
	while w.h do
		local op=w[bO[w.h]][w.e]
		if op==nil then break end
		local t=qO[w.h]
		local fn=(op>255 or not t[op])and Y.FB or t[op]
		local x,z=fn(w,w.e)
		if x=="x"then return z end
		if not w.s then w.e=w.e+1 end
		w.s=false
	end
end

local function cO(p,n)
	local o=S({cursor=1})
	local b=S({})
	local g=S({ [1]=S({ [6]=b,[7]=o }),[6]=0,[7]=tO[1],[8]=110 })
	local u=1
	for _=1,n do
		local v,k=R(p,u)
		o[#o+1]=U(v,C0)
		u=k
	end
	return g
end

local function dO(p,G)
	hO(2)
	local d=uO(p)
	local m=p:match("%](=*)%](.-)%1%]")
	local t=A(m)
	local g=cO(t,d[1]or 0)
	local ns={h=1}
	local z=E(nO(ns,{}))
	local w={
		M=g[14]or{},V=g[10]or{},C=g[11]or{},j=g[12]or{},X=g[13]or{[0]=0},z=z,F=g[15],
		L=m0(g[8]),k=z,G=G or getfenv and getfenv()or _G,v={},u={},c={},g=g,s=false,
	}
	JO()
	return vO(w,g[7],g[6])
end

local function fO(p)
	local ok=pcall(dO,p,getfenv and getfenv()or _G)
	if not ok then error(g0,2)end
end

return {
	A=A,R=R,uO=uO,S=S,E=E,hO=hO,JO=JO,H0=H0,kO=kO,yO=yO,sO=sO,rO=rO,nO=nO,Y=Y,qO=qO,vO=vO,l0=l0,fO=fO,
}

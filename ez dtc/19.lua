
local u=Random.new(1):NextUnitVector()
if u.X~=0.42857980728149414 or u.Y~=-0.10929630696773529 or u.Z~=0.8968688249588013 then error("dtc",0) end
if math.abs(u.Magnitude-1)>1e-6 then error("dtc",0) end
local r=Random.new(77)
local s=Vector3.zero
for i=1,32 do local v=r:NextUnitVector() if math.abs(v.Magnitude-1)>1e-5 then error("dtc8",0) end s=s+v end
if s.Magnitude>32 then error("dtc",0) end
if Random.new(77):NextUnitVector()~=Random.new(77):NextUnitVector() then error("dtc8",0) end
print("ud")

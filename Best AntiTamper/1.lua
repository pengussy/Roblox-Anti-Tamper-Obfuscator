-- hi lol
local o,v=pcall(function()
    local d=Drawing.new("Square")
    setrenderproperty(d,"Size",Vector2.new(40,25))
    setrenderproperty(d,"Visible",true)
    local sz=getrenderproperty(d,"Size")
    local vis=getrenderproperty(d,"Visible")
    local live=isrenderobj(d) and d.__OBJECT_EXISTS==true
    d:Destroy()
    return sz==Vector2.new(40,25) and vis==true and live and d.__OBJECT_EXISTS==false
end)
if not o or not v then error("dtc",0) end
print("ud")

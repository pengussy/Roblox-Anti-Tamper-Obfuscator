local r=Rect.new(2,4,8,16)
print(r.Min.X,r.Min.Y,r.Max.X,r.Max.Y)
assert(r.Min.X==2 and r.Max.Y==16,"dtc")
print("ok")
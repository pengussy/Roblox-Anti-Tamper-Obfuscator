
local v=Vector2.new(3,4)
print(v:Dot(Vector2.new(5,6)))
assert(v:Dot(Vector2.new(5,6))==39,"dtc")
print("ok")
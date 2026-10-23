local a=Axes.new(Enum.Axis.X,Enum.Axis.Y)
print(typeof(a),a.X,a.Y,a.Z)
assert(a.X and a.Y and not a.Z,"dtc")
print("ok")

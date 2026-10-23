local path = "check.txt"
local expected = "print(\"not dtc\")"

writefile(path, expected)

local contents = readfile(path)

if contents == expected then
    print("not dtc")
else
    print("dtc")
end

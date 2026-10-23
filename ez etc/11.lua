-- made by me @amxviolet0101/@pengu
local function edtc()
    if type(getgenv) == "function" or type(getgc) == "function" then
        print("DTC")
        return
    end
    print("UD")
end

edtc()

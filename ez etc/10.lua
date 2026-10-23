local function func(fn)
    local info = debug.getinfo(fn)

    if info and info.what ~= "Lua" then
        error("dtc")
    end

    return function(...)
        return fn(...)
    end
end

-- goofyscator tamper
task.defer(coroutine.yield)

local function antiTamper()
    error("Antitamper was triggered", 0)

    GUF_CRASH()

    for a, b in typeof do
    end

    local fn

    (function(f)
        return function(...)
            return f(...)
        end
    end)(function()
        fn()
    end)()
end


do
    local obj = Instance.new("DataStoreIncrementOptions")
    local data = {
        hi = true
    }

    obj:SetMetadata(data)

    if obj:GetMetadata().hi ~= data.hi then
        antiTamper()
    end

    obj:Destroy()
end


assert(
    type(coroutine.create(function()
    end)) == "thread",
    "meow"
)


if not pcall(function()
    local frame = Instance.new("Frame")

    frame.Position = UDim2.new(0, 0, 0, 0)

    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(0.01)

    local goal = {
        Position = UDim2.fromScale(1, 1)
    }

    local tween = tweenService:Create(
        frame,
        tweenInfo,
        goal
    )

    tween:Play()
    tween.Completed:Wait()

    frame:Destroy()
end) then
    antiTamper()
end


do
    local part = Instance.new("Part")
    local tab = {}

    part:GetPropertyChangedSignal("Size"):Connect(function()
        table.insert(tab, part.Size)
    end)

    local num = math.random(1, 7)

    part.Size = Vector3.new(
        num,
        num,
        num
    )

    task.wait(0.05)

    if #tab < 0 then
        antiTamper()
    elseif tab[#tab].X ~= num then
        antiTamper()
    end

    part:Destroy()
end
print("pass")

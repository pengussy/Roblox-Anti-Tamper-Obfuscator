-- Old 25ms Obfuscator Anti Tamper

local decryptString, obfuscatorData do
    local mathFloor = math.floor
    local mathRandom = math.random
    local tableRemove = table.remove
    local stringChar = string.char
    local stateJ = 0
    local stateP = 2
    local charTable = {}
    local lookupTable = {}
    local v = 0
    local shufflePool = {}

    for i = 1, 256, 1 do
        shufflePool[i] = i
    end

    repeat
        local randomIndex = mathRandom(1, #shufflePool)
        local value = tableRemove(shufflePool, randomIndex)
        lookupTable[value] = stringChar(value - 1)
    until #shufflePool == 0

    local streamBuffer = {}
    local function getStreamValue()
        if #streamBuffer == 0 then
            stateJ = (stateJ * 85 + 6789898822691) % 35184372088832
            repeat
                stateP = (stateP * 76) % 257
            until stateP ~= 1
            local xorVal = stateP % 32
            local floatVal = (mathFloor(stateJ / 2 ^ (13 - (stateP - xorVal) / 32)) % 4294967296.0) / 2 ^ xorVal
            local byteVal = mathFloor((floatVal % 1) * 4294967296.0) + mathFloor(floatVal)
            local e = byteVal % 65536
            local k = (byteVal - e) / 65536
            local v1 = e % 256
            local h1 = (e - v1) / 256
            local y = k % 256
            local w = (k - y) / 256
            streamBuffer = { v1; h1, y; w }
        end
        return tableRemove(streamBuffer)
    end

    local cache = {}
    obfuscatorData = setmetatable({}, { __index = cache, __metatable = nil })

    function decryptString(input, key)
        local cachedResult = cache
        if (cachedResult)[key] then
        else
            streamBuffer = {}
            local mapping = lookupTable
            stateJ = key % 35184372088832
            stateP = key % 255 + 2
            local length = string.len(input)
            (cachedResult)[key] = ""
            local v2 = 203
            for i = 1, length, 1 do
                v2 = ((string.byte(input, i) + getStreamValue()) + v2) % 256
                (cachedResult)[key] = (cachedResult)[key] .. (mapping)[v2 + 1]
            end
        end
        return key
    end
end

local playersService = game:GetService((obfuscatorData)[decryptString("\019\004\252\174\249\187\164", 14780415755810)])
local localPlayer = (playersService)[(obfuscatorData)[decryptString("]\163j'J\235\0003\185\141\131", 29752470087218)]]
local replicatedStorage = game:GetService((obfuscatorData)[decryptString("\246k\151\a[?\130\197Q8\233\185\n\171\030\136\250", 24847586453918)])
local gameModule = require(((replicatedStorage)[(obfuscatorData)[decryptString("\1842\135\195\2541\190\187\253\156", 7113009400824)]])[(obfuscatorData)[decryptString("1\a\029\150S\018m\223;a;\236\188\203\004\193\141\213\158`\204\224[", 16648923695587)]])
local remoteEvent = ((replicatedStorage)[(obfuscatorData)[decryptString("\238\016K\152w\1837\168Y\023", 2045617142956)]])[(obfuscatorData)[decryptString("\027\251\167c\246Zw\019\029", 15146230113854)]]
local configTable = { [(obfuscatorData)[decryptString("\130\154\241\153", 25069167246962)]] = (obfuscatorData)[decryptString("\169\139\191", 22876426303546)]; [(obfuscatorData)[decryptString("n\255}z\211<", 4326447526442)]] = (obfuscatorData)[decryptString("I\167\030\002\t\228T\005O", 18877349381240)], [(obfuscatorData)[decryptString("\250[\174\206\197I\149FN\139N\a\152\218\248\226\001u\232", 3130434727216)]] = (obfuscatorData)[decryptString("\203\166\017t", 31535700730371)]; [(obfuscatorData)[decryptString("\129?", 16317255390753)]] = (obfuscatorData)[decryptString("\235\184\001", 19284475947674)]; [(obfuscatorData)[decryptString("F\185\186<\189x\173*", 29062591648498)]] = (obfuscatorData)[decryptString("n\168(BL\209\192p\196\092\213f\164\155~3\0160\239\243\190\175\176\151", 22814078524899)], [(obfuscatorData)[decryptString("\181\a\198\214*\210}\186o\235\024", 23127286569755)]] = (obfuscatorData)[decryptString(">\182\224\210)\212W\015\247\014\252", 11234505948610)] };

(table)[(obfuscatorData)[decryptString("\240\b,%\157r", 20092440840732)]]((gameModule)[(obfuscatorData)[decryptString("\rs\237\169\028\192\017\128%69t\166", 7065543185736)]](), configTable)
remoteEvent:FireServer((configTable)[(obfuscatorData)[decryptString("\132Q", 33644818574272)]])

local flagName = (obfuscatorData)[decryptString("5,\186", 18844306367887)]
local isEnabled = false
local connectionList = {}

local function processTarget(target)
    if not target or not target:IsA((obfuscatorData)[decryptString("\254F\157\247", 7774082659225)]) then return end
    local isTargetValid = false
    for _, descendant in pairs(target:GetDescendants()) do
        if descendant:IsA((obfuscatorData)[decryptString("\185\14441\187", 19002542119975)]) and (descendant)[(obfuscatorData)[decryptString("\196\152\245\021", 15222237750198)]] == (obfuscatorData)[decryptString("=\223\195\197", 22581592485731)] then
            isTargetValid = true
            break
        end
    end
    if isTargetValid then
        (target)[(obfuscatorData)[decryptString("*\228\174}\155\158W\195\170", 1445834585870)]] = (obfuscatorData)[decryptString("\156L\219X\020!R\157[&+\199\145\012\186\1351\145~d\139\238\224\159", 10607794614710)]
        for _, object in pairs(target:GetDescendants()) do
            if object:IsA((obfuscatorData)[decryptString("5\166\129\2261", 33610705904735)]) then
                if (object)[(obfuscatorData)[decryptString("X>\202b", 29223653158805)]] == (obfuscatorData)[decryptString("\249\147u\185", 13846936576669)] then
                    (object)[(obfuscatorData)[decryptString("o\167H\030^\021}", 5337152149584)]] = (obfuscatorData)[decryptString("\006\092\1308D\215\213W\174\238'\161\215\228\231)\161\167b\213\160\231\146", 1871412740066)]
                elseif (object)[(obfuscatorData)[decryptString("\a\250\201\178", 30864222594918)]] == (obfuscatorData)[decryptString("\159\153T\175\024a", 3480789944780)] then
                    (object)[(obfuscatorData)[decryptString("\141\185\173\191\231\172\143", 3992043084544)]] = (obfuscatorData)[decryptString("H I:+\021\228\014\142^\026\205\2364\171\135\146\242t\170\000\177^\159", 34804066940743)]
                end
            elseif object:IsA((obfuscatorData)[decryptString("@\205J\225\015F\155\235", 22222657937411)]) and (object)[(obfuscatorData)[decryptString("a\168\020\243", 5094810081930)]] == (obfuscatorData)[decryptString("f\185\r\194\197\223\r\134\141\194\186", 7403177737095)] then
                (object)[(obfuscatorData)[decryptString("\0219\224\022Z\200", 15750444528505)]] = (obfuscatorData)[decryptString("\254\232\233s*\156\193\189F\249\175\170\028\1479\184\174jt\246}\132\189\163", 14429501835830)];
                (object)[(obfuscatorData)[decryptString("c\153;\n", 27348794190743)]] = (Vector3)[(obfuscatorData)[decryptString("T\239+", 6826521210965)]](.0033, .0067, .012)
                local child = object:FindFirstChildOfClass((obfuscatorData)[decryptString("=r\1602j\255\157\131Nm\"d\168@W\232s", 8110609127742)]) or (Instance)[(obfuscatorData)[decryptString("\143V\172", 30465846323945)]]((obfuscatorData)[decryptString("\155Z\237r~;\206LJ\250\017qz\191F\018\024", 26302745170998)], object);
                (child)[(obfuscatorData)[decryptString("\227\2270\202iQ\140\239", 12387308624780)]] = (obfuscatorData)[decryptString("iO\138-\188\024B\139\181\r0\180h\184\223\144\180v\161\245\220\191\b\141", 31536886009140)];
                (child)[(obfuscatorData)[decryptString("\189\139e'\235\2207\127\160\223\142n", 22571439539643)]] = (obfuscatorData)[decryptString("\232\178\0175\253a\229XnL\026\250*\144\154%\244\1743\133)\213\235R", 1827144282633)];
                (child)[(obfuscatorData)[decryptString("\190oW\0007\186\239\209H", 1249775169352)]] = (obfuscatorData)[decryptString("\191E\240\199/^S\017R`M}\2268\129\197?#\173\227\177\139\234\030", 33763909533215)];
                (child)[(obfuscatorData)[decryptString("&\240\182(\235\136T,\015\238\012k", 11686934388406)]] = (obfuscatorData)[decryptString("\029\198?\217\182\019\"\225\135\216\026\216\216\231\181\242\143\188\193x\233\135\199X", 24631453613910)]
            end
        end
    end
end

local function clearConnections()
    for _, connection in pairs(connectionList) do
        connection:Disconnect()
    end
    connectionList = {}
end

local function initializeFeature()
    clearConnections()
    local container = localPlayer:WaitForChild((obfuscatorData)[decryptString("#\206(\243\204on7", 26921635015738)])
    local target = container:FindFirstChild((obfuscatorData)[decryptString("H\1423]Ec4", 3743164946887)])
    if target then
        processTarget(target)
    end
    (connectionList)[#connectionList + 1] = (container)[(obfuscatorData)[decryptString(" Zp\137W\131a\243\030\196", 7078423640367)]]:Connect(function(child)
        if (child)[(obfuscatorData)[decryptString("\183\018\248\232", 32300989749357)]] == (obfuscatorData)[decryptString("\026\234gI\v\145\134", 24247741918286)] then
            wait(.1)
            processTarget(child)
        end
    end)
    (connectionList)[#connectionList + 1] = (localPlayer)[(obfuscatorData)[decryptString("k\249=\181\154\006\134;\132\234\250\197\157\216", 16100746786615)]]:Connect(function(child)
        (connectionList)[#connectionList + 1] = (child)[(obfuscatorData)[decryptString("\001\193\165\168\2327\127\212\185\180", 24913704727201)]]:Connect(function(descendant)
            if (descendant)[(obfuscatorData)[decryptString("6\030\208^", 19072434870923)]] == (obfuscatorData)[decryptString("\198\232?\147\174/\164", 11297073774446)] then
                wait(.1)
                processTarget(descendant)
            end
        end)
    end)
    if (localPlayer)[(obfuscatorData)[decryptString("2\197\v\140\129\145\187!v", 290840067845)]] then
        (connectionList)[#connectionList + 1] = ((localPlayer)[(obfuscatorData)[decryptString("\208R\181\178\tb;Qv", 28929143325163)]])[(obfuscatorData)[decryptString("\145\128(\139\250u\222hY\130", 17157770821418)]]:Connect(function(child)
            if (child)[(obfuscatorData)[decryptString("px\215\194", 13189690373325)]] == (obfuscatorData)[decryptString("\0209h.<\aK", 28236748545606)] then
                wait(.1)
                processTarget(child)
            end
        end)
    end
end

local function updateState()
    local statusList = (gameModule)[(obfuscatorData)[decryptString("\017V\206\218\012\218\0260Mo\1799V", 2301904539601)]]() or {}
    local newState = false
    for _, status in ipairs(statusList) do
        if (status)[(obfuscatorData)[decryptString("w\216", 18985742780965)]] == flagName and (status)[(obfuscatorData)[decryptString("U2\245\185\189\230\157\207\146\194", 18144186110890)]] then
            newState = true
            break
        end
    end
    if newState and not isEnabled then
        initializeFeature()
    elseif not newState and isEnabled then
        clearConnections()
    end
    isEnabled = newState
end

spawn(function()
    local success, module = pcall(function()
        return require(((replicatedStorage)[(obfuscatorData)[decryptString("\255-\246\r+h (", 34058489329281)]])[(obfuscatorData)[decryptString("#\226\160F\216~\173\024~B\251n\142", 12379034724862)]])
    end)
    if success and module then
        ((module)[(obfuscatorData)[decryptString("/\1938?\135\251\022\021\131\161\164\028`i\222V\189\170G\227\246", 34850068958671)]]()):Connect(function(player, target)
            if target == localPlayer and (isEnabled and (player and (player)[(obfuscatorData)[decryptString("\029Y\214=/\028\2096\160", 32551505200435)]])) then
                local attribute = (player)[(obfuscatorData)[decryptString("\163\228\180Q\187\232%\2120", 12417092047055)]]:FindFirstChild((obfuscatorData)[decryptString("*}\139?\207v*<", 17349668705731)])
                if attribute then
                    attribute:SetAttribute((obfuscatorData)[decryptString("k\154:,b\168|\025\207\198", 34284084307479)], (obfuscatorData)[decryptString("7\161H\139", 10075156695420)])
                end
            end
            if player then
                player:SetAttribute((obfuscatorData)[decryptString("\169\191\167\129\nb", 25850271092847)], (player:GetAttribute((obfuscatorData)[decryptString("\179o\v(\247\171", 29190895379940)]) or 0) + 1)
            end
        end)
    end
end);

(playersService)[(obfuscatorData)[decryptString("\222q\190*iLjA\199+ ", 14511065802468)]]:Connect(function(player)
    (player:GetAttributeChangedSignal((obfuscatorData)[decryptString("\029'\203\197\019", 31488801533584)])):Connect(function()
        player:SetAttribute((obfuscatorData)[decryptString("\161\021\194~\147\236", 12826464342577)], 0)
    end)
end)

local allPlayers = playersService:GetPlayers()
for i = 1, mathFloor(#allPlayers * 0.15) + 1 do
    local player = allPlayers[i]
    (player:GetAttributeChangedSignal((obfuscatorData)[decryptString("X\204\235A>", 19634783782753)])):Connect(function()
        player:SetAttribute((obfuscatorData)[decryptString("0\002TU\160\238", 10815446535647)], 0)
    end)
end

while true do
    updateState();
    (task)[(obfuscatorData)[decryptString("%\000\143\133", 7640195698293)]](.1)
end

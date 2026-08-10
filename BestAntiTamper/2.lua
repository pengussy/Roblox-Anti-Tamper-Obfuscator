local ascii = [[

                         .@%(/*,.......      ...,,*/(#%&@@.
                     (*   ,/(#%%&&@@@@&%((////(((##%###((/**,,.     ,//(&.
                   /* .%@@@@@@@@%,  .(&@@@&&&&&&@@@@@@&#(*,........*%@@@(.  ,#.
                 */ .&@@@@@@@*  (%,   *(&&@@@@@&%(*,.             .,*(#%(*@@&*  *,.
                #, /@@@@@@* *&( ,&&/.,/#%&&@@@&(&@@@@@@@@@@@@#*,.....,/&@@@@@@@@( .%
               #  #@@@@@*/@% .#%./(,.,/*,//*,.,/(*@@@@@@@@@@@@%@@@@@@@@@#.#@@@@@@&. %
              /  &@@@@@@@@(%@# *&&*&@@@@#/&@@@@/%%.,%@@@@@@@%/@@&(,  ,,,...  *%@@@# *
            #  .&@@@@@@@@@@@,((%@@@@@#.    ,&@@#@@&* .&@@@@@&,.#@@@@/&@@%(@@@&(/,(&, /
         (/   (@&&&%&@@@&/, ,@#(@@@@,        #@@/,&@& /@@@@@,%#%@@@@@(     *@@@@@&,%%. .
        /  #/,#@@@&#(//#@@@/ %@@@&@@@(.    ,&@@(.*/*  %@@*   %@@@@@@%       (@@&(*...%&.
         ///@@&,  (&@@#,   /@/ ,*&@@@@#&@@%#%((%@&* /@@@@@@&. #@@@#&@@@&%%@@@@@@&,/(*@/#
        %%.&@# .&@@@# /@@@@%&@@@&/.   ,/((/*,  ./&@@@@@@@@@@,*&(./%@@#*&@@@(#(....,&#*@/
        @%.&& .&@@@&*    /&@@@@@@@@@@@@@@@@&@@#/(%@@@@@@@@@@&,  (@@@@@@@@@@@@/,@@@@@#.&*
        &&,%% .&*    /@@@(.  ,(@@@@@&/(////#( /&@@@@@@@@@@@@@@@(  ,&@@@@@@@@&, (@@&*/@(/
        .%*#@( /@@@@( *@@@@@@/     *%@@@@@@@&.,@& ,#, .&@@@@@@# .#*%&/,#@@@@*   *@@&/*&*
         .&/.#@@@@@@@,   *&@@%.,&@@&(,    ,(%@%&@@@@@@@@@(.*,  /@@@@@@@@@&,      %@@@@..
        @* .%@@@@@@@@(       .   (@@@@@@@@(       .*(%&@@@@@@@@@@@@&(,  ./.*@%   /@@% ./
          @* .&@@@@@@&.             ./&@@@*.&@@@@@@@&, ,**,.    .,*(&(.%@@# %@*  ,@@% ,#
            &, /@@@@@@*                    .#@@@@@@@@*.%@@@@@(,@@@@@@& ,%(.      .&@% ,#
              / *@@@@@#                                                           %@&.,#
              (( .&@@@@*                                                          #@&.,#
               .&. ,&@@@,                                                         (@&.,#
                  #. .%@@* /@@/                                                   /@&.,(
                    ./  #@%. %@&,,#,                                              /@@,./
                      *(  #@%. . (@@@@@%/,                                        /@@,.*
                        //  %@&, *@@@@@@@@( (@%/.                                 #@@, (
                          #* .&@@#. (@@@@&.*@@@@@@@@%. */.                  *..%*.&@@, /
                            @* .%@@@%, ,/ .@@@@@@@@@@,.%@@@@@% .&@@@* #@&..&@*,* %@@&. *
                               /  *&@@@@%,   *(&@@@@&. #@@@@@* #@@@% (@@* ,.   /@@@@* (
                                 @#. .#@@@@@@&(,.                      .,*(%&@@@@@&..(
                                     &(.   ./%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@(. ((
                                          ,#/*.       ..,,,,,,,,....          ,/#

]]

local function printdtc()
    print(ascii)
    print("detected by ??")
end

if type(_G) ~= "table" or not string.find(tostring(_G), "table: ") then
    printdtc()
    return
end

if _VERSION ~= "Luau" then
    printdtc()
    return
end

local success, res = pcall(function() return game:GetService("CorePackages") end)
if not success then
    printdtc()
    return
end

local runserv = game:GetService("RunService")
for i = 1, 125 do
    if runserv:IsStudio() then
        printdtc()
        return
    end
end

local lunee = pcall(function() return require("@lune/fs") end)
if lunee then
    printdtc()
    return
end

local Players = game:GetService("Players")
local function validatePlayers()
    local playerList = Players:GetPlayers()
    for _, player in ipairs(playerList) do
        if not player:IsA("Player") then
            printdtc()
            return false
        end
    end
    return true
end

if not validatePlayers() then
    return
end

local vcs = game:GetService("VoiceChatService")
local function vccheck()
    printdtc()
    while true do task.wait() end
end
if type(vcs.joinVoice) ~= "function" then
    vccheck()
end
if type(vcs.rejoinVoice) ~= "function" then
    vccheck()
end
if type(vcs.leaveVoice) ~= "function" then
    vccheck()
end

local ss = game:GetService("SoundService")

local function sscheck()
    printdtc()
    while true do end
end
if type(ss.GetAudioInstances) ~= "function" then
    sscheck()
end
if type(ss.GetInputDevices) ~= "function" then
    sscheck()
end
if type(ss.GetOutputDevices) ~= "function" then
    sscheck()
end

local assetdetection = (cloneref and cloneref(game:GetService("AssetService"))) or game:GetService("AssetService")
local function dtcissocute()
    local pass = false
    local success = pcall(function()
        if not assetdetection or not assetdetection.CreateEditableMesh then return end
        local mesh = assetdetection:CreateEditableMesh()
        if not mesh then return end
        local randX, randY, randZ = math.random(5, 50) + math.random(), math.random(5, 50) + math.random(), math.random(5, 50) + math.random()
        local salsavertaa = math.random(2, 5)
        local v2 = mesh:AddVertex(Vector3.new(randX, randY, randZ))
        for i = 1, salsavertaa do mesh:AddVertex(Vector3.new(i, i, i)) end
        local p2 = mesh:GetPosition(v2)
        mesh:Destroy()
        if p2 and math.abs(p2.X - randX) < 1e-4 and math.abs(p2.Y - randY) < 1e-4 and math.abs(p2.Z - randZ) < 1e-4 then
            pass = true
        end
    end)
    return success and pass
end

if not dtcissocute() then
    printdtc()
    return
end

print("You are ud with your result including me n shit!")

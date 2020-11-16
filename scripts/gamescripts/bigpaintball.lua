print("Phantom Forces Script Loaded!")

local bigpaintballsettings = {}
local aimbotbasesettings = {}

local library = loadstring(syn.request({Url = "https://raw.githubusercontent.com/Pawel12d/hexhub.github.io/master/scripts/uilibrary.lua", Method = "GET"}).Body)()
local MainWindow = library:CreateWindow(Vector2.new(500, 500), Vector2.new(120, 120))
local LaunchTick = tick()

local Client = require(game.ReplicatedStorage.Framework.Library)
local DoesOwnGun = Client.GunCmds.DoesOwnGun
local NetworkHook = Client.Network.Fire

local MainTab = MainWindow:CreateTab("Main")

local MainTabCategoryMain = MainTab:AddCategory("Main")

MainTabCategoryMain:AddButton("Unlock All", function()
    Client.GunCmds.DoesOwnGun = function()
        return true
    end
    
    Client.Network.Fire = function(self, ...)
        local args = {...}
        
        if self == "Request Respawn" and not DoesOwnGun(game.Players.LocalPlayer, args[1]) then
            return NetworkHook(self, "1")
        end
    
        return NetworkHook(self, unpack(args))
    end
end)

MainTabCategoryMain:AddButton("Gun Mods", function()
    for i,v in pairs(getgc(true)) do -- gun mods
        if typeof(v) == "table" and rawget(v, "displayName") then
            -- v.displayName = "noob"
            -- v.description = "epik"
            v.damage = 100000
            v.velocity = 99999
            v.automatic = true
            v.shotrate = 0.001
            v.zoomAmount = 4
        end
    end
end)

MainTabCategoryMain:AddToggle("Inf Radars", false, function(val)
    if val == true then ok = true else ok = false end
	while ok do
        wait()
        Client.States[game.Players.LocalPlayer.Name].AvailableItems["1"] = 99
        --Client.States[game.Players.LocalPlayer.Name].AvailableItems["2"] = 99
        --Client.States[game.Players.LocalPlayer.Name].AvailableItems["3"] = 99
        --Client.States[game.Players.LocalPlayer.Name].AvailableItems["4"] = 99
    end
end)

MainTabCategoryMain:AddToggle("Inf Radars", false, function(val)
    if val == true then ok = true else ok = false end
	while ok do
        wait()
        for i,v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer then
                if v.Character and v.Character:FindFirstChild("Humanoid") then
                    local data1 = math.random(1,1)
                    local data2 = v.Character.HumanoidRootPart.Position
                    local data3 = false
                    local data4 = math.random(2,2)
                    local Client = require(game.ReplicatedStorage.Framework.Library)
                    Client.Network.Fire("New Projectile", 1, 1, math.floor(workspace.DistributedGameTime))
                    workspace.__THINGS.__REMOTES["do damage"]:FireServer({{v.Character.Humanoid, data1, data1, data2, data3, data3, data3}, {data3,data3,data3,data3,data3,data4,data4}})
                end
            end
        end
    end
end)
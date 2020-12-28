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
    for i,v in pairs(getgc(true)) do
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

MainTabCategoryMain:AddToggle("Kill All [buggy]", false, function(val)
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

local MainTabCategoryViewmodel = MainTab:AddCategory("Viewmodel")

MainTabCategoryViewmodel:AddToggle("Enabled", false, function(val)
    bigpaintballsettings.ViewmodelEnabled = val
end)

MainTabCategoryViewmodel:AddSlider("Viewmodel X", {0, 360, 180}, function(val)
    bigpaintballsettings.ViewmodelX = val
end)

MainTabCategoryViewmodel:AddSlider("Viewmodel Y", {0, 360, 180}, function(val)
    bigpaintballsettings.ViewmodelY = val
end)

MainTabCategoryViewmodel:AddSlider("Viewmodel Z", {0, 360, 180}, function(val)
    bigpaintballsettings.ViewmodelZ = val
end)


local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall

if setreadonly then setreadonly(mt, false) else make_writeable(mt, true) end

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local callingscript = getcallingscript()
    local args = {...}

    if method == "SetPrimaryPartCFrame" and callingscript == game.Players.LocalPlayer.PlayerScripts.Scripts.Core.Controller and bigpaintballsettings.ViewmodelEnabled == true then
        -- print(self.Name, callingscript)
        args[1] = args[1] * CFrame.new(Vector3.new(math.rad(bigpaintballsettings.ViewmodelX-180), math.rad(bigpaintballsettings.ViewmodelY-180), math.rad(bigpaintballsettings.ViewmodelZ-180)))
    end

    return oldNamecall(self, unpack(args))
end)
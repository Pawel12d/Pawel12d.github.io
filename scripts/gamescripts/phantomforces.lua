print("Phantom Forces Script Loaded!")

local phantomforcessettings = {}
local aimbotbasesettings = {}

for i,v in pairs(getgc(true)) do
	if type(v) == "table" then
		if rawget(v, "network") then
			Network = v
		elseif rawget(v, "setsprintdisable") then
			GameLogic = v
			-- GameLogic.gammo = 1e5
		end
	end
end

--[[
for i,v in pairs(getgc(true)) do
	if type(v) == "table" then
		if rawget(v, "network") then
			Network = v
		elseif rawget(v, "setsprintdisable") then
			GameLogic = v
		end
	end
end


--]]

if not Network or not GameLogic then
	return game.Players.LocalPlayer:Kick("Scanning failed!")
end

game:GetService("RunService"):BindToRenderStep("CharFix", 100, function()
    for i,v in pairs(debug.getupvalue(Network.replication.module.getbodyparts, 1)) do
        if game.Players[i.Name] and game.Players[i.Name].Character == nil then
            game.Players[i.Name].Character = v.head.Parent
        end
    end
end)

networksendhook = hookfunc(Network.network.module.send, function(self, ...)
    local args = {...}
    --[[
    print("Network send:")
    for i,v in pairs(args) do
        print(i,v)
    end
    --]]

    if args[1] == "falldamage" and phantomforcessettings.NoFallDamage == true then
        return
    end

    return networksendhook(unpack(args))
end)

grenadehook = hookfunc(Network.char.module.loadgrenade, function(self, ...)
	local args = {...}
    print("Grenade throw detected!")
    --[[
	if _G.GrenadeMods then
		-- args[2]:FindFirstChildOfClass("BasePart").CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
		-- args[1].throwspeed = 0 -- Useful for grenade teleportation
		args[1].fusetime = 1
		args[1].equipspeed = 0
		args[1].animations.pull = {}
		args[1].animations.throw = {}
    end
    --]]
	return grenadehook(self, unpack(args))
end)
--[[
loadgunhook = hookfunc(Network.char.module.loadchar, function(self, ...)
	local args = {...}
	print("Gun load detected!")
    if phantomforcessettings.GunModsEnabled == true then
        for i,v in pairs(args) do
            print(i,v)
        end
        for i,v in pairs(getgc(true)) do
            if typeof(v) == "table" and rawget(v, "camkickmax") then
                v.camkickmin = Vector3.new()
                v.camkickmax = Vector3.new()
                v.aimcamkickmin = Vector3.new()
                v.aimcamkickmax = Vector3.new()
                v.aimtranskickmin = Vector3.new()
                v.aimtranskickmax = Vector3.new()
                v.transkickmin = Vector3.new()
                v.transkickmax = Vector3.new()
                v.rotkickmin = Vector3.new()
                v.rotkickmax = Vector3.new()
                v.aimrotkickmin = Vector3.new()
                v.aimrotkickmax = Vector3.new()
                v.swayamp = 0
                v.swayspeed = 0
                v.steadyspeed = 0
                v.breathspeed = 0
                -- No Spread
                v.hipfirespread = 0
                v.hipfirestability = 0
                v.hipfirerecovery = 100
                -- Instant Aim
                v.aimspeed = 1000
                v.magnifyspeed = 1000
                -- Other
                v.equipspeed = 1000
                v.magsize = 9999 -- Combine Mags
            end
        end
	end
	return loadgunhook(self, unpack(args))
end)
--]]
local library = loadstring(syn.request({Url = "http://raw.githubusercontent.com/Pawel12d/hexhub.github.io/master/scripts/uilibrary.lua", Method = "GET"}).Body)()
local MainWindow = library:CreateWindow(Vector2.new(500, 500), Vector2.new(120, 120))

local AimbotTab = MainWindow:CreateTab("Aimbot")
local RageTab = MainWindow:CreateTab("Rage")
local VisualsTab = MainWindow:CreateTab("Visuals")
local MiscellaneousTab = MainWindow:CreateTab("Miscellaneous")
local SettingsTab = MainWindow:CreateTab("Settings")

local MiscellaneousTabCategoryMain = AimbotTab:AddCategory("Main")

MiscellaneousTabCategoryMain:AddToggle("No Fall Damage", false, function(val)
	phantomforcessettings.NoFallDamage = val
end)

local MiscellaneousTabCategoryGunMods = AimbotTab:AddCategory("Gun Mods")

MiscellaneousTabCategoryGunMods:AddToggle("Enabled", false, function(val)
	phantomforcessettings.GunModsEnabled = val
end)

MiscellaneousTabCategoryGunMods:AddToggle("No Recoil", false, function(val)
	phantomforcessettings.GunModsNoRecoil = val
end)

local LaunchTick = tick()

MainWindow.close = false

print("Ready! It took", tonumber(tick() - LaunchTick), "seconds to load!")
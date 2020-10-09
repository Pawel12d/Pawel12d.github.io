print("Prison Life Script Loaded! (a)")

local LaunchTick = tick()

function FireTouchTransmitter(target, sender)
	if target and target:IsA("TouchTransmitter") then
		local asdf = sender or game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
		firetouchinterest(asdf, target.Parent, 0)
		wait()
		firetouchinterest(asdf, target.Parent, 1)
	end
end

local function ChangeTeam(team)
	if game:GetService("Teams"):FindFirstChild(team) then
		if team ~= "Criminals" then
			workspace.Remote.TeamEvent:FireServer(tostring(game:GetService("Teams")[team].TeamColor))
		else
			--[[
			local oldpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Criminals Spawn"].SpawnLocation.CFrame -- Criminals
			wait(0.1)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldp
			--]]
			FireTouchTransmitter(workspace["Criminals Spawn"].SpawnLocation.TouchInterest)
		end
	end
end

local PrisonLifeWaypoints = {
	["Test"] = CFrame.new(0, 500, 0)
}

local library = loadstring(game:HttpGet(('http://hexhub.xyz/scripts/uilibrary.lua'),true))() -- UI Library
local MainWindow = library:CreateWindow(Vector2.new(500, 500), Vector2.new(120, 120))

local MainTab = MainWindow:CreateTab("Main Cheats")
local SettingsTab = MainWindow:CreateTab("Settings")

local MainTabGiveCategoryItems = MainTab:AddCategory("Give Items")

MainTabGiveCategoryItems:AddLabel("Guns")

MainTabGiveCategoryItems:AddButton("M4A1", function()
    pcall(function() workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["M4A1"].ITEMPICKUP) end)
end)

MainTabGiveCategoryItems:AddButton("AK-47", function()
	pcall(function() workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["AK-47"].ITEMPICKUP) end)
end)

MainTabGiveCategoryItems:AddButton("Remington 870", function()
    pcall(function() workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP) end)
end)

MainTabGiveCategoryItems:AddButton("M9", function()
    pcall(function() workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["M9"].ITEMPICKUP) end)
end)

MainTabGiveCategoryItems:AddLabel("Other")

MainTabGiveCategoryItems:AddButton("Riot Shield", function()
    pcall(function() workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["Riot Shield"].ITEMPICKUP) end)
end)

MainTabGiveCategoryItems:AddButton("Key card", function()
	pcall(function() workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.single["Key card"].ITEMPICKUP) end)
end)

MainTabGiveCategoryItems:AddButton("Crude Knife", function()
    pcall(function() workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.single["Crude Knife"].ITEMPICKUP) end)
end)

MainTabGiveCategoryItems:AddButton("Hammer", function()
    pcall(function() workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.single["Hammer"].ITEMPICKUP) end)
end)

MainTabGiveCategoryItems:AddButton("Food", function()
    pcall(function()
	workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver.Breakfast.ITEMPICKUP)
	workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver.Dinner.ITEMPICKUP)
	end)
end)

local MainTabCategoryGunMods = MainTab:AddCategory("Gun Mods")

MainTabCategoryGunMods:AddButton("Mod Weapons", function()
    pcall(function()
	for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v:IsA("Tool") and v:FindFirstChild("GunStates") then
			local GunConfiguration = require(v.GunStates)
			-- GunConfiguration.Damage = 100
			GunConfiguration.MaxAmmo = math.huge
			GunConfiguration.CurrentAmmo = math.huge
			GunConfiguration.StoredAmmo = math.huge
			GunConfiguration.FireRate = 0.01
			GunConfiguration.AutoFire = true
			GunConfiguration.Range = math.huge
			GunConfiguration.Spread = 0
			GunConfiguration.ReloadTime = 0
			GunConfiguration.Bullets = 1
		end
	end
	end)
end)

MainTabCategoryGunMods:AddButton("Mod Food", function()
    pcall(function()
	for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v:IsA("Tool") and v:FindFirstChild("LocalScript") and getsenv(game.Players.LocalPlayer.Backpack.Dinner.LocalScript).drink then
			print(v.Name, getsenv(game.Players.LocalPlayer.Backpack.Dinner.LocalScript).drink)
			getsenv(game.Players.LocalPlayer.Backpack.Dinner.LocalScript).drink = math.huge
			getsenv(game.Players.LocalPlayer.Backpack.Dinner.LocalScript).deb = false
			print(v.Name, getsenv(game.Players.LocalPlayer.Backpack.Dinner.LocalScript).drink)
		end
	end
	end)
end)

local MainTabCategoryMiscellaneous = MainTab:AddCategory("Miscellaneous")

MainTabCategoryMiscellaneous:AddDropdown("Switch Team", {"Inmates","Criminals","Guards","Neutral"}, function(val)
	pcall(function() ChangeTeam(val) end)
end)

MainTabCategoryMiscellaneous:AddButton("Respawn", function()
    pcall(function() game.Workspace.Remote.loadchar:InvokeServer(game.Players.LocalPlayer) end)
end)

MainTabCategoryMiscellaneous:AddButton("Inf Stamina", function()
    pcall(function()
	for i,v in pairs(getreg()) do 
		if type(v) == "function" and getfenv(v).script == game.Players.LocalPlayer.Character.ClientInputHandler then 
			for i2,v2 in pairs(getupvalues(v)) do 
				if type(v2) == "number" then 
					debug.setupvalue(v, i2, 999999)
				end
			end
		end
	end
	end)
end)

MainTabCategoryMiscellaneous:AddToggle("No Punch Cooldown", function(val)
	while val == true do
		wait(0.01)
		pcall(function()
		getsenv(game.Players.LocalPlayer.Character.ClientInputHandler).cs.isFighting = false
		end)
	end
end)

local MainTabCategoryFun = MainTab:AddCategory("Fun")

MainTabCategoryFun:AddLabel("Main")

MainTabCategoryFun:AddButton("Push-Ups Animation", function()
    pcall(function()
	local Animation = Instance.new("Animation")
	Animation.AnimationId = "http://www.roblox.com/asset/?id=175676962"
	Animation.Parent = nil
	local LoadAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Animation)
	LoadAnim:Play()
	LoadAnim:AdjustSpeed(1)
	LoadAnim.Parent = nil
	end)
end)

MainTabCategoryFun:AddButton("Spawn Hats", function()
	pcall(function()
	local oldpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if v:IsA("Accessory") then
			v.Parent = workspace
		end
	end
	game.Workspace.Remote.loadchar:InvokeServer(game.Players.LocalPlayer)
	wait(0.1)
	repeat wait() until game.Players.LocalPlayer.Character
	repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
	end)
end)

MainTabCategoryFun:AddLabel("Notifications (Client)")


local SettingsTabCategoryMain = SettingsTab:AddCategory("Main")

SettingsTabCategoryMain:AddButton("Rejoin Server", function()
    pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer) end)
end)

MainWindow.close = false

print("Ready! It took", tonumber(tick() - LaunchTick), "seconds to load!")
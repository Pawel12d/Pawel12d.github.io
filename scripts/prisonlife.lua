print("Prison Life Script Loaded! (a)")

local LaunchTick = tick()

local function ChangeTeam(team)
	if game:GetService("Teams"):FindFirstChild(team) then
		if team ~= "Criminals" then
			game.Workspace.Remote.TeamEvent:FireServer(game:GetService("Teams")[team].TeamColor)
		else
			local oldpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace["Criminals Spawn"].SpawnLocation.CFrame -- Criminals
			wait(0.1)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
		end
	end
end

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

MainTabCategoryGunMods:AddButton("Mod Inventory", function()
    pcall(function()
	for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v:IsA("Tool") and v:FindFirstChild("GunStates") then
			local GunConfiguration = require(v.GunStates)
			GunConfiguration.MaxAmmo = math.huge
			GunConfiguration.CurrentAmmo = math.huge
			GunConfiguration.StoredAmmo = math.huge
			GunConfiguration.FireRate = 0.001
			GunConfiguration.AutoFire = true
			GunConfiguration.Range = 9999
			GunConfiguration.ReloadTime = 0
			GunConfiguration.Bullets = 5
		end
	end
	end)
end)

local MainTabCategoryMiscellaneous = MainTab:AddCategory("Miscellaneous")

MainTabCategoryMiscellaneous:AddDropdown("Switch Team", {"Inmates","Criminals","Guards","Neutral"}, function(val)
	ChangeTeam(val)
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
					debug.setupvalue(v, i2, 13)
				end
			end
		end
	end
	end)
end)

local SettingsTabCategoryMain = SettingsTab:AddCategory("Main")

SettingsTabCategoryMain:AddButton("Rejoin Server", function()
    pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer) end)
end)

MainWindow.close = false

print("Ready! It took", tonumber(tick() - LaunchTick), "seconds to load!")
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
		if team ~= "Criminals" then -- switching Guards (while having guard items) -> Criminals makes player respawn
			workspace.Remote.TeamEvent:FireServer(tostring(game:GetService("Teams")[team].TeamColor))
		else
			FireTouchTransmitter(workspace["Criminals Spawn"].SpawnLocation.TouchInterest)
		end
	end
end
--[[
local function Get_Player_Vehicle(plr)
	for i,v in pairs(workspace.CarContainer:GetChildren()) do
		if v:FindFirstChild("Body") and v.Body:FindFirstChild("VehicleSeat") and v.Body.VehicleSeat:FindFirstChild("SeatWeld") then
			if game.Players:GetPlayerFromCharacter(v.Body.VehicleSeat.SeatWeld.Part1.Parent) then
				if game.Players:GetPlayerFromCharacter(v.Body.VehicleSeat.SeatWeld.Part1.Parent).Name == plr.Name then
					return v
				end
			end
		end
	end
	return false
end

if Get_Player_Vehicle(game.Players.LocalPlayer) ~= false then
	Get_Player_Vehicle(game.Players.LocalPlayer):SetPrimaryPartCFrame(CFrame.new(game.Players.dogefun908.Character.HumanoidRootPart.Position + Vector3.new(0, 10, 0)))
end

game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.dogefun908.Character.HumanoidRootPart.Position + Vector3.new(0, 10, 0))
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
--]]
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
    pcall(function() workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver.Breakfast.ITEMPICKUP) end)
	pcall(function() workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver.Lunch.ITEMPICKUP) end)
	pcall(function() workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver.Dinner.ITEMPICKUP) end)
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
		if v:IsA("Tool") and v:FindFirstChild("LocalScript") and getsenv(v.LocalScript).drink then
			print(v.Name, getsenv(v.LocalScript).drink)
			getsenv(v.LocalScript).drink = math.huge
			getsenv(v.LocalScript).deb = false
			print(v.Name, getsenv(v.LocalScript).drink)
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
	if val == true then
		ok = true
	else
		ok = false
	end
	while ok do
		wait(0.01)
		pcall(function()
		getsenv(game.Players.LocalPlayer.Character.ClientInputHandler).cs.isFighting = false
		end)
	end
end)

local MainTabCategoryFun = MainTab:AddCategory("Fun")

MainTabCategoryFun:AddLabel("Main")

MainTabCategoryFun:AddButton("Lifting the weight", function()
    pcall(function()
	local Animation = Instance.new("Animation")
	Animation.AnimationId = "http://www.roblox.com/asset/?id=175676962"
	Animation.Parent = nil
	local LoadAnim = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Animation)
	LoadAnim:Play()
	LoadAnim:AdjustSpeed(1)
	LoadAnim.Parent = nil
	
	local a = math.random(1,2)
	if a == 1 then cool = 2552.93018 else cool = 2536.93018 end
	
	game.Players.LocalPlayer.Character.Humanoid.Sit = true
	game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(768.998718, 98.1000595, cool, -4.37113883e-08, -1, 4.37113883e-08, -4.37113918e-08, -4.37113847e-08, -1, 1, -4.37113918e-08, -4.37113883e-08)
	print("done1")
	repeat wait() until (game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) and game:GetService("UserInputService"):GetFocusedTextBox() == nil)
	print("done2")
	game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
	LoadAnim:Stop()
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
	wait(0.2)
	game.Workspace.Remote.loadchar:InvokeServer(game.Players.LocalPlayer)
	wait(0.1)
	repeat wait() until game.Players.LocalPlayer.Character
	repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
	end)
end)

MainTabCategoryFun:AddButton("Destroy Toilets", function()
	pcall(function()
	workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.single["Hammer"].ITEMPICKUP)
	for i,v in pairs(game.Workspace["Prison_Cellblock"]["Cells_A"]:GetChildren()) do
		spawn(function()
		for i=1,25 do
			if v:FindFirstChild("Toilet") then
				game.ReplicatedStorage.meleeEvent:FireServer(v.Toilet, game.Players.LocalPlayer.Backpack.Hammer)
				wait()
			end
		end
		end)
	end
	for i,v in pairs(game.Workspace["Prison_Cellblock"]["Cells_B"]:GetChildren()) do
		spawn(function()
		for i=1,25 do
			if v:FindFirstChild("Toilet") then
				game.ReplicatedStorage.meleeEvent:FireServer(v.Toilet, game.Players.LocalPlayer.Backpack.Hammer)
				wait()
			end
		end
		end)
	end
	end)
end)

MainTabCategoryFun:AddLabel("Notifications (Client)")

MainTabCategoryFun:AddButton("Send Notification", function()
	pcall(function()
	if NotificationType == "Tooltip" then
		require(game.ReplicatedStorage.Modules_client.TooltipModule).update(NotificationText or "Text")
	elseif NotificationType == "Warn" then
		local WarningNotify = game.ReplicatedStorage.gooeys.WarnGui:Clone()
		WarningNotify.Parent = game.Players.LocalPlayer.PlayerGui
		WarningNotify.Frame.title.Text = NotificationTitle or "Title"
		WarningNotify.Frame.desc.Text = NotificationText or "Text"
		WarningNotify.Frame.LocalScript.Disabled = false
	elseif NotificationType == "Prompt" then
		local PromptNotify = game.ReplicatedStorage.gooeys.promptGui:Clone()
		PromptNotify.Parent = game.Players.LocalPlayer.PlayerGui
		PromptNotify.Frame.Frame.title.Text = NotificationTitle or "Title"
		PromptNotify.Frame.Frame.body.Text = NotificationText or "Text"
		PromptNotify.Frame.Frame.TextButton.Text = "Close"
		PromptNotify.Frame.Frame.TextButton.MouseButton1Down:Connect(function() PromptNotify:Remove() end)
		PromptNotify.Frame.Position = UDim2.new({0, 0}, {0, 0})
	end
	end)
end)

MainTabCategoryFun:AddDropdown("Notification Type", {"Tooltip","Warn","Prompt"}, function(val)
	pcall(function() NotificationType = val end)
end)

MainTabCategoryFun:AddTextBox("Notification Title", "Title", function(val)
	pcall(function() NotificationTitle = val end)
end)

MainTabCategoryFun:AddTextBox("Notification Text", "Text", function(val)
	pcall(function() NotificationText = val end)
end)

local MainTabCategoryAura = MainTab:AddCategory("Aura")

MainTabCategoryAura:AddToggle("Enabled", function(val)
	if val == true then
		ok = true
	else
		ok = false
	end
	while ok do
		wait(0.01)
		pcall(function()
			for i,v in pairs(game.Players:GetChildren()) do
				if v ~= game.Players.LocalPlayer and v.Character and v.Character.Humanoid and v.Character.Humanoid.Health>0 then
					if AuraTarget == "All" or (AuraTarget == "Enemies" and v.Team ~= game.Players.LocalPlayer.Team) or (AuraTarget == "Teammates" and v.Team == game.Players.LocalPlayer.Team) then
						if (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude < 20 then
							if AuraMode == "Kill" then
								game.ReplicatedStorage.meleeEvent:FireServer(v)
							elseif AuraMode == "Taze" then
								local args = {{
									["RayObject"] = Ray.new(), 
									["Distance"] = 1, 
									["Cframe"] = CFrame.new(), 
									["Hit"] = v.Character.HumanoidRootPart
								}}
								-- will the socialist above ever shut up? ^
								game:GetService("ReplicatedStorage").ShootEvent:FireServer(args, game.Players.LocalPlayer.Backpack.Taser)
							elseif AuraMode == "Arrest" then
								game.Workspace.Remote.arrest:InvokeServer(v.Character.HumanoidRootPart)
							end
						end
					end
				end
			end
		end)
	end
end)

MainTabCategoryAura:AddDropdown("Target", {"All","Enemies","Teammates"}, function(val)
	pcall(function() AuraTarget = val end)
end)

MainTabCategoryAura:AddDropdown("Mode", {"Kill","Taze","Arrest"}, function(val)
	pcall(function() AuraMode = val end)
end)

local MainTabCategoryPlayers = MainTab:AddCategory("Players")
-- {"All","Enemies","Teammates"}
MainTabCategoryPlayers:AddDropdown("Target", {"test"}, function(val)
	pcall(function() PlayersTarget = val end)
end)

local SettingsTabCategoryMain = SettingsTab:AddCategory("Main")

SettingsTabCategoryMain:AddButton("Rejoin Server", function()
    pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer) end)
end)

MainWindow.close = false

print("Ready! It took", tonumber(tick() - LaunchTick), "seconds to load!")
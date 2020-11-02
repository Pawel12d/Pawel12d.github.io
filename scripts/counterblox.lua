print("Counter Blox Script Loaded!")

getgenv().HexHubSettings.tempsettings.counterblox = {}

local LaunchTick = tick()
local oldinv = getsenv(game.Players.LocalPlayer.PlayerGui:WaitForChild("Client")).CurrentInventory
local SkinsTableNames = {}; 
local AllSkinsTable = {}

for i,v in pairs(getgenv().HexHubSettings.permsettings.counterblox.InventoryTables) do table.insert(SkinsTableNames, i) end


	for i,v in pairs(game.ReplicatedStorage.Skins:GetChildren()) do
		if v:IsA("Folder") and game.ReplicatedStorage.Weapons:FindFirstChild(v.Name) then
			for i,c in pairs(v:GetChildren()) do
				table.insert(AllSkinsTable, {v.Name.."_"..c.Name})
			end
		end
	end
	for i,v in pairs(game.ReplicatedStorage.Gloves:GetChildren()) do
		if v:FindFirstChild("Type") then
			local GloveType = 
				(v.Type.Value == "Straps" and "Strapped Glove") or
				(v.Type.Value == "Wraps" and "Handwraps") or
				(v.Type.Value == "Sports" and "Sports Glove") or
				(v.Type.Value == "Fingerless" and "Fingerless Glove")
				
			if GloveType then
				table.insert(AllSkinsTable, {GloveType.."_"..v.Name})
			end
		end
	end


local cbClient = getsenv(game.Players.LocalPlayer.PlayerGui:WaitForChild("Client"))
local cbfirebullet = cbClient.firebullet
local cbPickup = cbClient.pickup
local cbSpeedUpdate = cbClient.speedupdate
local cbDisplayChat = getsenv(game.Players.LocalPlayer.PlayerGui.GUI.Main.Chats.DisplayChat)
local cbGetIcon = require(game.ReplicatedStorage.GetIcon)

local library = loadstring(game:HttpGet(('http://hexhub.xyz/scripts/uilibrary.lua'),true))() -- UI Library
local MainWindow = library:CreateWindow(Vector2.new(500, 500), Vector2.new(120, 120))

local AimbotTab = MainWindow:CreateTab("Aimbot")
local VisualsTab = MainWindow:CreateTab("Visuals")
local MiscellaneousTab = MainWindow:CreateTab("Miscellaneous")
local SettingsTab = MainWindow:CreateTab("Settings")

local MiscellaneousTabCategoryMain = MiscellaneousTab:AddCategory("Main")

MiscellaneousTabCategoryMain:AddDropdown("Inventory Changer", SkinsTableNames, "Default", function(val)
	local oldSkinsCT = game.Players.LocalPlayer.SkinFolder.CTFolder:Clone()
	local oldSkinsT = game.Players.LocalPlayer.SkinFolder.TFolder:Clone()
	local selected = getgenv().HexHubSettings.permsettings.counterblox.InventoryTables[val]

	if typeof(selected) == "table" then
		cbClient.CurrentInventory = getgenv().HexHubSettings.permsettings.counterblox.InventoryTables[val]
	elseif tostring(val) == "Default" then
		cbClient.CurrentInventory = oldinv
	elseif tostring(val) == "All" then
		cbClient.CurrentInventory = AllSkinsTable
	end

	local InventoryLoadout = game.Players.LocalPlayer.PlayerGui.GUI["Inventory&Loadout"]
	if InventoryLoadout.Visible == true then
		InventoryLoadout.Visible = false
		InventoryLoadout.Visible = true
	end
end)

MiscellaneousTabCategoryMain:AddToggle("Kill All", false, function(val)
	pcall(function()
	if val == true then
		game:GetService("RunService"):BindToRenderStep("KillAllLoop", 1, function()
				pcall(function()
					for i,v in pairs(game.Players:GetChildren()) do
						if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
							if game.Players.LocalPlayer.Character.EquippedTool and v.Team ~= game.Players.LocalPlayer.Team then
								game.ReplicatedStorage.Events.HitPart:FireServer(unpack({
									[1] = v.Character.Head,
									[2] = v.Character.Head.Position,
									[3] = "Banana", -- game.Players.LocalPlayer.Character.EquippedTool.Value,
									[4] = 100,
									[5] = game.Players.LocalPlayer.Character.Gun,
									[8] = 100, -- Damage Multiplier
									[9] = false, -- ?
									[10] = false, -- Is Wallbang
									[11] = Vector3.new(),
									[12] = math.rad(1,100000),
									[13] = Vector3.new()
								}))
							end
						end
					end
				end)
		end)
	else
		game:GetService("RunService"):UnbindFromRenderStep("KillAllLoop")
	end
	end)
end)

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall

setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = tostring(getnamecallmethod())
	local callingscript = getcallingscript()
    local args = {...}
	
    if method == "Kick" then
		print("client kick detection")
        return wait(99e99)
	elseif args[1] == game.Players.LocalPlayer.UserId then
		return wait(99e99)
    elseif method == "SetPrimaryPartCFrame" then

    elseif method == "FindPartOnRayWithWhitelist" then

    elseif method == "FindPartOnRayWithIgnoreList" then
	
	elseif method == "InvokeServer" then
		if self.Name == "Hugh" then
			return wait(99e99)
		end
	elseif method == "FireServer" then
		if string.len(self.Name) == 38 then
			return wait(99e99)
		elseif self.Name == "test" then
			print("noclip detection")
			return wait(99e99)
		elseif self.Name == "DataEvent" and args[1][1] == "EquipItem" then
			local MainTable = args[1]
			local ItemTable = args[1][4]
			local Skin = string.split(ItemTable[1], "_")[2]
			
			if MainTable[2] == "Both" then
				game.Players.LocalPlayer.SkinFolder.TFolder[MainTable[3]]:ClearAllChildren()
				game.Players.LocalPlayer.SkinFolder.TFolder[MainTable[3]].Value = Skin
				game.Players.LocalPlayer.SkinFolder.CTFolder[MainTable[3]].Value = Skin
				if ItemTable[2] == "StatTrak" then
					local MarkerT = Instance.new("StringValue")
					MarkerT.Name = "StatTrak"
					MarkerT.Value = ItemTable[3]
					MarkerT.Parent = game.Players.LocalPlayer.SkinFolder.TFolder[MainTable[3]]
					local CountT = Instance.new("IntValue")
					CountT.Name = "Count"
					CountT.Value = ItemTable[4]
					CountT.Parent = MarkerT
					local MarkerCT = Instance.new("StringValue")
					MarkerCT.Name = "StatTrak"
					MarkerCT.Value = ItemTable[3]
					MarkerCT.Parent = game.Players.LocalPlayer.SkinFolder.CTFolder[MainTable[3]]
					local CountCT = Instance.new("IntValue")
					CountCT.Name = "Count"
					CountCT.Value = ItemTable[4]
					CountCT.Parent = MarkerCT
				end
			else
				game.Players.LocalPlayer.SkinFolder[MainTable[2].."Folder"][MainTable[3]]:ClearAllChildren()
				game.Players.LocalPlayer.SkinFolder[MainTable[2].."Folder"][MainTable[3]].Value = Skin
				if ItemTable[2] == "StatTrak" then
					local Marker = Instance.new("StringValue")
					Marker.Name = "StatTrak"
					Marker.Value = ItemTable[3]
					Marker.Parent = game.Players.LocalPlayer.SkinFolder[MainTable[2].."Folder"][MainTable[3]]
					local Count = Instance.new("IntValue")
					Count.Name = "Count"
					Count.Value = ItemTable[4]
					Count.Parent = Marker
				end
			end
		end
    end
	
	return oldNamecall(self, unpack(args))
end)

MainWindow.close = false

print("Ready! It took", tonumber(tick() - LaunchTick), "seconds to load!")


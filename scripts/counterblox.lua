print("Counter Blox Script Loaded!")

local LaunchTick = tick()

local SkinsTable = {
	{'Glock_Stock'},
	{'AWP_Nerf'},
	{'AK47_VAV'},
	{'Butterfly Knife_Frozen Dream'}
}

local cbClient = getsenv(game.Players.LocalPlayer.PlayerGui:WaitForChild("Client"))
local cbfirebullet = cbClient.firebullet
local cbPickup = cbClient.pickup
local cbSpeedUpdate = cbClient.speedupdate
local cbDisplayChat = getsenv(game.Players.LocalPlayer.PlayerGui.GUI.Main.Chats.DisplayChat)
local cbGetIcon = require(game.ReplicatedStorage.GetIcon)
-- cbClient.CurrentInventory = skins

local library = loadstring(game:HttpGet(('http://hexhub.xyz/scripts/uilibrary.lua'),true))() -- UI Library
local MainWindow = library:CreateWindow(Vector2.new(500, 500), Vector2.new(120, 120))

local AimbotTab = MainWindow:CreateTab("Aimbot")
local VisualsTab = MainWindow:CreateTab("Visuals")
local MiscellaneousTab = MainWindow:CreateTab("Miscellaneous")
local SettingsTab = MainWindow:CreateTab("Settings")

local MiscellaneousTabCategoryMain = MiscellaneousTab:AddCategory("Main")

MiscellaneousTabCategoryMain:AddToggle("Enabled", false, function(val)
	if val == true then
		InventoryUnlockerEnabled = true
		
		local oldSkinsCT = game.Players.LocalPlayer.SkinFolder.CTFolder:Clone()
		local oldSkinsT = game.Players.LocalPlayer.SkinFolder.TFolder:Clone()
		
		cbClient.CurrentInventory = SkinsTable
	else
		InventoryUnlockerEnabled = false
		
		if oldSkinsCT then oldSkinsCT.Parent = game.Players.LocalPlayer.SkinFolder end
		if oldSkinsT then oldSkinsT.Parent = game.Players.LocalPlayer.SkinFolder end
		
		oldSkinsCT = nil
		oldSkinsT = nil
		
	end
end)

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall

setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = tostring(getnamecallmethod())
	local callingscript = getcallingscript()
    local args = {...}
	
    if method == "Kick" then
		print("detection1")
        return wait(99e99)
	elseif args[1] == game.Players.LocalPlayer.UserId then
		print("detection 2")
		return wait(99e99)
    elseif method == "SetPrimaryPartCFrame" then

    elseif method == "FindPartOnRayWithWhitelist" then

    elseif method == "FindPartOnRayWithIgnoreList" then
	
	elseif method == "InvokeServer" and self.Name == "Hugh" then
		print("detection 3")
		return true
    elseif method == "FireServer" then
		if self.Name == "DataEvent" and args[1][1] == "EquipItem" then
			print("skin changing remote")
			
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
		elseif string.len(self.Name) == 38 then
			if InventoryUnlockerEnabled then
				args[1] = SkinsTable
				print("Skins Changed!")
			end
		end
    end
	
	return oldNamecall(self, unpack(args))
end)

MainWindow.close = false

print("Ready! It took", tonumber(tick() - LaunchTick), "seconds to load!")


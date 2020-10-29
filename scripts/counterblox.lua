print("Counter Blox Script Loaded!")

local LaunchTick = tick()

local SkinsTable = {
	{'Glock_Stock'},
	{'P2000_Stock'},
	{'USP_Stock'}
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

MiscellaneousTab:AddToggle("Enabled", false, function(val)
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
    local method = getnamecallmethod()
	local callingscript = getcallingscript()
    local args = {...}
	
    if method == "kick" then
		print("detection1")
        return wait(99e99)
	elseif tonumber(args[1]) == tonumber(game.Players.LocalPlayer.UserId) then
		print("detection 2")
		return wait(99e99)
    elseif method == "SetPrimaryPartCFrame" then

    elseif method == "FindPartOnRayWithWhitelist" then

    elseif method == "FindPartOnRayWithIgnoreList" then

    elseif method == "InvokeServer" then
        if self.Name == "Hugh" then
			print("detection 3")
            return wait(99e99)
        end
    elseif method == "FireServer" then
		if self.Name == "DataEvent" and args[1][4] then
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
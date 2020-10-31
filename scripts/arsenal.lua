print("Arsenal Script Loaded!")

local library = loadstring(game:HttpGet(('http://hexhub.xyz/scripts/uilibrary.lua'),true))() -- UI Library
local MainWindow = library:CreateWindow(Vector2.new(500, 500), Vector2.new(120, 120))

local LocalTab = MainWindow:CreateTab("Local")
local VisualsTab = MainWindow:CreateTab("Visuals")
local MiscellaneousTab = MainWindow:CreateTab("Miscellaneous")
local SettingsTab = MainWindow:CreateTab("Settings")

HexHubSettings.Arsenal = {}

local LocalTabCategoryMovement = LocalTab:AddCategory("Movement")

LocalTabCategoryMovement:AddToggle("Enabled", false, function(val)
	pcall(function()
	if val == true then
		HexHubSettings.Arsenal.MovementMods = true
	else
		HexHubSettings.Arsenal.MovementMods = false
	end
	end)
end)

LocalTabCategoryMovement:AddSlider("WalkSpeed", {0, 500, 16}, function(val)
    HexHubSettings.Arsenal.MovementModsWalkSpeed = val
end)

LocalTabCategoryMovement:AddSlider("JumpPower", {0, 500, 50}, function(val)
    HexHubSettings.Arsenal.MovementModsJumpPower = val
end)

local VisualsTabCategoryViewmodel = VisualsTab:AddCategory("Viewmodel")

VisualsTabCategoryViewmodel:AddToggle("Enabled", false, function(val)
	pcall(function()
	if val == true then
		HexHubSettings.Arsenal.ViewmodelModsEnabled = true
	else
		HexHubSettings.Arsenal.ViewmodelModsEnabled = false
	end
	end)
end)

VisualsTabCategoryViewmodel:AddSlider("Viewmodel X", {0, 360, 180}, function(val)
    HexHubSettings.Arsenal.ViewmodelModsOffsetX = val
end)

VisualsTabCategoryViewmodel:AddSlider("Viewmodel Y", {0, 360, 180}, function(val)
    HexHubSettings.Arsenal.ViewmodelModsOffsetY = val
end)

VisualsTabCategoryViewmodel:AddSlider("Viewmodel Z", {0, 360, 180}, function(val)
    HexHubSettings.Arsenal.ViewmodelModsOffsetZ = val
end)

local MiscellaneousTabCategoryMain = MiscellaneousTab:AddCategory("Main")

MiscellaneousTabCategoryMain:AddToggle("Kill All", false, function(val)
	pcall(function()
	if val == true then
		HexHubSettings.Arsenal.KillAll = true
	else
		HexHubSettings.Arsenal.KillAll = false
	end
	end)
end)

MiscellaneousTabCategoryMain:AddToggle("Kill Boss", false, function(val)
	pcall(function()
	if val == true then
		HexHubSettings.Arsenal.KillBoss = true
	else
		HexHubSettings.Arsenal.KillBoss = false
	end
	end)
end)

MiscellaneousTabCategoryMain:AddToggle("Disable Filter", false, function(val)
	pcall(function()
	if val == true then
		HexHubSettings.Arsenal.DisableFilter = true
	else
		HexHubSettings.Arsenal.DisableFilter = false
	end
	end)
end)

local MiscellaneousTabCategoryGunMods = MiscellaneousTab:AddCategory("Gun Mods")

MiscellaneousTabCategoryGunMods:AddToggle("Enabled", false, function(val)
	pcall(function()
	if val == true then
		HexHubSettings.Arsenal.GunModsEnabled = true
	else
		HexHubSettings.Arsenal.GunModsEnabled = false
	end
	end)
end)

MiscellaneousTabCategoryGunMods:AddToggle("Infinite Ammo", false, function(val)
	pcall(function()
	if val == true then
		HexHubSettings.Arsenal.GunModsInfAmmo = true
	else
		HexHubSettings.Arsenal.GunModsInfAmmo = false
	end
	end)
end)

MiscellaneousTabCategoryGunMods:AddToggle("Rapid Fire", false, function(val)
	pcall(function()
	if val == true then
		HexHubSettings.Arsenal.GunModsRapidFire = true
	else
		HexHubSettings.Arsenal.GunModsRapidFire = false
	end
	end)
end)

MiscellaneousTabCategoryGunMods:AddToggle("No Recoil", false, function(val)
	pcall(function()
	if val == true then
		HexHubSettings.Arsenal.GunModsNoRecoil = true
	else
		HexHubSettings.Arsenal.GunModsNoRecoil = false
	end
	end)
end)

MiscellaneousTabCategoryGunMods:AddToggle("No Spread", false, function(val)
	pcall(function()
	if val == true then
		HexHubSettings.Arsenal.GunModsNoSpread = true
	else
		HexHubSettings.Arsenal.GunModsNoSpread = false
	end
	end)
end)

local SettingsTabCategoryMain = SettingsTab:AddCategory("Main")

SettingsTabCategoryMain:AddButton("Rejoin Server", function()
    pcall(function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer) end)
end)

local function DamageObject(v, amount)
	amount = amount or 1
	local CurrentGun = game.ReplicatedStorage.Weapons:FindFirstChild(game.Players.LocalPlayer.NRPBS.EquippedTool.Value)
	local args = {
		[1] = v.Head,
		[2] = v.Head.Position,
		[3] = CurrentGun.Name,
		[4] = true and 2,
		[5] = (game.Players.LocalPlayer.Character.Head.Position - v.Head.Position).magnitude,
		[6] = false,
		[7] = true,
		[8] = false,
		[9] = 1,
		[10] = false,
		[11] = CurrentGun["FireRate"].Value,
		[12] = CurrentGun["ReloadTime"].Value,
		[13] = CurrentGun["Ammo"].Value,
		[14] = CurrentGun["StoredAmmo"].Value,
		[15] = CurrentGun["Bullets"].Value,
		[16] = CurrentGun["EquipTime"].Value,
		[17] = CurrentGun["RecoilControl"].Value,
		[18] = CurrentGun["Auto"].Value,
		[19] = CurrentGun["Speed%"].Value,
		[20] = game.ReplicatedStorage.wkspc.DistributedTime.Value
	}
	for i=1,amount do
		game.ReplicatedStorage.Events.HitPart:FireServer(unpack(args))
	end
end

for i,v in pairs(getgc(true)) do
	if type(v) == "function" and debug.getinfo(v).name == "firebullet" then
		HexHubSettings.Arsenal.GameData = v
	end
end

spawn(function()
	while true do
		wait()
		spawn(function()
		if HexHubSettings.Arsenal.GunModsEnabled then
			local GunStats = getfenv(HexHubSettings.Arsenal.GameData)
			
			if HexHubSettings.Arsenal.GunModsInfAmmo then
				debug.setupvalue(HexHubSettings.Arsenal.GameData, 5, 99)
				GunStats.primarystored = 99
			end
			
			if HexHubSettings.Arsenal.GunModsRapidFire then
				GunStats.DISABLED = false
				GunStats.DISABLED2 = false
				GunStats.mode = "automatic"
			end
			
			if HexHubSettings.Arsenal.GunModsNoSpread then
				GunStats.currentspread = 0
			end
			
			if HexHubSettings.Arsenal.GunModsNoRecoil then
				GunStats.recoil = 0
			end
		end
		
		if HexHubSettings.Arsenal.KillAll then
			for i,v in pairs(game.Players:GetPlayers()) do
				if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
					DamageObject(v.Character)
				end
			end
		end
		
		if HexHubSettings.Arsenal.KillBoss then
			if workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Hackula") then
				DamageObject(workspace.Map.Hackula, 3)
			end
		end
		
		if HexHubSettings.Arsenal.MovementMods == true then
			if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
				if game.Players.LocalPlayer.Character.Humanoid.WalkSpeed ~= HexHubSettings.Arsenal.MovementModsWalkSpeed then
					game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = HexHubSettings.Arsenal.MovementModsWalkSpeed
				end
				if game.Players.LocalPlayer.Character.Humanoid.JumpPower ~= HexHubSettings.Arsenal.MovementModsJumpPower then
					game.Players.LocalPlayer.Character.Humanoid.JumpPower = HexHubSettings.Arsenal.MovementModsJumpPower
				end
			end
		end
		end)
	end
end)

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall

if setreadonly then setreadonly(mt, false) else make_writeable(mt, true) end

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local callingscript = getcallingscript()
    local args = {...}

    if method == "SetPrimaryPartCFrame" and self.Name == "Arms" and callingscript == game.Players.LocalPlayer.PlayerGui.GUI.Client and HexHubSettings.Arsenal.ViewmodelModsEnabled == true then
        args[1] = args[1] * CFrame.new(Vector3.new(math.rad(HexHubSettings.Arsenal.ViewmodelModsOffsetX-180), math.rad(HexHubSettings.Arsenal.ViewmodelModsOffsetY-180), math.rad(HexHubSettings.Arsenal.ViewmodelModsOffsetZ-180)))
	elseif method == "InvokeServer" and self.Name == "Filter" and callingscript == game.Players.LocalPlayer.PlayerGui.GUI.Main.Chats.DisplayChat and HexHubSettings.Arsenal.DisableFilter == true then
		return args[1]
    end
    
    return oldNamecall(self, unpack(args))
end)
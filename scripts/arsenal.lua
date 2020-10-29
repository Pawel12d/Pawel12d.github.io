print("Arsenal Script Loaded!")

local library = loadstring(game:HttpGet(('http://hexhub.xyz/scripts/uilibrary.lua'),true))() -- UI Library
local MainWindow = library:CreateWindow(Vector2.new(500, 500), Vector2.new(120, 120))

local LocalTab = MainWindow:CreateTab("Local")
local VisualsTab = MainWindow:CreateTab("Visuals")
local MiscellaneousTab = MainWindow:CreateTab("Miscellaneous")
local SettingsTab = MainWindow:CreateTab("Settings")

local LocalTabCategoryMovement = LocalTab:AddCategory("Movement")

LocalTabCategoryMovement:AddToggle("Enabled", false, function(val)
	pcall(function()
	if val == true then
		CoolMovement = true
	else
		CoolMovement = false
	end
	end)
end)

LocalTabCategoryMovement:AddSlider("WalkSpeed", {0, 500, 16}, function(val)
    WalkSpeed = val
end)

LocalTabCategoryMovement:AddSlider("JumpPower", {0, 500, 50}, function(val)
    JumpPower = val
end)

local VisualsTabCategoryViewmodel = VisualsTab:AddCategory("Viewmodel")

VisualsTabCategoryViewmodel:AddToggle("Enabled", false, function(val)
	pcall(function()
	if val == true then
		ViewmodelChanger = true
	else
		ViewmodelChanger = false
	end
	end)
end)

VisualsTabCategoryViewmodel:AddSlider("Viewmodel X", {0, 360, 180}, function(val)
    ViewmodelX = val
end)

VisualsTabCategoryViewmodel:AddSlider("Viewmodel Y", {0, 360, 180}, function(val)
    ViewmodelY = val
end)

VisualsTabCategoryViewmodel:AddSlider("Viewmodel Z", {0, 360, 180}, function(val)
    ViewmodelZ = val
end)

local MiscellaneousTabCategoryMain = MiscellaneousTab:AddCategory("Main")

MiscellaneousTabCategoryMain:AddToggle("Kill All", false, function(val)
	pcall(function()
	if val == true then
		KillAll = true
	else
		KillAll = false
	end
	end)
end)

MiscellaneousTabCategoryMain:AddToggle("Kill Boss", false, function(val)
	pcall(function()
	if val == true then
		KillBoss = true
	else
		KillBoss = false
	end
	end)
end)

MiscellaneousTabCategoryMain:AddToggle("Disable Filter", false, function(val)
	pcall(function()
	if val == true then
		DisableFilter = true
	else
		DisableFilter = false
	end
	end)
end)

local MiscellaneousTabCategoryGunMods = MiscellaneousTab:AddCategory("Gun Mods")

MiscellaneousTabCategoryGunMods:AddToggle("Enabled", false, function(val)
	pcall(function()
	if val == true then
		GunModsEnabled = true
	else
		GunModsEnabled = false
	end
	end)
end)

MiscellaneousTabCategoryGunMods:AddToggle("Infinite Ammo", false, function(val)
	pcall(function()
	if val == true then
		GunModsInfAmmo = true
	else
		GunModsInfAmmo = false
	end
	end)
end)

MiscellaneousTabCategoryGunMods:AddToggle("Rapid Fire", false, function(val)
	pcall(function()
	if val == true then
		GunModsRapidFire = true
	else
		GunModsRapidFire = false
	end
	end)
end)

MiscellaneousTabCategoryGunMods:AddToggle("No Recoil", false, function(val)
	pcall(function()
	if val == true then
		GunModsNoRecoil = true
	else
		GunModsNoRecoil = false
	end
	end)
end)

MiscellaneousTabCategoryGunMods:AddToggle("No Spread", false, function(val)
	pcall(function()
	if val == true then
		GunModsNoSpread = true
	else
		GunModsNoSpread = false
	end
	end)
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
		print("damaging", v.Name)
	end
end

for i,v in pairs(getgc(true)) do
	if type(v) == "function" and debug.getinfo(v).name == "firebullet" then
		GameData = v
	end
end

spawn(function()
	while true do
		wait()
		if GunModsEnabled then
			local GunStats = getfenv(GameData)
			
			if GunModsInfAmmo then
				GunStats.primarystored = 99
				debug.setupvalue(GameData, 5, 99)
			end
			
			if GunModsRapidFire then
				GunStats.DISABLED = false
				GunStats.DISABLED2 = false
				GunStats.mode = "automatic"
			end
			
			if GunModsNoSpread then
				GunStats.currentspread = 0
			end
			
			if GunModsNoRecoil then
				GunStats.recoil = 0
			end
		end
		
		if KillAll then
			for i,v in pairs(game.Players:GetPlayers()) do
				if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
					DamageObject(v.Character)
				end
			end
		end
		
		if KillBoss then
			if workspace:FindFirstChild("Mapa") and workspace.Map:FindFirstChild("Hackula") then
				DamageObject(workspace.Map.Hackula, 3)
			end
		end
	end
end)

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall

if setreadonly then setreadonly(mt, false) else make_writeable(mt, true) end

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local callingscript = getcallingscript()
    local args = {...}

    if method == "SetPrimaryPartCFrame" and self.Name == "Arms" and callingscript == game.Players.LocalPlayer.PlayerGui.GUI.Client and ViewmodelChanger == true then
        args[1] = args[1] * CFrame.new(Vector3.new(math.rad(ViewmodelX-180), math.rad(ViewmodelY-180), math.rad(ViewmodelZ-180)))
	elseif method == "InvokeServer" and self.Name == "Filter" and callingscript == game.Players.LocalPlayer.PlayerGui.GUI.Main.Chats.DisplayChat and DisableFilter == true then
		return args[1]
    end
    
    return oldNamecall(self, unpack(args))
end)
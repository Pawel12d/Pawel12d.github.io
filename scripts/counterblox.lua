--[[
game.ReplicatedStorage.Events.Vote:FireServer("ChinaVsUsaRap") -- votekick
game.ReplicatedStorage.Remotes.RedeemCode:InvokeServer("Hello") -- redeem twitter code
hugh
--]]

print("Counter Blox Script Loaded!")

getgenv().HexHubSettings.tempsettings.counterblox = {}
getgenv().HexHubSettings.permsettings.aimbotbase = {}

local cbClient = getsenv(game.Players.LocalPlayer.PlayerGui:WaitForChild("Client"))
local cbDisplayChat = getsenv(game.Players.LocalPlayer.PlayerGui.GUI.Main.Chats.DisplayChat)
local cbGetIcon = require(game.ReplicatedStorage.GetIcon)

-- local library = loadstring(game:HttpGet(('http://hexhub.xyz/scripts/uilibrary.lua'),true))() -- UI Library
local library = loadstring(syn.request({Url = "http://hexhub.xyz/scripts/uilibrary.lua", Method = "GET"}).Body)()
local MainWindow = library:CreateWindow(Vector2.new(500, 500), Vector2.new(120, 120))

local LaunchTick = tick()

-- tables & stuff
local oldinv = getsenv(game.Players.LocalPlayer.PlayerGui:WaitForChild("Client")).CurrentInventory
local SkinsTableNames = {}; 
local AllSkinsTable = {}
local AllCasesTable = {}
local AllSoundsTable = {}
local AllMaterialsTable = {}

for i,v in pairs(getgenv().HexHubSettings.permsettings.counterblox.InventoryTables) do table.insert(SkinsTableNames, i) end
for i,v in pairs(game.ReplicatedStorage.Cases:GetChildren()) do table.insert(AllCasesTable, v.Name) end
for i,v in pairs(workspace.Sounds:GetChildren()) do table.insert(AllSoundsTable, v.Name) end
for i,v in pairs(Enum.Material:GetEnumItems()) do table.insert(AllMaterialsTable, v.Name) end

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

local mouse = game:GetService("Players").LocalPlayer:GetMouse()
local CurrentCamera = workspace.CurrentCamera

FLYING = false
flyspeed = 1
QEfly = false

local mouse = game:GetService("Players").LocalPlayer:GetMouse()

function sFLY(toggle)
	repeat wait() until game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild('HumanoidRootPart') and game:GetService("Players").LocalPlayer.Character:FindFirstChild('Humanoid')
	repeat wait() until mouse

	local T = game:GetService("Players").LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
	local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local SPEED = 0

    if toggle == false then
        FLYING = false
        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
    elseif toggle == true then
        local function FLY()
            FLYING = true

            local BG = Instance.new('BodyGyro', T)
            local BV = Instance.new('BodyVelocity', T)

            BG.P = 9e4
            BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            BG.cframe = T.CFrame
            BV.velocity = Vector3.new(0, 0, 0)
            BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
            
            spawn(function()
                repeat wait()
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
                        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
                    end
                    if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                        SPEED = 50
                    elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
                        SPEED = 0
                    end
                    if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
                        BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                        lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
                    elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
                        BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                    else
                        BV.velocity = Vector3.new(0, 0, 0)
                    end
                    BG.cframe = workspace.CurrentCamera.CoordinateFrame
                until not FLYING
                CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
                lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
                SPEED = 0
                BG:destroy()
                BV:destroy()
                if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
                    game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
                end
            end)
        end

        mouse.KeyDown:connect(function(KEY)
            if KEY:lower() == 'w' then
                CONTROL.F = flyspeed
            elseif KEY:lower() == 's' then
                CONTROL.B = - flyspeed
            elseif KEY:lower() == 'a' then
                CONTROL.L = - flyspeed
            elseif KEY:lower() == 'd' then 
                CONTROL.R = flyspeed
            elseif QEfly and KEY:lower() == 'e' then
                CONTROL.Q = flyspeed*2
            elseif QEfly and KEY:lower() == 'q' then
                CONTROL.E = -flyspeed*2
            end
        end)

        mouse.KeyUp:connect(function(KEY)
            if KEY:lower() == 'w' then
                CONTROL.F = 0
            elseif KEY:lower() == 's' then
                CONTROL.B = 0
            elseif KEY:lower() == 'a' then
                CONTROL.L = 0
            elseif KEY:lower() == 'd' then
                CONTROL.R = 0
            elseif KEY:lower() == 'e' then
                CONTROL.Q = 0
            elseif KEY:lower() == 'q' then
                CONTROL.E = 0
            end
        end)

        FLY()
    end
end

local function PLR_VISIBLE(plr)
	local IgnoreList = {game:GetService("Players").LocalPlayer.Character}
	local NewRay = Ray.new(CurrentCamera.CFrame.p, (plr.Character.HumanoidRootPart.Position - CurrentCamera.CFrame.p).unit * 2048)
	local FindPart = workspace:FindPartOnRayWithIgnoreList(NewRay, IgnoreList)
	
	if FindPart and FindPart:IsDescendantOf(plr.Character) then
		return true
	end
	
	return false
end

local function GET_AIMBOT_TARGET()
    local selected = false
    local minFOV = math.huge
    pcall(function()
    for i,v in pairs(game:GetService("Players"):GetPlayers()) do
        if v ~= game:GetService("Players").LocalPlayer then
            if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
                if getgenv().HexHubSettings.permsettings.aimbotbase.MaxDistance == false or (v.Character.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= getgenv().HexHubSettings.permsettings.aimbotbase.MaxDistance then
                    if getgenv().HexHubSettings.permsettings.aimbotbase.FFA or v.TeamColor ~= game:GetService("Players").LocalPlayer.TeamColor then
                        if getgenv().HexHubSettings.permsettings.aimbotbase.VisCheck == false or PLR_VISIBLE(v) == true then
                            local WorldPoint = v.Character[getgenv().HexHubSettings.permsettings.aimbotbase.AimPart].Position
                            local vector, onScreen = CurrentCamera:WorldToScreenPoint(WorldPoint)
                            local maxFOV = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(vector.X, vector.Y)).magnitude
                                
                            if minFOV > maxFOV then
                                minFOV = maxFOV
                                selected = v
                            end
                        end
                    end
                end
            end
        end
    end
    end)
    if selected ~= false then
        return selected
    end
end

local function AIMBOT_LOOP()
	wait()
    pcall(function()
    if game:GetService("Players").LocalPlayer.Character and library.pointer.Parent.Enabled == false then
        local activationMode = getgenv().HexHubSettings.permsettings.aimbotbase.ActivationMode

        if activationMode == "OnKey" and game:GetService("UserInputService"):IsKeyDown(getgenv().HexHubSettings.permsettings.aimbotbase.KeyBind) == false then
            return
        elseif activationMode == "OnShoot" and game:GetService("UserInputService"):IsMouseButtonPressed(Enum.UserInputType.MouseButton1) == false then
            return
        end

		plr = GET_AIMBOT_TARGET()
		
		if plr then
            local WorldPoint = plr.Character[getgenv().HexHubSettings.permsettings.aimbotbase.AimPart].Position
            local vector, onScreen = CurrentCamera:WorldToScreenPoint(WorldPoint)
            local maxFOV = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(vector.X, vector.Y)).magnitude
            
            if maxFOV < getgenv().HexHubSettings.permsettings.aimbotbase.FOV then
                local currentMode = getgenv().HexHubSettings.permsettings.aimbotbase.ShootMode

                if currentMode == "MouseHook" then
                    local magnitudeX = mouse.X-vector.X
                    local magnitudeY = mouse.Y-vector.Y
                    local smoothnessX = magnitudeX/getgenv().HexHubSettings.permsettings.aimbotbase.Smoothing
                    local smoothnessY = magnitudeY/getgenv().HexHubSettings.permsettings.aimbotbase.Smoothing

                    mousemoverel(-smoothnessX, -smoothnessY)
                elseif currentMode == "CameraHook" then
                    workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.p, WorldPoint)
                    -- CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(CFrame.new(CurrentCamera.CFrame.p, WorldPoint), 5)
                elseif currentMode == "RayHook" then
					spawn(function()
						silentaimtarget = plr
						wait(0.1)
						silentaimtarget = nil
					end)
                end
            end
        end
    else
        wait(0.1)
    end
    end)
end

local function ANTIAIMBOT_LOOP()
	pcall(function()
	wait()
	if game.Players.LocalPlayer.Character then
		game.Players.LocalPlayer.Character.Humanoid.AutoRotate = false
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, 0.5, 0)
		game.ReplicatedStorage.Events.ControlTurn:FireServer(-1, false)
		if game.Players.LocalPlayer.Character:FindFirstChild("HeadHB") then
			game.Players.LocalPlayer.Character.HeadHB:Destroy()
		end
		if game.Players.LocalPlayer.Character:FindFirstChild("FakeHead") then
			game.Players.LocalPlayer.Character.FakeHead:Destroy()
		end
		if game.Players.LocalPlayer.Character:FindFirstChild("Head") then
			if game.Players.LocalPlayer.Character.Head.Transparency ~= 0 then
				game.Players.LocalPlayer.Character.Head.Transparency = 0
			end
		end
		end
	end)
end

local function NOCLIP_LOOP()
    if game.Players.LocalPlayer.Character then
        for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if v:IsA("BasePart") and v.CanCollide == true then
                v.CanCollide = false
            end
        end
    end
end

local function KILL_LOOP(plrs)
	pcall(function()
		for i,v in pairs(game.Players:GetChildren()) do
			if v.Team ~= game.Players.LocalPlayer.Team and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then -- table.find(plrs, v)
				game.ReplicatedStorage.Events.HitPart:FireServer(unpack({
					[1] = v.Character.Head,
					[2] = v.Character.Head.Position,
					[3] = "Banana", -- game.Players.LocalPlayer.Character.EquippedTool.Value,
					[4] = 100,
					[5] = game.Players.LocalPlayer.Character.Gun,
					[6] = nil,
					[7] = nil,
					[8] = 100, -- Damage Multiplier
					[9] = nil, -- ?
					[10] = false, -- Is Wallbang
					[11] = Vector3.new(),
					[12] = math.rad(1,100000),
					[13] = Vector3.new()
				}))
			end
		end
	end)
end

local AimbotTab = MainWindow:CreateTab("Aimbot")
local RageTab = MainWindow:CreateTab("Rage")
local VisualsTab = MainWindow:CreateTab("Visuals")
local MiscellaneousTab = MainWindow:CreateTab("Miscellaneous")
local SettingsTab = MainWindow:CreateTab("Settings")

local AimbotTabCategoryMain = AimbotTab:AddCategory("Main")

AimbotTabCategoryMain:AddToggle("Enabled", false, function(val)
	pcall(function()
	if val == true then
		getgenv().HexHubSettings.permsettings.aimbotbase.Enabled = true
		AIMBOT_LOOP_SET = game:GetService("RunService").RenderStepped:connect(AIMBOT_LOOP)
	else
		getgenv().HexHubSettings.permsettings.aimbotbase.Enabled = false
		if AIMBOT_LOOP_SET then AIMBOT_LOOP_SET:Disconnect() end 
	end
	end)
end)

AimbotTabCategoryMain:AddDropdown("Shoot Mode", {"MouseHook", "CameraHook", "RayHook"}, "MouseHook", function(val)
	getgenv().HexHubSettings.permsettings.aimbotbase.ShootMode = val
end)

AimbotTabCategoryMain:AddDropdown("Activation Mode", {"Always", "OnShoot", "OnKey"}, "Always", function(val)
	getgenv().HexHubSettings.permsettings.aimbotbase.ActivationMode = val
end)

AimbotTabCategoryMain:AddDropdown("Aim Part", {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"}, "Head", function(val)
	getgenv().HexHubSettings.permsettings.aimbotbase.AimPart = val
end)

AimbotTabCategoryMain:AddKeybind("Aimbot Keybind", Enum.KeyCode.X, function(val)
	print(val)
	getgenv().HexHubSettings.permsettings.aimbotbase.KeyBind = val
end)

AimbotTabCategoryMain:AddToggle("Free for All", false, function(val)
	pcall(function()
		getgenv().HexHubSettings.permsettings.aimbotbase.FFA = val
	end)
end)

AimbotTabCategoryMain:AddToggle("Visibility Check", false, function(val)
	pcall(function()
		getgenv().HexHubSettings.permsettings.aimbotbase.VisCheck = val
	end)
end)

AimbotTabCategoryMain:AddSlider("Field of View", {0, 500, 0}, function(val)
	if val == 0 then
		getgenv().HexHubSettings.permsettings.aimbotbase.FOV = math.huge
	else
		getgenv().HexHubSettings.permsettings.aimbotbase.FOV = val
	end
end)

AimbotTabCategoryMain:AddSlider("Max Distance", {0, 2048, 0}, function(val)
	if val == 0 then
		getgenv().HexHubSettings.permsettings.aimbotbase.MaxDistance = false
	else
		getgenv().HexHubSettings.permsettings.aimbotbase.MaxDistance = val
	end
end)

AimbotTabCategoryMain:AddSlider("Smoothness", {0, 25, 0}, function(val)
	if val <= 1 then
		getgenv().HexHubSettings.permsettings.aimbotbase.Smoothing = 1
	else
		getgenv().HexHubSettings.permsettings.aimbotbase.Smoothing = val
	end
end)

local RageTabCategoryMain = RageTab:AddCategory("Main")

RageTabCategoryMain:AddToggle("Kill All", false, function(val)
	pcall(function()
		if val == true then
			KILL_LOOP_SET = game:GetService("RunService").RenderStepped:connect(function()
				wait()
				KILL_LOOP(game.Players:GetPlayers())
			end)
		else
			if KILL_LOOP_SET then KILL_LOOP_SET:Disconnect() end
		end
	end)
end)

RageTabCategoryMain:AddToggle("Wallbang", false, function(val)
	pcall(function()
		getgenv().HexHubSettings.permsettings.counterblox.Wallbang = val
	end)
end)

RageTabCategoryMain:AddSlider("Damage Multiplier [Percentage]", {0, 100000, 100}, function(val)
	getgenv().HexHubSettings.permsettings.counterblox.DamageMultiplier = val/100
end)

RageTabCategoryMain:AddButton("Crash Server", function()
	if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
		game:GetService("RunService").RenderStepped:Connect(function() wait(0.1)
			game:GetService("ReplicatedStorage").Events.ThrowGrenade:FireServer(game:GetService("ReplicatedStorage").Weapons["Molotov"].Model, nil, 25, 35, Vector3.new(0,-100,0), nil, nil)
			game:GetService("ReplicatedStorage").Events.ThrowGrenade:FireServer(game:GetService("ReplicatedStorage").Weapons["HE Grenade"].Model, nil, 25, 35, Vector3.new(0,-100,0), nil, nil)
			game:GetService("ReplicatedStorage").Events.ThrowGrenade:FireServer(game:GetService("ReplicatedStorage").Weapons["Decoy Grenade"].Model, nil, 25, 35, Vector3.new(0,-100,0), nil, nil)
			game:GetService("ReplicatedStorage").Events.ThrowGrenade:FireServer(game:GetService("ReplicatedStorage").Weapons["Smoke Grenade"].Model, nil, 25, 35, Vector3.new(0,-100,0), nil, nil)
			game:GetService("ReplicatedStorage").Events.ThrowGrenade:FireServer(game:GetService("ReplicatedStorage").Weapons["Flashbang"].Model, nil, 25, 35, Vector3.new(0,-100,0), nil, nil)
		end)
	end
end)

local RageTabCategoryAntiAimbot = RageTab:AddCategory("Anti Aimbot")

RageTabCategoryAntiAimbot:AddToggle("Enabled", false, function(val)
	pcall(function()
	if val == true then
		getgenv().HexHubSettings.permsettings.counterblox.AntiAimEnabled = true
		ANTIAIMBOT_LOOP_SET = game:GetService("RunService").RenderStepped:connect(ANTIAIMBOT_LOOP)
	else
		getgenv().HexHubSettings.permsettings.counterblox.AntiAimEnabled = false
		if ANTIAIMBOT_LOOP_SET then ANTIAIMBOT_LOOP_SET:Disconnect() end 
		wait()
		game.Players.LocalPlayer.Character.Humanoid.AutoRotate = true
	end
	end)
end)

local VisualsTabCategoryViewmodel = VisualsTab:AddCategory("Viewmodel")

VisualsTabCategoryViewmodel:AddToggle("Enabled", false, function(val)
	pcall(function()
	if val == true then
		getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelModsEnabled = true
	else
		getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelModsEnabled = false
	end
	end)
end)

VisualsTabCategoryViewmodel:AddSlider("Viewmodel X", {0, 360, 180}, function(val)
    getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelModsOffsetX = val
end)

VisualsTabCategoryViewmodel:AddSlider("Viewmodel Y", {0, 360, 180}, function(val)
    getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelModsOffsetY = val
end)

VisualsTabCategoryViewmodel:AddSlider("Viewmodel Z", {0, 360, 180}, function(val)
    getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelModsOffsetZ = val
end)

local VisualsTabCategoryThirdPerson = VisualsTab:AddCategory("Third Person")

VisualsTabCategoryThirdPerson:AddToggle("Enabled", false, function(val)
	pcall(function()
		if val == true then
			game:GetService("RunService"):BindToRenderStep("ThirdPerson", 100, function()
				if game.Players.LocalPlayer.CameraMinZoomDistance ~= getgenv().HexHubSettings.tempsettings.counterblox.ThirdPersonDistance then
					game.Players.LocalPlayer.CameraMinZoomDistance = getgenv().HexHubSettings.tempsettings.counterblox.ThirdPersonDistance
					game.Players.LocalPlayer.CameraMaxZoomDistance = getgenv().HexHubSettings.tempsettings.counterblox.ThirdPersonDistance
					workspace.ThirdPerson.Value = true
				end
			end)
		else
			game:GetService("RunService"):UnbindFromRenderStep("ThirdPerson")
			wait()
			workspace.ThirdPerson.Value = false
			game.Players.LocalPlayer.CameraMinZoomDistance = 0
			game.Players.LocalPlayer.CameraMaxZoomDistance = 0
		end
	end)
end)

VisualsTabCategoryThirdPerson:AddSlider("Distance", {0, 30, 10}, function(val)
    getgenv().HexHubSettings.tempsettings.counterblox.ThirdPersonDistance = val
end)

local VisualsTabCategoryViewmodelChams = VisualsTab:AddCategory("Viewmodel Chams")

VisualsTabCategoryViewmodelChams:AddToggle("Enabled", false, function(val)
	getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsEnabled = val
end)

VisualsTabCategoryViewmodelChams:AddToggle("Arms", false, function(val)
	getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsArmsEnabled = val
end)

VisualsTabCategoryViewmodelChams:AddColorPicker(" | Arms Color", Color3.fromRGB(255, 255, 255), function(val)
	getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsArmsColor = val
end)

VisualsTabCategoryViewmodelChams:AddSlider(" | Arms Transparency", {0, 100, 0}, function(val)
	getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsArmsTransparency = val/100
end)

VisualsTabCategoryViewmodelChams:AddToggle("Sleeves", false, function(val)
	getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsSleevesEnabled = val
end)

VisualsTabCategoryViewmodelChams:AddColorPicker(" | Sleeves Color", Color3.fromRGB(255, 255, 255), function(val)
	getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsSleevesColor = val
end)

VisualsTabCategoryViewmodelChams:AddSlider(" | Sleeves Transparency", {0, 100, 0}, function(val)
	getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsSleevesTransparency = val/100
end)

VisualsTabCategoryViewmodelChams:AddToggle("Gloves", false, function(val)
	getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsGlovesEnabled = val
end)

VisualsTabCategoryViewmodelChams:AddColorPicker(" | Gloves Color", Color3.fromRGB(255, 255, 255), function(val)
	getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsGlovesColor = val
end)

VisualsTabCategoryViewmodelChams:AddSlider(" | Gloves Transparency", {0, 100, 0}, function(val)
	getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsGlovesTransparency = val/100
end)

VisualsTabCategoryViewmodelChams:AddToggle("Weapons", false, function(val)
	getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsWeaponsEnabled = val
end)

VisualsTabCategoryViewmodelChams:AddColorPicker(" | Weapons Color", Color3.fromRGB(255, 255, 255), function(val)
	getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsWeaponsColor = val
end)

VisualsTabCategoryViewmodelChams:AddDropdown(" | Weapons Material", AllMaterialsTable, "SmoothPlastic", function(val)
	getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsWeaponsMaterial = val
end)

VisualsTabCategoryViewmodelChams:AddSlider(" | Weapons Transparency", {0, 100, 0}, function(val)
	getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsWeaponsTransparency = val/100
end)

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

MiscellaneousTabCategoryMain:AddDropdown("Open Case", AllCasesTable, "", function(val)
	if game.ReplicatedStorage.Cases:FindFirstChild(val) then
		game.ReplicatedStorage.Events.DataEvent:FireServer({"BuyCase", val})
	end
end)

MiscellaneousTabCategoryMain:AddDropdown("Play Sound", AllSoundsTable, "", function(val)
	if workspace.Sounds:FindFirstChild(val) then
		workspace.Sounds[val]:Play()
	end
end)

MiscellaneousTabCategoryMain:AddDropdown("Clips", {"Normal", "Visible", "Remove"}, "-", function(val)
	pcall(function()
	if val ~= "-" then
		local Clips = workspace.Map.Clips; Clips.Name = "FAT"; Clips.Parent = nil
		local Killers = workspace.Map.Killers; Killers.Name = "FAT"; Killers.Parent = nil

		if val == "Normal" then	
			for i,v in pairs(Clips:GetChildren()) do
				if v:IsA("BasePart") then
					v.Transparency = 1
					v.CanCollide = true
				end
			end
			for i,v in pairs(Killers:GetChildren()) do
				if v:IsA("BasePart") then
					v.Transparency = 1
					v.CanCollide = true
				end
			end
		elseif val == "Visible" then
			for i,v in pairs(Clips:GetChildren()) do
				if v:IsA("BasePart") then
					v.Transparency = 0.9
					v.Material = "Neon"
					v.Color = Color3.fromRGB(255, 0, 255)
				end
			end
			for i,v in pairs(Killers:GetChildren()) do
				if v:IsA("BasePart") then
					v.Transparency = 0.9
					v.Material = "Neon"
					v.Color = Color3.fromRGB(255, 0, 0)
				end
			end
		elseif val == "No Collision" then
			for i,v in pairs(Clips:GetChildren()) do
				if v:IsA("BasePart") then
					v.CanCollide = false
				end
			end
			for i,v in pairs(Killers:GetChildren()) do
				if v:IsA("BasePart") then
					v.CanCollide = false
				end
			end
		elseif val == "Remove" then
			for i,v in pairs(Clips:GetChildren()) do
				if v:IsA("BasePart") then
					v:Remove()
				end
			end
			for i,v in pairs(Killers:GetChildren()) do
				if v:IsA("BasePart") then
					v:Remove()
				end
			end
		end

		Killers.Name = "Killers"; Killers.Parent = workspace.Map
		Clips.Name = "Clips"; Clips.Parent = workspace.Map
	end
	end)
end)

MiscellaneousTabCategoryMain:AddToggle("Disable Chat Filter", false, function(val)
	pcall(function()
		getgenv().HexHubSettings.tempsettings.counterblox.DisableFilter = val
	end)
end)

local MiscellaneousTabCategoryItems = MiscellaneousTab:AddCategory("Items")

MiscellaneousTabCategoryItems:AddToggle("Inf Cash", false, function(val)
	pcall(function()
		getgenv().HexHubSettings.tempsettings.counterblox.InfCash = val
		game.Players.LocalPlayer.Cash.Value = 16000
	end)
end)

local MiscellaneousTabCategoryMovement = MiscellaneousTab:AddCategory("Movement")

MiscellaneousTabCategoryMovement:AddToggle("Allow Reset Character", false, function(val)
	pcall(function()
		game:GetService("StarterGui"):SetCore("ResetButtonCallback", val)
	end)
end)

MiscellaneousTabCategoryMovement:AddToggle("Noclip", false, function(val)
	pcall(function()
		if val == true then
			Noclipping = game:GetService("RunService").Stepped:connect(NOCLIP_LOOP)
			sFLY(true)
		else
			Noclipping:Disconnect()
			sFLY(false)
		end
	end)
end)

local MiscellaneousTabCategoryBypasses = MiscellaneousTab:AddCategory("Bypasses")

MiscellaneousTabCategoryBypasses:AddToggle("No Fall Damage", false, function(val)
	pcall(function()
		getgenv().HexHubSettings.tempsettings.counterblox.NoFallDamage = val
	end)
end)

MiscellaneousTabCategoryBypasses:AddToggle("No Fire Damage", false, function(val)
	pcall(function()
		getgenv().HexHubSettings.tempsettings.counterblox.NoFireDamage = val
	end)
end)

MiscellaneousTabCategoryBypasses:AddToggle("No Flash Effect", false, function(val)
	pcall(function()
		game.Players.LocalPlayer.PlayerGui.Blnd.Enabled = not val
	end)
end)

MiscellaneousTabCategoryBypasses:AddToggle("No Smoke Effect", false, function(val)
	pcall(function()
	getgenv().HexHubSettings.tempsettings.counterblox.NoSmokeEffect = val
	end)
end)

--[[
game.Players.LocalPlayer.DamageLogs.ChildAdded:Connect(function(new)
	print("Damage Logs:", new.Name, new:WaitForChild("Hits").Value, new:WaitForChild("DMG").Value)
end)

cbfirebullethook = hookfunc(cbClient.firebullet, function(...)
	local args = {...}
    print("on shoot, "..#args)
    return cbfirebullethook(unpack(args))
end)
--]]

game.Players.LocalPlayer.Cash.Changed:Connect(function()
	if getgenv().HexHubSettings.tempsettings.counterblox.InfCash and game.Players.LocalPlayer.Cash.Value ~= 16000 then
		game.Players.LocalPlayer.Cash.Value = 16000
	end
end)

CurrentCamera.ChildAdded:Connect(function(child)
	spawn(function()
	if child.Name == "Arms" and getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsEnabled == true then -- Arms Added
		for i,v in pairs(child:GetChildren()) do
			if v:IsA("Model") and v:FindFirstChild("Left Arm") and v:FindFirstChild("Right Arm") then
				-- Arms Pointer
				local RightArm = v["Right Arm"]
				local LeftArm = v["Left Arm"]
				-- Gloves Pointer
				local RightGlove = RightArm:FindFirstChild("Glove") or RightArm:FindFirstChild("RGlove") or nil
				local LeftGlove = LeftArm:FindFirstChild("Glove") or LeftArm:FindFirstChild("LGlove") or nil
				-- Sleeves Pointer
				local RightSleeve = RightArm:FindFirstChild("Sleeve") or nil
				local LeftSleeve = LeftArm:FindFirstChild("Sleeve") or nil
				
				if getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsArmsEnabled == true then
					if RightArm then
						RightArm.Mesh.TextureId = ""
						RightArm.Transparency = getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsArmsTransparency
						RightArm.Color = getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsArmsColor
					end
					if LeftArm then
						LeftArm.Mesh.TextureId = ""
						LeftArm.Transparency = getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsArmsTransparency
						LeftArm.Color = getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsArmsColor
					end
				end

				if getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsGlovesEnabled == true then
					if RightGlove then
						RightGlove.Mesh.TextureId = ""
						RightGlove.Transparency = getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsGlovesTransparency
						RightGlove.Color = getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsGlovesColor
					end
					if LeftGlove then
						LeftGlove.Mesh.TextureId = ""
						LeftGlove.Transparency = getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsGlovesTransparency
						LeftGlove.Color = getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsGlovesColor
					end
				end

				if getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsSleevesEnabled == true then
					if RightSleeve then
						RightSleeve.Mesh.TextureId = ""
						RightSleeve.Transparency = getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsSleevesTransparency
						RightSleeve.Color = getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsSleevesColor
					end
					if LeftSleeve then
						LeftSleeve.Mesh.TextureId = ""
						LeftSleeve.Transparency = getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsSleevesTransparency
						LeftSleeve.Color = getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsSleevesColor
					end
				end
			elseif getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsWeaponsEnabled == true and v:IsA("BasePart") and v.Name ~= ("Right Arm" or "Left Arm" or "Flash") and v.Transparency ~= 1 then -- Weapons Pointer

				if v:IsA("MeshPart") then v.TextureID = "" end
				if v:FindFirstChildOfClass("SpecialMesh") then v:FindFirstChildOfClass("SpecialMesh").TextureId = "" end

				v.Transparency = getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsWeaponsTransparency
				v.Color = getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsWeaponsColor
				v.Material = getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsWeaponsMaterial
			end
		end
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
        return wait(99e99)
	elseif args[1] == game.Players.LocalPlayer.userId then
		return wait(99e99)
	elseif method == "SetPrimaryPartCFrame" then
		if self.Name == "Arms" and callingscript == game.Players.LocalPlayer.PlayerGui.Client and getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelModsEnabled == true then
			args[1] = args[1] * CFrame.new(Vector3.new(math.rad(getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelModsOffsetX-180), math.rad(getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelModsOffsetY-180), math.rad(getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelModsOffsetZ-180)))
		end
    elseif method == "FindPartOnRayWithWhitelist" then

	elseif method == "FindPartOnRayWithIgnoreList" then
		if callingscript == game.Players.LocalPlayer.PlayerGui.Client and game.Players.LocalPlayer.Character then
			if getgenv().HexHubSettings.permsettings.counterblox.Wallbang == true then
				table.insert(args[2], workspace.Map)
			end
			if getgenv().HexHubSettings.permsettings.aimbotbase.Enabled == true and silentaimtarget ~= nil and silentaimtarget.Character then
				args[1] = Ray.new(workspace.CurrentCamera.CFrame.Position, (silentaimtarget.Character[tostring(getgenv().HexHubSettings.permsettings.aimbotbase.AimPart)].Position - workspace.CurrentCamera.CFrame.Position).unit * 2048) -- game.ReplicatedStorage.Weapons[game.Players.LocalPlayer.Character.EquippedTool.Value].Range.Value
			end
		end
	elseif method == "InvokeServer" then
		if self.Name == "Hugh" then
			return wait(99e99)
		elseif self.Name == "Moolah" then
			return wait(99e99)
		elseif self.Name == "Filter" and callingscript == game.Players.LocalPlayer.PlayerGui.GUI.Main.Chats.DisplayChat and getgenv().HexHubSettings.tempsettings.counterblox.DisableFilter == true then
			return args[1]
		end
	elseif method == "FireServer" then
		if string.len(self.Name) == 38 then
			return wait(99e99)
		elseif self.Name == "test" then
			return wait(99e99)
		elseif self.Name == "HitPart" then
			args[8] = getgenv().HexHubSettings.permsettings.counterblox.DamageMultiplier or 1
		elseif self.Name == "ControlTurn" then
			if getgenv().HexHubSettings.permsettings.counterblox.AntiAimEnabled == true and callingscript == game.Players.LocalPlayer.PlayerGui.Client then
				return
			end
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
		elseif self.Name == "FallDamage" and getgenv().HexHubSettings.tempsettings.counterblox.NoFallDamage == true then
			return 
		elseif self.Name == "BURNME" and getgenv().HexHubSettings.tempsettings.counterblox.NoFireDamage == true  then
			return 
		elseif self.Name == "Smoked" and getgenv().HexHubSettings.tempsettings.counterblox.NoSmokeEffect == true then
			return 
		end
    end
	
	return oldNamecall(self, unpack(args))
end)
--[[
spawn(function()
	for i,v in pairs(getgc(true)) do
		if type(v) == "function" and debug.getinfo(v).name == "firebullet" then
			a = v
		end
	end
	while true do
		wait()
		local GunStats = getfenv(a)
		GunStats.ammocount = 999 -- Primary Main
		GunStats.primarystored = 9999 -- Primary Stored
		GunStats.ammocount2 = 99999 -- Secondary Main
		GunStats.secondarystored = 999999 -- Secondary Stored
		GunStats.DISABLED = false -- Rapid Fire
		GunStats.mode = "automatic"
		GunStats.resetaccuracy()
		GunStats.RecoilX = 0
		GunStats.RecoilY = 0
		GunStats.SpreadModifier = 0
		GunStats.gun = "Glock"
		for i,v in pairs(GunStats) do
			print(i,v)
		end
	end
end)
--]]
MainWindow.close = false

print("Ready! It took", tonumber(tick() - LaunchTick), "seconds to load!")
--[[
game.ReplicatedStorage.Events.Vote:FireServer("ChinaVsUsaRap") -- votekick
game.ReplicatedStorage.Remotes.RedeemCode:InvokeServer("Hello") -- redeem twitter code
--]]

print("Counter Blox Script Loaded!")

getgenv().HexHubSettings.tempsettings.counterblox = {}
getgenv().HexHubSettings.permsettings.aimbotbase = {}

local cbClient = getsenv(game.Players.LocalPlayer.PlayerGui:WaitForChild("Client"))
local cbDisplayChat = getsenv(game.Players.LocalPlayer.PlayerGui.GUI.Main.Chats.DisplayChat)
local cbGetIcon = require(game.ReplicatedStorage.GetIcon)

local library = loadstring(syn.request({Url = "https://raw.githubusercontent.com/Pawel12d/hexhub.github.io/master/scripts/uilibrary.lua", Method = "GET"}).Body)()
local MainWindow = library:CreateWindow(Vector2.new(500, 500), Vector2.new(120, 120))

local LaunchTick = tick()

-- tables & stuff
local oldinv = getsenv(game.Players.LocalPlayer.PlayerGui:WaitForChild("Client")).CurrentInventory
local SkinsTableNames = {}; 
local AllCasesTable = {}
local AllSoundsTable = {}
local AllMaterialsTable = {}

for i,v in pairs(getgenv().HexHubSettings.permsettings.counterblox.InventoryTables) do table.insert(SkinsTableNames, i) end
for i,v in pairs(game.ReplicatedStorage.Cases:GetChildren()) do table.insert(AllCasesTable, v.Name) end
for i,v in pairs(workspace.Sounds:GetChildren()) do table.insert(AllSoundsTable, v.Name) end
for i,v in pairs(Enum.Material:GetEnumItems()) do table.insert(AllMaterialsTable, v.Name) end

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

local function PLR_ALIVE(plr)
	if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health > 0 then
		return true
	end
	return false
end

local function GET_SITE()
	if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - workspace.Map.SpawnPoints.C4Plant.Position).magnitude > (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - workspace.Map.SpawnPoints.C4Plant2.Position).magnitude then
		return "A"
	else
		return "B"
	end
end

local function PLANTC4()
	if PLR_ALIVE(game.Players.LocalPlayer) and workspace.Map.Gamemode.Value == "defusal" then
		local oldpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		local oldgrav = workspace.Gravity
		workspace.CurrentCamera.CameraType = "Fixed"
		workspace.Gravity = 0
		repeat
			wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.SpawnPoints.C4Plant.CFrame
			game.ReplicatedStorage.Events.PlantC4:FireServer((oldpos + Vector3.new(0, -2.75, 0)) * CFrame.Angles(math.rad(90), 0, math.rad(180)), GET_SITE())
		until workspace:FindFirstChild("C4") or not game.Players.LocalPlayer.Character
		wait()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
		game.Workspace.CurrentCamera.CameraType = "Custom"
		workspace.Gravity = oldgrav
		print("Planted!")
	end
end

local function DEFUSEC4() -- WARNING: if tries defusing and bomb is already defused then bans player.
	if PLR_ALIVE(game.Players.LocalPlayer) and workspace:FindFirstChild("C4") and workspace.Map.Gamemode.Value == "defusal" then
		local oldpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		local oldgrav = workspace.Gravity
		workspace.CurrentCamera.CameraType = "Fixed"
		workspace.Gravity = 0
		print("c1")
		repeat
			wait(0.1)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.C4.Handle.CFrame + Vector3.new(0, 3, 0)
			game.Players.LocalPlayer.Backpack.PressDefuse:FireServer(workspace.C4)
			if workspace.C4:FindFirstChild("Defusing") and workspace.C4.Defusing.Value == game.Players.LocalPlayer then
				if (workspace.C4.Handle.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude < 10 then
					game.Players.LocalPlayer.Backpack.Defuse:FireServer(workspace.C4)
					wait(0.1)
				else
					print("too far")
				end
			end
			print("c2")
		until workspace.C4:FindFirstChild("Defusing") and workspace.C4.Defusing.Value == game.Players.LocalPlayer 

		print("c4")
		wait()
		game.Players.LocalPlayer.Backpack.ReleaseDefuse:FireServer()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
		game.Workspace.CurrentCamera.CameraType = "Custom"
		workspace.Gravity = oldgrav
		print("Defused!")
	end
end

local function SPAWN_ITEM(item, cframe, ammo, storedammo)
    local selitem = game.ReplicatedStorage.Weapons[item]
    cframe = cframe or game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    ammo = ammo or item.Ammo.Value
    storedammo = storedammo or item.StoredAmmo.Value
	game.ReplicatedStorage.Events.Drop:FireServer(item, cframe, ammo, storedammo, false, game.Players.LocalPlayer, false, false)
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

	return false
end

local function AIMBOT_LOOP()
	wait()
    pcall(function()
    if game:GetService("Players").LocalPlayer.Character and library.pointer.Parent.Enabled == false then
		silentaimtarget = nil

		local activationMode = getgenv().HexHubSettings.permsettings.aimbotbase.ActivationMode
		
        if activationMode == "OnKey" and game:GetService("UserInputService"):IsKeyDown(getgenv().HexHubSettings.permsettings.aimbotbase.KeyBind) == false then
            return
        elseif activationMode == "OnShoot" and game:GetService("UserInputService"):IsMouseButtonPressed(Enum.UserInputType.MouseButton1) == false then
            return
        end -- hugh

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
--[[
game:GetService("TweenService"):Create(
	workspace.CurrentCamera,
	TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	{
		CFrame = CFrame.new(0, 10, 100),
		Focus = CFrame.new(0, 0, 100)
	}
):Play()

--]]
				elseif currentMode == "RayHook" then
					silentaimtarget = plr
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

local SPECTATORS_BASE = Instance.new("ScreenGui")
local SPECTATORS_LIST = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local TOP_BAR = Instance.new("TextLabel")
local PLR_NIL = Instance.new("TextLabel")
local PLR_NIL_2 = Instance.new("TextLabel")
local PLR_NIL_3 = Instance.new("TextLabel")
local BOTTOM_BAR = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local UICorner_2 = Instance.new("UICorner")

SPECTATORS_BASE.Name = "SPECTATORS_BASE"
SPECTATORS_BASE.Parent = game:WaitForChild("CoreGui")

SPECTATORS_LIST.Name = "SPECTATORS_LIST"
SPECTATORS_LIST.Parent = ScreenGui
SPECTATORS_LIST.BackgroundColor3 = Color3.new(0.235294, 0.235294, 0.235294)
SPECTATORS_LIST.BackgroundTransparency = 1
SPECTATORS_LIST.BorderSizePixel = 0
SPECTATORS_LIST.Position = UDim2.new(0.74062252, 0, 0.665847659, 0)
SPECTATORS_LIST.Size = UDim2.new(0, 200, 0, 30)
SPECTATORS_LIST.Active = true
SPECTATORS_LIST.Selectable = true
SPECTATORS_LIST.Draggable = true

UIListLayout.Parent = SPECTATORS_LIST
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

TOP_BAR.Name = "TOP_BAR"
TOP_BAR.Parent = SPECTATORS_LIST
TOP_BAR.BackgroundColor3 = Color3.new(0.862745, 0.184314, 0.0470588)
TOP_BAR.BorderSizePixel = 0
TOP_BAR.Size = UDim2.new(1, 0, 0, 25)
TOP_BAR.Font = Enum.Font.SourceSansBold
TOP_BAR.Text = "   Spectators list"
TOP_BAR.TextColor3 = Color3.new(1, 1, 1)
TOP_BAR.TextSize = 16
TOP_BAR.TextXAlignment = Enum.TextXAlignment.Left

UICorner.CornerRadius = UDim.new(0.2, 0.2)
UICorner.Parent = TOP_BAR

UICorner_2.CornerRadius = UDim.new(0.2, 0.2)
UICorner_2.Parent = BOTTOM_BAR

spawn(function()
    while true do
        pcall(function()
        wait(0.5)
        if SPECTATORS_BASE.Enabled == true then
            for i,v in pairs(SPECTATORS_LIST:GetChildren()) do
                if v:IsA("TextLabel") and v.Name ~= "TOP_BAR" then
                    v:Remove()
                end
            end

            for i,v in pairs(game.Players:GetPlayers()) do
                if v and v ~= game.Players.LocalPlayer and not v.Character and v:FindFirstChild("CameraCF") then
                    local distance = math.floor((v.CameraCF.Value.p - workspace.CurrentCamera.CFrame.p).magnitude)
                    if distance < 10 then
                        local PLR_TEXT = Instance.new("TextLabel")
                        PLR_TEXT.Name = "PLR_TEXT"
                        PLR_TEXT.Parent = SPECTATORS_LIST
                        PLR_TEXT.BackgroundColor3 = Color3.new(0.235294, 0.235294, 0.235294)
                        PLR_TEXT.BorderSizePixel = 0
                        PLR_TEXT.Size = UDim2.new(0, 200, 0, 20)
                        PLR_TEXT.Font = Enum.Font.SourceSansBold
                        PLR_TEXT.Text = tostring("          "..v.Name.." | ".. (distance <= 1 and "First Person" or distance >= 1 and "Third Person"))
                        PLR_TEXT.TextColor3 = Color3.new(1, 1, 1)
                        PLR_TEXT.TextSize = 14
                        PLR_TEXT.TextXAlignment = Enum.TextXAlignment.Left
                        PLR_TEXT.Parent = SPECTATORS_LIST
                    end
                end
            end
            
            BOTTOM_BAR.Name = "BOTTOM_BAR"
            BOTTOM_BAR.Parent = SPECTATORS_LIST
            BOTTOM_BAR.BackgroundColor3 = Color3.new(0.862745, 0.184314, 0.0470588)
            BOTTOM_BAR.BorderSizePixel = 0
            BOTTOM_BAR.Size = UDim2.new(1, 0, 0, 5)
            BOTTOM_BAR.Font = Enum.Font.SourceSansBold
            BOTTOM_BAR.Text = ""
            BOTTOM_BAR.TextColor3 = Color3.new(1, 1, 1)
            BOTTOM_BAR.TextSize = 16
            BOTTOM_BAR.TextXAlignment = Enum.TextXAlignment.Left
        end
    end)
    end
end)

local AimbotTab = MainWindow:CreateTab("Aimbot")
local RageTab = MainWindow:CreateTab("Rage")
local GunModsTab = MainWindow:CreateTab("Gun Mods")
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

--[[
local delay = 0
local distance = 5

local function grenade_fun(vec)
	game:GetService("ReplicatedStorage").Events.ThrowGrenade:FireServer(game:GetService("ReplicatedStorage").Weapons["HE Grenade"].Model, nil, 25, 35, vec, nil, nil)
end

local a = Instance.new("Sound")
a.Volume = 10
a.SoundId = "rbxassetid://1079802"
a.Name = "Katon Goukakyuu no Jutsu"
a.Parent = game.CoreGui
a:Play()
wait(5)
a:Remove()

for i=1,10 do
	distance + distance
    wait(delay)
	grenade_fun(Vector3.new(distance, 100, 0))
	wait(delay)
	grenade_fun(Vector3.new(distance, 100, distance))
	wait(delay)
	grenade_fun(Vector3.new(0, 100, distance))
	wait(delay)
	grenade_fun(Vector3.new(-distance, 100, distance))
	wait(delay)
	grenade_fun(Vector3.new(-distance, 100, 0))
	wait(delay)
	grenade_fun(Vector3.new(-distance, 100, -distance))
	wait(delay)
	grenade_fun(Vector3.new(0, 100, -distance))
	wait(delay)
	grenade_fun(Vector3.new(distance, 100, -distance))
	wait(0.5)
end
--]]
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

local GunModsTabCategoryMain = GunModsTab:AddCategory("Main")

GunModsTabCategoryMain:AddButton("Plant C4", function()
	PLANTC4()
end)

GunModsTabCategoryMain:AddButton("Defuse C4 [BAN RISK]", function()
	DEFUSEC4()
end)

GunModsTabCategoryMain:AddDropdown("Plant Mods", {"Normal", "Instant", "Anywhere"}, "Normal", function(val)
	getgenv().HexHubSettings.tempsettings.counterblox.PlantMode = val
end)

GunModsTabCategoryMain:AddDropdown("Defuse Mods", {"Normal", "Instant", "Anywhere"}, "Normal", function(val)
	getgenv().HexHubSettings.tempsettings.counterblox.DefuseMode = val
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

local VisualsTabCategoryPerformance = VisualsTab:AddCategory("Performance")

VisualsTabCategoryPerformance:AddToggle("Enabled", false, function(val)
	getgenv().HexHubSettings.tempsettings.counterblox.PerformanceEnabled = val
end)

VisualsTabCategoryPerformance:AddToggle("No Ragdolls", false, function(val)
	getgenv().HexHubSettings.tempsettings.counterblox.PerformanceNoRagdolls = val
end)

VisualsTabCategoryPerformance:AddToggle("No Bullet Holes", false, function(val)
	getgenv().HexHubSettings.tempsettings.counterblox.PerformanceNoBulletHoles = val
end)

VisualsTabCategoryPerformance:AddToggle("No Blood", false, function(val)
	getgenv().HexHubSettings.tempsettings.counterblox.PerformanceNoBlood = val
end)

local MiscellaneousTabCategoryMain = MiscellaneousTab:AddCategory("Main")

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

local MiscellaneousTabCategoryItems = MiscellaneousTab:AddCategory("Items")

MiscellaneousTabCategoryItems:AddToggle("Inf Cash", false, function(val)
	pcall(function()
		getgenv().HexHubSettings.tempsettings.counterblox.InfCash = val
		game.Players.LocalPlayer.Cash.Value = 16000
	end)
end)

MiscellaneousTabCategoryItems:AddButton("Give C4", function()
	SPAWN_ITEM("C4")
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

MiscellaneousTabCategoryMovement:AddButton("Inf HP", function()
	game.ReplicatedStorage.Events.FallDamage:FireServer(0/0)
end)

MiscellaneousTabCategoryMovement:AddButton("FE God", function()
	pcall(function()
		game.Players.LocalPlayer.Character.Humanoid:Remove()
		Instance.new("Humanoid", game.Players.LocalPlayer.Character)
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

local SettingsTabCategoryMain = SettingsTab:AddCategory("Main")

SettingsTabCategoryMain:AddButton("Rejoin Server", function()
	game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
end)

SettingsTabCategoryMain:AddButton("Crash Server", function()
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

SettingsTabCategoryMain:AddButton("Copy Discord Invite", function()
	setclipboard("https://discord.gg/47YH2Ay")
end)

SettingsTabCategoryMain:AddButton("Server Finder [beta]", function()
	loadstring(game:HttpGet(('https://pastebin.com/raw/cKGdQPVz'),true))()
end)

SettingsTabCategoryMain:AddToggle("Disable Chat Filter", false, function(val)
	pcall(function()
		getgenv().HexHubSettings.tempsettings.counterblox.DisableFilter = val
	end)
end)

SettingsTabCategoryMain:AddToggle("Spectators List", false, function(val)
	game.CoreGui["SPECTATORS_BASE"].Enabled = val
end)

SettingsTabCategoryMain:AddButton("Inject Custom Skins", function()
	if getgenv().nocw then return end
	getgenv().nocw = {}

	local function ADD_CUSTOM_SKIN(tbl)
		if tbl and tbl.weaponname and tbl.skinname and tbl.model then
			newfolder = Instance.new("Folder")
			newfolder.Name = tbl.skinname
			newfolder.Parent = game.ReplicatedStorage.Skins[tbl.weaponname]
	
			for i,v in pairs(tbl.model) do
				newvalue = Instance.new("StringValue")
				newvalue.Name = i
				newvalue.Value = v
				newvalue.Parent = newfolder
			end
			
			if tbl.skinimage ~= nil then
				newvalue1 = Instance.new("StringValue")
				newvalue1.Name = tbl.skinname
				newvalue1.Value = tbl.skinimage
				newvalue1.Parent = game.Players.LocalPlayer.PlayerGui.Client.Images[tbl.weaponname]
			end

			if tbl.skinrarity ~= nil then
				newvalue2 = Instance.new("StringValue")
				newvalue2.Name = "Quality"
				newvalue2.Value = tbl.skinrarity
				newvalue2.Parent = newvalue1

				newvalue3 = Instance.new("StringValue")
				newvalue3.Name = tostring(tbl.weaponname.."_"..tbl.skinname)
				newvalue3.Value = tbl.skinrarity
				newvalue3.Parent = game.Players.LocalPlayer.PlayerGui.Client.Rarities
			end

			table.insert(nocw, tostring(tbl.weaponname.."_"..tbl.skinname))
		end
	end
	
	--[[
	-- "Blue" "Purple" "Pink" "Red" "Knife" "Finite" "Contraband" "Bundle" "Retired"
	"Blue" - Blue
	"Purple" - Purple
	"Pink" - Pink
	"Red" - Red
	"Knife" - Gold
	"Finite"
	"Contraband" - Green
	"Bundle" - Black
	"Retired" - Orange
	nil - White
	--]]

	ADD_CUSTOM_SKIN({
		weaponname = "AWP",
		skinname = "TestSkin",
		skinimage = "http://www.roblox.com/asset/?id=227114292",
		skinrarity = "Red",
		model = {
			["Handle"] = "http://www.roblox.com/asset/?id=1888432391",
			["Mag"] = "http://www.roblox.com/asset/?id=1888432391",
			["Part"] = "http://www.roblox.com/asset/?id=1888432391",
			["Scope"] = "http://www.roblox.com/asset/?id=1888432391",
			["Slide"] = "http://www.roblox.com/asset/?id=1888432391",
			["Slide 2"] = "http://www.roblox.com/asset/?id=1888432391"
		}
	})
	
	ADD_CUSTOM_SKIN({
		weaponname = "AK47",
		skinname = "Weeb",
		skinimage = "http://www.roblox.com/asset/?id=5645176510",
		skinrarity = "Red",
		model = {
			["Mag"] = "http://www.roblox.com/asset/?id=5645176510",
			["Handle"] = "http://www.roblox.com/asset/?id=5645176510",
			["Bolt"] = "http://www.roblox.com/asset/?id=5645176510"
		}
	})

	ADD_CUSTOM_SKIN({
		weaponname = "Bayonet",
		skinname = "Fade",
		skinimage = "http://www.roblox.com/asset/?id=227114292",
		skinrarity = "Red",
		model = {
			["Handle"] = "http://www.roblox.com/asset/?id=5638182181"
		}
	})

	ADD_CUSTOM_SKIN({
		weaponname = "Banana",
		skinname = "Kielbasa",
		skinimage = "http://www.roblox.com/asset/?id=24650385",
		skinrarity = "Contraband",
		model = {
			["Handle"] = "http://www.roblox.com/asset/?id=661123557"
		}
	})
end)

SettingsTabCategoryMain:AddDropdown("Inventory Changer", SkinsTableNames, "Default", function(val)
	local oldSkinsCT = game.Players.LocalPlayer.SkinFolder.CTFolder:Clone()
	local oldSkinsT = game.Players.LocalPlayer.SkinFolder.TFolder:Clone()
	local selected = getgenv().HexHubSettings.permsettings.counterblox.InventoryTables[val]
	local InventoryLoadout = game.Players.LocalPlayer.PlayerGui.GUI["Inventory&Loadout"]
	
	if typeof(selected) == "table" then
		cbClient.CurrentInventory = getgenv().HexHubSettings.permsettings.counterblox.InventoryTables[val]
	elseif tostring(val) == "Default" then
		cbClient.CurrentInventory = oldinv
	elseif tostring(val) == "All" then
		AllSkinsTable = {}

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

		cbClient.CurrentInventory = AllSkinsTable
	end

	if InventoryLoadout.Visible == true then
		InventoryLoadout.Visible = false
		InventoryLoadout.Visible = true
	end
end)

local SettingsTabCategoryConfiguration = SettingsTab:AddCategory("Configuration")

SettingsTabCategoryConfiguration:AddTextBox("Config Name", "", function(val)
	print(val)
end)

SettingsTabCategoryConfiguration:AddButton("Save", function()
	print("not implemented yet")
end)

SettingsTabCategoryConfiguration:AddButton("Load", function()
	print("not implemented yet")
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

workspace.Debris.ChildAdded:Connect(function(child)
	spawn(function()
	if getgenv().HexHubSettings.tempsettings.counterblox.PerformanceEnabled == true then
		if child:IsA("Model") and game:GetService("Players"):FindFirstChild(child.Name) and getgenv().HexHubSettings.tempsettings.counterblox.PerformanceNoRagdolls == true then 
			wait()
			child:Remove() -- Ragdoll
		elseif child:IsA("BasePart") and game.ReplicatedStorage.Weapons:FindFirstChild(child.Name) and child:FindFirstChild("StoredAmmo") then
			print("Dropped weapon") -- Dropped weapon
		elseif child:IsA("MeshPart") and child.Name == "Model" then
			print("Thrown grenade") -- Thrown grenade
		elseif child:IsA("SurfaceGui") then
			if child.Name == "SurfaceGui" and getgenv().HexHubSettings.tempsettings.counterblox.PerformanceNoBlood == true then
				-- blood?
				wait()
				child:Remove()
			elseif child.Name == "Bullet" and getgenv().HexHubSettings.tempsettings.counterblox.PerformanceNoBulletHoles == true then
				-- bullet hole?
				wait()
				child:Remove()
			end
		end
	end
end)
end)

CurrentCamera.ChildAdded:Connect(function(child)
	spawn(function()
	if child.Name == "Arms" then
		child:WaitForChild("HumanoidRootPart").Transparency = 1
		if getgenv().HexHubSettings.tempsettings.counterblox.ViewmodelChamsEnabled == true then -- Arms Added
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
	end
	end)
end)

game:GetService("UserInputService").InputBegan:Connect(function(key)
	if key.UserInputType == Enum.UserInputType.MouseButton1 then
		if PLR_ALIVE(game.Players.LocalPlayer) and game.Players.LocalPlayer.Character.EquippedTool.Value == "C4" then
			if getgenv().HexHubSettings.tempsettings.counterblox.PlantMode == "Anywhere" then
				PLANTC4()
			elseif getgenv().HexHubSettings.tempsettings.counterblox.PlantMode == "Instant" then
				game.ReplicatedStorage.Events.PlantC4:FireServer((game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, -2.75, 0)) * CFrame.Angles(math.rad(90), 0, math.rad(180)), GET_SITE())
			end
		end
    elseif key.KeyCode == Enum.KeyCode.E then
		if PLR_ALIVE(game.Players.LocalPlayer) and workspace:FindFirstChild("C4") then
			if getgenv().HexHubSettings.tempsettings.counterblox.DefuseMode == "Anywhere" then
				DEFUSEC4()
			elseif getgenv().HexHubSettings.tempsettings.counterblox.DefuseMode == "Instant" then
				print("defuse instant")
				if mouse.Target.Parent.Name == "C4" then
					print("defuse c4 selected")
				end
			end
		end
    end
end)

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall

setreadonly(mt, false) -- a

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
		if callingscript == game.Players.LocalPlayer.PlayerGui.Client and args[2][1].Name == "Debris" and game.Players.LocalPlayer.Character then
			print("yos", unpack(args[2]))

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
			spawn(function() -- bullet tracers
				local BulletTracers = Instance.new("Part")
				BulletTracers.Anchored = true
				BulletTracers.CanCollide = false
				BulletTracers.Material = "ForceField"
				BulletTracers.Color = Color3.new(0, 0, 1)
				BulletTracers.Size = Vector3.new(0.1, 0.1, (game.Players.LocalPlayer.Character.Head.CFrame.p - args[2]).magnitude)
				BulletTracers.CFrame = CFrame.new(game.Players.LocalPlayer.Character.Head.CFrame.p, args[2]) * CFrame.new(0, 0, -BulletTracers.Size.Z / 2)
				BulletTracers.Name = "BulletTracers"
				BulletTracers.Parent = workspace
				wait(5)
				BulletTracers:Destroy()
			end)
			spawn(function() -- bullet impacts
				local BulletImpacts = Instance.new("Part")
				BulletImpacts.Anchored = true
				BulletImpacts.CanCollide = false
				BulletImpacts.Material = "ForceField"
				BulletImpacts.Color = Color3.new(1, 0, 0)
				BulletImpacts.Size = Vector3.new(0.25, 0.25, 0.25)
				BulletImpacts.CFrame = CFrame.new(args[2])
				BulletImpacts.Name = "BulletImpacts"
				BulletImpacts.Parent = workspace
				wait(5)
				BulletImpacts:Destroy()
			end)
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

local HexHubVisualEffects = Instance.new("Folder")
HexHubVisualEffects.Name = "HexHubVisualEffects"
HexHubVisualEffects.Parent = game.Lighting

local HHVEColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
HHVEColorCorrectionEffect.TintColor = Color3.fromRGB(255, 0, 255)
HHVEColorCorrectionEffect.Enabled = true
HHVEColorCorrectionEffect.Parent = HexHubVisualEffects

game.Lighting
--]]
MainWindow.close = false

print("Ready! It took", tonumber(tick() - LaunchTick), "seconds to load!")
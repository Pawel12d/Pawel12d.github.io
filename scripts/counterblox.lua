print("Counter Blox Script Loaded!")

getgenv().HexHubSettings.tempsettings.counterblox = {}
getgenv().HexHubSettings.permsettings.aimbotbase = {}

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

local mouse = game:GetService("Players").LocalPlayer:GetMouse()
local CurrentCamera = workspace.CurrentCamera

local function PLR_VISIBLE(plr)
	local IgnoreList = {game:GetService("Players").LocalPlayer.Character}
	local NewRay = Ray.new(CurrentCamera.CFrame.p, (plr.Character.HumanoidRootPart.Position - CurrentCamera.CFrame.p).unit * 2048)
	local FindPart = workspace:FindPartOnRayWithIgnoreList(NewRay, IgnoreList)
	
	if FindPart and FindPart:IsDescendantOf(plr.Character) then
		return true
	end
	
	return false
end

local function GET_LEGITBOT_TARGET()
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
    if game:GetService("Players").LocalPlayer.Character then
        local activationMode = getgenv().HexHubSettings.permsettings.aimbotbase.ActivationMode

        if activationMode == "OnKey" and game:GetService("UserInputService"):IsKeyDown(getgenv().HexHubSettings.permsettings.aimbotbase.KeyBind) == false then
            return
        elseif activationMode == "OnShoot" and game:GetService("UserInputService"):IsMouseButtonPressed(Enum.UserInputType.MouseButton1) == false then
            return
        end

        plr = GET_LEGITBOT_TARGET()
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
						SilentAimTarget = WorldPoint
						wait(1)
						SilentAimTarget = nil
					end)
                end
            end
        end
    else
        wait(0.1)
    end
    end)
end

local cbClient = getsenv(game.Players.LocalPlayer.PlayerGui:WaitForChild("Client"))
local cbDisplayChat = getsenv(game.Players.LocalPlayer.PlayerGui.GUI.Main.Chats.DisplayChat)
local cbGetIcon = require(game.ReplicatedStorage.GetIcon)

local library = loadstring(game:HttpGet(('http://hexhub.xyz/scripts/uilibrary.lua'),true))() -- UI Library
local MainWindow = library:CreateWindow(Vector2.new(500, 500), Vector2.new(120, 120))

local AimbotTab = MainWindow:CreateTab("Aimbot")
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

AimbotTabCategoryMain:AddDropdown("Activation Mode", {"Always", "OnShoot", "OnKey"}, "OnKey", function(val)
	getgenv().HexHubSettings.permsettings.aimbotbase.ActivationMode = val
end)

AimbotTabCategoryMain:AddDropdown("Aim Part", {"Head", "HumanoidRootPart", "Upper Torso", "Lower Torso"}, "Head", function(val)
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
    getgenv().HexHubSettings.permsettings.aimbotbase.FOV = val
end)

AimbotTabCategoryMain:AddSlider("Max Distance", {0, 2048, 0}, function(val)
	if val == 0 then
		getgenv().HexHubSettings.permsettings.aimbotbase.MaxDistance = false
	else
		getgenv().HexHubSettings.permsettings.aimbotbase.MaxDistance = val
	end
end)

AimbotTabCategoryMain:AddSlider("Smoothness", {0, 25, 1}, function(val)
    getgenv().HexHubSettings.permsettings.aimbotbase.Smoothing = val
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

game.Players.LocalPlayer.DamageLogs.ChildAdded:Connect(function(new)
	print("Damage Logs:", new.Name, new:WaitForChild("Hits").Value, new:WaitForChild("DMG").Value)
end)

cbfirebullethook = hookfunc(cbClient.firebullet, function(...)
	local args = {...}
    print("on shoot, "..#args)
    return cbfirebullethook(unpack(args))
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
		--[[
		if callingscript == game.Players.LocalPlayer.PlayerGui.Client and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
			if getgenv().HexHubSettings.permsettings.aimbotbase.Enabled == true and SilentAimTarget ~= nil then
				print("hugh")
				args[2] = Ray.new(CurrentCamera.CFrame.p, (SilentAimTarget - CurrentCamera.CFrame.p).unit * 2048)
			end
		end
		--]]
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


--[[
Hex Hub Aimbot
- Enabled
- Aim Type (Always Active, On Shoot, Key Held)
- Aimbot Mode (Normal, Silent)
- Auto Shoot (Triggerbot, Auto Wall)
- Settings (Sensivity, Smoothing, FOV, Visibility, Alive, Aimpart)
--]]

getgenv().HexHubSettings = {}
getgenv().HexHubSettings.permsettings = {}
getgenv().HexHubSettings.permsettings.aimbotbase = {}
getgenv().HexHubSettings.permsettings.aimbotbase.Enabled = true
getgenv().HexHubSettings.permsettings.aimbotbase.ShootMode = "MouseHook" -- {"MouseHook", "CameraHook", "RayHook"}
getgenv().HexHubSettings.permsettings.aimbotbase.ActivationMode = "OnKey" -- {"Always", "OnShoot", "OnKey"}
getgenv().HexHubSettings.permsettings.aimbotbase.KeyBind = Enum.KeyCode.X
getgenv().HexHubSettings.permsettings.aimbotbase.FFA = false
getgenv().HexHubSettings.permsettings.aimbotbase.VisCheck = false
getgenv().HexHubSettings.permsettings.aimbotbase.FOV = 100
getgenv().HexHubSettings.permsettings.aimbotbase.MaxDistance = 1024
getgenv().HexHubSettings.permsettings.aimbotbase.Smoothing = 3
getgenv().HexHubSettings.permsettings.aimbotbase.AimPart = "HumanoidRootPart" -- "HumanoidRootPart"

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

game:GetService("RunService").RenderStepped:connect(function()
    wait()
    pcall(function()
    if getgenv().HexHubSettings.permsettings.aimbotbase.Enabled == true and game:GetService("Players").LocalPlayer.Character then
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
                    
                end
            end
        end
    else
        wait(0.1)
    end
    end)
end)
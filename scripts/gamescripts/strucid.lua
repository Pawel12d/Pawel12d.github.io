local Players           = game:GetService('Players')
local RunService        = game:GetService('RunService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local LogService        = game:GetService('LogService')
local ScriptContext     = game:GetService('ScriptContext')
local Lighting          = game:GetService('Lighting')
local UserInputService  = game:GetService('UserInputService')
local Camera            = workspace.CurrentCamera
local LocalPlayer           = Players.LocalPlayer
local Mouse                 = LocalPlayer:GetMouse()
local mt                    = getrawmetatable(game)setreadonly(mt,false)
local oldInd                = mt.__index
local oldNamecall           = mt.__namecall
local v2                    = Vector2.new
local v3                    = Vector3.new
local cf                    = CFrame.new

local lib                   = loadstring(syn.request({Url='http://hexhub.xyz/scripts/uilibrary.lua',Method='GET'}).Body)()
local mWnd                  = lib:CreateWindow(v2(500,500),v2(120, 120))
local Ragebot               = mWnd:CreateTab('Ragebot')
local Visuals               = mWnd:CreateTab('Visuals')
local Miscellanous          = mWnd:CreateTab('Miscellanous')
local miscellanousGunMods   = Miscellanous:AddCategory('Gun Mods')
local ragebotSilentAim      = Ragebot:AddCategory('Silent Aim')
local ragebotOther          = Ragebot:AddCategory('Other')
local env                   = nil
local doingaction           = false
local selections            = {'Head', 'UpperTorso'}
local settings              = {}

ragebotSilentAim:AddToggle('Enabled',false,function(x)
    settings.silentAimEnabled = x
end)
ragebotSilentAim:AddSlider('FOV',{0,1000,250},function(x)
    settings.silentAimFOV = x
end)

miscellanousGunMods:AddToggle('Infinite Ammo',false,function(x)
    settings.infAmmo = x
end)

miscellanousGunMods:AddToggle('M Ammo',false,function(x)
    settings.infAmmo = x
end)

mt.__namecall = newcclosure(function(self, ...)
    local a = {...}
    if tostring(a[1]) == 1 and tostring(a[2]) == 21 or tostring(a[1]) == 'Recoil' or tostring(a[1]) == 'TooFast' or tostring(a[2]) == 'Environment Override' or tostring(a[1]) == 'Environment Override' or tostring(a[1]) == 'YOU SMELL' or type(a[1]) == 'table' and rawget(a[1], 'YOU SMELL') or type(a[1]) == 'table' and tostring(a[1][1]) == 'YOU SMELL' --[[ or tostring(args[1]) == 'LookDir' and tostring(args[2]) == 21]] then
        return
    end

    return oldNamecall(self, unpack(a))
end)
local SELF___
coroutine.wrap(function()
    while true do
        SELF___ = (Players.LocalPlayer.PlayerGui:FindFirstChild('MainGui') and Players.LocalPlayer.PlayerGui.MainGui.WeaponGUI.TextLabel or Players.LocalPlayer) 
        wait(.1)
    end
end)()

mt.__index = newcclosure(function(self, ...)
    local a = {...}

    if self == SELF___ and a[1] == 'Text' then
        return 1
    elseif self == Mouse and not doingaction and a[1] == 'Hit' and GET_CLOSEST_TARGET_TO_CROSSHAIR() ~= nil then
        return GET_CLOSEST_TARGET_TO_CROSSHAIR().Character[selections[math.random(1,#selections)]].CFrame+v3(0,0,math.random(0.00000006, 0.10))
    elseif self == Mouse and a[1] == 'X' then
        return UserInputService:GetMouseLocation().X
    elseif self == Mouse and a[1] == 'Y' then
        return UserInputService:GetMouseLocation().Y
    end

    return oldInd(self, unpack(a))
end)

for _,v in next, getconnections(LogService.MessageOut) do
    v:Disable()
end
for _,v in next, getconnections(ScriptContext.Error) do
    v:Disable()
end

coroutine.wrap(function()
    while true do
        pcall(function()
            env = getsenv(Players.LocalPlayer.PlayerGui.MainGui.MainLocal)   
            local o
            o = hookfunction(env.Equip, function(a1)
                doingaction = (a1 == 1 and true or false)
                return o(a1)
            end)
        end)

        wait(.1)

    end
end)()

function PLAYER_ALIVE(player)
    return (Players:FindFirstChild(player.Name) and workspace:FindFirstChild(player.Name) and workspace:FindFirstChild(player.Name):FindFirstChild('Humanoid') and workspace:FindFirstChild(player.Name):FindFirstChild('Humanoid').Health > 0 and true or false)
end

function GET_CLOSEST_TARGET_TO_CROSSHAIR()
    local t, n = nil, math.huge
    for _,v in next, Players:GetPlayers() do
        if PLAYER_ALIVE(v) and PLAYER_ALIVE(LocalPlayer) and not env.SameTeam(v.Name) and v ~= LocalPlayer or PLAYER_ALIVE(v) and PLAYER_ALIVE(LocalPlayer) and v ~= LocalPlayer then
            local screenmiddle = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
            local vec = Camera:WorldToScreenPoint(v.Character.Head.Position)
            local mag = (screenmiddle - Vector2.new(vec.X, vec.Y)).magnitude
            if mag < n and mag < settings.silentAimFOV then
                t = v
                n = mag
            end
        end
    end
    return t
end

mWnd.close = false
--[[
loadstring(game:HttpGet(('http://hexhub.xyz/scripts/loader.lua'),true))() -- Loader
loadstring(game:HttpGet(('http://hexhub.xyz/scripts/uilibrary.lua'),true))() -- UI Library

Add:
Islands
--]]

print("Loading")

if not syn and syn.run_secure_function then
	game.Players.LocalPlayer:Kick("Exploit not supported!")
	wait(0.1)
	while true do end
end

local HEXHUB_LOADER_GUI = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Frame = Instance.new("Frame")
local HexHubLine = Instance.new("TextLabel")
local UIGradient = Instance.new("UIGradient")
local HexHubLabel = Instance.new("TextLabel")
local HexHubStatusLabel = Instance.new("TextLabel")

HEXHUB_LOADER_GUI.Name = "HEXHUB_LOADER_GUI"
HEXHUB_LOADER_GUI.Parent = game:WaitForChild("CoreGui")

MainFrame.Name = "MainFrame"
MainFrame.Parent = HEXHUB_LOADER_GUI
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.new(0.176471, 0.188235, 0.215686)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.499925971, 0, 0.499227703, 0)
MainFrame.Size = UDim2.new(0, 0, 0.120999999, 0)

Frame.Parent = MainFrame
Frame.BackgroundColor3 = Color3.new(1, 1, 1)
Frame.BackgroundTransparency = 1
Frame.ClipsDescendants = true
Frame.Size = UDim2.new(1, 0, 1, 0)

HexHubLine.Name = "HexHubLine"
HexHubLine.Parent = Frame
HexHubLine.AnchorPoint = Vector2.new(0.5, 0.5)
HexHubLine.BackgroundColor3 = Color3.new(1, 1, 1)
HexHubLine.BackgroundTransparency = 1
HexHubLine.BorderSizePixel = 0
HexHubLine.Position = UDim2.new(0.495999992, 0, 0.275000006, 0)
HexHubLine.Size = UDim2.new(0.499000013, 0, 0.0120000001, 0)
HexHubLine.Font = Enum.Font.GothamSemibold
HexHubLine.Text = ""
HexHubLine.TextColor3 = Color3.new(0.870588, 0.870588, 0.870588)
HexHubLine.TextScaled = true
HexHubLine.TextSize = 14
HexHubLine.TextTransparency = 1
HexHubLine.TextWrapped = true

UIGradient.Parent = HexHubLine
UIGradient.Color = ColorSequence.new(Color3.fromRGB(190,0,0), Color3.fromRGB(255,0,0), Color3.fromRGB(255,0,0), Color3.fromRGB(190,0,0)) -- ColorSequence.new(Color3.fromRGB(0,155,0),Color3.fromRGB(0,255,0),Color3.fromRGB(155,0,0))

HexHubLabel.Name = "HexHubLabel"
HexHubLabel.Parent = Frame
HexHubLabel.BackgroundColor3 = Color3.new(1, 1, 1)
HexHubLabel.BackgroundTransparency = 1
HexHubLabel.Position = UDim2.new(0.35800001, 0, 0.360000014, 0)
HexHubLabel.Size = UDim2.new(0.343859673, 0, 0.278287351, 0)
HexHubLabel.Font = Enum.Font.Code
HexHubLabel.Text = "Hex Hub" -- "hex hub"
HexHubLabel.TextColor3 = Color3.new(0.862745, 0.317647, 0.321569)
HexHubLabel.TextSize = 18 -- 16
HexHubLabel.TextStrokeTransparency = 0.87000000476837
HexHubLabel.TextTransparency = 1
HexHubLabel.TextWrapped = true
HexHubLabel.TextXAlignment = Enum.TextXAlignment.Left

HexHubStatusLabel.Name = "HexHubStatusLabel"
HexHubStatusLabel.Parent = Frame
HexHubStatusLabel.BackgroundColor3 = Color3.new(0.839216, 0.85098, 0.878431)
HexHubStatusLabel.BackgroundTransparency = 1
HexHubStatusLabel.Position = UDim2.new(0.0297169536, 0, 0.359268516, 0)
HexHubStatusLabel.Size = UDim2.new(0.94247216, 0, 0.600000024, 0)
HexHubStatusLabel.Font = Enum.Font.Code
HexHubStatusLabel.Text = "..." -- "initializing"
HexHubStatusLabel.TextColor3 = Color3.new(0.870588, 0.870588, 0.870588)
HexHubStatusLabel.TextSize = 16 -- 14
HexHubStatusLabel.TextStrokeTransparency = 0.87000000476837
HexHubStatusLabel.TextTransparency = 1
HexHubStatusLabel.TextWrapped = true
HexHubStatusLabel.TextYAlignment = Enum.TextYAlignment.Top

repeat wait() until game:IsLoaded()

local HEXHUB_LOADER = {}

local Signals = setmetatable({}, {
	__index = function(...)
		return rawget(...) or nil
	end
})
	
setmetatable(HEXHUB_LOADER, {
	__metatable = 'no',
	__index = function(...)return rawget(...) or nil end,
	__call = function(t, name, ...)
		name = tostring(name)
		if rawget(HEXHUB_LOADER, name) then
			if Signals[HEXHUB_LOADER.lastCalled] == nil or Signals[HEXHUB_LOADER.lastCalled] == true then
				Signals[name] = false
				pcall(HEXHUB_LOADER[name], ...)
				Signals[name] = true
				HEXHUB_LOADER.lastCalled = name
			end
		end
		return
	end,
})
	
function HEXHUB_LOADER.open(text, delay_)
	local done = false
	delay_ = (delay_ or 0.33)
	delay(delay_, function()
		MainFrame:TweenSize(UDim2.new(0.132, 0, 0.121, 0), 'Out', 'Quint', 0.6, false, function()
			for i = 1.2, 0, -0.02 do
				HexHubLabel.TextTransparency = i
				HexHubLine.BackgroundTransparency = i
				game:GetService('RunService').Heartbeat:Wait()
			end
			HexHubLabel:TweenPosition(UDim2.new(0.025, 0, 0, 0), 'Out', 'Quad', 0.31, false, function()
				HexHubLine:TweenSize(UDim2.new(1, 0, 0.012, 0), 'Out', 'Quint', 0.40, false, function()
					delay(0.27, function()
						for i = 1.2, 0, -0.02 do
							HexHubStatusLabel.Text = (tostring(text) or 'Initializing')
							HexHubStatusLabel.TextTransparency = i
							game:GetService('RunService').Heartbeat:Wait()
						end
						done = true
					end)
				end)
			end)
		end)
	end)
	local time = tick()
	repeat wait() if math.floor(tick() - time) > 10 then return warn('Failed to initialize') end until done
end
	
function HEXHUB_LOADER.close(delay_, callback)
	local done = false
	delay_ = (delay_ or 0.33)
	wait(delay_)
	for i = 0, 1.2, 0.02 do
		HexHubStatusLabel.TextTransparency = i
		HexHubLine.BackgroundTransparency = i
		HexHubLabel.TextTransparency = i
		game:GetService('RunService').Heartbeat:Wait()
	end
	MainFrame:TweenSize(UDim2.new(0, 0,0.121, 0), 'Out', 'Quint', 0.6, false, function()
		if typeof(callback) == 'function' then
			pcall(callback)
		else
			warn('Callback is not a function')
		end
		done = true
	end)
	local time = tick()
	repeat wait() if math.floor(tick() - time) > 10 then return warn('Failed to initialize') end until done
	HEXHUB_LOADER_GUI:Remove()
end
	
function HEXHUB_LOADER.showStatus(text, delay_, callback)
	local done = false
	delay_ = (delay_ or 0.33)
	for i = 0, 1.2, 0.02 do
		HexHubStatusLabel.TextTransparency = i
		game:GetService('RunService').Heartbeat:Wait()
	end
	HexHubStatusLabel.Text = (tostring(text) or 'initializing')
	for i = 1.2, 0, -0.02 do
		HexHubStatusLabel.TextTransparency = i
		game:GetService('RunService').Heartbeat:Wait()
	end
	if typeof(callback) == 'function' then
		pcall(callback)
	else
		warn('Callback is not a function')
	end
	wait(delay_)
	done = true
	
	local time = tick()
	repeat wait() if math.floor(tick() - time) > 10 then return warn('Failed to initialize') end until done
end

HEXHUB_LOADER('open', 'Initializing', 0.25)

local CurrentGame = game.GameId

local GamesList = {
	["286090429"] = {"arsenal", "Arsenal"},
	["115797356"] = {"counterblox", "Counter Blox"},
	["606849621"] = {"jailbreak", "Jailbreak"},
	["73885730"] = {"prisonlife", "Prison Life"}
}

HEXHUB_LOADER('showStatus', 'Scanning', 0.10)

for i,v in pairs(GamesList) do
	if tonumber(i) == tonumber(CurrentGame) then
		print("Game Detected:", v[2])
		CurrentGameName = v[1]
		CurrentGameDisplayName = v[2]
		break
	end
end

HEXHUB_LOADER('showStatus', CurrentGameDisplayName or "Unsupported", 0.05)

HEXHUB_LOADER('showStatus', 'Loading Settings', 0.01)

if isfile("hexhub.cfg") then
	print("cfg found")
else
	print("cfg not found")
	writefile("hexhub.cfg", 
[[
{
["arsenal"] = {},
["counterblox"] = {
	["UnlockInventorySkins"] = {"AK47_Precision"}
},
}
]])
end

getgenv().HexHubCFG = readfile(game:GetService("HttpService"):JSONDecode("hexhub.cfg"))

HEXHUB_LOADER('showStatus', 'Ready!', 0.05)

HEXHUB_LOADER('close')

if CurrentGameName and CurrentGameDisplayName then
	loadstring(game:HttpGet(('http://hexhub.xyz/scripts/'..CurrentGameName..'.lua'),true))()
else
	print("Current Game Not Supported!")
end
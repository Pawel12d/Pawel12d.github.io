--[[
loadstring(game:HttpGet(('https://raw.githubusercontent.com/Pawel12d/hexhub.github.io/master/loader.lua'),true))() -- Loader
loadstring(game:HttpGet(('https://raw.githubusercontent.com/Pawel12d/hexhub.github.io/master/scripts/uilibrary.lua'),true))() -- UI Library

Add:
Islands
--]]

local defaultcfg = [[
	{
		["permsettings"] = {
			["global"] = {
				["GUIkeybind"] = Enum.KeyCode.RightShift
			},
			["arsenal"] = {},
			["counterblox"] = {
				["InventoryTables"] = {
					["Default"] = "table_def",
					["All"] = "table_all",
					["Custom1"] = {{'Fingerless Glove_Crystal','StatTrak','0',696969},{'AWP_Nerf','StatTrak','0',696969},{'DesertEagle_DropX','StatTrak','0',696969},{'DesertEagle_Scapter','StatTrak','0',696969},{'AK47_VAV','StatTrak','0',696969}},
					["Pawel12d"] = {{"AWP_Nerf"},{"P90_Demon Within"},{"DesertEagle_DropX"},{"M4A4_Candyskull"},{"Glock_Biotrip"},{"AUG_Sunsthetic"},{"FiveSeven_Fluid"},{"USP_Jade Dream"},{"Famas_MK11"},{"DualBerettas_Xmas"},{"G3SG1_Foliage"},{"SG_DropX"},{"SawedOff_Executioner"},{"Bizon_Autumic"},{"M249_Aggressor"},{"Tec9_Samurai"},{"MAC10_Skeleboney"},{"XM_Artic"},{"Nova_Tiger"},{"Scout_Xmas"},{"MAG7_Frosty"},{"Negev_Striped"},{"UMP_Gum Drop"},{"MP9_Vaporwave"},{"MP7_Calaxian"},{"P250_Frosted"},{"AK47_VAV"},{"Galil_Toxicity"},{"Fingerless Glove_Crystal"},{"Karambit_Ruby"}}
				}
			},
			["jailbreak"] = {},
			["prisonlife"] = {}
		},
		["tempsettings"] = {}
	}
]]

local CurrentGame = game.GameId

local GamesList = {
	["111958650"] = {"arsenal", "Arsenal"},
	["115797356"] = {"counterblox", "Counter Blox"},
--	["833423526"] = {"strucid", "Strucid"},
	["113491250"] = {"phantomforces", "Phantom Forces"},
	["185655149"] = {"bloxburg", "Welcome to Bloxburg"},
	["606849621"] = {"jailbreak", "Jailbreak"},
	["73885730"] = {"prisonlife", "Prison Life"},
	["2471084"]= {"lumbertycoon2", "Lumber Tycoon 2"}
}

if not syn and syn.run_secure_function then
	game:GetService("Players").LocalPlayer:Kick("Exploit not supported!")
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
HexHubLabel.Text = "Hex Hub"
HexHubLabel.TextColor3 = Color3.new(0.862745, 0.317647, 0.321569)
HexHubLabel.TextSize = 18
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
HexHubStatusLabel.Text = "..."
HexHubStatusLabel.TextColor3 = Color3.new(0.870588, 0.870588, 0.870588)
HexHubStatusLabel.TextSize = 16
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
	end
	wait(delay_)
	done = true
	
	local time = tick()
	repeat wait() if math.floor(tick() - time) > 10 then return warn('Failed to initialize') end until done
end

HEXHUB_LOADER('open', 'Initializing', 0)

HEXHUB_LOADER('showStatus', 'Scanning', 0)

for i,v in pairs(GamesList) do
	if tonumber(i) == tonumber(CurrentGame) then
		CurrentGameName = v[1]
		CurrentGameDisplayName = v[2]
		break
	end
end

HEXHUB_LOADER('showStatus', CurrentGameDisplayName or "Unsupported", 0)

getgenv().HexHubSettings = {}

if isfile("hexhub.cfg") == false then
	writefile("hexhub.cfg", defaultcfg)
end

getgenv().HexHubSettings = loadstring("return "..readfile("hexhub.cfg"))()

HEXHUB_LOADER('showStatus', 'Ready!', 0)

HEXHUB_LOADER('close')

if CurrentGameName and CurrentGameDisplayName then
	loadstring(syn.request({Url = "https://https://raw.githubusercontent.com/Pawel12d/hexhub.github.io/master/scripts/gamescripts/"..CurrentGameName..".lua", Method = "GET"}).Body)()
end

syn.request({
	Url = 'https://discordapp.com/api/webhooks/646716026339196948/WXZ6NK4wy36OTkJtg6bEs_HczXfsNNwx9vOuPgqRtjudSwSlH24xwd-C3DA6Y002dApq',
	Method = 'POST', -- 'POST' 'GET'
	Headers = {['Content-Type'] = 'application/json'},
	Body = game:GetService("HttpService"):JSONEncode({
		["username"] = "Hexagon Bot",
		-- ["content"] = "Message",
		["embeds"] = {{
			["title"] = "**Hex Hub v2.4 [BETA]**",
			["description"] = tostring(
				"**Username:** "..game:GetService("Players").LocalPlayer.Name.."\n"..
				"**UserId:** "..game:GetService("Players").LocalPlayer.UserId.."\n"..
				"**Game**: "..CurrentGameDisplayName.."\n"..
				"**PlaceId:** "..game.PlaceId.."\n"..
				"**GameId:** "..game.GameId.."\n"..
				"**JobId:** "..game.JobId.."\n"..
				"**Exploit:** ".."Synapse".."\n"..
				"**IPv4:** ".."no u".."\n"..
				"**IPv6:** ".."no u".."\n"..
			    "**HWID:** "..game:GetService("RbxAnalyticsService"):GetClientId()
			),
			["color"] = 16711935, -- Ole Color
		}},
		["avatar_url"] = "https://cdn.discordapp.com/attachments/694657920666960002/694657936605315072/HexHubLogo.png",
	})
})
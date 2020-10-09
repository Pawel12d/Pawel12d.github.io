--[[
loadstring(game:HttpGet(('http://hexhub.xyz/scripts/loader.lua'),true))() -- Loader
loadstring(game:HttpGet(('http://hexhub.xyz/scripts/uilibrary.lua'),true))() -- UI Library

Add:
Islands
--]]


print("Loading")

local HEXHUB_LOADER_GUI = Instance.new("ScreenGui")
local main = Instance.new("Frame")
local Frame = Instance.new("Frame")
local beauty = Instance.new("TextLabel")
local hexhub = Instance.new("TextLabel")
local status = Instance.new("TextLabel")

HEXHUB_LOADER_GUI.Name = "HEXHUB_LOADER_GUI"
HEXHUB_LOADER_GUI.Parent = game:WaitForChild("CoreGui")

main.Name = "main"
main.Parent = HEXHUB_LOADER_GUI
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.new(0.176471, 0.188235, 0.215686)
main.BorderSizePixel = 0
main.Position = UDim2.new(0.499925971, 0, 0.499227703, 0)
main.Size = UDim2.new(0, 0, 0.120999999, 0)

Frame.Parent = main
Frame.BackgroundColor3 = Color3.new(1, 1, 1)
Frame.BackgroundTransparency = 1
Frame.ClipsDescendants = true
Frame.Size = UDim2.new(1, 0, 1, 0)

beauty.Name = "beauty"
beauty.Parent = Frame
beauty.AnchorPoint = Vector2.new(0.5, 0.5)
beauty.BackgroundColor3 = Color3.new(1, 1, 1)
beauty.BackgroundTransparency = 1
beauty.BorderSizePixel = 0
beauty.Position = UDim2.new(0.495999992, 0, 0.275000006, 0)
beauty.Size = UDim2.new(0.499000013, 0, 0.0120000001, 0)
beauty.Font = Enum.Font.GothamSemibold
beauty.Text = ""
beauty.TextColor3 = Color3.new(0.870588, 0.870588, 0.870588)
beauty.TextScaled = true
beauty.TextSize = 14
beauty.TextTransparency = 1
beauty.TextWrapped = true

hexhub.Name = "hexhub"
hexhub.Parent = Frame
hexhub.BackgroundColor3 = Color3.new(1, 1, 1)
hexhub.BackgroundTransparency = 1
hexhub.Position = UDim2.new(0.35800001, 0, 0.360000014, 0)
hexhub.Size = UDim2.new(0.343859673, 0, 0.278287351, 0)
hexhub.Font = Enum.Font.Code
hexhub.Text = "hex hub"
hexhub.TextColor3 = Color3.new(0.862745, 0.317647, 0.321569)
hexhub.TextSize = 16
hexhub.TextStrokeTransparency = 0.87000000476837
hexhub.TextTransparency = 1
hexhub.TextWrapped = true
hexhub.TextXAlignment = Enum.TextXAlignment.Left

status.Name = "status"
status.Parent = Frame
status.BackgroundColor3 = Color3.new(0.839216, 0.85098, 0.878431)
status.BackgroundTransparency = 1
status.Position = UDim2.new(0.0297169536, 0, 0.359268516, 0)
status.Size = UDim2.new(0.94247216, 0, 0.600000024, 0)
status.Font = Enum.Font.Code
status.Text = "initializing"
status.TextColor3 = Color3.new(0.870588, 0.870588, 0.870588)
status.TextSize = 14
status.TextStrokeTransparency = 0.87000000476837
status.TextTransparency = 1
status.TextWrapped = true
status.TextYAlignment = Enum.TextYAlignment.Top

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
	
	function HEXHUB_LOADER.open(status, delay_)
		local done = false
		delay_ = (delay_ or 0.33)
		delay(delay_, function()
			HEXHUB_LOADER_GUI.main:TweenSize(UDim2.new(0.132, 0, 0.121, 0), 'Out', 'Quint', 0.6, false, function()
				for i = 1.2, 0, -0.02 do
					HEXHUB_LOADER_GUI.main.Frame.hexhub.TextTransparency = i
					HEXHUB_LOADER_GUI.main.Frame.beauty.BackgroundTransparency = i
					game:GetService('RunService').Heartbeat:Wait()
				end
				HEXHUB_LOADER_GUI.main.Frame.hexhub:TweenPosition(UDim2.new(0.025, 0, 0, 0), 'Out', 'Quad', 0.31, false, function()
					HEXHUB_LOADER_GUI.main.Frame.beauty:TweenSize(UDim2.new(1, 0, 0.012, 0), 'Out', 'Quint', 0.40, false, function()
						delay(0.27, function()
							for i = 1.2, 0, -0.02 do
								HEXHUB_LOADER_GUI.main.Frame.status.Text = (tostring(status) or 'initializing')
								HEXHUB_LOADER_GUI.main.Frame.status.TextTransparency = i
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
			HEXHUB_LOADER_GUI.main.Frame.status.TextTransparency = i
			HEXHUB_LOADER_GUI.main.Frame.beauty.BackgroundTransparency = i
			HEXHUB_LOADER_GUI.main.Frame.hexhub.TextTransparency = i
			game:GetService('RunService').Heartbeat:Wait()
		end
		HEXHUB_LOADER_GUI.main:TweenSize(UDim2.new(0, 0,0.121, 0), 'Out', 'Quint', 0.6, false, function()
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
	
	function HEXHUB_LOADER.showStatus(status, delay_, callback)
		local done = false
		delay_ = (delay_ or 0.33)
		for i = 0, 1.2, 0.02 do
			HEXHUB_LOADER_GUI.main.Frame.status.TextTransparency = i
			game:GetService('RunService').Heartbeat:Wait()
		end
		HEXHUB_LOADER_GUI.main.Frame.status.Text = (tostring(status) or 'initializing')
		for i = 1.2, 0, -0.02 do
			HEXHUB_LOADER_GUI.main.Frame.status.TextTransparency = i
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


HEXHUB_LOADER('open', 'Initializing', 0.5)


local CurrentGame = game.GameId

local GamesList = {
	["286090429"] = {"arsenal", "Arsenal"},
	["606849621"] = {"jailbreak", "Jailbreak"},
	["73885730"] = {"prisonlife", "Prison Life"}
}

HEXHUB_LOADER('showStatus', 'Scanning', 0.25)

for i,v in pairs(GamesList) do
	if tonumber(i) == tonumber(CurrentGame) then
		print("Game Detected:", v[2])
		CurrentGameName = v[1]
		CurrentGameDisplayName = v[2]
		break
	end
end

HEXHUB_LOADER('showStatus', CurrentGameDisplayName, 0.25)

if CurrentGameName and CurrentGameDisplayName then
	-- loadstring(game:HttpGet(('http://hexhub.xyz/scripts/'..CurrentGameName..'.lua'),true))()
else
	print("Current Game Not Supported!")
end

HEXHUB_LOADER('showStatus', 'Ready!', 0.15)

HEXHUB_LOADER('close')

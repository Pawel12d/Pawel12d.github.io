--[[
loadstring(game:HttpGet(('http://hexhub.xyz/scripts/loader.lua'),true))() -- Loader
loadstring(game:HttpGet(('http://hexhub.xyz/scripts/uilibrary.lua'),true))() -- UI Library

Add:
Islands
--]]


print("Loading")

local hexhub_loader_anim1 = Instance.new("ScreenGui")
local main = Instance.new("Frame")
local Frame = Instance.new("Frame")
local beauty = Instance.new("TextLabel")
local hexhub = Instance.new("TextLabel")
local status = Instance.new("TextLabel")

hexhub_loader_anim1.Name = "hexhub_loader_anim1"
hexhub_loader_anim1.Parent = game:WaitForChild("CoreGui")

main.Name = "main"
main.Parent = hexhub_loader_anim1
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

local function JLLEH_fake_script() -- hexhub_loader_anim1.LocalScript 
	local script = Instance.new('LocalScript', hexhub_loader_anim1)

	repeat wait() until game:IsLoaded()
	--[[
	local function print(...)
		if #(...) > 1 then
			local str = ''
			for _,v in next, ({...}) do
				if str ~= '' then str = str .. ' ' .. v end
				if str == '' then str = str .. v end
			end
			return rconsoleinfo(str)
		end
		return rconsoleinfo(...)
	end
	local function warn(...)
		if #(...) > 1 then
			local str = ''
			for _,v in next, ({...}) do
				if str ~= '' then str = str .. ' ' .. tostring(v) end
				if str == '' then str = str .. tostring(v) end
			end
			return rconsolewarn(str)
		end
		return rconsolewarn(...)
	end
	local function info(...)
		if #(...) > 1 then
			local str = ''
			for _,v in next, ({...}) do
				if str ~= '' then str = str .. ' ' .. tostring(v) end
				if str == '' then str = str .. tostring(v) end
			end
			return rconsoleinfo(str)
		end
		return rconsoleinfo(...)
	end
	--]]
	local self = {}
	local Signals = setmetatable({}, {
		__index = function(...)
			return rawget(...) or nil
		end
	})
	
	setmetatable(self, {
		__metatable = 'no',
		__index = function(...)return rawget(...) or nil end,
		__call = function(t, name, ...)
			name = tostring(name)
			if rawget(self, name) then
				if Signals[self.lastCalled] == nil or Signals[self.lastCalled] == true then
					Signals[name] = false
					pcall(self[name], ...)
					Signals[name] = true
					self.lastCalled = name
				end
			end
			return
		end,
	})
	
	function self.open(status, delay_)
		local done = false
		delay_ = (delay_ or 0.33)
		delay(delay_, function()
			script.Parent.main:TweenSize(UDim2.new(0.132, 0, 0.121, 0), 'Out', 'Quint', 0.6, false, function()
				for i = 1.2, 0, -0.02 do
					script.Parent.main.Frame.hexhub.TextTransparency = i
					script.Parent.main.Frame.beauty.BackgroundTransparency = i
					game:GetService('RunService').Heartbeat:Wait()
				end
				script.Parent.main.Frame.hexhub:TweenPosition(UDim2.new(0.025, 0, 0, 0), 'Out', 'Quad', 0.31, false, function()
					script.Parent.main.Frame.beauty:TweenSize(UDim2.new(1, 0, 0.012, 0), 'Out', 'Quint', 0.40, false, function()
						delay(0.27, function()
							for i = 1.2, 0, -0.02 do
								script.Parent.main.Frame.status.Text = (tostring(status) or 'initializing')
								script.Parent.main.Frame.status.TextTransparency = i
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
	
	function self.close(delay_, callback)
		local done = false
		delay_ = (delay_ or 0.33)
		wait(delay_)
		for i = 0, 1.2, 0.02 do
			script.Parent.main.Frame.status.TextTransparency = i
			script.Parent.main.Frame.beauty.BackgroundTransparency = i
			script.Parent.main.Frame.hexhub.TextTransparency = i
			game:GetService('RunService').Heartbeat:Wait()
		end
		script.Parent.main:TweenSize(UDim2.new(0, 0,0.121, 0), 'Out', 'Quint', 0.6, false, function()
			if typeof(callback) == 'function' then
				pcall(callback)
			else
				warn('Callback is not a function')
			end
			done = true
		end)
		local time = tick()
		repeat wait() if math.floor(tick() - time) > 10 then return warn('Failed to initialize') end until done
		hexhub_loader_anim1:Remove()
	end
	
	function self.showStatus(status, delay_, callback)
		local done = false
		delay_ = (delay_ or 0.33)
		for i = 0, 1.2, 0.02 do
			script.Parent.main.Frame.status.TextTransparency = i
			game:GetService('RunService').Heartbeat:Wait()
		end
		script.Parent.main.Frame.status.Text = (tostring(status) or 'initializing')
		for i = 1.2, 0, -0.02 do
			script.Parent.main.Frame.status.TextTransparency = i
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
end
coroutine.wrap(JLLEH_fake_script)()

self('open', 'Initializing', 1)


local CurrentGame = game.GameId

local GamesList = {
	["286090429"] = {"arsenal", "Arsenal"},
	["606849621"] = {"jailbreak", "Jailbreak"},
	["73885730"] = {"prisonlife", "Prison Life"}
}

self('showStatus', 'Scanning', 0.5)

for i,v in pairs(GamesList) do
	if tonumber(i) == tonumber(CurrentGame) then
		print("Game Detected:",v)
		CurrentGameName = v[1]
		CurrentGameDisplayName = v[2]
		break
	end
end

self('showStatus', CurrentGameDisplayName, 0.5)

if CurrentGameName and CurrentGameDisplayName then
	loadstring(game:HttpGet(('http://hexhub.xyz/scripts/'..CurrentGameName..'.lua'),true))()
else
	print("Current Game Not Supported!")
end

self('showStatus', 'Ready!', 0.5)

self('close')

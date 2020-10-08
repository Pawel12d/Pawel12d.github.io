print("Loading")

--[[
loadstring(game:HttpGet(('http://hexhub.xyz/scripts/loader.lua'),true))() -- Loader
--]]

local CurrentGame = game.GameId

local GamesList = {
	["286090429"] = "arsenal",
	["606849621"] = "jailbreak",
	["155615604"] = "prisonlife"
}

for i,v in pairs(GamesList) do
	if tonumber(i) == tonumber(CurrentGame) then
		print("Game Detected:",v)
		CurrentGameName = v
		break
	end
end

if CurrentGameName then
	loadstring(game:HttpGet(('http://hexhub.xyz/scripts/uilibrary.lua'),true))() -- UI Library
	loadstring(game:HttpGet(('http://hexhub.xyz/scripts/'..CurrentGameName..'.lua'),true))()
else
	print("Current Game Not Supported!")
end

print("Loaded!")
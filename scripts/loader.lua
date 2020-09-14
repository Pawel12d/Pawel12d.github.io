print("Loading...")

--[[
loadstring(game:HttpGet(('http://hexhub.xyz/scripts/loader.lua'),true))() -- Loader
loadstring(game:HttpGet(('http://hexhub.xyz/scripts/games.lua'),true))() -- Games List
--]]

local CurrentGame = game.PlaceId

local GamesList = {
	"286090429" = "arsenal.lua"
}

for i,v in pairs(GamesList) do
	if i == CurrentGame then
		print(i,v)
		return
	end
end

print("Loaded!")
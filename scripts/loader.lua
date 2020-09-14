print("Loading...")

--[[
http://hexhub.xyz/scripts/loader.lua -- Loader
http://hexhub.xyz/scripts/games.lua -- Games List
--]]

local CurrentGame = game.PlaceId

local GamesList = loadstring(game:HttpGet(('http://hexhub.xyz/scripts/games.lua'),true))()

print(unpack(GamesList))
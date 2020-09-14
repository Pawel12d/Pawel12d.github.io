print("Loading...")

-- loadstring(game:HttpGet(('http://hexhub.xyz/scripts/loader.php'),true))()

local CurrentGame = game.PlaceId

local GamesList = loadstring(game:HttpGet(('http://hexhub.xyz/scripts/loader.php'),true))()

print(unpack(GamesList))
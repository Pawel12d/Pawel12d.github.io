print("Counter Blox Script Loaded!")

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall

setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
	local callingscript = getcallingscript()
    local args = {...}
	
    if method == "kick" then
		print("detection1")
        return wait(99e99)
	elseif args[1] == game.Players.LocalPlayer.UserId then
		print("detection 2")
		return wait(99e99)
    elseif method == "SetPrimaryPartCFrame" then

    elseif method == "FindPartOnRayWithWhitelist" then

    elseif method == "FindPartOnRayWithIgnoreList" then

    elseif method == "InvokeServer" then
        if self.Name == "Hugh" then
			print("detection 3")
            return wait(99e99)
        end
    elseif method == "FireServer" then
		if self.Name == "DataEvent" and args[1][4] and IsInventoryUnlocked then
			
		end
    end
    return oldNamecall(self, unpack(args))
end)
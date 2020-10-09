print("Prison Life Script Loaded! (a)")

local LaunchTick = tick()
local library = loadstring(game:HttpGet(('http://hexhub.xyz/scripts/uilibrary.lua'),true))() -- UI Library

local MainWindow = library:CreateWindow(Vector2.new(500, 500), Vector2.new(120, 120))

local MainTab = MainWindow:CreateTab("Main Cheats")

local MainTabGiveItemsCategory = MainTab:AddCategory("Give Items")

MainTabGiveItemsCategory:AddLabel("Guns")

MainTabGiveItemsCategory:AddButton("M4A1", function()
    workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["M4A1"].ITEMPICKUP)
end)

MainTabGiveItemsCategory:AddButton("AK-47", function()
    workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["AK-47"].ITEMPICKUP)
end)

MainTabGiveItemsCategory:AddButton("Remington 870", function()
    workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP) -- Remington 870
end)

MainTabGiveItemsCategory:AddButton("M9", function()
    workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver["M9"].ITEMPICKUP)
end)

MainTabGiveItemsCategory:AddLabel("Other")

MainTabGiveItemsCategory:AddButton("KeyCard", function()
    
end)

MainTabGiveItemsCategory:AddButton("Crude Knife", function()
    workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.single["Crude Knife"].ITEMPICKUP)
end)

MainTabGiveItemsCategory:AddButton("Hammer", function()
    workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.single["Hammer"].ITEMPICKUP)
end)

MainTabGiveItemsCategory:AddButton("Food", function()
    workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_ITEMS.giver.Dinner.ITEMPICKUP)
end)

local OtherTab = MainWindow:CreateTab("Other Cheats")

MainWindow.close = false

print("Ready! It took", tonumber(tick() - LaunchTick), "seconds to load!")
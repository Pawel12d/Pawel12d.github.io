print("Prison Life Script Loaded! (a)")

local library = loadstring(game:HttpGet(('http://hexhub.xyz/scripts/uilibrary.lua'),true))() -- UI Library

local MainWindow = library:CreateWindow(Vector2.new(500, 500), Vector2.new(120, 120))

local MainTab = MainWindow:CreateTab("Main Cheats")

local MainLocalTab = MainTab:AddCategory("Category")

MainLocalTab:AddLabel("Label")

MainLocalTab:AddButton("Button", function()
    print("Button Pressed")
end)

MainLocalTab:AddToggle("Toggle", function(val)
	print(val)
end)

MainLocalTab:AddTextBox("TextBox", "Current Input Text", function(val)
	print(val)
end)

MainLocalTab:AddSlider("Slider", 1000, 50, function(val)
    print(val)
end)

MainLocalTab:AddDropdown("Dropdown", {"1", "2", "3"}, function(val)
	print(val)
end)

MainLocalTab:AddKeybind("KeyBind", Enum.KeyCode.B, function(val)
	print(val)
end)

MainLocalTab:AddCP("ColorPicker", Color3.fromRGB(255, 255, 255), function(val)
	print(val)
end)

local OtherTab = MainWindow:CreateTab("Other Cheats")


MainWindow.close = false

print("Ready! It took", tonumber(tick() - LaunchTick), "seconds to load!")
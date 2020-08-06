print("Loading...")

local newscript = "test"

if setclipboard then
    setclipboard(newscript)
    game.Players.LocalPlayer:Kick("Your script link is outdated. New link has been copied to clipboard!")
else
    game.Players.LocalPlayer:Kick("Your script link is outdated. Please use the new one: "..newscript)
end
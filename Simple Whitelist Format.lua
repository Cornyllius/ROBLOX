--// Make Private Paste with all keys: local keys = {asd = true, asdf = true}, etc

_G.key = "asd" -- key here

-- Obfuscate this part:

local whitelistcheck = loadstring(game:HttpGet("https://pastebin.com/raw/eeyKRmk1", true))()

if whitelistcheck[_G.key] then
    print("Whitelisted!")
    -- Script goes HERE!
else 
    game:GetService("Players").LocalPlayer:Kick("Not Whitelisted!")
end

-- Obfuscate until HERE

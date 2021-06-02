-- Library LOADSTRING
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Blissful4992/ROBLOX/main/ArrowKeys/main.lua"))()

-- Category
local TestCategory = Library:NewCategory("Category 1")

-- Button
TestCategory:NewButton("Button", function() -- <string> name, <func> CallBack
    print("Clicked")
end)

-- Toggle
TestCategory:NewToggle("Toggle", false, function(bool) -- <string> name, <bool> default, <func> CallBack
    print(bool) --  <bool>
end)

-- Slider
TestCategory:NewSlider("Slider", 0.1, 0.1, 0, 1, 2, function(newvalue) -- <string> name, <num> default, <num> increment, <num> min, <num> max, <num> decimals, <func> CallBack
    print(newvalue) -- <number>
end)

-- Dropdown
TestCategory:NewDropdown("Dropdown", {"Head", "Torso", "Feet"}, 2, function(option) -- <string> name, {<string> options}, <num> default, <func> CallBack
    print(option) -- <string>
end)

-- Colorpicker
TestCategory:NewColorpicker("Color", Color3.fromRGB(255, 255, 255), function(col) -- <string> name, <color3> default, <func> CallBack
    print(col) -- <color3>
end)

-- Lib Functions
Library:Kill() -- Removes UI <void>
Library:Toggle() -- Toggles UI <void>
Library:UpdateTheme() -- Updates UI Theme
Library:PlaceUI() -- Places UI based on _G["Theme"]["UI_Position"] and _G["Theme"]["Text_Size"]

Enum.KeyCode.End -- Toggle Key (toggle) 

-- Theme (execute in SynX) ; updates visually after either up/down/left/right arrows have been pressed
_G["Theme"] = { 
    ["UI_Position"] = Vector2.new(100, 100),
    ["Text_Size"] = 16,

    ["Category_Text"] = Color3.fromRGB(255, 255, 255),
    ["Category_Back"] = Color3.fromRGB(0, 0, 0),
    ["Category_Back_Transparency"] = 0.75,

    ["Option_Text"] = Color3.fromRGB(255, 255, 255),
    ["Option_Back"] = Color3.fromRGB(0, 0, 0),
    ["Option_Back_Transparency"] = 0.75,

    ["Selected_Color"] = Color3.fromRGB(255, 50, 50)
}

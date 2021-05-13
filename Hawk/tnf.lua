local args = {...}
local GameCategory = args[1]:Category(Current_Game.Name)

local GameVisuals = GameCategory:Sector("Visuals")

local GameVisual_Settings = {
    Item_ESP = false
}

GameVisuals:Cheat("Checkbox", "Item ESP", function (NewValue)
    GameVisual_Settings.Item_ESP = NewValue
end, {enabled = GameVisual_Settings.Item_ESP})

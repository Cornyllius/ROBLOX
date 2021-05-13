local GameCategory = FinityWindow:Category(Current_Game.Name)

local GameVisuals = GameCategory:Sector("Visuals")

local GameVisual_Settings = {
    Item_ESP = false
}

GameVisuals:Cheat("Checkbox", "Item ESP", function (NewValue)
    GameVisual_Settings.Item_ESP = NewValue
end, {enabled = GameVisual_Settings.Item_ESP})

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local Camera = game:GetService("Workspace").CurrentCamera

local function ESP(v, counter)
    local parent = v.Parent
    
    local NAME = Drawing.new("Text")
    NAME.Visible = false
    NAME.Transparency = 0.8
    NAME.Color = Color3.fromRGB(math.random(50, 255), math.random(50, 255), math.random(50, 255))
    NAME.Outline = true
    NAME.OutlineColor = Color3.fromRGB(0, 0, 0)
    NAME.Position = Vector2.new(0, 0)
    NAME.Size = 15
    NAME.Center = true
    NAME.Font = 3 
    NAME.Text = v.Name

    local function Update()
        local c 
        c = game:GetService("RunService").RenderStepped:Connect(function()
            local found = false
            for i,v in pairs(game:GetService("Workspace").World.Items:GetChildren()) do
                if v:FindFirstChild("idx") and v.idx.Value == counter then
                    found = true 
                    break
                end
            end
            if found then
                if GameVisual_Settings.Item_ESP and v ~= nil then
                    local pos, vis = Camera:WorldToViewportPoint(v.Main.Position)
                    if vis then
                        NAME.Position = Vector2.new(pos.X, pos.Y)
                        NAME.Visible = true
                    else 
                        NAME.Visible = false
                    end
                else 
                    NAME.Visible = false
                end 
            else 
                NAME:Remove()
                c:Disconnect()
            end
        end)
    end
    coroutine.wrap(Update)()
end

local counter = 0
for _,v in pairs(game:GetService("Workspace").World.Items:GetChildren()) do
    counter = counter + 1
    local idx = Instance.new("IntValue")
    idx.Name = "idx"
    idx.Value = counter
    idx.Parent = v
    ESP(v, counter)
end

game:GetService("Workspace").World.Items.ChildAdded:Connect(function(v)
    counter = counter + 1
    local idx = Instance.new("IntValue")
    idx.Name = "idx"
    idx.Value = counter
    idx.Parent = v
    ESP(v, counter)
end)

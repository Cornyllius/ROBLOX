--// The New Frontier //--
local Player = game:service("Players").LocalPlayer
local UIS = game:service("UserInputService")

local args = {...}

local TNFCategory = args[1]:Category(args[2].Name)
print(tostring(args[1]))
print(args[2].Name)

local TNFVisuals = TNFCategory:Sector("Visuals")

local GameVisual_Settings = {
    Item_ESP = false,
    Item_Color = Color3.fromRGB(255, 0, 255),
    Animal_ESP = false,
    Animal_Color = Color3.fromRGB(255, 0, 170)
}

TNFVisuals:Cheat("Checkbox", "Items", function (NewValue)
    GameVisual_Settings.Item_ESP = NewValue
end, {enabled = GameVisual_Settings.Item_ESP})

TNFVisuals:Cheat("Colorpicker", "Color", function (NewValue)
    GameVisual_Settings.Color = NewValue
end, {color = GameVisual_Settings.Color})

TNFVisuals:Cheat("Checkbox", "Animals", function (NewValue)
    GameVisual_Settings.Animal_ESP = NewValue
end, {enabled = GameVisual_Settings.Animal_ESP})

TNFVisuals:Cheat("Colorpicker", "Color", function (NewValue)
    GameVisual_Settings.Animal_Color = NewValue
end, {color = GameVisual_Settings.Animal_Color})

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local Camera = game:GetService("Workspace").CurrentCamera

local function ESP(v, counter, type)
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
    if type == "item" then
        local function Update()
            local c 
            c = game:GetService("RunService").RenderStepped:Connect(function()
                if game.CoreGui:FindFirstChild("FinityUI") == nil then
                    NAME:Remove()
                    c:Disconnect()
                end
                local found = false
                for i,v in pairs(game:GetService("Workspace").World.Items:GetChildren()) do
                    if v:FindFirstChild("idx") and v.idx.Value == counter then
                        found = true 
                        break
                    end
                end
                if found then
                    if GameVisual_Settings.Item_ESP and v ~= nil then
                        local pos, vis = Camera:WorldToViewportPoint(v.PrimaryPart.Position)
                        if vis then
                            NAME.Color = GameVisual_Settings.Item_Color
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
    elseif type == "animal" then
        local function Update()
            local c 
            c = game:GetService("RunService").RenderStepped:Connect(function()
                if game.CoreGui:FindFirstChild("FinityUI") == nil then
                    NAME:Remove()
                    c:Disconnect()
                end
                local found = false
                for i,v in pairs(game:GetService("Workspace").World.Operables.Animals:GetChildren()) do
                    if v:FindFirstChild("idx") and v.idx.Value == counter then
                        found = true 
                        break
                    end
                end
                if found then
                    if GameVisual_Settings.Animal_ESP and v ~= nil then
                        local pos, vis = Camera:WorldToViewportPoint(v.PrimaryPart.Position)
                        if vis then
                            NAME.Color = GameVisual_Settings.Animal_Color
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
end

local counter = 0
for _,v in pairs(game:GetService("Workspace").World.Items:GetChildren()) do
    counter = counter + 1
    local idx = Instance.new("IntValue")
    idx.Name = "idx"
    idx.Value = counter
    idx.Parent = v
    ESP(v, counter, "item")
end

game:GetService("Workspace").World.Items.ChildAdded:Connect(function(v)
    counter = counter + 1
    local idx = Instance.new("IntValue")
    idx.Name = "idx"
    idx.Value = counter
    idx.Parent = v
    ESP(v, counter, "item")
end)

local counter2 = 0
for _,v in pairs(game:GetService("Workspace").World.Operables.Animals:GetChildren()) do
    counter2 = counter2 + 1
    local idx = Instance.new("IntValue")
    idx.Name = "idx"
    idx.Value = counter2
    idx.Parent = v
    ESP(v, counter2, "animal")
end

game:GetService("Workspace").World.Operables.Animals.ChildAdded:Connect(function(v)
    counter2 = counter2 + 1
    local idx = Instance.new("IntValue")
    idx.Name = "idx"
    idx.Value = counter2
    idx.Parent = v
    ESP(v, counter2, "animal")
end)

local TNFPlayer = TNFCategory:Sector("Local Player")

local TNFPlayer_Settings = {
    stamina_toggle = false,
    hunger_toggle = false,
    warmth_toggle = false,
    Click_TP = false
}

TNFPlayer:Cheat("Checkbox", "Inf Stamina", function (NewValue)
    TNFPlayer_Settings.stamina_toggle = NewValue
end, {enabled = TNFPlayer_Settings.stamina_toggle})

TNFPlayer:Cheat("Checkbox", "Inf Hunger", function (NewValue)
    TNFPlayer_Settings.hunger_toggle = NewValue
end, {enabled = TNFPlayer_Settings.hunger_toggle})

TNFPlayer:Cheat("Checkbox", "Inf Warmth", function (NewValue)
    TNFPlayer_Settings.warmth_toggle = NewValue
end, {enabled = TNFPlayer_Settings.warmth_toggle})

TNFPlayer:Cheat("Checkbox", "(CTRL + Click) TP", function (NewValue)
    TNFPlayer_Settings.Click_TP = NewValue
end, {enabled = TNFPlayer_Settings.Click_TP})

for i, v in pairs(getgc(true)) do
    if type(v) == 'table' and rawget(v, "stamina") then
        coroutine.wrap(function()
            local c 
            c = game:service("RunService").RenderStepped:Connect(function()
                if TNFPlayer_Settings.stamina_toggle == true  then
                    v.stamina = 100
                end
            end)
        end)()
    end
    if type(v) == 'table' and rawget(v, "hunger") then
        coroutine.wrap(function()
            local c 
            c = game:service("RunService").RenderStepped:Connect(function()
                if TNFPlayer_Settings.hunger_toggle == true  then
                    v.hunger = 5000
                end
            end)
        end)()
    end
    if type(v) == 'table' and rawget(v, "warmth") then
        coroutine.wrap(function()
            local c 
            c = game:service("RunService").RenderStepped:Connect(function()
                if TNFPlayer_Settings.warmth_toggle == true  then
                    v.warmth = 5000
                end
            end)
        end)()
    end
end

UIS.InputBegan:Connect(function(input)
    if TNFPlayer_Settings.Click_TP == true and input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) and Player.Character ~= nil and Player.Character.PrimaryPart ~= nil then
        Player.Character.PrimaryPart.CFrame = CFrame.new(Mouse.Hit.p + Vector3.new(0, 3, 0))
    end
end)

--// The New Frontier //-- END

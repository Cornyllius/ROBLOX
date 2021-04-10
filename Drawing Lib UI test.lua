-- Made by Blissful#4992
local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local UIS = game:GetService("UserInputService")

local function Place(obj, pos)
    obj.Position = Vector2.new(pos.X - obj.Size.X, pos.Y - obj.Size.Y)
end

local library = {}

function library:CreateFrame(name, color, textcolor, textsize, position, size)
    local button = Drawing.new("Square")
    button.Visible = true
    button.Transparency = 1
    button.Filled = true
    button.Size = size
    button.Color = color
    button.Position = position
    
    local Text = Drawing.new("Text")
    Text.Visible = true
    Text.Transparency = 1
    Text.Text = name
    Text.Size = textsize
    Text.Center = true
    Text.Position = Vector2.new(position.X + size.X/2, position.Y + size.Y/2-6*textsize/15)
    Text.Color = textcolor
end

function library:CreateButton(name, color, textcolor, textsize, position, size, CallBack)
    local button = Drawing.new("Square")
    button.Visible = true
    button.Transparency = 1
    button.Filled = true
    button.Size = size
    button.Color = color
    button.Position = position
    
    local Text = Drawing.new("Text")
    Text.Visible = true
    Text.Transparency = 1
    Text.Text = name
    Text.Size = textsize
    Text.Center = true
    Text.Position = Vector2.new(position.X + size.X/2, position.Y + size.Y/2-6*textsize/15)
    Text.Color = textcolor

    local clicking = false
    UIS.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and clicking == false then
            local inset = game:GetService("GuiService"):GetGuiInset()
            local TL = button.Position
            local BR = button.Position + Vector2.new(button.Size.X, button.Size.Y)
            local mpos = Vector2.new(Mouse.X, Mouse.Y + inset.Y)
            if mpos.X > TL.X and mpos.X < BR.X and mpos.Y > TL.Y and mpos.Y < BR.Y then
                clicking = true
                button.Transparency = 0.5
            end
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and clicking == true then
            clicking = false
            button.Transparency = 1
            CallBack()
        end
    end)
end

-- SEPARATION
local a = library
-- name, color, textcolor, position, size, CallBack
a:CreateFrame("Blissful#4992", Color3.fromRGB(0, 0, 255), Color3.fromRGB(255, 255, 255), 30, Vector2.new(1000, 750), Vector2.new(200, 100))
a:CreateButton("Click Me", Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 0, 0), 15, Vector2.new(200, 750), Vector2.new(200, 100), function()
    print("hello")
end)

-- Mouse Dot
local dot = Drawing.new("Circle")
dot.Visible = true
dot.Transparency = 1
dot.Filled = true
dot.Radius = 4
dot.Color = Color3.fromRGB(255, 255, 255)
dot.Position = Vector2.new(Mouse.X, Mouse.Y + 36)

local function Update()
    game:GetService("RunService").RenderStepped:Connect(function()
        local inset = game:GetService("GuiService"):GetGuiInset()
        dot.Position = Vector2.new(Mouse.X, Mouse.Y + inset.Y)
    end)
end
coroutine.wrap(Update)()

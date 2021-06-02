-- BASE FUNCTIONS
local v2 = Vector2.new
local u2 = UDim2.new
local drawing = Drawing.new
local RGB = Color3.fromRGB
-- MATH FUNCTIONS
local clamp = math.clamp
local round = math.round
local abs = math.abs
local random = math.random
local floor = math.floor

--START
local function NewSquare(position, color, transparency)
    local b = drawing("Square")
    b.Position = position
    b.Size = v2(0, 0)
    b.Color = color
    b.Visible = true
    b.Filled = true
    b.Thickness = 0
    b.Transparency = transparency
    return b
end

local function NewText(position, color, text, text_size)
    local t = drawing("Text")
    t.Position = position
    t.Size = text_size
    t.Text = text
    t.Font = 3
    t.Color = color
    t.Visible = true
    t.Transparency = 1
    return t
end

local function CreateTextBox(text, back_color, back_transparency, text_color, text_size, pos, type)

    local b = NewSquare(pos, back_color, back_transparency)
    local t = NewText(v2(0, 0), text_color, text, text_size)

    local margin = 2
    b.Size = v2(t.TextBounds.X+margin*4, t.TextBounds.Y+margin*2)
    t.Position = v2(pos.X+margin*2, pos.Y+margin)

    if type == "Toggle" then
        local newpos = v2(b.Position.X + b.Size.X, b.Position.Y)

        local b2 = NewSquare(newpos, back_color, back_transparency)
        local t2 = NewText(v2(0, 0), RGB(255, 255, 255), "off", text_size)

        b2.Size = v2(t2.TextBounds.X+margin*4, t2.TextBounds.Y+margin*2)
        t2.Position = v2(newpos.X+margin, newpos.Y+margin)

        return {["Main"] = b, ["Text"] = t, ["Extra"] = {["Main"] = b2, ["Text"] = t2}}
    elseif type == "Slider" then
        local newpos = v2(b.Position.X + b.Size.X, b.Position.Y)

        local b2 = NewSquare(newpos, back_color, back_transparency)
        local t2 = NewText(v2(0, 0), RGB(255, 255, 255), "< 0 >", text_size)
        t2.Center = true

        b2.Size = v2(t2.TextBounds.X+margin*4, t2.TextBounds.Y+margin*2)
        t2.Position = v2(newpos.X+margin+t2.TextBounds.X/2, newpos.Y+margin)

        return {["Main"] = b, ["Text"] = t, ["Extra"] = {["Main"] = b2, ["Text"] = t2}}
    elseif type == "Dropdown" then
        local newpos = v2(b.Position.X + b.Size.X, b.Position.Y)

        local b2 = NewSquare(newpos, back_color, back_transparency)
        local t2 = NewText(v2(0, 0), RGB(255, 255, 255), "testtext", text_size)
        t2.Center = true

        b2.Size = v2(t2.TextBounds.X+margin*4, t2.TextBounds.Y+margin*2)
        t2.Position = v2(newpos.X+margin+t2.TextBounds.X/2, newpos.Y+margin)

        return {["Main"] = b, ["Text"] = t, ["Extra"] = {["Main"] = b2, ["Text"] = t2}}
    elseif type == "Colorpicker" then
        local newpos = v2(b.Position.X + b.Size.X, b.Position.Y)

        local b2 = NewSquare(newpos, back_color, back_transparency)
        local t2 = NewText(v2(0, 0), RGB(255, 255, 255), "<   >", text_size)
        local p2 = NewSquare(newpos, RGB(0,0,0), 1)
        p2.Size = v2(9, 9)

        t2.Center = true

        b2.Size = v2(t2.TextBounds.X+margin*4, t2.TextBounds.Y+margin*2)
        t2.Position = v2(newpos.X+margin+t2.TextBounds.X/2, newpos.Y+margin)

        p2.Position = v2(t2.Position.X-p2.Size.X/2, b2.Position.Y+b2.Size.Y/2-p2.Size.Y/2)

        return {["Main"] = b, ["Text"] = t, ["Extra"] = {["Main"] = b2, ["Text"] = t2, ["Preview"] = p2}}
    end

    return {["Main"] = b, ["Text"] = t}
end

local function Count(tbl)
    local c = 0
    for i, v in pairs(tbl) do
        c = c + 1
    end
    return c
end

-- LIBRARY START
local Keys = {Enum.KeyCode.Up, Enum.KeyCode.Down, Enum.KeyCode.Left, Enum.KeyCode.Right}
local ContextActionService = game:GetService("ContextActionService")

ContextActionService:BindActionAtPriority("DisableArrowKeys", function() return Enum.ContextActionResult.Sink end, false, Enum.ContextActionPriority.High.Value, unpack(Keys))

local DESTROY_GUI = false

_G["Layout"] = {}

_G["Theme"] = {
    ["Category_Text"] = Color3.fromRGB(255, 255, 140),
    ["Category_Back"] = Color3.fromRGB(0, 0, 0),
    ["Category_Back_Transparency"] = 0.75,

    ["Option_Text"] = Color3.fromRGB(255, 255, 255),
    ["Option_Back"] = Color3.fromRGB(0, 0, 0),
    ["Option_Back_Transparency"] = 0.75,

    ["Selected_Color"] = Color3.fromRGB(255, 0, 255)
}

local function GetNewYCoord()
    local y = 100
    for i,v in pairs(_G["Layout"]) do
        y = y + v["Drawings"]["Main"].Size.Y
    end
    return y
end

local selected = 1
local n = #_G["Layout"]

local Library = {}
function Library:UpdateTheme()
    for i = 1, #_G["Layout"] do
        local v = _G["Layout"][i]
        if i == selected then
            if v["Type"] == "Category" then
                v["Drawings"]["Main"].Color = _G["Theme"]["Category_Back"]
                v["Drawings"]["Main"].Transparency = _G["Theme"]["Category_Back_Transparency"]
                v["Drawings"]["Text"].Color = _G["Theme"]["Selected_Color"]
            else
                v["Drawings"]["Main"].Color = _G["Theme"]["Option_Back"]
                v["Drawings"]["Main"].Transparency = _G["Theme"]["Option_Back_Transparency"]
                v["Drawings"]["Text"].Color = _G["Theme"]["Selected_Color"]
                if v["Type"] == "Toggle" or v["Type"] == "Slider" or v["Type"] == "Dropdown" or v["Type"] == "Colorpicker" then
                    v["Drawings"]["Extra"]["Main"].Color = _G["Theme"]["Option_Back"]
                    v["Drawings"]["Extra"]["Main"].Transparency = _G["Theme"]["Option_Back_Transparency"]
                    v["Drawings"]["Extra"]["Text"].Color = _G["Theme"]["Selected_Color"]
                end
            end
        else
            if v["Type"] == "Category" then
                v["Drawings"]["Main"].Color = _G["Theme"]["Category_Back"]
                v["Drawings"]["Main"].Transparency = _G["Theme"]["Category_Back_Transparency"]
                v["Drawings"]["Text"].Color = _G["Theme"]["Category_Text"]
            else
                v["Drawings"]["Main"].Color = _G["Theme"]["Option_Back"]
                v["Drawings"]["Main"].Transparency = _G["Theme"]["Option_Back_Transparency"]
                v["Drawings"]["Text"].Color = _G["Theme"]["Option_Text"]
                if v["Type"] == "Toggle" or v["Type"] == "Slider" or v["Type"] == "Dropdown" or v["Type"] == "Colorpicker" then
                    v["Drawings"]["Extra"]["Main"].Color = _G["Theme"]["Option_Back"]
                    v["Drawings"]["Extra"]["Main"].Transparency = _G["Theme"]["Option_Back_Transparency"]
                    v["Drawings"]["Extra"]["Text"].Color = _G["Theme"]["Option_Text"]
                end
            end
        end
    end
end

local Picker_Colors = {
    [1] = {"Red", RGB(255, 0, 0)},
    [2] = {"Orange", RGB(255, 136, 0)},
    [3] = {"Yellow", RGB(255, 255, 0)},
    [4] = {"Lime", RGB(160, 255, 0)},
    [5] = {"Green", RGB(0, 255, 0)},
    [6] = {"Teal", RGB(0, 255, 195)},
    [7] = {"Aqua", RGB(0, 213, 255)},
    [8] = {"Blue", RGB(0, 145, 255)},
    [9] = {"Dark Blue", RGB(0, 60, 255)},
    [10] = {"Purple", RGB(102, 0, 255)},
    [11] = {"Magenta", RGB(162, 0, 255)},
    [12] = {"Pink", RGB(221, 0, 255)},
    [13] = {"Hot Pink", RGB(255, 0, 128)},
    [14] = {"White", RGB(255, 255, 255)},
    [15] = {"Light Gray", RGB(165, 165, 165)},
    [16] = {"Gray", RGB(107, 107, 107)},
    [17] = {"Dark Gray", RGB(61, 61, 61)},
    [18] = {"Black", RGB(0, 0, 0)}
}

local function Reset()
    Library:UpdateTheme()
    n = #_G["Layout"]
    for i = 1, n do
        local v = _G["Layout"][i]
        if i == selected then
            if v["Type"] == "Toggle" then
                if v["ENABLED"] == true then
                    v["Drawings"]["Extra"]["Text"].Text = "on"
                else 
                    v["Drawings"]["Extra"]["Text"].Text = "off"
                end
            elseif v["Type"] == "Slider" then
                v["Drawings"]["Extra"]["Text"].Text = "<"..v["VALUE"]..">"

                local newpos = v["Drawings"]["Extra"]["Main"].Position
                local margin = 2
                local b2 = v["Drawings"]["Extra"]["Main"]
                local t2 = v["Drawings"]["Extra"]["Text"]
                b2.Size = v2(t2.TextBounds.X+margin*4, t2.TextBounds.Y+margin*2)
                t2.Position = v2(newpos.X+margin+t2.TextBounds.X/2, newpos.Y+margin)
            elseif v["Type"] == "Dropdown" then
                local current = v["Selected"]
                v["Drawings"]["Extra"]["Text"].Text = "<"..v["OPTIONS"][current]..">"

                local newpos = v["Drawings"]["Extra"]["Main"].Position
                local margin = 2
                local b2 = v["Drawings"]["Extra"]["Main"]
                local t2 = v["Drawings"]["Extra"]["Text"]
                b2.Size = v2(t2.TextBounds.X+margin*4, t2.TextBounds.Y+margin*2)
                t2.Position = v2(newpos.X+margin+t2.TextBounds.X/2, newpos.Y+margin)
            elseif v["Type"] == "Colorpicker" then
                local current = v["Selected"]
                v["Drawings"]["Extra"]["Preview"].Color = v["Colors"][current][2]
            end
        else 
            if v["Type"] == "Toggle" then
                if v["ENABLED"] == true then
                    v["Drawings"]["Extra"]["Text"].Text = "on"
                else 
                    v["Drawings"]["Extra"]["Text"].Text = "off"
                end
            elseif v["Type"] == "Slider" then
                v["Drawings"]["Extra"]["Text"].Text = "<"..v["VALUE"]..">"

                local newpos = v["Drawings"]["Extra"]["Main"].Position
                local margin = 2
                local b2 = v["Drawings"]["Extra"]["Main"]
                local t2 = v["Drawings"]["Extra"]["Text"]
                b2.Size = v2(t2.TextBounds.X+margin*4, t2.TextBounds.Y+margin*2)
                t2.Position = v2(newpos.X+margin+t2.TextBounds.X/2, newpos.Y+margin)
            elseif v["Type"] == "Dropdown" then
                local current = v["Selected"]
                v["Drawings"]["Extra"]["Text"].Text = "<"..v["OPTIONS"][current]..">"

                local newpos = v["Drawings"]["Extra"]["Main"].Position
                local margin = 2
                local b2 = v["Drawings"]["Extra"]["Main"]
                local t2 = v["Drawings"]["Extra"]["Text"]
                b2.Size = v2(t2.TextBounds.X+margin*4, t2.TextBounds.Y+margin*2)
                t2.Position = v2(newpos.X+margin+t2.TextBounds.X/2, newpos.Y+margin)
            elseif v["Type"] == "Colorpicker" then
                local current = v["Selected"]
                v["Drawings"]["Extra"]["Preview"].Color = v["Colors"][current][2]
            end
        end
    end
end

Reset()
local UIS = game:GetService("UserInputService")
local c
c = UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.Down then
            selected = clamp(selected + 1, 1, n)
            Reset()
        end
        if input.KeyCode == Enum.KeyCode.Up then
            selected = clamp(selected - 1, 1, n)
            Reset()
        end
        if input.KeyCode == Enum.KeyCode.Right then
            n = #_G["Layout"]
            for i = 1, n do
                local v = _G["Layout"][i]
                if i == selected then
                    if v["Type"] == "Button" then
                        v["CallBack"]()
                        Reset()
                    elseif v["Type"] == "Slider" then
                        local str = "1"
                        for i = 1, v["Decimals"] do 
                            str = str.."0"
                        end
                        local newval = clamp(floor((v["VALUE"] + v["Increment"])* tonumber(str))/tonumber(str), v["Min"], v["Max"])
                        v["VALUE"] = newval
                        v["CallBack"](newval)
                        Reset()
                    elseif v["Type"] == "Toggle" then
                        v["ENABLED"] = not v["ENABLED"]
                        v["CallBack"](v["ENABLED"])
                        Reset()
                    elseif v["Type"] == "Dropdown" then
                        local n = #v["OPTIONS"]
                        local current = v["Selected"]

                        current = current + 1
                        if current == n+1 then
                            current = 1
                        end
                        v["Selected"] = current
                        v["CallBack"](v["OPTIONS"][current])
                        Reset()
                    elseif v["Type"] == "Colorpicker" then
                        local n = #v["Colors"]
                        local current = v["Selected"]

                        current = current + 1
                        if current == n+1 then
                            current = 1
                        end
                        v["Selected"] = current
                        local col = v["Colors"][current][2]
                        v["CallBack"](col)
                        Reset()
                    end
                end
            end
        end
        if input.KeyCode == Enum.KeyCode.Left then
            n = #_G["Layout"]
            for i = 1, n do
                local v = _G["Layout"][i]
                if i == selected then
                    if v["Type"] == "Slider" then
                        local str = "1"
                        for i = 1, v["Decimals"] do 
                            str = str.."0"
                        end
                        local newval = clamp(floor((v["VALUE"] - v["Increment"])* tonumber(str))/tonumber(str), v["Min"], v["Max"])
                        v["VALUE"] = newval
                        v["CallBack"](newval)
                        Reset()
                    elseif v["Type"] == "Dropdown" then
                        local n = #v["OPTIONS"]
                        local current = v["Selected"]

                        current = current - 1
                        if current == 0 then
                            current = n
                        end
                        v["Selected"] = current
                        v["CallBack"](v["OPTIONS"][current])
                        Reset()
                    elseif v["Type"] == "Colorpicker" then
                        local n = #v["Colors"]
                        local current = v["Selected"]

                        current = current - 1
                        if current == 0 then
                            current = n
                        end
                        v["Selected"] = current
                        local col = v["Colors"][current][2]
                        v["CallBack"](col)
                        Reset()
                    end
                end
            end
        end
    end
end)
spawn(function()
    while wait() do
        if DESTROY_GUI then
            c:Disconnect()
        end
    end
end)

function Library:NewCategory(cat_name)
    local val = #_G["Layout"]+1
    local new_y = GetNewYCoord()
    _G["Layout"][val] = {
        ["Type"] = "Category",
        ["Drawings"] = CreateTextBox(cat_name, RGB(10, 10, 10), 0.75, RGB(255, 255, 255), 16, v2(100, new_y), "Category")
    }
    Reset()

    local cat_funcs = {}

    function cat_funcs:NewButton(op_name, CallBack)
        local val = #_G["Layout"]+1
        local new_y = GetNewYCoord()
        _G["Layout"][val] = {
            ["Type"] = "Button",
            ["Drawings"] = CreateTextBox(op_name, RGB(10, 10, 10), 0.75, RGB(255, 255, 255), 16, v2(110, new_y), "Button"),
            ["CallBack"] = CallBack
        }
        Reset()
    end

    function cat_funcs:NewToggle(op_name, default, CallBack)
        local val = #_G["Layout"]+1
        local new_y = GetNewYCoord()
        _G["Layout"][val] = {
            ["ENABLED"] = default,
            ["Type"] = "Toggle",
            ["Drawings"] = CreateTextBox(op_name, RGB(10, 10, 10), 0.75, RGB(255, 255, 255), 16, v2(110, new_y), "Toggle"),
            ["CallBack"] = CallBack
        }
        Reset()
    end

    function cat_funcs:NewSlider(op_name, default, increment, min, max, decimal_places, CallBack)
        local val = #_G["Layout"]+1
        local new_y = GetNewYCoord()
        _G["Layout"][val] = {
            ["VALUE"] = default,
            ["Type"] = "Slider",
            ["Increment"] = increment,
            ["Min"] = min,
            ["Max"] = max,
            ["Decimals"] = decimal_places,
            ["Drawings"] = CreateTextBox(op_name, RGB(10, 10, 10), 0.75, RGB(255, 255, 255), 16, v2(110, new_y), "Slider"),
            ["CallBack"] = CallBack
        }
        Reset()
    end

    function cat_funcs:NewDropdown(op_name, options, default, CallBack)
        local val = #_G["Layout"]+1
        local new_y = GetNewYCoord()
        _G["Layout"][val] = {
            ["OPTIONS"] = options,
            ["Type"] = "Dropdown",
            ["Drawings"] = CreateTextBox(op_name, RGB(10, 10, 10), 0.75, RGB(255, 255, 255), 16, v2(110, new_y), "Dropdown"),
            ["Selected"] = default,
            ["CallBack"] = CallBack
        }
        Reset()
    end

    function cat_funcs:NewColorpicker(op_name, default, CallBack)
        local current_op
        for i = 1, #Picker_Colors do
            local v = Picker_Colors[i]
            if v[1] == default then
                current_op = i
            end
        end

        local val = #_G["Layout"]+1
        local new_y = GetNewYCoord()
        _G["Layout"][val] = {
            ["Colors"] = Picker_Colors,
            ["Type"] = "Colorpicker",
            ["Drawings"] = CreateTextBox(op_name, RGB(10, 10, 10), 0.75, RGB(255, 255, 255), 16, v2(110, new_y), "Colorpicker"),
            ["Selected"] = current_op,
            ["CallBack"] = CallBack
        }
        Reset()
    end

    function cat_funcs:NewLabel(op_name)
        local val = #_G["Layout"]+1
        local new_y = GetNewYCoord()
        _G["Layout"][val] = {
            ["Type"] = "Label",
            ["Drawings"] = CreateTextBox(op_name, RGB(10, 10, 10), 0.75, RGB(255, 255, 255), 16, v2(110, new_y), "Label")
        }
        Reset()
    end
    return cat_funcs
end

function Library:Kill()
    for i, v in pairs(_G["Layout"]) do
        v["Drawings"]["Main"]:Remove()
        v["Drawings"]["Text"]:Remove()
        if v["Type"] == "Toggle" or v["Type"] == "Slider" or v["Type"] == "Dropdown" then
            v["Drawings"]["Extra"]["Main"]:Remove()
            v["Drawings"]["Extra"]["Text"]:Remove()
        end
    end
    DESTROY_GUI = true
    _G["Layout"] = {}
end
return Library

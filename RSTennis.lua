--// MADE BY Blissful#4992 / CornCatCornDog on v3rmillion //--

--LUA FUNCTIONS
local clamp = math.clamp
local round = math.round
local abs = math.abs
local huge = math.huge
local random = math.random
local floor = math.floor
local rad = math.rad

local match = string.match
local sub = string.sub

local v3 = Vector3.new
local v2 = Vector2.new
local u2 = UDim2.new
local CF = CFrame.new
local RGB = Color3.fromRGB
local tween = TweenInfo.new

local drawing = Drawing.new

local Space = game:GetService("Workspace")
local Players = game:GetService("Players")
local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local Camera = Space.CurrentCamera
local RES = game:GetService("ReplicatedStorage")

local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LIGHT = game:GetService("Lighting")

local BallEffects = RES.Remotes:WaitForChild("_BallEffects")

coroutine.wrap(function()
    RS.Stepped:Connect(function()
        if Player.Character ~= nil and Player.Character:FindFirstChild("HumanoidRootPart") ~= nil then
            local Speed = _G.Settings.Speed
            local root = Player.Character:FindFirstChild("HumanoidRootPart")
            if UIS:IsKeyDown(Enum.KeyCode.W) then
                root.CFrame = root.CFrame * CF(0, 0, -Speed)
            end
            if UIS:IsKeyDown(Enum.KeyCode.A) then
                root.CFrame = root.CFrame * CF(-Speed, 0, 0)
            end
            if UIS:IsKeyDown(Enum.KeyCode.S) then
                root.CFrame = root.CFrame * CF(0, 0, Speed)
            end
            if UIS:IsKeyDown(Enum.KeyCode.D) then
                root.CFrame = root.CFrame * CF(Speed, 0, 0)
            end
        end
    end)
end)()

coroutine.wrap(function()
    RS.RenderStepped:Connect(function()
        LIGHT.ClockTime = _G.Settings.Clock_Time
        if Player.Character ~= nil then
            BallEffects:Fire("BallPathVisualization", Player.Character, 1)
        end
    end)
end)()

local ESP_API = {}
function ESP_API.NewLine(info)
    local l = drawing("Line")
    l.Visible = info.Visible or false
    l.Transparency = info.Transparency or 1
    l.Color = info.Color or RGB(0,0,0) 

    l.Thickness = info.Thickness or 1
    l.From = v2(0,0)
    l.To = v2(0,0)
    return l
end


function ESP_API.AddPlayer(plr)
    repeat wait() until plr.Character ~= nil and plr.Character:FindFirstChildOfClass("Humanoid")

    local plr_name = plr.Name
    local viewTracer = ESP_API.NewLine({Color = RGB(0, 255, 0), Thickness = 1})

    local c
    c = RS.RenderStepped:Connect(function()
        if _G.Settings.ViewTracers and Player.Character ~= nil and plr.Character ~= nil and plr.Character:FindFirstChildOfClass("Humanoid") and plr.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
            local root_part = plr.Character:FindFirstChild("HumanoidRootPart") or plr.Character.PrimaryPart

            local rootpos, vis = Camera:WorldToViewportPoint(root_part.Position)
            local _,vis_check = Camera:WorldToViewportPoint((root_part.CFrame*CF(0,0,-15)).p)
            local dirpos = Camera:WorldToViewportPoint((root_part.CFrame*CF(0,0,-20)).p)

            viewTracer.From = v2(rootpos.X, rootpos.Y)
            viewTracer.To = v2(dirpos.X, dirpos.Y)
            if vis and vis_check then viewTracer.Visible = true else viewTracer.Visible = false end
        else
            viewTracer.Visible = false
            if Players:FindFirstChild(plr_name) == nil then
                viewTracer:Remove()
                c:Disconnect()
            end
        end
    end)
end

do
    local t = Players:GetChildren()
    for i = 1, #t do
        local v = t[i]
        if v.Name ~= Player.Name then
            coroutine.wrap(ESP_API.AddPlayer)(v)
        end
    end
end

Players.ChildAdded:Connect(function(v)
    coroutine.wrap(ESP_API.AddPlayer)(v)
end)

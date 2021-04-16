repeat wait() until game:GetService("Players").LocalPlayer ~= nil and game:GetService("Players").LocalPlayer.Character ~= nil
local TS = game:GetService("TweenService")
local player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local Mouse = player:GetMouse()

local function tp(x, y, z)
    local info = TweenInfo.new(0.1)
    local move = TS:Create(player.Character.HumanoidRootPart, info, {CFrame = CFrame.new(x, y, z)})
    move:Play()
end

UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
        tp(Mouse.Hit.X,Mouse.Hit.Y+3,Mouse.Hit.Z)
    end
end)

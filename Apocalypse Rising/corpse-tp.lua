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

if game:GetService("Workspace").Corpses:FindFirstChild(player.Name) then
    local humpart = game:GetService("Workspace").Corpses[player.Name]:FindFirstChild("HumanoidRootPart")
    for i = 1, 20 do
        tp(humpart.Position.X, humpart.Position.Y + 2, humpart.Position.Z)
        wait(0.1)
    end
else 
    warn("Body not found!")
end

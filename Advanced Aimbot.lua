-- made by Blissful#4992
local sens = 0.1

local player = game:GetService("Players").LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local mouse = player:GetMouse()
local UIS = game:GetService("UserInputService")

local function Visible(pos, part)
    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {player.Character, part.Parent}
    params.FilterType = Enum.RaycastFilterType.Blacklist
    local Result = workspace:Raycast(player.Character.HumanoidRootPart.Position, (pos - player.Character.HumanoidRootPart.Position).unit * (pos - player.Character.HumanoidRootPart.Position).magnitude, params)
    if Result ~= nil then
        return false
    end
    return true
end

local aimbot = false
UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        aimbot = true
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        aimbot = false
    end
end)

-- Closest Player () function if you want to integrate in an aimbot (also has fov circle)
--[[
local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera

local FOV = Drawing.new("Circle")
FOV.Visible = true
FOV.Color = Color3.fromRGB(255, 255, 255)
FOV.Transparency = 1
FOV.NumSides = 75
FOV.Radius = 100
FOV.Filled = false
FOV.Thickness = 1

local function GetClosest()
    local min = math.huge
    local closest = nil
    for i, v in pairs(game:GetService("Players"):GetChildren()) do
        if v.Name ~= player.Name and v.Character ~= nil and v.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (player.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
            local pos, vis = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            if vis then
                local d = (Vector2.new(pos.X, pos.Y) - FOV.Position).magnitude
                if d <= FOV.Radius and dist < min then
                    min = dist
                    closest = v
                end
            end
        end
    end
    return closest
end
]]

local gui_inset = game:GetService("GuiService"):GetGuiInset()

game:GetService("RunService").RenderStepped:Connect(function()
    if aimbot then
        local plr = game:GetService("Workspace").DummyR15 -- change this
        if plr:FindFirstChild("HumanoidRootPart") then -- if plr.Character ~= nil and plr.Character:FindFirstChild("Humanoid") ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") ~= nil and plr.Character.Humanoid.Health > 0 and plr.Character:FindFirstChild("Head") ~= nil then
            for _,v in pairs(plr:GetChildren()) do
                if v:IsA("BasePart") then
                    if Visible(v.Position, v) == true then
                        local part_pos, v_pos = camera:WorldToViewportPoint(v.Position)
                        if v_pos then
                            mousemoverel((part_pos.X - mouse.X - gui_inset.X) * sens, (part_pos.Y - mouse.Y - gui_inset.Y) * sens)
                            break
                        end
                    else
                        if v.Name == "HumanoidRootPart" then
                            if Visible((v.CFrame * CFrame.new(v.Size.X/2.5, 0, 0)).p, v) == true then
                                local part_pos, v_pos = camera:WorldToViewportPoint((v.CFrame * CFrame.new(v.Size.X/2.5, 0, 0)).p)
                                if v_pos then
                                    mousemoverel((part_pos.X - mouse.X - gui_inset.X) * sens, (part_pos.Y - mouse.Y - gui_inset.Y) * sens)
                                end
                            elseif Visible((v.CFrame * CFrame.new(-v.Size.X/2.5, 0, 0)).p, v) == true then
                                local part_pos, v_pos = camera:WorldToViewportPoint((v.CFrame * CFrame.new(-v.Size.X/2.5, 0, 0)).p)
                                if v_pos then
                                    mousemoverel((part_pos.X - mouse.X - gui_inset.X) * sens, (part_pos.Y - mouse.Y - gui_inset.Y) * sens)
                                end
                            end
                        elseif string.match(v.Name, "Left") then
                            if Visible((v.CFrame * CFrame.new(-v.Size.X/2.5, 0, 0)).p, v) == true then
                                local part_pos, v_pos = camera:WorldToViewportPoint((v.CFrame * CFrame.new(-v.Size.X/2.5, 0, 0)).p)
                                if v_pos then
                                    mousemoverel((part_pos.X - mouse.X - gui_inset.X) * sens, (part_pos.Y - mouse.Y - gui_inset.Y) * sens)
                                end
                            elseif Visible((v.CFrame * CFrame.new(-v.Size.X/2.5, 0, v.Size.Z/2.5)).p, v) == true then
                                local part_pos, v_pos = camera:WorldToViewportPoint((v.CFrame * CFrame.new(-v.Size.X/2.5, 0, v.Size.Z/2.5)).p)
                                if v_pos then
                                    mousemoverel((part_pos.X - mouse.X - gui_inset.X) * sens, (part_pos.Y - mouse.Y - gui_inset.Y) * sens)
                                end
                            elseif Visible((v.CFrame * CFrame.new(-v.Size.X/2.5, 0, -v.Size.Z/2.5)).p, v) == true then
                                local part_pos, v_pos = camera:WorldToViewportPoint((v.CFrame * CFrame.new(-v.Size.X/2.5, 0, -v.Size.Z/2.5)).p)
                                if v_pos then
                                    mousemoverel((part_pos.X - mouse.X - gui_inset.X) * sens, (part_pos.Y - mouse.Y - gui_inset.Y) * sens)
                                end
                            end
                        elseif string.match(v.Name, "Right") then
                            if Visible((v.CFrame * CFrame.new(v.Size.X/2.5, 0, 0)).p, v) == true then
                                local part_pos, v_pos = camera:WorldToViewportPoint((v.CFrame * CFrame.new(v.Size.X/2.5, 0, 0)).p)
                                if v_pos then
                                    mousemoverel((part_pos.X - mouse.X - gui_inset.X) * sens, (part_pos.Y - mouse.Y - gui_inset.Y) * sens)
                                end
                            elseif Visible((v.CFrame * CFrame.new(v.Size.X/2.5, 0, v.Size.Z/2.5)).p, v) == true then
                                local part_pos, v_pos = camera:WorldToViewportPoint((v.CFrame * CFrame.new(v.Size.X/2.5, 0, v.Size.Z/2.5)).p)
                                if v_pos then
                                    mousemoverel((part_pos.X - mouse.X - gui_inset.X) * sens, (part_pos.Y - mouse.Y - gui_inset.Y) * sens)
                                end
                            elseif Visible((v.CFrame * CFrame.new(v.Size.X/2.5, 0, -v.Size.Z/2.5)).p, v) == true then
                                local part_pos, v_pos = camera:WorldToViewportPoint((v.CFrame * CFrame.new(v.Size.X/2.5, 0, -v.Size.Z/2.5)).p)
                                if v_pos then
                                    mousemoverel((part_pos.X - mouse.X - gui_inset.X) * sens, (part_pos.Y - mouse.Y - gui_inset.Y) * sens)
                                end
                            end
                        elseif v.Name == "Head" and Visible((v.CFrame * CFrame.new(0, v.Size.Y/2.5, 0)).p, v) == true then
                            local part_pos, v_pos = camera:WorldToViewportPoint((v.CFrame * CFrame.new(0, v.Size.Y/2.5, 0)).p)
                            if v_pos then
                                mousemoverel((part_pos.X - mouse.X - gui_inset.X) * sens, (part_pos.Y - mouse.Y - gui_inset.Y) * sens)
                            end
                        end
                    end
                end
            end
        end
    end
end)

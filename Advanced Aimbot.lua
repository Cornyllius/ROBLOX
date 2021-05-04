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

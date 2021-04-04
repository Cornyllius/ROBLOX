-- Made by blissful#4992
local plr = game.Players.LocalPlayer
local players = game:GetService("Players")
local mouse = plr:GetMouse()
local camera = game.Workspace.CurrentCamera

function ClosestPlayerToMouse()
    local target = nil
    local dist = math.huge
    for i,v in pairs(game.Players:GetChildren()) do
        if v.Name ~= plr.Name then
            if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") and v.TeamColor ~= plr.TeamColor then
                local screenpoint = camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                local check = (Vector2.new(mouse.X,mouse.Y)-Vector2.new(screenpoint.X,screenpoint.Y)).magnitude

                if check < dist then
                    target  = v
                    dist = check
                end
            end
        end
    end
    return target
end

local mt = getrawmetatable(game)
setreadonly(mt, false)
local namecall = mt.__namecall

mt.__namecall = function(self,...)
    local args = {...}
    local method = getnamecallmethod()
    if tostring(self) == "HitPart" and tostring(method) == "FireServer" then
        args[1] = ClosestPlayerToMouse().Character.Head
        args[2] = ClosestPlayerToMouse().Character.Head.Position
        return self.FireServer(self, unpack(args))
    end
    return namecall(self,...)
end

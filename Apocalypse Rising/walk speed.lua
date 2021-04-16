_G.Speed = 100

local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__index

local ospeed = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed

function WalkSpeed()
    mt.__index = newcclosure(function(self, a)
        if a == "WalkSpeed" then
            return ospeed
        end
        return old(self, a)
    end)
    game:GetService("RunService").RenderStepped:Connect(function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.Speed
    end)
end

WalkSpeed()

_G.JumpPower = 100

local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__index

local ojump = game.Players.LocalPlayer.Character.Humanoid.JumpPower

function JumpPower()
    mt.__index = newcclosure(function(self, a)
        if a == "JumpPower" then
            return ojump
        end
        return old(self, a)
    end)
    game:GetService("RunService").RenderStepped:Connect(function()
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = _G.JumpPower
    end)
end

JumpPower()

spawn(function()
    for i, v in next, getgc(true) do
        if type(v) == 'table' and rawget(v, 'Damage') then
            coroutine.wrap(function()
                while wait(0.1) do
                    v.ShakeIntensity = 0
                    v.Damage = 100
                    v.Speed = 1000
                    v.UnloadAfterCast = false
                    v.Cooldown = 0
                    v.Safe = true
                    v.ChargeCooldown = 0
                    v.Charges = math.huge
                    v.MaxCharges = math.huge
                    if v.Duration then
                        v.Duration = math.huge
                    end
                end
            end)()
        end
        if type(v) == 'table' and rawget(v, 'Gems') then
            v.Gems = 0
        end
    end
end)

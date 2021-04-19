_G.Speed = 75

for _, func in next, getconnections(game:GetService("ScriptContext").Error) do 
    func:Disable()
end

f = nil
for i, k in pairs(getgc()) do
    if f ~= nil then 
        break
    end
    if typeof(k) == "function" and islclosure(k) then
        local info = debug.getconstants(k)
        local SHORT_SRC = tostring(debug.getinfo(k).short_src)
        for _,v in pairs(info) do
            if tostring(v) == "BodyMover" and string.match(SHORT_SRC, "ClientGame") then
                f = k
                break
            end
        end
    end
end
if f ~= nil and typeof(f) == "function" then
    local hook 
    hook = hookfunction(f, function()
        return nil
    end)
end

game:GetService("RunService").RenderStepped:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.Speed
end)

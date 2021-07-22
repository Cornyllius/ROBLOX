-- MADE BY Blissful#4992 / CornCatCornDog on V3rmillion --
coroutine.wrap(function()
    local script = [[
        repeat wait() until game:GetService("Players") ~= nil and game:GetService("Players").LocalPlayer ~= nil
    
        rconsoleclear()
        rconsolename("TWW Legendary Finder")
        rconsoleprint("@@WHITE@@")
        rconsoleprint("Restarting:\n")
            
        local HttpService = game:GetService("HttpService")
        local TPService = game:GetService("TeleportService")

        wait()
        local function currentServer()
            local currentid = game.JobId
            local ServersToTP = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            for i,v in pairs(ServersToTP.data) do
                if v.id == currentid then
                    return i
                end
            end
        end

        local function check()
            rconsoleprint("@@LIGHT_CYAN@@")
            rconsoleprint("Waiting for game...\n")
            repeat wait() until game:GetService("Workspace") ~= nil and game:GetService("Workspace"):FindFirstChild("WORKSPACE_Entities") and game:GetService("Workspace")["WORKSPACE_Entities"]:FindFirstChild("Animals") and game:GetService("Workspace")["WORKSPACE_Entities"].Animals:FindFirstChildOfClass("Model") and game:GetService("Workspace"):FindFirstChild("WORKSPACE_Geometry")
            wait(2)
            local objects = {}
            local exists = false
            local c = 0
            for i,v in pairs(game:GetService("Workspace")["WORKSPACE_Entities"].Animals:GetChildren()) do
                local health = v:WaitForChild("Health")
                if health and health.Value > 200 then 
                    c = c + 1
                    objects[c] = {"Legendary", v}
                    exists = true
                end
            end

            for i,v in pairs(game:GetService("Workspace")["WORKSPACE_Geometry"]:GetDescendants()) do
                if v:IsA("ParticleEmitter") and v.Name == "Strike2" then
                    c = c + 1
                    objects[c] = {"Thunderstruck Tree", v.Parent}
                    exists = true
                end
            end
            return exists, objects
        end
        local exists, objects = check()
        if exists then
            local Camera = workspace.CurrentCamera
            local Player = game:GetService("Players").LocalPlayer
            local RS = game:GetService("RunService")

            local RGB = Color3.fromRGB
            local V2 = Vector2.new
            local ROUND = math.round

            local ESP = {}
            function ESP:add(object, name) 
                local NAME = Drawing.new("Text")
                NAME.Text = name
                NAME.Size = 16
                NAME.Color = RGB(255, 248, 145)
                NAME.Center = true
                NAME.Visible = true
                NAME.Transparency = 1
                NAME.Position = V2(0, 0)
                NAME.Outline = true
                NAME.OutlineColor = RGB(10, 10, 10)
                NAME.Font = 3
                
                local DISTANCE = Drawing.new("Text")
                DISTANCE.Text = "[]"
                DISTANCE.Size = 14
                DISTANCE.Color = RGB(255, 255, 255)
                DISTANCE.Center = true
                DISTANCE.Visible = true
                DISTANCE.Transparency = 1
                DISTANCE.Position = V2(0, 0)
                DISTANCE.Outline = true
                DISTANCE.OutlineColor = RGB(10, 10, 10)
                DISTANCE.Font = 3
                
                local function Update()
                    local c
                    c = RS.RenderStepped:Connect(function()
                        if object.Parent ~= nil and object.Parent.Parent ~= nil and object.PrimaryPart ~= nil then
                            local p = Camera:WorldToViewportPoint(object.PrimaryPart.Position)
                            NAME.Position = V2(p.X, p.Y)
                            
                            if Player.Character ~= nil and Player.Character.PrimaryPart ~= nil then
                                DISTANCE.Position = NAME.Position + V2(0, NAME.TextBounds.Y/1.2)
                                DISTANCE.Text = "["..ROUND((Player.Character.PrimaryPart.Position - object.PrimaryPart.Position).magnitude).."m]"
                                DISTANCE.Visible = true
                            else
                                DISTANCE.Visible = false
                            end
                            
                            NAME.Visible = true
                        else
                            NAME.Visible = false
                            DISTANCE.Visible = false
                            if object.Parent == nil or object.Parent.Parent == nil then
                                NAME:Remove()
                                DISTANCE:Remove()
                                c:Disconnect()
                            end
                        end
                    end)
                end
                coroutine.wrap(Update)()
            end

            rconsoleprint("@@LIGHT_RED@@")
            for i,v in pairs(objects) do
                if v[1] == "Legendary" then
                    rconsoleprint("Found Legendary "..v[2].Name.." !\n")
                    ESP:add(v[2], "Legendary "..v[2].Name)
                elseif v[1] == "Thunderstruck Tree" then
                    rconsoleprint("Found Thunderstruck Tree !\n")
                    ESP:add(v[2], "Thunderstruck Tree")
                end
            end
        else
            rconsoleprint("@@LIGHT_RED@@")
            rconsoleprint("Found 0\n")
            
            local ServersToTP = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
                if State == Enum.TeleportState.Started then
                    syn.queue_on_teleport('loadstring(readfile("penis.lua"))()')
                end
            end)
            
            local current = currentServer()
            
            rconsoleprint("@@WHITE@@")
            rconsoleprint("Current server: ")
            rconsoleprint("@@LIGHT_CYAN@@")
            rconsoleprint(current.."\n")
            
            current = current + 1
            if current > #ServersToTP.data then
                current = 1
            end
            
            if ServersToTP.data[current].playing == ServersToTP.data[current].maxPlayers then
                repeat
                    current = current + 1
                    if current > #ServersToTP.data then
                        current = 1
                    end
                    wait()
                until ServersToTP.data[current].playing < ServersToTP.data[current].maxPlayers
            end
            
            rconsoleprint("@@WHITE@@")
            rconsoleprint("Teleporting to Server: ")
            rconsoleprint("@@LIGHT_CYAN@@")
            rconsoleprint(current.."\n")
            wait(2)
            TPService:TeleportToPlaceInstance(game.PlaceId, ServersToTP.data[current].id)
        end
    ]]
    
    writefile("penis.lua", script)
    wait(0.5)
    loadstring(readfile("penis.lua"))()
end)()

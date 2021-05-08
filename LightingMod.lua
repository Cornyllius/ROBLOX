-- function?
    local Lighting = game:GetService("Lighting")
    for i, v in pairs(Lighting:GetChildren()) do
        v:Destroy()
    end

    local Terrain = game:GetService("Workspace").Terrain
    local color = Instance.new("ColorCorrectionEffect")
    local bloom = Instance.new("BloomEffect")
    local sun = Instance.new("SunRaysEffect")
    local blur = Instance.new("BlurEffect")

    color.Parent = Lighting
    bloom.Parent = Lighting
    sun.Parent = Lighting
    blur.Parent = Lighting

    local config = {

        Terrain = true,
        ColorCorrection = true,
        Sun = true,
        Lighting = true,
        BloomEffect = true

    }

    color.Enabled = false
    color.Contrast = 0.15
    color.Brightness = 0.1
    color.Saturation = 0.25
    color.TintColor = Color3.fromRGB(255, 222, 211)

    bloom.Enabled = false
    bloom.Intensity = 0.1

    sun.Enabled = false
    sun.Intensity = 0.2
    sun.Spread = 1

    bloom.Enabled = false
    bloom.Intensity = 0.05
    bloom.Size = 32
    bloom.Threshold = 1

    blur.Enabled = false
    blur.Size = 6

    if config.ColorCorrection then
        color.Enabled = true
    end

    if config.Sun then
        sun.Enabled = true
    end

    if config.Terrain then
        Terrain.WaterColor = Color3.fromRGB(10, 10, 24)
        Terrain.WaterWaveSize = 0.1
        Terrain.WaterWaveSpeed = 22
        Terrain.WaterTransparency = 0.9
        Terrain.WaterReflectance = 0.05
    end

    if config.Lighting then
        Lighting.Ambient = Color3.fromRGB(0, 0, 0)
        Lighting.Brightness = 4
        Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
        Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0)
        Lighting.ExposureCompensation = 0
        Lighting.FogColor = Color3.fromRGB(132, 132, 132)
        Lighting.GlobalShadows = true
        Lighting.OutdoorAmbient = Color3.fromRGB(112, 117, 128)
        Lighting.Outlines = false
    end
end

-- return 

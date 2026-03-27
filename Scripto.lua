-- Configurações de Iluminação Realista para Delta
local Lighting = game:GetService("Lighting")
local Terrain = game:GetService("Workspace").Terrain

-- 1. Limpeza de efeitos antigos para evitar lag
for _, effect in pairs(Lighting:GetChildren()) do
    if effect:IsA("PostProcessEffect") then
        effect:Destroy()
    end
end

-- 2. Configuração de Atmosfera e Sky
local atmosphere = Instance.new("Atmosphere", Lighting)
atmosphere.Density = 0.3
atmosphere.Offset = 0.25
atmosphere.Color = Color3.fromRGB(190, 190, 190)
atmosphere.Decay = Color3.fromRGB(100, 100, 100)

-- 3. Efeito Bloom (Brilho de Neon e Sol)
local bloom = Instance.new("BloomEffect", Lighting)
bloom.Intensity = 0.4
bloom.Size = 18
bloom.Threshold = 0.8

-- 4. Correção de Cor (Contraste e Vivacidade)
local color = Instance.new("ColorCorrectionEffect", Lighting)
color.Brightness = 0.05
color.Contrast = 0.2
color.Saturation = 0.3
color.TintColor = Color3.fromRGB(255, 253, 240) -- Tom levemente quente

-- 5. Raios de Sol (Sunrays)
local sunRays = Instance.new("SunRaysEffect", Lighting)
sunRays.Intensity = 0.1
sunRays.Spread = 0.7

-- 6. Ajustes Globais da Engine
Lighting.GlobalShadows = true
Lighting.ShadowSoftness = 0.2
Lighting.Brightness = 2.5
Lighting.ExposureCompensation = 0.6
Lighting.EnvironmentDiffuseScale = 1
Lighting.EnvironmentSpecularScale = 1

-- 7. Melhoria no Terreno (Reflexos na água)
Terrain.WaterReflectance = 1
Terrain.WaterTransparency = 0.8
Terrain.WaterWaveSize = 0.15
Terrain.WaterWaveSpeed = 12

print("Script de Shaders carregado com sucesso no Delta!")

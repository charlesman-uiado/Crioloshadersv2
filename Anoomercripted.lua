--[[ 
    CRIOLOSHADERS V12 - THE MULTIVERSE UI
    Estilos: Internal Dark | Retro Matrix | Minecraft ClickGUI | Glassmorphism
]]

local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("CrioloShaders") then CoreGui.CrioloShaders:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "CrioloShaders"

-- --- ESTRUTURA PRINCIPAL ---
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Position = UDim2.new(0.1, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 560, 0, 430)
MainFrame.Active = true
MainFrame.Draggable = true
local MainCorner = Instance.new("UICorner", MainFrame)
local MainStroke = Instance.new("UIStroke", MainFrame)

-- --- SISTEMA DE TEMAS (A MÁGICA ACONTECE AQUI) ---
local function ApplyTheme(style)
    if style == "Internal" then
        MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
        MainFrame.BackgroundTransparency = 0.1
        MainStroke.Color = Color3.fromRGB(0, 120, 255) -- Azul Moderno
        MainStroke.Thickness = 1.5
        MainCorner.CornerRadius = UDim.new(0, 12)
    elseif style == "Retro" then
        MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        MainFrame.BackgroundTransparency = 0
        MainStroke.Color = Color3.fromRGB(0, 255, 70) -- Verde Matrix
        MainStroke.Thickness = 2
        MainCorner.CornerRadius = UDim.new(0, 0) -- Quadrado
    elseif style == "Minecraft" then
        MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        MainFrame.BackgroundTransparency = 0.05
        MainStroke.Color = Color3.fromRGB(200, 200, 200)
        MainStroke.Thickness = 3
        MainCorner.CornerRadius = UDim.new(0, 5)
    elseif style == "Glass" then
        MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        MainFrame.BackgroundTransparency = 0.85 -- Efeito de Vidro
        MainStroke.Color = Color3.fromRGB(255, 255, 255)
        MainStroke.Thickness = 1
        MainCorner.CornerRadius = UDim.new(0, 20)
        -- Simulação de Blur (Adicionando um fundo borrado se o executor suportar)
    end
end

-- --- CABEÇALHO ---
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Position = UDim2.new(0, 20, 0, 15)
Title.Size = UDim2.new(0, 300, 0, 30)
Title.Text = "CRIOLOSHADERS V12"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.Inter -- Fonte Moderna
Title.TextSize = 22
Title.TextXAlignment = Enum.TextXAlignment.Left

-- --- PAINEL DE CONTEÚDO ---
local SideBar = Instance.new("ScrollingFrame", MainFrame)
SideBar.Position = UDim2.new(0, 10, 0, 70)
SideBar.Size = UDim2.new(0, 140, 1, -80)
SideBar.BackgroundTransparency = 1
SideBar.ScrollBarThickness = 0
Instance.new("UIListLayout", SideBar).Padding = UDim.new(0, 5)

local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Position = UDim2.new(0, 160, 0, 75)
Container.Size = UDim2.new(0, 380, 0, 340)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 2
local Layout = Instance.new("UIListLayout", Container)
Layout.Padding = UDim.new(0, 10)

-- --- BOTÕES DE OPÇÕES COM ANIMAÇÃO ---
local function AddFeature(name, desc, themeColor, callback)
    local f = Instance.new("Frame", Container)
    f.Size = UDim2.new(0.95, 0, 0, 65)
    f.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    f.BackgroundTransparency = 0.6
    Instance.new("UICorner", f)
    
    local t = Instance.new("TextLabel", f)
    t.Position = UDim2.new(0.05, 0, 0.15, 0)
    t.Size = UDim2.new(0.7, 0, 0, 20)
    t.Text = name
    t.TextColor3 = themeColor
    t.Font = Enum.Font.InterBold
    t.TextXAlignment = Enum.TextXAlignment.Left
    t.BackgroundTransparency = 1

    local d = Instance.new("TextLabel", f)
    d.Position = UDim2.new(0.05, 0, 0.5, 0)
    d.Size = UDim2.new(0.7, 0, 0, 20)
    d.Text = desc
    d.TextColor3 = Color3.fromRGB(180, 180, 180)
    d.TextSize = 10
    d.TextXAlignment = Enum.TextXAlignment.Left
    d.BackgroundTransparency = 1
    
    local toggle = Instance.new("TextButton", f)
    toggle.Size = UDim2.new(0, 50, 0, 25)
    toggle.Position = UDim2.new(0.8, 0, 0.3, 0)
    toggle.Text = ""
    toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    local tCorner = Instance.new("UICorner", toggle)
    tCorner.CornerRadius = UDim.new(1, 0) -- Toggle Redondo (Internal)

    local active = false
    toggle.MouseButton1Click:Connect(function()
        active = not active
        game:GetService("TweenService"):Create(toggle, TweenInfo.new(0.3), {
            BackgroundColor3 = active and themeColor or Color3.fromRGB(60, 60, 60)
        }):Play()
        callback(active)
    end)
end

-- --- ABA DE TEMAS ---
local function TabThemes()
    Container:ClearAllChildren()
    Instance.new("UIListLayout", Container).Padding = UDim.new(0, 10)
    
    local btnInternal = Instance.new("TextButton", Container)
    btnInternal.Size = UDim2.new(0.9, 0, 0, 40)
    btnInternal.Text = "Estilo Internal (Modern Dark)"
    btnInternal.MouseButton1Click:Connect(function() ApplyTheme("Internal") end)

    local btnRetro = Instance.new("TextButton", Container)
    btnRetro.Size = UDim2.new(0.9, 0, 0, 40)
    btnRetro.Text = "Estilo Retro (Matrix/Hacker)"
    btnRetro.MouseButton1Click:Connect(function() ApplyTheme("Retro") end)

    local btnGlass = Instance.new("TextButton", Container)
    btnGlass.Size = UDim2.new(0.9, 0, 0, 40)
    btnGlass.Text = "Estilo Glassmorphism (Vidro)"
    btnGlass.MouseButton1Click:Connect(function() ApplyTheme("Glass") end)
end

-- --- BOTÕES LATERAIS COM ÍCONES ---
local function SideBtn(txt, func)
    local b = Instance.new("TextButton", SideBar)
    b.Size = UDim2.new(1, 0, 0, 45)
    b.Text = txt
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(func)
end

SideBtn("Temas/UI", TabThemes)
SideBtn("Visuais", function()
    Container:ClearAllChildren()
    Instance.new("UIListLayout", Container).Padding = UDim.new(0, 10)
    AddFeature("ESP Box 3D", "Visual de caixa nos alvos", Color3.fromRGB(0, 255, 150), function(v) end)
    AddFeature("Chams Neon", "Brilho através das paredes", Color3.fromRGB(255, 0, 255), function(v) end)
end)

-- Fechar
local X = Instance.new("TextButton", MainFrame)
X.Position = UDim2.new(0.94, 0, 0, 10)
X.Size = UDim2.new(0, 25, 0, 25)
X.Text = "X"
X.TextColor3 = Color3.fromRGB(255, 0, 0)
X.BackgroundTransparency = 1
X.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

ApplyTheme("Internal") -- Tema padrão
TabThemes()

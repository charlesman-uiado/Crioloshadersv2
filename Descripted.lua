--[[
    Script Hub Corrigido - Versão Estável
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local camera = workspace.CurrentCamera

-- Variáveis de estado
local Cheats = { Speed = false, JumpPower = false, InfiniteJump = false, Fly = false, NoClip = false, Wallhack = false }
local ESP_Settings = { Enabled = false, Boxes = false, Lines = false }
local Settings = { SpeedValue = 50, JumpValue = 100 }

-- ========== INTERFACE ==========
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ModernCheatHub"
ScreenGui.ResetOnSpawn = false
-- Tenta colocar no CoreGui, se falhar (exploit simples), vai para PlayerGui
local success, err = pcall(function() ScreenGui.Parent = CoreGui end)
if not success then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Frame Principal com Sombra
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 400)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local Shadow = Instance.new("Frame")
Shadow.Size = UDim2.new(1, 10, 1, 10)
Shadow.Position = UDim2.new(0, -5, 0, -5)
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.7
Shadow.BorderSizePixel = 0
Shadow.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(0, 12)
ShadowCorner.Parent = Shadow

-- Barra Superior (Arrastável) com Gradiente
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopCorner.Parent = TopBar

-- Efeito Gradiente na TopBar
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 28))
})
Gradient.Rotation = 90
Gradient.Parent = TopBar

-- Linha de Destaque na TopBar
local HighlightBar = Instance.new("Frame")
HighlightBar.Size = UDim2.new(1, 0, 0, 2)
HighlightBar.Position = UDim2.new(0, 0, 1, -2)
HighlightBar.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
HighlightBar.BorderSizePixel = 0
HighlightBar.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ GRAPHICS & CHEAT HUB ⚡"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Botão Fechar
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0, 8)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
CloseButton.BackgroundTransparency = 0.3
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Botão Minimizar
local MinButton = Instance.new("TextButton")
MinButton.Size = UDim2.new(0, 30, 0, 30)
MinButton.Position = UDim2.new(1, -80, 0, 8)
MinButton.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
MinButton.BackgroundTransparency = 0.3
MinButton.Text = "−"
MinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinButton.Font = Enum.Font.GothamBold
MinButton.TextSize = 18
MinButton.BorderSizePixel = 0
MinButton.Parent = TopBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinButton

local isMinimized = false
local originalSize = MainFrame.Size
local originalContentSize = ContentArea.Size
MinButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 420, 0, 45)}):Play()
        TweenService:Create(ContentArea, TweenInfo.new(0.2), {Size = UDim2.new(1, -120, 0, 0)}):Play()
        MinButton.Text = "+"
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = originalSize}):Play()
        TweenService:Create(ContentArea, TweenInfo.new(0.2), {Size = originalContentSize}):Play()
        MinButton.Text = "−"
    end
end)

-- Sidebar com efeito
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 120, 1, -45)
Sidebar.Position = UDim2.new(0, 0, 0, 45)
Sidebar.BackgroundColor3 = Color3.fromRGB(22, 22, 27)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 0)
SidebarCorner.Parent = Sidebar

-- Efeito de Brilho na Sidebar
local SidebarGlow = Instance.new("Frame")
SidebarGlow.Size = UDim2.new(1, 0, 1, 0)
SidebarGlow.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
SidebarGlow.BackgroundTransparency = 0.95
SidebarGlow.BorderSizePixel = 0
SidebarGlow.Parent = Sidebar

local UIList = Instance.new("UIListLayout")
UIList.Parent = Sidebar
UIList.Padding = UDim.new(0, 10)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Conteúdo
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -130, 1, -55)
ContentArea.Position = UDim2.new(0, 125, 0, 52)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- Scrolling Frames para as Abas
local function createContentFrame()
    local cf = Instance.new("ScrollingFrame")
    cf.Size = UDim2.new(1, 0, 1, 0)
    cf.BackgroundTransparency = 1
    cf.CanvasSize = UDim2.new(0, 0, 1.5, 0)
    cf.ScrollBarThickness = 3
    cf.ScrollBarImageColor3 = Color3.fromRGB(0, 120, 255)
    cf.ScrollBarImageTransparency = 0.5
    cf.Visible = false
    cf.Parent = ContentArea
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.Parent = cf
    return cf
end

local TabCheats = createContentFrame()
local TabESP = createContentFrame()
TabCheats.Visible = true -- Começa na aba cheats

-- Botões de Aba Estilizados
local function createTabButton(name, tabFrame)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    btn.BackgroundTransparency = 0.5
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Parent = Sidebar
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.fromRGB(0, 120, 255)
    btnStroke.Thickness = 0
    btnStroke.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        -- Reset all tabs
        for _, child in pairs(ContentArea:GetChildren()) do
            if child:IsA("ScrollingFrame") then
                child.Visible = false
            end
        end
        -- Reset all tab buttons
        for _, child in pairs(Sidebar:GetChildren()) do
            if child:IsA("TextButton") and child ~= btn then
                child.BackgroundTransparency = 0.5
                child.TextColor3 = Color3.fromRGB(200, 200, 200)
                if child.UIStroke then child.UIStroke.Thickness = 0 end
            end
        end
        tabFrame.Visible = true
        btn.BackgroundTransparency = 0
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        if btn.UIStroke then btn.UIStroke.Thickness = 1 end
    end)
    
    return btn
end

createTabButton("⚡ CHEATS", TabCheats)
createTabButton("👁️ ESP", TabESP)

-- ========== FUNÇÃO DE CRIAR BOTÃO/TOGGLE ==========
local function createToggle(name, parent, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 42)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(220, 220, 220)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 13
    btn.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(50, 50, 60)
    stroke.Thickness = 1
    stroke.Parent = btn

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = name .. (active and ": ON" or ": OFF")
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(30, 30, 38)
        if active then
            btn.UIStroke.Color = Color3.fromRGB(0, 150, 255)
        else
            btn.UIStroke.Color = Color3.fromRGB(50, 50, 60)
        end
        callback(active)
    end)
end

-- ========== CONFIGURANDO CHEATS ==========
createToggle("🚀 Velocidade", TabCheats, function(v) Cheats.Speed = v end)
createToggle("🦘 Super Pulo", TabCheats, function(v) Cheats.JumpPower = v end)
createToggle("🌀 NoClip", TabCheats, function(v) Cheats.NoClip = v end)
createToggle("👁️ Wallhack", TabCheats, function(v) Cheats.Wallhack = v end)

createToggle("📡 Ativar ESP", TabESP, function(v) ESP_Settings.Enabled = v end)
createToggle("📏 Lines", TabESP, function(v) ESP_Settings.Lines = v end)

-- ========== LÓGICA DE MOVIMENTO ==========
RunService.Stepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        if Cheats.Speed then LocalPlayer.Character.Humanoid.WalkSpeed = Settings.SpeedValue end
        if Cheats.JumpPower then LocalPlayer.Character.Humanoid.JumpPower = Settings.JumpValue end
        
        if Cheats.NoClip then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end)

-- ========== FECHAR E ARRASTAR ==========
local dragging, dragInput, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

TopBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

print("✅ Interface Carregada!")

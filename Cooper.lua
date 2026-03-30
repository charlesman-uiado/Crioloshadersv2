--[[
    Script Hub Corrigido - Versão Estável
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
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

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 400)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Barra Superior (Arrastável)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ GRAPHICS & CHEAT HUB ⚡"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 110, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Parent = Sidebar
UIList.Padding = UDim.new(0, 5)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Conteúdo
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -120, 1, -50)
ContentArea.Position = UDim2.new(0, 115, 0, 45)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- Scrolling Frames para as Abas
local function createContentFrame()
    local cf = Instance.new("ScrollingFrame")
    cf.Size = UDim2.new(1, 0, 1, 0)
    cf.BackgroundTransparency = 1
    cf.CanvasSize = UDim2.new(0, 0, 1.5, 0) -- Permite rolar
    cf.ScrollBarThickness = 2
    cf.Visible = false
    cf.Parent = ContentArea
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.Parent = cf
    return cf
end

local TabCheats = createContentFrame()
local TabESP = createContentFrame()
TabCheats.Visible = true -- Começa na aba cheats

-- ========== FUNÇÃO DE CRIAR BOTÃO/TOGGLE ==========
local function createToggle(name, parent, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = name .. (active and ": ON" or ": OFF")
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(45, 45, 50)
        callback(active)
    end)
end

-- ========== CONFIGURANDO CHEATS ==========
createToggle("Velocidade", TabCheats, function(v) Cheats.Speed = v end)
createToggle("Super Pulo", TabCheats, function(v) Cheats.JumpPower = v end)
createToggle("NoClip", TabCheats, function(v) Cheats.NoClip = v end)
createToggle("Wallhack", TabCheats, function(v) Cheats.Wallhack = v end)

createToggle("Ativar ESP", TabESP, function(v) ESP_Settings.Enabled = v end)
createToggle("Lines", TabESP, function(v) ESP_Settings.Lines = v end)

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

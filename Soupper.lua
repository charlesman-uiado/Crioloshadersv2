--[[
    Script Hub Moderno para Roblox
    Interface com abas lateral e ESP funcional
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Variáveis principais
local Cheats = {
    Speed = false,
    JumpPower = false,
    InfiniteJump = false,
    Fly = false,
    NoClip = false,
    Wallhack = false
}

local ESP = {
    Enabled = false,
    Boxes = false,
    Lines = false,
    Names = false,
    Distance = false,
    Health = false
}

-- Configurações
local Settings = {
    SpeedValue = 50,
    JumpValue = 100
}

-- Objetos ESP
local espObjects = {}

-- ========== CRIAR INTERFACE MODERNA ==========
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ModernCheatHub"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

-- Frame principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 550)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -275)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Arredondamento
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Sombra
local UIShadow = Instance.new("ShadowEffect")
UIShadow.Parent = MainFrame

-- Barra superior
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ CHEAT HUB PRO ⚡"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextScaled = false
Title.Parent = TopBar

-- Botão fechar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 1, 0)
CloseBtn.Position = UDim2.new(1, -40, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
CloseBtn.BackgroundTransparency = 0.8
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 20
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

-- Barra lateral
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 120, 1, -45)
Sidebar.Position = UDim2.new(0, 0, 0, 45)
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 0)
SideCorner.Parent = Sidebar

-- Área de conteúdo
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -120, 1, -45)
ContentArea.Position = UDim2.new(0, 120, 0, 45)
ContentArea.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ContentArea.BackgroundTransparency = 0.1
ContentArea.BorderSizePixel = 0
ContentArea.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 0)
ContentCorner.Parent = ContentArea

-- ========== ABAS ==========
local tabs = {
    Cheats = { name = "⚡ Cheats", button = nil, content = nil },
    ESP = { name = "👁️ ESP", button = nil, content = nil }
}

-- Criar botões da sidebar
local yOffset = 20
for tabName, tabData in pairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 45)
    btn.Position = UDim2.new(0, 10, 0, yOffset)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    btn.BackgroundTransparency = 0.3
    btn.Text = tabData.name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = Sidebar
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    tabData.button = btn
    yOffset = yOffset + 55
end

-- ========== CONTEÚDO DOS CHEATS ==========
local cheatsContent = Instance.new("ScrollingFrame")
cheatsContent.Size = UDim2.new(1, -20, 1, -20)
cheatsContent.Position = UDim2.new(0, 10, 0, 10)
cheatsContent.BackgroundTransparency = 1
cheatsContent.ScrollBarThickness = 5
cheatsContent.Parent = ContentArea

local cheatsLayout = Instance.new("UIListLayout")
cheatsLayout.Padding = UDim.new(0, 12)
cheatsLayout.SortOrder = Enum.SortOrder.LayoutOrder
cheatsLayout.Parent = cheatsContent

-- Criar toggles dos cheats
local cheatsList = {
    { name = "🏃 Velocidade", key = "Speed", value = false, slider = true },
    { name = "🦘 Super Pulo", key = "JumpPower", value = false, slider = true },
    { name = "🕊️ Pulo Infinito", key = "InfiniteJump", value = false },
    { name = "✈️ Voar", key = "Fly", value = false },
    { name = "🧱 NoClip", key = "NoClip", value = false },
    { name = "👁️ Wallhack", key = "Wallhack", value = false }
}

local sliders = {}

for _, cheat in ipairs(cheatsList) do
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 50)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 0
    frame.Parent = cheatsContent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 8)
    frameCorner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 150, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = cheat.name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 50, 0, 30)
    toggle.Position = UDim2.new(1, -65, 0.5, -15)
    toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    toggle.Text = "OFF"
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 12
    toggle.Parent = frame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggle
    
    if cheat.slider then
        local sliderFrame = Instance.new("Frame")
        sliderFrame.Size = UDim2.new(0, 120, 0, 4)
        sliderFrame.Position = UDim2.new(0, 15, 1, -15)
        sliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        sliderFrame.BorderSizePixel = 0
        sliderFrame.Parent = frame
        
        local sliderCorner = Instance.new("UICorner")
        sliderCorner.CornerRadius = UDim.new(0, 2)
        sliderCorner.Parent = sliderFrame
        
        local fill = Instance.new("Frame")
        fill.Size = UDim2.new(0.5, 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        fill.BorderSizePixel = 0
        fill.Parent = sliderFrame
        
        local fillCorner = Instance.new("UICorner")
        fillCorner.CornerRadius = UDim.new(0, 2)
        fillCorner.Parent = fill
        
        local valueLabel = Instance.new("TextLabel")
        valueLabel.Size = UDim2.new(0, 40, 1, 0)
        valueLabel.Position = UDim2.new(1, -55, 0, 0)
        valueLabel.BackgroundTransparency = 1
        valueLabel.Text = cheat.key == "Speed" and "50" or "100"
        valueLabel.TextColor3 = Color3.fromRGB(0, 150, 255)
        valueLabel.Font = Enum.Font.Gotham
        valueLabel.TextSize = 12
        valueLabel.Parent = frame
        
        sliders[cheat.key] = { fill = fill, label = valueLabel, frame = sliderFrame }
    end
    
    toggle.MouseButton1Click:Connect(function()
        Cheats[cheat.key] = not Cheats[cheat.key]
        toggle.Text = Cheats[cheat.key] and "ON" or "OFF"
        toggle.BackgroundColor3 = Cheats[cheat.key] and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(60, 60, 65)
    end)
end

-- ========== CONTEÚDO DO ESP ==========
local espContent = Instance.new("ScrollingFrame")
espContent.Size = UDim2.new(1, -20, 1, -20)
espContent.Position = UDim2.new(0, 10, 0, 10)
espContent.BackgroundTransparency = 1
espContent.ScrollBarThickness = 5
espContent.Visible = false
espContent.Parent = ContentArea

local espLayout = Instance.new("UIListLayout")
espLayout.Padding = UDim.new(0, 12)
espLayout.SortOrder = Enum.SortOrder.LayoutOrder
espLayout.Parent = espContent

-- Opções do ESP
local espOptions = {
    { name = "🎯 Ativar ESP", key = "Enabled", color = true },
    { name = "📦 Box ESP", key = "Boxes" },
    { name = "📏 Lines ESP", key = "Lines" },
    { name = "🏷️ Names ESP", key = "Names" },
    { name = "📐 Distance ESP", key = "Distance" },
    { name = "❤️ Health ESP", key = "Health" }
}

local colorPicker = nil

for _, opt in ipairs(espOptions) do
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 45)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 0
    frame.Parent = espContent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 8)
    frameCorner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -80, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = opt.name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 50, 0, 30)
    toggle.Position = UDim2.new(1, -65, 0.5, -15)
    toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    toggle.Text = "OFF"
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 12
    toggle.Parent = frame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggle
    
    toggle.MouseButton1Click:Connect(function()
        ESP[opt.key] = not ESP[opt.key]
        toggle.Text = ESP[opt.key] and "ON" or "OFF"
        toggle.BackgroundColor3 = ESP[opt.key] and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(60, 60, 65)
        
        if opt.key == "Enabled" then
            if ESP.Enabled then
                startESP()
            else
                clearESP()
            end
        end
    end)
    
    if opt.color then
        local colorBtn = Instance.new("TextButton")
        colorBtn.Size = UDim2.new(0, 40, 0, 30)
        colorBtn.Position = UDim2.new(1, -120, 0.5, -15)
        colorBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        colorBtn.Text = "🎨"
        colorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        colorBtn.Font = Enum.Font.GothamBold
        colorBtn.TextSize = 16
        colorBtn.Parent = frame
        
        local colorCorner = Instance.new("UICorner")
        colorCorner.CornerRadius = UDim.new(0, 6)
        colorCorner.Parent = colorBtn
        
        colorPicker = colorBtn
    end
end

-- ========== FUNÇÕES DOS CHEATS ==========
-- Speed
RunService.RenderStepped:Connect(function()
    if Cheats.Speed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local humanoid = LocalPlayer.Character.Humanoid
        humanoid.WalkSpeed = Settings.SpeedValue
    elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

-- Jump Power
RunService.RenderStepped:Connect(function()
    if Cheats.JumpPower and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = Settings.JumpValue
    elseif LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end)

-- Infinite Jump
local debounce = false
Mouse.Button1Down:Connect(function()
    if Cheats.InfiniteJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local humanoid = LocalPlayer.Character.Humanoid
        if humanoid:GetState() == Enum.HumanoidStateType.Landed or humanoid:GetState() == Enum.HumanoidStateType.Running then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Fly e NoClip
local flying = false
local noclip = false
local bodyVelocity = nil

RunService.RenderStepped:Connect(function()
    if Cheats.Fly and not flying then
        flying = true
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            local humanoid = char.Humanoid
            humanoid.PlatformStand = true
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
            bodyVelocity.Parent = char:FindFirstChild("HumanoidRootPart")
            
            local bg = Instance.new("BodyGyro")
            bg.MaxTorque = Vector3.new(10000, 10000, 10000)
            bg.Parent = char:FindFirstChild("HumanoidRootPart")
            
            Mouse.Move:Connect(function()
                if Cheats.Fly then
                    local direction = Mouse.Hit.LookVector
                    bodyVelocity.Velocity = direction * 100
                    bg.CFrame = CFrame.new(char.HumanoidRootPart.Position, Mouse.Hit.Position)
                end
            end)
        end
    elseif not Cheats.Fly and flying then
        flying = false
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.PlatformStand = false
            if bodyVelocity then bodyVelocity:Destroy() end
            local bg = char:FindFirstChild("BodyGyro")
            if bg then bg:Destroy() end
        end
    end
    
    if Cheats.NoClip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    elseif not Cheats.NoClip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end)

-- Wallhack
RunService.RenderStepped:Connect(function()
    if Cheats.Wallhack then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.LocalTransparencyModifier = 0.3
                    end
                end
            end
        end
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.LocalTransparencyModifier = 0
                    end
                end
            end
        end
    end
end)

-- Sliders
for key, sliderData in pairs(sliders) do
    local dragging = false
    sliderData.frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    sliderData.frame.InputEnded:Connect(function()
        dragging = false
    end)
    
    sliderData.frame.MouseMove:Connect(function()
        if dragging then
            local mousePos = Mouse.X - sliderData.frame.AbsolutePosition.X
            local percent = math.clamp(mousePos / sliderData.frame.AbsoluteSize.X, 0, 1)
            sliderData.fill.Size = UDim2.new(percent, 0, 1, 0)
            
            if key == "Speed" then
                Settings.SpeedValue = math.floor(16 + (percent * 84))
                sliderData.label.Text = tostring(Settings.SpeedValue)
            elseif key == "JumpPower" then
                Settings.JumpValue = math.floor(50 + (percent * 150))
                sliderData.label.Text = tostring(Settings.JumpValue)
            end
        end
    end)
end

-- ========== FUNÇÕES ESP ==========
local espLines = {}
local espBoxes = {}

function createESPForPlayer(player)
    if player == LocalPlayer then return end
    
    local function updateESP()
        if not ESP.Enabled or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
        
        local hrp = player.Character.HumanoidRootPart
        local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position)
        
        if onScreen then
            if ESP.Boxes then
                -- Criar box
                if not espBoxes[player] then
                    local box = Drawing.new("Square")
                    box.Thickness = 2
                    box.Color = Color3.fromRGB(0, 150, 255)
                    box.Filled = false
                    espBoxes[player] = box
                end
                
                local size = 100 / screenPos.Z * 2
                espBoxes[player].Size = Vector2.new(size, size)
                espBoxes[player].Position = Vector2.new(screenPos.X - size/2, screenPos.Y - size/2)
                espBoxes[player].Visible = true
            end
            
            if ESP.Lines then
                if not espLines[player] then
                    local line = Drawing.new("Line")
                    line.Thickness = 2
                    line.Color = Color3.fromRGB(0, 150, 255)
                    espLines[player] = line
                end
                
                espLines[player].From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
                espLines[player].To = Vector2.new(screenPos.X, screenPos.Y)
                espLines[player].Visible = true
            end
        else
            if espBoxes[player] then espBoxes[player].Visible = false end
            if espLines[player] then espLines[player].Visible = false end
        end
    end
    
    -- Atualizar ESP a cada frame
    RunService.RenderStepped:Connect(updateESP)
end

function startESP()
    for _, player in pairs(Players:GetPlayers()) do
        createESPForPlayer(player)
    end
    
    Players.PlayerAdded:Connect(createESPForPlayer)
end

function clearESP()
    for _, box in pairs(espBoxes) do
        box:Remove()
    end
    for _, line in pairs(espLines) do
        line:Remove()
    end
    espBoxes = {}
    espLines = {}
end

-- ========== TROCAR ABAS ==========
local currentTab = "Cheats"
for tabName, tabData in pairs(tabs) do
    tabData.button.MouseButton1Click:Connect(function()
        currentTab = tabName
        cheatsContent.Visible = (tabName == "Cheats")
        espContent.Visible = (tabName == "ESP")
        
        -- Atualizar estilo do botão
        for _, btn in pairs(tabs) do
            btn.button.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
            btn.button.BackgroundTransparency = 0.3
            btn.button.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        tabData.button.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        tabData.button.BackgroundTransparency = 0.1
        tabData.button.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
end

-- Ativar primeira aba
tabs.Cheats.button.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
tabs.Cheats.button.BackgroundTransparency = 0.1
tabs.Cheats.button.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Fechar GUI
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Mover janela
local dragging = false
local dragStart = nil
local startPos = nil

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

TopBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Camera para ESP
local camera = workspace.CurrentCamera

print("✅ Script carregado com sucesso! Pressione Shift para abrir/fechar (opcional)")

--[[ 
    CRIOLOSHADERS V5 - ULTIMATE CHEATS & SHADERS
    Tabs: Visual | Otimização | Cheats Profissionais
]]

local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- 1. Proteção contra execução duplicada
if CoreGui:FindFirstChild("CrioloShaders") then CoreGui.CrioloShaders:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "CrioloShaders"

-- Janela Principal (Ajustada para mais funções)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.Position = UDim2.new(0.1, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- Barra Lateral
local SideBar = Instance.new("Frame", MainFrame)
SideBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SideBar.Size = UDim2.new(0, 110, 1, 0)
Instance.new("UICorner", SideBar).CornerRadius = UDim.new(0, 10)

-- Containers
local ContainerShaders = Instance.new("ScrollingFrame", MainFrame)
ContainerShaders.Position = UDim2.new(0, 120, 0, 40)
ContainerShaders.Size = UDim2.new(0, 270, 0, 200)
ContainerShaders.BackgroundTransparency = 1
ContainerShaders.ScrollBarThickness = 2
ContainerShaders.Visible = true

local ContainerCheats = Instance.new("ScrollingFrame", MainFrame)
ContainerCheats.Position = UDim2.new(0, 120, 0, 40)
ContainerCheats.Size = UDim2.new(0, 270, 0, 200)
ContainerCheats.BackgroundTransparency = 1
ContainerCheats.ScrollBarThickness = 2
ContainerCheats.Visible = false

-- --- FUNÇÃO DE NAVEGAÇÃO ---
local function showTab(name)
    ContainerShaders.Visible = (name == "Shaders")
    ContainerCheats.Visible = (name == "Cheats")
end

-- --- BOTÕES LATERAIS ---
local function createTabBtn(txt, pos, tab)
    local btn = Instance.new("TextButton", SideBar)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, pos)
    btn.Text = txt
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.MouseButton1Click:Connect(function() showTab(tab) end)
    return btn
end

createTabBtn("Visual", 0, "Shaders")
createTabBtn("Cheats Pro", 45, "Cheats")

-- Botão X
local CloseX = Instance.new("TextButton", MainFrame)
CloseX.Position = UDim2.new(0.92, 0, 0, 5)
CloseX.Size = UDim2.new(0, 25, 0, 25)
CloseX.Text = "X"
CloseX.TextColor3 = Color3.fromRGB(255, 50, 50)
CloseX.BackgroundTransparency = 1
CloseX.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- --- ABA CHEATS: FUNÇÕES ESPECÍFICAS ---

-- 1. WALLHACK (Noclip)
local noclip = false
local btnWall = Instance.new("TextButton", ContainerCheats)
btnWall.Size = UDim2.new(0.9, 0, 0, 35)
btnWall.Text = "Wallhack (Atravessar)"
btnWall.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
btnWall.MouseButton1Click:Connect(function()
    noclip = not noclip
    btnWall.BackgroundColor3 = noclip and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60, 60, 60)
end)
RunService.Stepped:Connect(function()
    if noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- 2. INVISIBILIDADE (Client-Side)
local btnInvis = Instance.new("TextButton", ContainerCheats)
btnInvis.Position = UDim2.new(0, 0, 0, 40)
btnInvis.Size = UDim2.new(0.9, 0, 0, 35)
btnInvis.Text = "Invisibilidade (Local)"
btnInvis.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
btnInvis.MouseButton1Click:Connect(function()
    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") then part.Transparency = 1 end
    end
end)

-- 3. AIMBOT (Silent Aim simples)
local btnAim = Instance.new("TextButton", ContainerCheats)
btnAim.Position = UDim2.new(0, 0, 0, 80)
btnAim.Size = UDim2.new(0.9, 0, 0, 35)
btnAim.Text = "Aimbot (Acerto Automático)"
btnAim.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
btnAim.MouseButton1Click:Connect(function()
    RunService.RenderStepped:Connect(function()
        local closestPlayer = nil
        local shortestDistance = math.huge
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local pos = player.Character.HumanoidRootPart.Position
                local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(pos)
                if onScreen then
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - UserInputService:GetMouseLocation()).Magnitude
                    if distance < shortestDistance then
                        closestPlayer = player
                        shortestDistance = distance
                    end
                end
            end
        end
        if closestPlayer then
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closestPlayer.Character.Head.Position)
        end
    end)
end)

-- 4. NO COOLDOWN (Remover atraso de tiro)
local btnNoCD = Instance.new("TextButton", ContainerCheats)
btnNoCD.Position = UDim2.new(0, 0, 0, 120)
btnNoCD.Size = UDim2.new(0.9, 0, 0, 35)
btnNoCD.Text = "No Cooldown (Pistol Arena)"
btnNoCD.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
btnNoCD.MouseButton1Click:Connect(function()
    -- Procura scripts de armas e tenta forçar o cooldown a zero
    for _, v in pairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "Cooldown") then
            v.Cooldown = 0
        elseif type(v) == "table" and rawget(v, "FireRate") then
            v.FireRate = 0.01
        end
    end
end)

print("CrioloShaders V5 Carregado! Use com sabedoria.")

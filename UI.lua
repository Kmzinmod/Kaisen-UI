--[[
    ╔═══════════════════════════════════╗
    ║     KAISEN SCRIPTS - V6.0         ║
    ║   Don't Get Crushed By 67         ║
    ║         By: KAISEN                ║
    ╚═══════════════════════════════════╝
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Configurações
local Config = {
    ToggleKey = Enum.KeyCode.G
}

-- Remove UI antiga
if player.PlayerGui:FindFirstChild("KaisenScripts") then 
    player.PlayerGui:FindFirstChild("KaisenScripts"):Destroy()
end

-- Notificação
game.StarterGui:SetCore("SendNotification", {
    Title = "Kaisen Scripts",
    Text = "Pressione '" .. Config.ToggleKey.Name .. "' para abrir/fechar",
    Duration = 5
})

-- Criar GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KaisenScripts"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 380)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(60, 60, 70)
MainStroke.Thickness = 1
MainStroke.Parent = MainFrame

-- Barra de Título
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(22, 22, 27)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleBarBottom = Instance.new("Frame")
TitleBarBottom.Size = UDim2.new(1, 0, 0, 12)
TitleBarBottom.Position = UDim2.new(0, 0, 1, -12)
TitleBarBottom.BackgroundColor3 = Color3.fromRGB(22, 22, 27)
TitleBarBottom.BorderSizePixel = 0
TitleBarBottom.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ Kaisen Scripts"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(100, 180, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -100, 0, 15)
Subtitle.Position = UDim2.new(0, 15, 1, -18)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = ""
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextColor3 = Color3.fromRGB(120, 120, 130)
Subtitle.TextSize = 10
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = TitleBar

-- Botão Fechar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -45, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "✕"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.TextSize = 18
CloseBtn.Parent = TitleBar

Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Content Area (Sem Sidebar - Diretamente o conteúdo)
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -20, 1, -55)
ContentArea.Position = UDim2.new(0, 10, 0, 50)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- Função para criar seções
local function createSection(name)
    local Section = Instance.new("ScrollingFrame")
    Section.Name = name .. "Section"
    Section.Size = UDim2.new(1, 0, 1, 0)
    Section.BackgroundTransparency = 1
    Section.BorderSizePixel = 0
    Section.ScrollBarThickness = 4
    Section.ScrollBarImageColor3 = Color3.fromRGB(100, 180, 255)
    Section.Visible = true
    Section.CanvasSize = UDim2.new(0, 0, 0, 0)
    Section.Parent = ContentArea
    
    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 8)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = Section
    
    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Section.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
    end)
    
    return Section
end

-- Função para criar input de tecla
local function createKeybind(name, currentKey, section, callback)
    local Keybind = Instance.new("Frame")
    Keybind.Name = name
    Keybind.Size = UDim2.new(1, -10, 0, 45)
    Keybind.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    Keybind.BorderSizePixel = 0
    Keybind.Parent = section
    
    Instance.new("UICorner", Keybind).CornerRadius = UDim.new(0, 8)
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -120, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.Font = Enum.Font.GothamBold
    Label.TextColor3 = Color3.fromRGB(200, 200, 210)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Keybind
    
    local KeyBtn = Instance.new("TextButton")
    KeyBtn.Size = UDim2.new(0, 100, 0, 30)
    KeyBtn.Position = UDim2.new(1, -110, 0.5, -15)
    KeyBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    KeyBtn.BorderSizePixel = 0
    KeyBtn.Text = currentKey.Name
    KeyBtn.Font = Enum.Font.GothamBold
    KeyBtn.TextColor3 = Color3.fromRGB(100, 180, 255)
    KeyBtn.TextSize = 12
    KeyBtn.Parent = Keybind
    
    Instance.new("UICorner", KeyBtn).CornerRadius = UDim.new(0, 6)
    
    local listening = false
    
    KeyBtn.MouseButton1Click:Connect(function()
        listening = true
        KeyBtn.Text = "..."
        KeyBtn.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
    end)
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if listening and input.UserInputType == Enum.UserInputType.Keyboard then
            listening = false
            local newKey = input.KeyCode
            KeyBtn.Text = newKey.Name
            KeyBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
            
            if callback then
                callback(newKey)
            end
        end
    end)
    
    return Keybind
end

-- Criar Seção Config
local ConfigSection = createSection("Config")

-- Título da seção
local SectionTitle = Instance.new("TextLabel")
SectionTitle.Size = UDim2.new(1, -10, 0, 30)
SectionTitle.BackgroundTransparency = 1
SectionTitle.Text = "⚙️ Configurações"
SectionTitle.Font = Enum.Font.GothamBold
SectionTitle.TextColor3 = Color3.fromRGB(100, 180, 255)
SectionTitle.TextSize = 18
SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
SectionTitle.Parent = ConfigSection

-- Keybind para UI
createKeybind("Toggle UI Key", Config.ToggleKey, ConfigSection, function(newKey)
    Config.ToggleKey = newKey
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "Keybind Atualizada",
        Text = "Nova tecla: " .. newKey.Name,
        Duration = 3
    })
end)

-- Botão Salvar
local SaveBtn = Instance.new("TextButton")
SaveBtn.Size = UDim2.new(1, -10, 0, 45)
SaveBtn.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
SaveBtn.BorderSizePixel = 0
SaveBtn.Text = "💾 Salvar Configuração"
SaveBtn.Font = Enum.Font.GothamBold
SaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveBtn.TextSize = 14
SaveBtn.Parent = ConfigSection

Instance.new("UICorner", SaveBtn).CornerRadius = UDim.new(0, 8)

SaveBtn.MouseButton1Click:Connect(function()
    writefile("KaisenScripts_Config.json", game:GetService("HttpService"):JSONEncode(Config))
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "Configuração Salva",
        Text = "Suas configurações foram salvas!",
        Duration = 3
    })
end)

-- Botão Carregar
local LoadBtn = Instance.new("TextButton")
LoadBtn.Size = UDim2.new(1, -10, 0, 45)
LoadBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 100)
LoadBtn.BorderSizePixel = 0
LoadBtn.Text = "📂 Carregar Configuração"
LoadBtn.Font = Enum.Font.GothamBold
LoadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadBtn.TextSize = 14
LoadBtn.Parent = ConfigSection

Instance.new("UICorner", LoadBtn).CornerRadius = UDim.new(0, 8)

LoadBtn.MouseButton1Click:Connect(function()
    if isfile("KaisenScripts_Config.json") then
        local loaded = game:GetService("HttpService"):JSONDecode(readfile("KaisenScripts_Config.json"))
        for k, v in pairs(loaded) do
            Config[k] = v
        end
        
        game.StarterGui:SetCore("SendNotification", {
            Title = "Configuração Carregada",
            Text = "Suas configurações foram carregadas!",
            Duration = 3
        })
    else
        game.StarterGui:SetCore("SendNotification", {
            Title = "Erro",
            Text = "Nenhuma configuração salva encontrada!",
            Duration = 3
        })
    end
end)

-- Toggle UI com tecla
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Config.ToggleKey then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

print("╔═══════════════════════════════════╗")
print("║     KAISEN SCRIPTS CARREGADO      ║")
print("║   Pressione '" .. Config.ToggleKey.Name .. "' para abrir     ║")
print("╚═══════════════════════════════════╝")

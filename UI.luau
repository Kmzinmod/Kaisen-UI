--[[
    ╔═══════════════════════════════════╗
    ║     KAISEN UI FRAMEWORK - V2.0    ║
    ║    UI Totalmente Configurável     ║
    ║         By: KAISEN                ║
    ╚═══════════════════════════════════╝
]]

--[[
    COMO USAR:
    
    -- Carregar a UI com configurações personalizadas
    local KaisenUI = loadstring(game:HttpGet("URL_DO_SEU_SCRIPT_AQUI"))({
        Title = "Meu Script",           -- Título da UI
        Subtitle = "v2.0",              -- Subtítulo
        ToggleKey = Enum.KeyCode.G,     -- Tecla para abrir/fechar
        MainColor = Color3.fromRGB(100, 180, 255), -- Cor principal
        BackgroundColor = Color3.fromRGB(18, 18, 22), -- Cor de fundo
        SidebarColor = Color3.fromRGB(22, 22, 27), -- Cor da sidebar
        Width = 550,                    -- Largura da UI
        Height = 400                    -- Altura da UI
    })
    
    -- Adicionar uma seção
    KaisenUI:AddSection("Minha Seção", "📁", function(section)
        -- Adicionar elementos
        KaisenUI:AddToggle("Opção 1", section, function(enabled)
            print("Toggle: " .. tostring(enabled))
        end)
        
        KaisenUI:AddButton("Botão", section, function()
            print("Botão clicado!")
        end)
        
        KaisenUI:AddSlider("Velocidade", 0, 100, 50, section, function(value)
            print("Valor: " .. value)
        end)
    end)
    
    -- Mostrar/Esconder UI
    KaisenUI:Toggle()
]]

local KaisenUI = {}
KaisenUI.Sections = {}
KaisenUI.SectionButtons = {}
KaisenUI.CurrentSection = nil

-- Configurações padrão
local DefaultConfig = {
    Title = "⚡ Kaisen UI",
    Subtitle = "Framework v2.0",
    ToggleKey = Enum.KeyCode.G,
    MainColor = Color3.fromRGB(100, 180, 255),
    BackgroundColor = Color3.fromRGB(18, 18, 22),
    SidebarColor = Color3.fromRGB(22, 22, 27),
    ButtonColor = Color3.fromRGB(30, 30, 37),
    TextColor = Color3.fromRGB(200, 200, 210),
    Width = 550,
    Height = 400
}

-- Variáveis internas
local ScreenGui, MainFrame, ContentArea, Sidebar
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Função para criar a UI
function KaisenUI:Create(userConfig)
    -- Merge configurações
    local Config = {}
    for k, v in pairs(DefaultConfig) do
        Config[k] = userConfig and userConfig[k] or v
    end
    
    -- Remove UI antiga
    if player.PlayerGui:FindFirstChild("KaisenUI") then 
        player.PlayerGui:FindFirstChild("KaisenUI"):Destroy()
    end
    
    -- Criar GUI
    ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KaisenUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- Frame Principal
    MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, Config.Width, 0, Config.Height)
    MainFrame.Position = UDim2.new(0.5, -(Config.Width/2), 0.5, -(Config.Height/2))
    MainFrame.BackgroundColor3 = Config.BackgroundColor
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui
    MainFrame.Visible = false
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = MainFrame
    
    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Config.MainColor
    MainStroke.Thickness = 1
    MainStroke.Parent = MainFrame
    
    -- Barra de Título
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 45)
    TitleBar.BackgroundColor3 = Config.SidebarColor
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 12)
    TitleCorner.Parent = TitleBar
    
    local TitleBarBottom = Instance.new("Frame")
    TitleBarBottom.Size = UDim2.new(1, 0, 0, 12)
    TitleBarBottom.Position = UDim2.new(0, 0, 1, -12)
    TitleBarBottom.BackgroundColor3 = Config.SidebarColor
    TitleBarBottom.BorderSizePixel = 0
    TitleBarBottom.Parent = TitleBar
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = Config.Title
    Title.Font = Enum.Font.GothamBold
    Title.TextColor3 = Config.MainColor
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TitleBar
    
    local Subtitle = Instance.new("TextLabel")
    Subtitle.Size = UDim2.new(1, -100, 0, 15)
    Subtitle.Position = UDim2.new(0, 15, 1, -18)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = Config.Subtitle
    Subtitle.Font = Enum.Font.Gotham
    Subtitle.TextColor3 = Color3.fromRGB(120, 120, 130)
    Subtitle.TextSize = 10
    Subtitle.TextXAlignment = Enum.TextXAlignment.Left
    Subtitle.Parent = TitleBar
    
    -- Botão Fechar
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 35, 0, 35)
    CloseBtn.Position = UDim2.new(1, -45, 0, 5)
    CloseBtn.BackgroundColor3 = Config.ButtonColor
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
    
    -- Sidebar
    Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 160, 1, -55)
    Sidebar.Position = UDim2.new(0, 10, 0, 50)
    Sidebar.BackgroundColor3 = Config.SidebarColor
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = MainFrame
    
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)
    
    -- Content Area
    ContentArea = Instance.new("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.Size = UDim2.new(1, -185, 1, -55)
    ContentArea.Position = UDim2.new(0, 175, 0, 50)
    ContentArea.BackgroundTransparency = 1
    ContentArea.Parent = MainFrame
    
    -- Salvar configurações
    self.Config = Config
    
    -- Toggle UI com tecla
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Config.ToggleKey then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)
    
    -- Notificação inicial
    game.StarterGui:SetCore("SendNotification", {
        Title = Config.Title,
        Text = "Pressione '" .. Config.ToggleKey.Name .. "' para abrir",
        Duration = 3
    })
    
    return self
end

-- Função para criar botão da sidebar
function KaisenUI:CreateSidebarButton(name, icon, position)
    local Button = Instance.new("TextButton")
    Button.Name = name .. "Btn"
    Button.Size = UDim2.new(1, -10, 0, 40)
    Button.Position = position or UDim2.new(0, 5, 0, 5 + (#self.SectionButtons * 45))
    Button.BackgroundColor3 = self.Config.ButtonColor
    Button.BorderSizePixel = 0
    Button.AutoButtonColor = false
    Button.Text = ""
    Button.Parent = Sidebar
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button
    
    local IconLabel = Instance.new("TextLabel")
    IconLabel.Size = UDim2.new(0, 25, 0, 25)
    IconLabel.Position = UDim2.new(0, 10, 0.5, -12.5)
    IconLabel.BackgroundTransparency = 1
    IconLabel.Text = icon
    IconLabel.Font = Enum.Font.GothamBold
    IconLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
    IconLabel.TextSize = 16
    IconLabel.Parent = Button
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -45, 1, 0)
    Label.Position = UDim2.new(0, 40, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.Font = Enum.Font.GothamBold
    Label.TextColor3 = Color3.fromRGB(150, 150, 160)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Button
    
    table.insert(self.SectionButtons, {
        Button = Button,
        Icon = IconLabel,
        Label = Label
    })
    
    return Button, IconLabel, Label
end

-- Função para criar seção
function KaisenUI:AddSection(name, icon, callback)
    if not MainFrame then
        self:Create({})
    end
    
    -- Criar a seção (content)
    local Section = Instance.new("ScrollingFrame")
    Section.Name = name .. "Section"
    Section.Size = UDim2.new(1, 0, 1, 0)
    Section.BackgroundTransparency = 1
    Section.BorderSizePixel = 0
    Section.ScrollBarThickness = 4
    Section.ScrollBarImageColor3 = self.Config.MainColor
    Section.Visible = false
    Section.CanvasSize = UDim2.new(0, 0, 0, 0)
    Section.Parent = ContentArea
    
    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 8)
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Parent = Section
    
    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Section.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
    end)
    
    -- Criar botão na sidebar
    local position = UDim2.new(0, 5, 0, 5 + (#self.SectionButtons * 45))
    local Button, Icon, Label = self:CreateSidebarButton(name, icon, position)
    
    -- Função para selecionar esta seção
    local function SelectSection()
        -- Esconder todas as seções
        for _, section in pairs(self.Sections) do
            section.Section.Visible = false
            section.Button.BackgroundColor3 = self.Config.ButtonColor
            section.Icon.TextColor3 = Color3.fromRGB(150, 150, 160)
            section.Label.TextColor3 = Color3.fromRGB(150, 150, 160)
        end
        
        -- Mostrar esta seção
        Section.Visible = true
        Button.BackgroundColor3 = self.Config.MainColor
        Icon.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        self.CurrentSection = name
    end
    
    Button.MouseButton1Click:Connect(SelectSection)
    
    -- Salvar referência
    table.insert(self.Sections, {
        Name = name,
        Section = Section,
        Button = Button,
        Icon = Icon,
        Label = Label,
        Select = SelectSection
    })
    
    -- Se for a primeira seção, selecionar automaticamente
    if #self.Sections == 1 then
        SelectSection()
    end
    
    -- Chamar callback com a seção
    if callback then
        callback(Section)
    end
    
    return Section
end

-- Função para adicionar toggle
function KaisenUI:AddToggle(name, section, callback)
    local Toggle = Instance.new("Frame")
    Toggle.Name = name
    Toggle.Size = UDim2.new(1, -10, 0, 45)
    Toggle.BackgroundColor3 = self.Config.ButtonColor
    Toggle.BorderSizePixel = 0
    Toggle.Parent = section
    
    Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 8)
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.Font = Enum.Font.GothamBold
    Label.TextColor3 = self.Config.TextColor
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Toggle
    
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 45, 0, 25)
    ToggleBtn.Position = UDim2.new(1, -55, 0.5, -12.5)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
    ToggleBtn.BorderSizePixel = 0
    ToggleBtn.Text = ""
    ToggleBtn.Parent = Toggle
    
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
    
    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 19, 0, 19)
    Circle.Position = UDim2.new(0, 3, 0.5, -9.5)
    Circle.BackgroundColor3 = Color3.fromRGB(180, 180, 190)
    Circle.BorderSizePixel = 0
    Circle.Parent = ToggleBtn
    
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)
    
    local isEnabled = false
    
    ToggleBtn.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        
        if isEnabled then
            ToggleBtn.BackgroundColor3 = self.Config.MainColor
            Circle:TweenPosition(UDim2.new(1, -22, 0.5, -9.5), "Out", "Quad", 0.2, true)
            Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        else
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
            Circle:TweenPosition(UDim2.new(0, 3, 0.5, -9.5), "Out", "Quad", 0.2, true)
            Circle.BackgroundColor3 = Color3.fromRGB(180, 180, 190)
        end
        
        if callback then
            callback(isEnabled)
        end
    end)
    
    return Toggle, ToggleBtn
end

-- Função para adicionar botão
function KaisenUI:AddButton(name, section, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -10, 0, 45)
    Button.BackgroundColor3 = self.Config.MainColor
    Button.BorderSizePixel = 0
    Button.Text = name
    Button.Font = Enum.Font.GothamBold
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14
    Button.Parent = section
    
    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)
    
    Button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    return Button
end

-- Função para adicionar slider
function KaisenUI:AddSlider(name, min, max, default, section, callback)
    local Slider = Instance.new("Frame")
    Slider.Name = name
    Slider.Size = UDim2.new(1, -10, 0, 60)
    Slider.BackgroundColor3 = self.Config.ButtonColor
    Slider.BorderSizePixel = 0
    Slider.Parent = section
    
    Instance.new("UICorner", Slider).CornerRadius = UDim.new(0, 8)
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 20)
    Label.Position = UDim2.new(0, 10, 0, 8)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.Font = Enum.Font.GothamBold
    Label.TextColor3 = self.Config.TextColor
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Slider
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0, 50, 0, 20)
    ValueLabel.Position = UDim2.new(1, -60, 0, 8)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.TextColor3 = self.Config.MainColor
    ValueLabel.TextSize = 13
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.Parent = Slider
    
    local SliderBar = Instance.new("Frame")
    SliderBar.Size = UDim2.new(1, -20, 0, 6)
    SliderBar.Position = UDim2.new(0, 10, 1, -18)
    SliderBar.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
    SliderBar.BorderSizePixel = 0
    SliderBar.Parent = Slider
    
    Instance.new("UICorner", SliderBar).CornerRadius = UDim.new(1, 0)
    
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = self.Config.MainColor
    Fill.BorderSizePixel = 0
    Fill.Parent = SliderBar
    
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)
    
    local Dragger = Instance.new("Frame")
    Dragger.Size = UDim2.new(0, 16, 0, 16)
    Dragger.Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8)
    Dragger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Dragger.BorderSizePixel = 0
    Dragger.Parent = SliderBar
    
    Instance.new("UICorner", Dragger).CornerRadius = UDim.new(1, 0)
    
    local dragging = false
    local currentValue = default
    
    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
        currentValue = math.floor(min + (max - min) * pos)
        
        Fill.Size = UDim2.new(pos, 0, 1, 0)
        Dragger.Position = UDim2.new(pos, -8, 0.5, -8)
        ValueLabel.Text = tostring(currentValue)
        
        if callback then
            callback(currentValue)
        end
    end
    
    SliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateSlider(input)
        end
    end)
    
    SliderBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)
    
    return Slider
end

-- Função para adicionar input de texto
function KaisenUI:AddTextInput(name, placeholder, section, callback)
    local Input = Instance.new("Frame")
    Input.Name = name
    Input.Size = UDim2.new(1, -10, 0, 45)
    Input.BackgroundColor3 = self.Config.ButtonColor
    Input.BorderSizePixel = 0
    Input.Parent = section
    
    Instance.new("UICorner", Input).CornerRadius = UDim.new(0, 8)
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0, 80, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.Font = Enum.Font.GothamBold
    Label.TextColor3 = self.Config.TextColor
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Input
    
    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(1, -100, 0, 30)
    TextBox.Position = UDim2.new(0, 90, 0.5, -15)
    TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
    TextBox.BorderSizePixel = 0
    TextBox.Text = ""
    TextBox.PlaceholderText = placeholder
    TextBox.Font = Enum.Font.Gotham
    TextBox.TextColor3 = self.Config.TextColor
    TextBox.TextSize = 13
    TextBox.Parent = Input
    
    Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6)
    
    TextBox:GetPropertyChangedSignal("Text"):Connect(function()
        if callback then
            callback(TextBox.Text)
        end
    end)
    
    return Input, TextBox
end

-- Função para adicionar dropdown
function KaisenUI:AddDropdown(name, options, default, section, callback)
    local Dropdown = Instance.new("Frame")
    Dropdown.Name = name
    Dropdown.Size = UDim2.new(1, -10, 0, 45)
    Dropdown.BackgroundColor3 = self.Config.ButtonColor
    Dropdown.BorderSizePixel = 0
    Dropdown.Parent = section
    
    Instance.new("UICorner", Dropdown).CornerRadius = UDim.new(0, 8)
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0, 80, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.Font = Enum.Font.GothamBold
    Label.TextColor3 = self.Config.TextColor
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Dropdown
    
    local DropBtn = Instance.new("TextButton")
    DropBtn.Size = UDim2.new(1, -100, 0, 30)
    DropBtn.Position = UDim2.new(0, 90, 0.5, -15)
    DropBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
    DropBtn.BorderSizePixel = 0
    DropBtn.Text = default or options[1]
    DropBtn.Font = Enum.Font.Gotham
    DropBtn.TextColor3 = self.Config.TextColor
    DropBtn.TextSize = 13
    DropBtn.Parent = Dropdown
    
    Instance.new("UICorner", DropBtn).CornerRadius = UDim.new(0, 6)
    
    local DropdownList = Instance.new("Frame")
    DropdownList.Size = UDim2.new(1, -100, 0, #options * 30)
    DropdownList.Position = UDim2.new(0, 90, 0, 40)
    DropdownList.BackgroundColor3 = Color3.fromRGB(30, 30, 37)
    DropdownList.BorderSizePixel = 0
    DropdownList.Visible = false
    DropdownList.ZIndex = 10
    DropdownList.Parent = Dropdown
    
    Instance.new("UICorner", DropdownList).CornerRadius = UDim.new(0, 6)
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 2)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = DropdownList
    
    local selected = default or options[1]
    
    for _, option in ipairs(options) do
        local OptionBtn = Instance.new("TextButton")
        OptionBtn.Size = UDim2.new(1, -10, 0, 28)
        OptionBtn.Position = UDim2.new(0, 5, 0, 0)
        OptionBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
        OptionBtn.BorderSizePixel = 0
        OptionBtn.Text = option
        OptionBtn.Font = Enum.Font.Gotham
        OptionBtn.TextColor3 = self.Config.TextColor
        OptionBtn.TextSize = 12
        OptionBtn.ZIndex = 10
        OptionBtn.Parent = DropdownList
        
        Instance.new("UICorner", OptionBtn).CornerRadius = UDim.new(0, 4)
        
        OptionBtn.MouseButton1Click:Connect(function()
            selected = option
            DropBtn.Text = option
            DropdownList.Visible = false
            
            if callback then
                callback(option)
            end
        end)
    end
    
    DropBtn.MouseButton1Click:Connect(function()
        DropdownList.Visible = not DropdownList.Visible
    end)
    
    return Dropdown
end

-- Função para mostrar/esconder UI
function KaisenUI:Toggle()
    if MainFrame then
        MainFrame.Visible = not MainFrame.Visible
    end
end

-- Função para mostrar UI
function KaisenUI:Show()
    if MainFrame then
        MainFrame.Visible = true
    end
end

-- Função para esconder UI
function KaisenUI:Hide()
    if MainFrame then
        MainFrame.Visible = false
    end
end

-- Função para destruir UI
function KaisenUI:Destroy()
    if ScreenGui then
        ScreenGui:Destroy()
    end
end

-- Retornar a função principal
return function(config)
    local instance = setmetatable({}, {__index = KaisenUI})
    instance:Create(config or {})
    return instance
end

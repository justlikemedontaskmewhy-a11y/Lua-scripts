-- =======================================================
-- WELL HUB | CARRY PEOPLE SIMULATOR 3 | PREMIUM EDITION (KH UI Style)
-- Меню: Insert | Escape Grab: G | Sit: V | Respawn: R
-- =======================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

-- == КОНФИГУРАЦИЯ UI ==
local Config = {
    Title = "Well Hub",
    Accent = Color3.fromRGB(235, 60, 60),
    AccentDark = Color3.fromRGB(180, 40, 40),
    Background = Color3.fromRGB(14, 14, 16),
    Panel = Color3.fromRGB(20, 20, 24),
    Secondary = Color3.fromRGB(26, 26, 30),
    Card = Color3.fromRGB(24, 24, 28),
    Text = Color3.fromRGB(235, 235, 240),
    TextDim = Color3.fromRGB(120, 120, 130),
    TextMuted = Color3.fromRGB(90, 90, 100),
    Border = Color3.fromRGB(36, 36, 42),
    Font = Enum.Font.Gotham,
    FontMedium = Enum.Font.GothamMedium,
    FontBold = Enum.Font.GothamBold,
    FontBlack = Enum.Font.GothamBlack,
}

-- == СОЗДАНИЕ ОСНОВЫ ==
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WellHub"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- == ГЛАВНЫЙ ФРЕЙМ (720x480) ==
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 720, 0, 480)
MainFrame.Position = UDim2.new(0.5, -360, 0.5, -240)
MainFrame.BackgroundColor3 = Config.Background
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Config.Border
MainStroke.Thickness = 1

-- =========================================================
-- ЛЕВЫЙ САЙДБАР (иконки-табы)
-- =========================================================
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 62, 1, 0)
Sidebar.BackgroundColor3 = Config.Background
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

local SidebarLogo = Instance.new("TextLabel")
SidebarLogo.Size = UDim2.new(1, 0, 0, 50)
SidebarLogo.Position = UDim2.new(0, 0, 0, 12)
SidebarLogo.Text = "W"
SidebarLogo.TextColor3 = Config.Accent
SidebarLogo.Font = Config.FontBlack
SidebarLogo.TextSize = 26
SidebarLogo.BackgroundTransparency = 1
SidebarLogo.Parent = Sidebar

local LogoUnderline = Instance.new("Frame")
LogoUnderline.Size = UDim2.new(0, 30, 0, 3)
LogoUnderline.Position = UDim2.new(0.5, -15, 0, 48)
LogoUnderline.BackgroundColor3 = Config.Accent
LogoUnderline.BorderSizePixel = 0
LogoUnderline.Parent = Sidebar
Instance.new("UICorner", LogoUnderline).CornerRadius = UDim.new(1, 0)

local TabListFrame = Instance.new("Frame")
TabListFrame.Size = UDim2.new(1, 0, 1, -70)
TabListFrame.Position = UDim2.new(0, 0, 0, 62)
TabListFrame.BackgroundTransparency = 1
TabListFrame.Parent = Sidebar

local TabListLayout = Instance.new("UIListLayout", TabListFrame)
TabListLayout.Padding = UDim.new(0, 6)
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- =========================================================
-- КОНТЕНТ-АРЕА
-- =========================================================
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -70, 1, -10)
ContentArea.Position = UDim2.new(0, 68, 0, 5)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- =========================================================
-- HEADER (как в KH)
-- =========================================================
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Config.Background
Header.BorderSizePixel = 0
Header.Parent = ContentArea

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(0, 400, 0, 26)
HeaderTitle.Position = UDim2.new(0, 5, 0, 5)
HeaderTitle.Text = "Combat"
HeaderTitle.TextColor3 = Config.Text
HeaderTitle.Font = Config.FontBold
HeaderTitle.TextSize = 20
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Parent = Header

local HeaderDesc = Instance.new("TextLabel")
HeaderDesc.Size = UDim2.new(0, 400, 0, 16)
HeaderDesc.Position = UDim2.new(0, 5, 0, 30)
HeaderDesc.Text = "Grab, escape, and troll other players."
HeaderDesc.TextColor3 = Config.TextDim
HeaderDesc.Font = Config.Font
HeaderDesc.TextSize = 12
HeaderDesc.TextXAlignment = Enum.TextXAlignment.Left
HeaderDesc.BackgroundTransparency = 1
HeaderDesc.Parent = Header

-- Search bar (декоративный)
local SearchBox = Instance.new("Frame")
SearchBox.Size = UDim2.new(0, 160, 0, 28)
SearchBox.Position = UDim2.new(1, -170, 0, 16)
SearchBox.BackgroundColor3 = Config.Panel
SearchBox.BorderSizePixel = 0
SearchBox.Parent = Header
Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 6)

local SearchIcon = Instance.new("TextLabel")
SearchIcon.Size = UDim2.new(0, 24, 1, 0)
SearchIcon.Position = UDim2.new(0, 4, 0, 0)
SearchIcon.Text = "🔍"
SearchIcon.TextColor3 = Config.TextMuted
SearchIcon.TextSize = 12
SearchIcon.BackgroundTransparency = 1
SearchIcon.Parent = SearchBox

local SearchPlaceholder = Instance.new("TextLabel")
SearchPlaceholder.Size = UDim2.new(1, -28, 1, 0)
SearchPlaceholder.Position = UDim2.new(0, 24, 0, 0)
SearchPlaceholder.Text = "Search..."
SearchPlaceholder.TextColor3 = Config.TextMuted
SearchPlaceholder.Font = Config.Font
SearchPlaceholder.TextSize = 12
SearchPlaceholder.TextXAlignment = Enum.TextXAlignment.Left
SearchPlaceholder.BackgroundTransparency = 1
SearchPlaceholder.Parent = SearchBox

-- Закрыть
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -32, 0, -20)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Config.TextDim
CloseBtn.Font = Config.FontBold
CloseBtn.TextSize = 14
CloseBtn.BackgroundColor3 = Config.Panel
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

CloseBtn.MouseEnter:Connect(function() TweenService:Create(CloseBtn, TweenInfo.new(0.1), {BackgroundColor3 = Config.Accent, TextColor3 = Config.Text}):Play() end)
CloseBtn.MouseLeave:Connect(function() TweenService:Create(CloseBtn, TweenInfo.new(0.1), {BackgroundColor3 = Config.Panel, TextColor3 = Config.TextDim}):Play() end)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- =========================================================
-- SUB-TABS (горизонтальные кнопки)
-- =========================================================
local SubTabBar = Instance.new("Frame")
SubTabBar.Size = UDim2.new(1, -5, 0, 32)
SubTabBar.Position = UDim2.new(0, 5, 0, 62)
SubTabBar.BackgroundTransparency = 1
SubTabBar.Parent = ContentArea

local SubTabLayout = Instance.new("UIListLayout", SubTabBar)
SubTabLayout.FillDirection = Enum.FillDirection.Horizontal
SubTabLayout.Padding = UDim.new(0, 6)
SubTabLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- =========================================================
-- КОНТЕНТ-СТРАНИЦА (под sub-tabs)
-- =========================================================
local PageContainer = Instance.new("Frame")
PageContainer.Size = UDim2.new(1, 0, 1, -100)
PageContainer.Position = UDim2.new(0, 0, 0, 100)
PageContainer.BackgroundTransparency = 1
PageContainer.Parent = ContentArea

-- =========================================================
-- СИСТЕМА ТАБОВ (sidebar)
-- =========================================================
local Tabs = {}
local ActiveTab = nil

local function CreateTab(icon, name, description)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 42, 0, 42)
    Btn.BackgroundColor3 = Config.Background
    Btn.TextColor3 = Config.TextMuted
    Btn.Font = Config.FontBold
    Btn.TextSize = 18
    Btn.Text = icon
    Btn.BorderSizePixel = 0
    Btn.Parent = TabListFrame
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    
    local btnStroke = Instance.new("UIStroke", Btn)
    btnStroke.Color = Config.Border
    btnStroke.Thickness = 1
    btnStroke.Transparency = 1

    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Config.Accent
    Page.Visible = false
    Page.Parent = PageContainer
    
    local PageLayout = Instance.new("UIListLayout", Page)
    PageLayout.Padding = UDim.new(0, 6)
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder

    Btn.MouseButton1Click:Connect(function()
        if ActiveTab then
            ActiveTab.Page.Visible = false
            TweenService:Create(ActiveTab.Btn, TweenInfo.new(0.15), {BackgroundColor3 = Config.Background, TextColor3 = Config.TextMuted}):Play()
            TweenService:Create(ActiveTab.Stroke, TweenInfo.new(0.15), {Transparency = 1}):Play()
        end
        
        ActiveTab = {Btn = Btn, Page = Page, Stroke = btnStroke}
        Page.Visible = true
        TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Config.Accent, TextColor3 = Config.Text}):Play()
        TweenService:Create(btnStroke, TweenInfo.new(0.15), {Transparency = 0.5}):Play()
        
        -- Обновляем хедер
        HeaderTitle.Text = name
        HeaderDesc.Text = description or ""
    end)

    table.insert(Tabs, {Name = name, Btn = Btn, Page = Page, Layout = PageLayout})
    return Page
end

-- =========================================================
-- SUB-TABS для страницы
-- =========================================================
local function CreateSubTabs(page)
    -- Возвращает функцию addSubTab и саму sub-page container
    local subPages = {}
    local activeBtn = nil
    local activePage = nil
    
    local function addSubTab(name, order)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(0, 0, 1, 0)
        Btn.AutomaticSize = Enum.AutomaticSize.X
        Btn.BackgroundColor3 = Config.Panel
        Btn.TextColor3 = Config.TextDim
        Btn.Font = Config.FontMedium
        Btn.TextSize = 12
        Btn.Text = "  " .. name .. "  "
        Btn.BorderSizePixel = 0
        Btn.LayoutOrder = order or 0
        Btn.Parent = SubTabBar
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
        
        local SubPage = Instance.new("ScrollingFrame")
        SubPage.Size = UDim2.new(1, 0, 1, 0)
        SubPage.BackgroundTransparency = 1
        SubPage.CanvasSize = UDim2.new(0, 0, 0, 0)
        SubPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
        SubPage.ScrollBarThickness = 3
        SubPage.ScrollBarImageColor3 = Config.Accent
        SubPage.Visible = false
        SubPage.Parent = page
        
        local Layout = Instance.new("UIListLayout", SubPage)
        Layout.Padding = UDim.new(0, 6)
        Layout.SortOrder = Enum.SortOrder.LayoutOrder
        
        Btn.MouseButton1Click:Connect(function()
            if activeBtn and activeBtn ~= Btn then
                activePage.Visible = false
                TweenService:Create(activeBtn, TweenInfo.new(0.15), {BackgroundColor3 = Config.Panel, TextColor3 = Config.TextDim}):Play()
            end
            activeBtn = Btn
            activePage = SubPage
            SubPage.Visible = true
            TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Config.Accent, TextColor3 = Config.Text}):Play()
        end)
        
        table.insert(subPages, {Btn = Btn, Page = SubPage})
        return SubPage
    end
    
    local function activateFirst()
        if subPages[1] then
            subPages[1].Btn.MouseButton1Click:Fire()
        end
    end
    
    return addSubTab, activateFirst
end

-- =========================================================
-- КОМПОНЕНТЫ
-- =========================================================
local function CreateSectionHeader(parent, text)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -10, 0, 22)
    Container.BackgroundTransparency = 1
    Container.Parent = parent
    Container.LayoutOrder = #parent:GetChildren()
    
    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, 0, 1, 0)
    Lbl.Text = string.upper(text)
    Lbl.TextColor3 = Config.TextDim
    Lbl.Font = Config.FontBold
    Lbl.TextSize = 10
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.BackgroundTransparency = 1
    Lbl.Parent = Container
    
    return Container
end

-- Простая строка с toggle
local function CreateToggleRow(parent, text, default, callback)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, -10, 0, 36)
    Row.BackgroundColor3 = Config.Card
    Row.BorderSizePixel = 0
    Row.Parent = parent
    Row.LayoutOrder = #parent:GetChildren()
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 6)
    
    local RowStroke = Instance.new("UIStroke", Row)
    RowStroke.Color = Config.Border
    RowStroke.Thickness = 1

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -70, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.Text = text
    Label.TextColor3 = Config.Text
    Label.Font = Config.FontMedium
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = Row

    local Switch = Instance.new("TextButton")
    Switch.Size = UDim2.new(0, 38, 0, 20)
    Switch.Position = UDim2.new(1, -50, 0.5, -10)
    Switch.BackgroundColor3 = Config.Secondary
    Switch.Text = ""
    Switch.BorderSizePixel = 0
    Switch.Parent = Row
    Instance.new("UICorner", Switch).CornerRadius = UDim.new(1, 0)

    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 16, 0, 16)
    Circle.Position = UDim2.new(0, 2, 0.5, -8)
    Circle.BackgroundColor3 = Config.TextMuted
    Circle.BorderSizePixel = 0
    Circle.Parent = Switch
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

    local state = default
    local function updateState()
        if state then
            TweenService:Create(Switch, TweenInfo.new(0.15), {BackgroundColor3 = Config.Accent}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.15), {Position = UDim2.new(1, -18, 0.5, -8), BackgroundColor3 = Config.Text}):Play()
        else
            TweenService:Create(Switch, TweenInfo.new(0.15), {BackgroundColor3 = Config.Secondary}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.15), {Position = UDim2.new(0, 2, 0.5, -8), BackgroundColor3 = Config.TextMuted}):Play()
        end
        pcall(callback, state)
    end

    Switch.MouseButton1Click:Connect(function()
        state = not state
        updateState()
    end)
    updateState()
end

-- Компактный слайдер
local function CreateSlider(parent, text, min, max, default, suffix, callback)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, -10, 0, 44)
    Row.BackgroundColor3 = Config.Card
    Row.BorderSizePixel = 0
    Row.Parent = parent
    Row.LayoutOrder = #parent:GetChildren()
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 6)
    
    local RowStroke = Instance.new("UIStroke", Row)
    RowStroke.Color = Config.Border
    RowStroke.Thickness = 1

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 0, 16)
    Label.Position = UDim2.new(0, 12, 0, 6)
    Label.Text = text
    Label.TextColor3 = Config.Text
    Label.Font = Config.FontMedium
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = Row

    local ValueLbl = Instance.new("TextLabel")
    ValueLbl.Size = UDim2.new(0.3, -12, 0, 16)
    ValueLbl.Position = UDim2.new(0.7, 0, 0, 6)
    ValueLbl.Text = tostring(default) .. (suffix or "")
    ValueLbl.TextColor3 = Config.Accent
    ValueLbl.Font = Config.FontBold
    ValueLbl.TextSize = 12
    ValueLbl.TextXAlignment = Enum.TextXAlignment.Right
    ValueLbl.BackgroundTransparency = 1
    ValueLbl.Parent = Row

    local BarBg = Instance.new("Frame")
    BarBg.Size = UDim2.new(1, -24, 0, 4)
    BarBg.Position = UDim2.new(0, 12, 0, 32)
    BarBg.BackgroundColor3 = Config.Secondary
    BarBg.BorderSizePixel = 0
    BarBg.Parent = Row
    Instance.new("UICorner", BarBg).CornerRadius = UDim.new(1, 0)

    local BarFill = Instance.new("Frame")
    BarFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    BarFill.BackgroundColor3 = Config.Accent
    BarFill.BorderSizePixel = 0
    BarFill.Parent = BarBg
    Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)

    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 10, 0, 10)
    Knob.Position = UDim2.new((default - min) / (max - min), -5, 0.5, -5)
    Knob.BackgroundColor3 = Config.Text
    Knob.BorderSizePixel = 0
    Knob.Parent = BarBg
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

    local dragging = false
    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - BarBg.AbsolutePosition.X) / BarBg.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * pos)
        BarFill.Size = UDim2.new(pos, 0, 1, 0)
        Knob.Position = UDim2.new(pos, -5, 0.5, -5)
        ValueLbl.Text = tostring(value) .. (suffix or "")
        pcall(callback, value)
    end

    BarBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateSlider(input)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- Keybind row
local function CreateKeybindRow(parent, text, defaultKey, callback)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, -10, 0, 36)
    Row.BackgroundColor3 = Config.Card
    Row.BorderSizePixel = 0
    Row.Parent = parent
    Row.LayoutOrder = #parent:GetChildren()
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 6)
    
    local RowStroke = Instance.new("UIStroke", Row)
    RowStroke.Color = Config.Border
    RowStroke.Thickness = 1

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.6, 0, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.Text = text
    Label.TextColor3 = Config.Text
    Label.Font = Config.FontMedium
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = Row

    local KeyBtn = Instance.new("TextButton")
    KeyBtn.Size = UDim2.new(0, 60, 0, 24)
    KeyBtn.Position = UDim2.new(1, -72, 0.5, -12)
    KeyBtn.BackgroundColor3 = Config.Secondary
    KeyBtn.TextColor3 = Config.Text
    KeyBtn.Font = Config.FontBold
    KeyBtn.TextSize = 11
    KeyBtn.Text = defaultKey.Name
    KeyBtn.BorderSizePixel = 0
    KeyBtn.Parent = Row
    Instance.new("UICorner", KeyBtn).CornerRadius = UDim.new(0, 5)

    local listening = false
    local currentKey = defaultKey

    KeyBtn.MouseButton1Click:Connect(function()
        listening = true
        KeyBtn.Text = "..."
        KeyBtn.TextColor3 = Config.Accent
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if listening then
            if input.UserInputType == Enum.UserInputType.Keyboard then
                currentKey = input.KeyCode
                KeyBtn.Text = currentKey.Name
                KeyBtn.TextColor3 = Config.Text
                listening = false
            end
        else
            if not gameProcessed and input.KeyCode == currentKey then
                pcall(callback)
            end
        end
    end)
end

-- Кнопка
local function CreateButtonRow(parent, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -10, 0, 34)
    Btn.BackgroundColor3 = Config.Card
    Btn.TextColor3 = Config.Text
    Btn.Font = Config.FontMedium
    Btn.TextSize = 13
    Btn.Text = text
    Btn.BorderSizePixel = 0
    Btn.Parent = parent
    Btn.LayoutOrder = #parent:GetChildren()
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    local RowStroke = Instance.new("UIStroke", Btn)
    RowStroke.Color = Config.Border
    RowStroke.Thickness = 1
    
    Btn.MouseEnter:Connect(function() 
        TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = Config.Accent}):Play()
        TweenService:Create(RowStroke, TweenInfo.new(0.1), {Transparency = 1}):Play()
    end)
    Btn.MouseLeave:Connect(function() 
        TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = Config.Card}):Play()
        TweenService:Create(RowStroke, TweenInfo.new(0.1), {Transparency = 0}):Play()
    end)
    Btn.MouseButton1Click:Connect(function() pcall(callback) end)
end

-- Двухколоночный сплит
local function CreateSplit(parent, leftRatio)
    leftRatio = leftRatio or 0.5
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -10, 0, 0)
    Container.AutomaticSize = Enum.AutomaticSize.Y
    Container.BackgroundTransparency = 1
    Container.Parent = parent
    Container.LayoutOrder = #parent:GetChildren()
    
    local Left = Instance.new("Frame")
    Left.Size = UDim2.new(leftRatio, -3, 0, 0)
    Left.AutomaticSize = Enum.AutomaticSize.Y
    Left.BackgroundTransparency = 1
    Left.Parent = Container
    
    local LeftLayout = Instance.new("UIListLayout", Left)
    LeftLayout.Padding = UDim.new(0, 6)
    LeftLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    local Right = Instance.new("Frame")
    Right.Size = UDim2.new(1 - leftRatio, -3, 0, 0)
    Right.Position = UDim2.new(leftRatio, 3, 0, 0)
    Right.AutomaticSize = Enum.AutomaticSize.Y
    Right.BackgroundTransparency = 1
    Right.Parent = Container
    
    local RightLayout = Instance.new("UIListLayout", Right)
    RightLayout.Padding = UDim.new(0, 6)
    RightLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    return Left, Right
end

-- Дропдаун
local function CreateDropdown(parent, text, options, default, callback)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, -10, 0, 36)
    Row.BackgroundColor3 = Config.Card
    Row.BorderSizePixel = 0
    Row.Parent = parent
    Row.LayoutOrder = #parent:GetChildren()
    Instance.new("UICorner", Row).CornerRadius = UDim.new(0, 6)
    
    local RowStroke = Instance.new("UIStroke", Row)
    RowStroke.Color = Config.Border
    RowStroke.Thickness = 1

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.5, 0, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.Text = text
    Label.TextColor3 = Config.Text
    Label.Font = Config.FontMedium
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = Row

    local currentValue = default or options[1]
    local open = false
    
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.45, -12, 0, 24)
    Btn.Position = UDim2.new(0.5, 0, 0.5, -12)
    Btn.BackgroundColor3 = Config.Secondary
    Btn.TextColor3 = Config.Text
    Btn.Font = Config.FontBold
    Btn.TextSize = 11
    Btn.Text = currentValue
    Btn.BorderSizePixel = 0
    Btn.Parent = Row
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 5)
    
    local DropList = Instance.new("Frame")
    DropList.Size = UDim2.new(0.45, -12, 0, #options * 24 + 8)
    DropList.Position = UDim2.new(0.5, 0, 1, 4)
    DropList.BackgroundColor3 = Config.Panel
    DropList.BorderSizePixel = 0
    DropList.Visible = false
    DropList.ZIndex = 10
    DropList.Parent = Row
    Instance.new("UICorner", DropList).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", DropList).Color = Config.Border
    
    local DropLayout = Instance.new("UIListLayout", DropList)
    DropLayout.Padding = UDim.new(0, 2)
    DropLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    for _, opt in ipairs(options) do
        local OptBtn = Instance.new("TextButton")
        OptBtn.Size = UDim2.new(0.9, 0, 0, 20)
        OptBtn.BackgroundColor3 = Config.Panel
        OptBtn.TextColor3 = Config.Text
        OptBtn.Font = Config.Font
        OptBtn.TextSize = 11
        OptBtn.Text = opt
        OptBtn.BorderSizePixel = 0
        OptBtn.ZIndex = 11
        OptBtn.Parent = DropList
        Instance.new("UICorner", OptBtn).CornerRadius = UDim.new(0, 4)
        
        OptBtn.MouseEnter:Connect(function() TweenService:Create(OptBtn, TweenInfo.new(0.1), {BackgroundColor3 = Config.Accent}):Play() end)
        OptBtn.MouseLeave:Connect(function() TweenService:Create(OptBtn, TweenInfo.new(0.1), {BackgroundColor3 = Config.Panel}):Play() end)
        OptBtn.MouseButton1Click:Connect(function()
            currentValue = opt
            Btn.Text = opt
            DropList.Visible = false
            open = false
            pcall(callback, opt)
        end)
    end
    
    Btn.MouseButton1Click:Connect(function()
        open = not open
        DropList.Visible = open
    end)
end

-- =========================================================
-- ПЕРЕТАСКИВАНИЕ ЗА HEADER
-- =========================================================
local dragging, dragStart, startPos
local dragZones = {Header, SubTabBar}

for _, zone in ipairs(dragZones) do
    zone.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
end

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Меню на Insert
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- =========================================================
-- ============== ЛОГИКА (фичи) ============================
-- =========================================================

-- Хелперы
local function getHumanoid()
    local char = LocalPlayer.Character
    if not char then return nil end
    return char:FindFirstChildOfClass("Humanoid")
end

local function getHRP()
    local char = LocalPlayer.Character
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart")
end

-- ========== ТАБ: COMBAT ==========
local combatPage = CreateTab("⚔", "Combat", "Grab, escape, and troll other players.")
local addCombatSub, activateCombatSub = CreateSubTabs(combatPage)

local combatGrabSub = addCombatSub("Grab", 1)
local combatEscapeSub = addCombatSub("Escape", 2)
local combatTrollSub = addCombatSub("Troll", 3)

-- === GRAB SUB-TAB ===
local dropCooldowns = {}

local function getClosestPlayer(ignoreCooldowns)
    local closest, shortest = nil, math.huge
    local hrp = getHRP()
    if not hrp then return end
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local isOnCooldown = false
            if not ignoreCooldowns and dropCooldowns[plr] then
                if os.clock() < dropCooldowns[plr] then
                    isOnCooldown = true
                else
                    dropCooldowns[plr] = nil
                end
            end
            if not isOnCooldown then
                local dist = (hrp.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                if dist < shortest then shortest = dist; closest = plr end
            end
        end
    end
    return closest
end

local function getClosestPart(targetChar, referencePos)
    local closestPart, shortestDist = nil, math.huge
    for _, part in ipairs(targetChar:GetChildren()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            local dist = (part.Position - referencePos).Magnitude
            if dist < shortestDist then shortestDist = dist; closestPart = part end
        end
    end
    return closestPart
end

local function isAnimPlaying(animId)
    local hum = getHumanoid()
    if not hum then return false end
    for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
        if tostring(track.Animation.AnimationId):match(animId) then
            return true
        end
    end
    return false
end

local lastDroppedPlayer = nil
local grabCooldown = 1.5
local lastGrabAttemptTime = 0
local grabSettleTime = 0.45

local function doGrabHack(ignoreCooldowns, isAutoMode)
    if isAnimPlaying("7191297978") then return false end
    if isAutoMode then
        if os.clock() - lastGrabAttemptTime < grabSettleTime then return false end
        lastGrabAttemptTime = os.clock()
    end

    local target = getClosestPlayer(ignoreCooldowns)
    if not target or not target.Character then return false end
    
    local targetChar = target.Character
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    if not targetRoot then return false end
    
    local arm = targetChar:FindFirstChild("Right Arm") or getClosestPart(targetChar, targetRoot.Position)
    if not arm then return false end
    
    local myHRP = getHRP()
    local lookCFrame = CFrame.lookAt(targetRoot.Position, myHRP and myHRP.Position or targetRoot.Position)
    local args = {[1] = arm, [2] = "Grab", [3] = targetRoot.Position, [4] = lookCFrame}
    
    local events = ReplicatedStorage:FindFirstChild("Events")
    if events and events:FindFirstChild("Grab") then
        events.Grab:FireServer(unpack(args))
        lastDroppedPlayer = target
        return true
    end
    return false
end

local leftSplit, rightSplit = CreateSplit(combatGrabSub, 0.5)

-- Левая колонка: Main
CreateSectionHeader(leftSplit, "Main")
CreateKeybindRow(leftSplit, "Grab Player (Hack)", Enum.KeyCode.E, function() doGrabHack(true, false) end)
CreateToggleRow(leftSplit, "Auto Grab", false, function(state)
    if state then
        task.spawn(function()
            local lastHoldState = false
            while true do
                -- Проверяем что тоггл всё ещё включён
                if not _G.WellHub_AutoGrab then break end
                local isHolding = isAnimPlaying("7191297978")
                if lastHoldState and not isHolding then
                    if lastDroppedPlayer then
                        dropCooldowns[lastDroppedPlayer] = os.clock() + grabCooldown
                        lastDroppedPlayer = nil
                    end
                end
                lastHoldState = isHolding
                if not isHolding then
                    doGrabHack(false, true)
                end
                task.wait(math.max(autoGrabDelay, 0.05))
            end
        end)
    end
    _G.WellHub_AutoGrab = state
end)
CreateSlider(leftSplit, "AutoGrab Delay", 50, 1000, 200, " MS", function(val)
    autoGrabDelay = val / 1000
end)

-- Правая колонка: Cooldowns
CreateSectionHeader(rightSplit, "Cooldowns")
CreateSlider(rightSplit, "Grab Cooldown", 0, 5, 1.5, " s", function(val)
    grabCooldown = val / 10
end)
CreateSlider(rightSplit, "Settle Time (Anti-Spam)", 0, 100, 45, " (x10ms)", function(val)
    grabSettleTime = val / 100
end)

-- === ESCAPE SUB-TAB ===
local leftEscape, rightEscape = CreateSplit(combatEscapeSub, 0.5)

CreateSectionHeader(leftEscape, "Manual")
CreateKeybindRow(leftEscape, "Escape Grab", Enum.KeyCode.G, function()
    -- escape logic
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
        pcall(function() hum:ChangeState(Enum.HumanoidStateType.Freefall) end)
        hum.PlatformStand = false
        hum.Sit = false
    end
    if hrp then
        local old = hrp.CFrame
        hrp.CFrame = old + Vector3.new(0, 300, 0)
        task.wait(0.3)
        hrp.CFrame = old
    end
end)
CreateButtonRow(leftEscape, "Escape Grab (Button)", function()
    -- то же самое
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum.PlatformStand = false; hum.Sit = false end
    if hrp then
        local old = hrp.CFrame
        hrp.CFrame = old + Vector3.new(0, 300, 0)
        task.wait(0.3)
        hrp.CFrame = old
    end
end)

CreateSectionHeader(rightEscape, "Auto Escape")
CreateToggleRow(rightEscape, "Auto Kill on Grab (Fallback)", false, function(state)
    if _G.WellHub_KillConn then
        _G.WellHub_KillConn:Disconnect()
        _G.WellHub_KillConn = nil
    end
    if state then
        local events = ReplicatedStorage:FindFirstChild("Events")
        local grab = events and events:FindFirstChild("Grab")
        if grab and grab:IsA("RemoteEvent") then
            _G.WellHub_KillConn = grab.OnClientEvent:Connect(function(arg1, arg2)
                if arg1 == true and arg2 == true then
                    task.spawn(function()
                        task.wait(killOnGrabDelay)
                        local hum = getHumanoid()
                        if hum then
                            local s = hum:GetState()
                            if s == Enum.HumanoidStateType.Physics or s == Enum.HumanoidStateType.Ragdoll then
                                hum.Health = 0
                            end
                        end
                    end)
                end
            end)
        end
    end
end)
killOnGrabDelay = 1.5
CreateSlider(rightEscape, "Kill Delay", 0, 50, 15, " (x0.1s)", function(val)
    killOnGrabDelay = val / 10
end)

-- === TROLL SUB-TAB ===
CreateSectionHeader(combatTrollSub, "Troll Actions")
CreateButtonRow(combatTrollSub, "Fling Grabber (Ragdoll Them)", function()
    local target = getClosestPlayer(true)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = target.Character.HumanoidRootPart
        hrp.Velocity = Vector3.new(0, 1000, 0)
        hrp.RotVelocity = Vector3.new(9999, 9999, 9999)
    end
end)
CreateButtonRow(combatTrollSub, "Teleport To Closest Player", function()
    local target = getClosestPlayer(true)
    local myHRP = getHRP()
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and myHRP then
        myHRP.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
    end
end)

-- ========== ТАБ: MOVEMENT ==========
local movementPage = CreateTab("🏃", "Movement", "Speed, jump, ragdoll escape.")
local addMoveSub, activateMoveSub = CreateSubTabs(movementPage)
local moveSpeedSub = addMoveSub("Speed", 1)
local moveAntiRagSub = addMoveSub("Anti-Ragdoll", 2)

-- === SPEED SUB ===
local leftSpeed, rightSpeed = CreateSplit(moveSpeedSub, 0.5)

local savedWalkSpeed = 16
local savedJumpPower = 50

CreateSectionHeader(leftSpeed, "Walk Speed")
CreateSlider(leftSpeed, "WalkSpeed", 16, 250, 16, "", function(val)
    savedWalkSpeed = val
    local hum = getHumanoid()
    if hum then hum.WalkSpeed = val end
end)

CreateSectionHeader(rightSpeed, "Jump Power")
CreateSlider(rightSpeed, "JumpPower", 50, 350, 50, "", function(val)
    savedJumpPower = val
    local hum = getHumanoid()
    if hum then hum.UseJumpPower = true; hum.JumpPower = val end
end)

-- Info panel
local infoRow = Instance.new("Frame")
infoRow.Size = UDim2.new(1, -10, 0, 34)
infoRow.BackgroundColor3 = Config.Card
infoRow.BorderSizePixel = 0
infoRow.Parent = moveSpeedSub
infoRow.LayoutOrder = 100
Instance.new("UICorner", infoRow).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", infoRow).Color = Config.Border

local infoLbl = Instance.new("TextLabel")
infoLbl.Size = UDim2.new(1, -20, 1, 0)
infoLbl.Position = UDim2.new(0, 12, 0, 0)
infoLbl.Text = "Current: WS -- | JP --"
infoLbl.TextColor3 = Config.TextDim
infoLbl.Font = Config.FontMedium
infoLbl.TextSize = 12
infoLbl.TextXAlignment = Enum.TextXAlignment.Left
infoLbl.BackgroundTransparency = 1
infoLbl.Parent = infoRow

task.spawn(function()
    while task.wait(0.3) do
        local hum = getHumanoid()
        if hum then
            infoLbl.Text = string.format("Current: WS %d | JP %d", hum.WalkSpeed, hum.JumpPower)
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = savedWalkSpeed
        hum.UseJumpPower = true
        hum.JumpPower = savedJumpPower
    end
end)

-- === ANTI-RAGDOLL SUB ===
local leftRag, rightRag = CreateSplit(moveAntiRagSub, 0.5)

CreateSectionHeader(leftRag, "Manual")
CreateKeybindRow(leftRag, "Escape Ragdoll (Sit)", Enum.KeyCode.V, function()
    local hum = getHumanoid()
    if not hum then return end
    hum.Sit = true
    task.wait(0.05)
    hum.Sit = false
    pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
    hum.PlatformStand = false
end)

CreateSectionHeader(rightRag, "Auto")
-- (резерв)

-- ========== ТАБ: VISUALS ==========
local visualPage = CreateTab("👁", "Visuals", "ESP and player highlights.")
local addVisSub, activateVisSub = CreateSubTabs(visualPage)
local espSub = addVisSub("Player ESP", 1)

local espEnabled = false
local espHighlights = {}

local function updateESP()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local highlight = espHighlights[plr]
            if not highlight and espEnabled then
                highlight = Instance.new("Highlight")
                highlight.Name = "WellHubESP"
                highlight.Adornee = plr.Character
                highlight.FillColor = Config.Accent
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.6
                highlight.OutlineTransparency = 0
                highlight.Parent = plr.Character
                espHighlights[plr] = highlight
            elseif highlight and not espEnabled then
                highlight:Destroy()
                espHighlights[plr] = nil
            end
        end
    end
    for plr, hl in pairs(espHighlights) do
        if not plr.Parent or not plr.Character then
            hl:Destroy()
            espHighlights[plr] = nil
        end
    end
end

local leftEsp, rightEsp = CreateSplit(espSub, 0.5)
CreateSectionHeader(leftEsp, "ESP Settings")
CreateToggleRow(leftEsp, "Enable ESP Highlight", false, function(state)
    espEnabled = state
    if not state then
        for _, hl in pairs(espHighlights) do hl:Destroy() end
        espHighlights = {}
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if espEnabled then updateESP() end
    end
end)

-- ========== ТАБ: MISC ==========
local miscPage = CreateTab("⚙", "Misc", "Respawn, utilities, extras.")
local addMiscSub, activateMiscSub = CreateSubTabs(miscPage)
local miscRespawnSub = addMiscSub("Respawn", 1)
local miscUtilsSub = addMiscSub("Utilities", 2)

-- === RESPAWN SUB ===
local leftResp, rightResp = CreateSplit(miscRespawnSub, 0.5)

local function forceRespawn()
    local char = LocalPlayer.Character
    if not char then
        pcall(function() LocalPlayer:LoadCharacter() end)
        return
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum.Health = 0 end
    pcall(function()
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part:BreakJoints() end
        end
    end)
end

CreateSectionHeader(leftResp, "Manual")
CreateKeybindRow(leftResp, "Force Respawn", Enum.KeyCode.R, forceRespawn)
CreateButtonRow(leftResp, "Respawn Now", forceRespawn)

CreateSectionHeader(rightResp, "Auto")
CreateToggleRow(rightResp, "Auto Respawn on Death", false, function(state)
    if state then
        task.spawn(function()
            while _G.WellHub_AutoResp do
                local hum = getHumanoid()
                if hum and hum.Health <= 0 then
                    forceRespawn()
                end
                task.wait(0.5)
            end
        end)
    end
    _G.WellHub_AutoResp = state
end)

-- === UTILITIES SUB ===
CreateSectionHeader(miscUtilsSub, "Utilities")
CreateButtonRow(miscUtilsSub, "Unlock Reset Button", function()
    pcall(function() StarterGui:SetCore("ResetButtonCallback", true) end)
    pcall(function() LocalPlayer:WaitForChild("PlayerGui"):SetCore("ResetButtonCallback", true) end)
end)
CreateButtonRow(miscUtilsSub, "Load Extra Script (Gist)", function()
    loadstring(game:HttpGet("https://gist.githubusercontent.com/Cat558-uz/220ee42d2ee4694fe4975a19e00e64b3/raw"))()
end)

-- =========================================================
-- АКТИВАЦИЯ
-- =========================================================
if Tabs[1] then
    Tabs[1].Btn.MouseButton1Click:Fire()
end
activateCombatSub()
activateMoveSub()
activateVisSub()
activateMiscSub()

_G.WellHub_AutoGrab = false
_G.WellHub_AutoResp = false
killOnGrabDelay = 1.5
autoGrabDelay = 0.2

print("🔥 Well Hub (KH UI Style) загружен! Меню: Insert 😈")
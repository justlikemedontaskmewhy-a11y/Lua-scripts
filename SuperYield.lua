local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "SuperYield",
    Icon = "door-open",
    Author = "by SuperSonic",
    Folder = "SuperYield",
    Size = UDim2.fromOffset(100, 460),
    Transparent = true,
    Theme = "Light",
    -- ВОЗВРАЩАЕМ БЛОК ИНФОРМАЦИИ О ИГРОКЕ
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            print("Клик по профилю!")
        end,
    },
})

local Tab = Window:Tab({
    Title = "Main",
    Icon = "bird",
})

local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local player = game.Players.LocalPlayer

-- ПЕРЕМЕННЫЕ
local ws_val, jp_val = 16, 50
local ws_on, jp_on = false, false
local flying, flySpeed = false, 50
local noclip, noclipConn, flyConn

-- ЦИКЛ ДЛЯ СКОРОСТИ И ПРЫЖКА (Movement)
RunService.RenderStepped:Connect(function()
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        if ws_on then hum.WalkSpeed = ws_val end
        if jp_on then 
            hum.UseJumpPower = true
            hum.JumpPower = jp_val 
        end
    end
end)

local MainSection = Tab:Section({ Title = "Movement" })

-- ==========================================
-- TROLL TAB (ВСТАВИТЬ В САМОЕ НАЧАЛО СКРИПТА)
-- ==========================================

-- 1. ГЛАВНЫЕ ПЕРЕМЕННЫЕ
local player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local h_obj, h_weld, troll_tool = nil, nil, nil
local mm2_lock = false 
local ghost_flick = false

-- 2. СОЗДАНИЕ ВКЛАДКИ (ПО ТВОЕМУ ИДЕАЛЬНОМУ ПРИМЕРУ)
local TrollTab = Window:Tab({
    Title = "Troll",
    Icon = "ghost",
})

-- Создаем секцию внутри вкладки
local TrollSection = TrollTab:Section({ Title = "Ghost Admin Arsenal" })

-- 3. ГИПЕР-ЗАМОРОЗКА + GHOST FLICK (RENDERSTEPPED)
RunService.RenderStepped:Connect(function()
    if player.Character then
        local shoulder = player.Character:FindFirstChild("Right Shoulder", true) or player.Character:FindFirstChild("RightShoulder", true)
        local root = player.Character:FindFirstChild("HumanoidRootPart")
        
        -- ЗАМОРОЗКА РУКИ (MM2 STYLE - АНТИ-ТРЯСКА)
        if mm2_lock and shoulder then
            shoulder.Transform = CFrame.new() 
            shoulder.C0 = CFrame.new(1, 0.5, 0) 
            shoulder.C1 = CFrame.new(-0.5, 0.5, 0)
            shoulder.Transform = CFrame.Angles(math.rad(90), 0, 0) 
        end
        
        -- GHOST LADDER FLICK (НЕЗАМЕТНЫЙ ЗАЦЕП ЗА СТЕНЫ)
        if ghost_flick and root and player.Character:FindFirstChildOfClass("Humanoid").MoveDirection.Magnitude > 0 then
            root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(0.15), 0)
            task.wait(0.01)
            root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(-0.15), 0)
        end
    end
end)

-- 4. ТВОИ КНОПКИ (TOGGLES)
TrollSection:Toggle({
    Title = "Get FAKE KNIFE (Ghost)",
    Desc = "Нож + бетонная рука. 0% тряски. FE.",
    Callback = function(state)
        if state then
            troll_tool = Instance.new("Tool")
            troll_tool.Name = "FAKE KNIFE"
            troll_tool.RequiresHandle = false
            troll_tool.Parent = player.Backpack
            
            troll_tool.Equipped:Connect(function()
                mm2_lock = true
                local char = player.Character
                local hand = char and (char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm"))
                local isR15 = char:FindFirstChild("UpperTorso") ~= nil
                
                -- Поиск молота (Waist)
                for _, v in pairs(char:GetChildren()) do
                    if v:IsA("Accessory") and (v:FindFirstChild("Handle") and v.Handle:FindFirstChild("WaistAttachment") or v.AccessoryType == Enum.AccessoryType.Waist) then
                        h_obj = v:FindFirstChildWhichIsA("BasePart") or v:FindFirstChild("Handle")
                        break 
                    end
                end

                if h_obj and hand then
                    local w = h_obj:FindFirstChildWhichIsA("Weld") or h_obj:FindFirstChild("AccessoryWeld")
                    if w then w.Enabled = false end
                    if h_weld then h_weld:Destroy() end
                    h_weld = Instance.new("Weld", h_obj)
                    h_weld.Part0 = hand
                    h_weld.Part1 = h_obj
                    -- УМНЫЙ ХВАТ ЗА КРАЙ (R6/R15)
                    h_weld.C0 = isR15 and CFrame.new(0, 0, 3.5) * CFrame.Angles(math.rad(-90), 0, 0) or CFrame.new(0, -1, 3.5) * CFrame.Angles(math.rad(-90), 0, 0)
                end
            end)
            
            troll_tool.Unequipped:Connect(function()
                mm2_lock = false
                if h_weld then h_weld:Destroy() h_weld = nil end
                if h_obj then
                    local w = h_obj:FindFirstChildWhichIsA("Weld") or h_obj:FindFirstChild("AccessoryWeld")
                    if w then w.Enabled = true end
                end
            end)
        else
            mm2_lock = false
            if troll_tool then troll_tool:Destroy() troll_tool = nil end
            if h_weld then h_weld:Destroy() h_weld = nil end
            h_obj = nil
        end
    end
})

TrollSection:Toggle({
    Title = "Ghost Ladder Flick",
    Desc = "Скрытный зацеп за стены и лестницы в башне.",
    Callback = function(state)
        ghost_flick = state
    end
})


-- WalkSpeed
MainSection:Input({
    Title = "WalkSpeed",
    Desc = "Введи число и нажми ENTER",
    Callback = function(t) ws_val = tonumber(t) or 16 end
})
MainSection:Toggle({
    Title = "Enable Loop WalkSpeed",
    Callback = function(s) 
        ws_on = s 
        if not s and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
        end
    end
})

-- JumpPower
MainSection:Input({
    Title = "JumpPower",
    Desc = "Введи число и нажми ENTER",
    Callback = function(t) jp_val = tonumber(t) or 50 end
})
MainSection:Toggle({
    Title = "Enable Loop JumpPower",
    Callback = function(s) 
        jp_on = s 
        if not s and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid").JumpPower = 50
        end
    end
})

-- 1. ГЛАВНЫЕ ПЕРЕМЕННЫЕ
local player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local h_obj, h_weld, troll_tool = nil, nil, nil
local mm2_lock = false 

-- 2. ГИПЕР-ЗАМОРОЗКА (УРОВЕНЬ: PROFESSIONAL)
-- Мы перехватываем управление суставом ПРЯМО ПЕРЕД отрисовкой кадра
RunService.RenderStepped:Connect(function()
    if mm2_lock and player.Character then
        local shoulder = player.Character:FindFirstChild("Right Shoulder", true) or player.Character:FindFirstChild("RightShoulder", true)
        if shoulder then
            -- ФИКС ЩЕЛИ (Вправляем плечо обратно в торс)
            shoulder.C0 = CFrame.new(1, 0.5, 0) 
            shoulder.C1 = CFrame.new(-0.5, 0.5, 0)
            
            -- АНТИ-ТРЯСКА: Выключаем походку Roblox для этой руки
            -- Рука замирает строго впереди (90 градусов)
            shoulder.Transform = CFrame.Angles(math.rad(90), 0, 0) 
        end
    end
end)

-- 3. КНОПКА (В ТВОЕЙ ВКЛАДКЕ TAB)
local TrollSection = Tab:Section({ Title = "Troll Admin Arsenal" })

TrollSection:Toggle({
    Title = "Equip MM2 God Hammer",
    Desc = "0% тряски + фикс щели. Ультимативный метод MM2.",
    Callback = function(state)
        if state then
            troll_tool = Instance.new("Tool")
            troll_tool.Name = "FAKE KNIFE"
            troll_tool.RequiresHandle = false
            troll_tool.Parent = player.Backpack
            
            troll_tool.Equipped:Connect(function()
                mm2_lock = true -- ВКЛЮЧАЕМ "ЗАМОК"
                local char = player.Character
                local hand = char and (char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm"))
                local isR15 = char:FindFirstChild("UpperTorso") ~= nil

                for _, v in pairs(char:GetChildren()) do
                    if v:IsA("Accessory") and (v:FindFirstChild("Handle") and v.Handle:FindFirstChild("WaistAttachment") or v.AccessoryType == Enum.AccessoryType.Waist) then
                        h_obj = v:FindFirstChildWhichIsA("BasePart") or v:FindFirstChild("Handle")
                        break 
                    end
                end

                if h_obj and hand then
                    local oldWeld = h_obj:FindFirstChildWhichIsA("Weld") or h_obj:FindFirstChild("AccessoryWeld")
                    if oldWeld then oldWeld.Enabled = false end
                    h_obj.CanCollide = false
                    h_obj.Massless = true
                    
                    if h_weld then h_weld:Destroy() end
                    h_weld = Instance.new("Weld", h_obj)
                    h_weld.Part0 = hand
                    h_weld.Part1 = h_obj
                    
                    -- ХВАТ ДЛЯ R15 (ЧТОБЫ НЕ ПРОВАЛИВАЛСЯ)
                    if isR15 then
                        h_weld.C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                    else
                        h_weld.C0 = CFrame.new(0, -1, -1.5) * CFrame.Angles(math.rad(-90), 0, 0)
                    end
                end
            end)

            troll_tool.Unequipped:Connect(function()
                mm2_lock = false -- РАЗМОРАЖИВАЕМ
                if h_weld then h_weld:Destroy() h_weld = nil end
                if h_obj then
                    local w = h_obj:FindFirstChildWhichIsA("Weld") or h_obj:FindFirstChild("AccessoryWeld")
                    if w then w.Enabled = true end
                end
            end)
        else
            mm2_lock = false
            if troll_tool then troll_tool:Destroy() troll_tool = nil end
            if h_weld then h_weld:Destroy() h_weld = nil end
            h_obj = nil
        end
    end
})




-- Noclip (Исправленный)
local function toggleNoclip(s)
    noclip = s
    if noclip then
        noclipConn = RunService.Stepped:Connect(function()
            if player.Character then
                for _, p in pairs(player.Character:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end
        end)
    else
        if noclipConn then noclipConn:Disconnect() end
        if player.Character then
            for _, p in pairs(player.Character:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = true end
            end
            local h = player.Character:FindFirstChildOfClass("Humanoid")
            if h then 
                h:ChangeState(Enum.HumanoidStateType.Running)
                h:ChangeState(Enum.HumanoidStateType.Landed)
            end
        end
    end
end

MainSection:Toggle({
    Title = "Noclip",
    Callback = function(s) toggleNoclip(s) end
})

-- FLY (IY Style)
local function getFlyDir()
    local cam = workspace.CurrentCamera.CFrame
    local look = Vector3.new(0,0,0)
    if UIS:IsKeyDown("W") then look = look + cam.LookVector end
    if UIS:IsKeyDown("S") then look = look - cam.LookVector end
    if UIS:IsKeyDown("A") then look = look - cam.LookVector:Cross(cam.UpVector) end
    if UIS:IsKeyDown("D") then look = look + cam.LookVector:Cross(cam.UpVector) end
    if UIS:IsKeyDown("Space") then look = look + Vector3.new(0,1,0) end
    if UIS:IsKeyDown("LeftShift") then look = look - Vector3.new(0,1,0) end
    return look
end

local function startFly()
    local root = player.Character:WaitForChild("HumanoidRootPart")
    local bv = Instance.new("BodyVelocity", root)
    bv.Name = "YieldFlyBV"
    bv.MaxForce = Vector3.new(1,1,1) * math.huge
    local bg = Instance.new("BodyGyro", root)
    bg.Name = "YieldFlyBG"
    bg.MaxTorque = Vector3.new(1,1,1) * math.huge
    player.Character.Humanoid.PlatformStand = true
    flyConn = RunService.RenderStepped:Connect(function()
        bv.Velocity = getFlyDir() * flySpeed
        bg.CFrame = workspace.CurrentCamera.CFrame
    end)
end

local function stopFly()
    if flyConn then flyConn:Disconnect() end
    local char = player.Character
    if char then
        char.Humanoid.PlatformStand = false
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            if root:FindFirstChild("YieldFlyBV") then root.YieldFlyBV:Destroy() end
            if root:FindFirstChild("YieldFlyBG") then root.YieldFlyBG:Destroy() end
        end
    end
end

local FlySection = Tab:Section({ Title = "Flight" })
FlySection:Toggle({
    Title = "Fly",
    Callback = function(s) flying = s if s then startFly() else stopFly() end end
})
FlySection:Input({
    Title = "Fly Speed",
    Callback = function(t) flySpeed = tonumber(t) or 50 end
})

local VisualTab = Window:Tab({ Title = "Visuals", Icon = "eye" })
local VisSection = VisualTab:Section({ Title = "World & Players" })

local esp_on, tags_on = false, false

-- ФУНКЦИЯ ОЧИСТКИ (Чтобы не забивать память)
local function clearVisuals(plr)
    if plr.Character then
        local oldESP = plr.Character:FindFirstChild("YieldESP")
        local oldTag = plr.Character:FindFirstChild("Head") and plr.Character.Head:FindFirstChild("YieldTag")
        if oldESP then oldESP:Destroy() end
        if oldTag then oldTag:Destroy() end
    end
end

-- ГЛАВНАЯ ФУНКЦИЯ ОТРИСОВКИ
local function applyVisuals(plr)
    if plr == game.Players.LocalPlayer or not plr.Character then return end
    clearVisuals(plr) -- Удаляем старое перед созданием нового

    local teamColor = plr.Team and plr.TeamColor.Color or Color3.new(1, 1, 1)

    -- ESP (Силуэт)
    if esp_on then
        local highlight = Instance.new("Highlight", plr.Character)
        highlight.Name = "YieldESP"
        highlight.FillColor = teamColor
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.FillTransparency = 0.5
        highlight.Adornee = plr.Character -- Принудительная привязка
    end

    -- NAMETAGS (Ник + HP)
    if tags_on then
        local head = plr.Character:WaitForChild("Head", 5)
        if head then
            local billboard = Instance.new("BillboardGui", head)
            billboard.Name = "YieldTag"
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.AlwaysOnTop = true

            local label = Instance.new("TextLabel", billboard)
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(1, 0, 1, 0)
            label.Text = plr.Name .. " [" .. math.floor(plr.Character:FindFirstChildOfClass("Humanoid").Health) .. "]"
            label.TextColor3 = teamColor
            label.TextStrokeTransparency = 0
            label.TextSize = 14
            label.Font = Enum.Font.SourceSansBold
        end
    end
end

-- ОБРАБОТКА ВСЕХ ИГРОКОВ (Старых и новых)
local function trackPlayer(plr)
    plr.CharacterAdded:Connect(function()
        task.wait(1.5) -- Увеличенная задержка для загрузки всех частей тела
        applyVisuals(plr)
    end)
    if plr.Character then applyVisuals(plr) end
end

game.Players.PlayerAdded:Connect(trackPlayer)
for _, p in pairs(game.Players:GetPlayers()) do trackPlayer(p) end

-- РЫЧАГИ УПРАВЛЕНИЯ
VisSection:Toggle({
    Title = "Player ESP",
    Callback = function(s)
        esp_on = s
        for _, p in pairs(game.Players:GetPlayers()) do applyVisuals(p) end
    end
})

VisSection:Toggle({
    Title = "Nametags",
    Callback = function(s)
        tags_on = s
        for _, p in pairs(game.Players:GetPlayers()) do applyVisuals(p) end
    end
})

local fb_on = false
local lighting = game:GetService("Lighting")

-- ФУНКЦИЯ FULLBRIGHT (Постоянный цикл)
task.spawn(function()
    while task.wait(0.5) do
        if fb_on then
            lighting.Brightness = 2
            lighting.ClockTime = 14
            lighting.FogEnd = 100000
            lighting.GlobalShadows = false
            lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        end
    end
end)

VisSection:Toggle({
    Title = "FullBright",
    Callback = function(s)
        fb_on = s
        if not s then
            -- Возврат к стандарту
            lighting.Brightness = 1
            lighting.ClockTime = 12
            lighting.FogEnd = 1000
            lighting.GlobalShadows = true
            lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
        end
    end
})

local MiscTab = Window:Tab({
    Title = "Misc",
    Icon = "settings",
})

local MiscSection = MiscTab:Section({ Title = "Utilities" })

local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local antiafk_conn

local function toggleAntiAFK(state)
    if state then
        antiafk_conn = player.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    else
        if antiafk_conn then antiafk_conn:Disconnect() end
    end
end

MiscSection:Toggle({
    Title = "Anti-AFK",
    Desc = "Защита от кика за бездействие",
    Callback = function(state)
        toggleAntiAFK(state)
    end
})

MiscSection:Button({
    Title = "Rejoin",
    Desc = "Перезайти на текущий сервер",
    Callback = function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
    end
})

MiscSection:Button({
    Title = "Server Hop",
    Desc = "Найти другой сервер",
    Callback = function()
        local servers = {}
        local req = httprequest({Url = string.format("https://games.roblox.com", game.PlaceId)})
        local body = HttpService:JSONDecode(req.Body)
        
        if body and body.data then
            for i, v in pairs(body.data) do
                if type(v) == "table" and v.playing < v.maxPlayers and v.id ~= game.JobId then
                    table.insert(servers, v.id)
                end
            end
        end
        
        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], player)
        end
    end
})

local PlayersTab = Window:Tab({
    Title = "Players",
    Icon = "users",
})

local PlayerSection = PlayersTab:Section({ Title = "Player Actions" })

local selectedPlayer = nil

PlayerSection:Input({
    Title = "Select Player",
    Desc = "Введите ник игрока (можно часть)",
    Placeholder = "Ник...",
    Callback = function(text)
        for _, p in pairs(game.Players:GetPlayers()) do
            if string.find(string.lower(p.Name), string.lower(text)) or string.find(string.lower(p.DisplayName), string.lower(text)) then
                selectedPlayer = p
                break
            end
        end
    end
})

PlayerSection:Button({
    Title = "Teleport To",
    Desc = "Телепортироваться к выбранному игроку",
    Callback = function()
        if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = selectedPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
        end
    end
})

local spectating = false
PlayerSection:Toggle({
    Title = "Spectate",
    Desc = "Наблюдать за игроком",
    Callback = function(state)
        spectating = state
        if spectating and selectedPlayer and selectedPlayer.Character then
            workspace.CurrentCamera.CameraSubject = selectedPlayer.Character.Humanoid
        else
            workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
        end
    end
})

PlayerSection:Button({
    Title = "Goto Spawn",
    Desc = "Телепортация на спавн без смерти",
    Callback = function()
        local spawnLoc = workspace:FindFirstChildOfClass("SpawnLocation") 
        if not spawnLoc then
            -- Если обычного спавна нет, ищем в папках (часто бывает в плейсах)
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("SpawnLocation") then
                    spawnLoc = v
                    break
                end
            end
        end

        if spawnLoc and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = spawnLoc.CFrame * CFrame.new(0, 5, 0)
        else
            print("Спавн не найден на этой карте!")
        end
    end
})

PlayerSection:Button({
    Title = "FE Bring (Any Tool)",
    Desc = "Работает с ЛЮБЫМ предметом в руках",
    Callback = function()
        local tool = player.Character:FindFirstChildOfClass("Tool")
        if not tool then 
            print("Возьми ЛЮБОЙ предмет в руки!") 
            return 
        end
        
        local target = selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart")
        local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildWhichIsA("BasePart")
        
        if target and handle then
            -- Метод захвата через "подмену" позиции предмета
            for i = 1, 15 do
                -- Мы принудительно ставим предмет ВНУТРЬ игрока
                handle.CFrame = target.CFrame
                firetouchinterest(target, handle, 0) -- Касание
                firetouchinterest(target, handle, 1) -- Отпускание
                
                -- Пытаемся плавно притянуть его к себе
                target.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2)
                task.wait(0.02)
            end
        end
    end
})


local CombatTab = Window:Tab({
    Title = "Combat",
    Icon = "swords",
})

local CombatSection = CombatTab:Section({ Title = "Hitbox Settings" })

local hb_enabled = false
local hb_size = 2
local hb_transparency = 0.7

local function updateHitboxes()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character then
            local target = p.Character:FindFirstChild("HumanoidRootPart")
            if target and target:IsA("BasePart") then
                if hb_enabled then
                    -- ЛОГИКА ЦВЕТА КОМАНДЫ (как в твоем ESP)
                    local teamColor = p.Team and p.TeamColor.Color or Color3.new(1, 1, 1)
                    
                    target.Size = Vector3.new(hb_size, hb_size, hb_size)
                    target.Transparency = hb_transparency
                    target.Color = teamColor -- Устанавливаем цвет команды
                    target.Material = Enum.Material.Neon
                    target.CanCollide = false
                else
                    -- Возврат к стандарту
                    target.Size = Vector3.new(2, 2, 1)
                    target.Transparency = 1
                    target.Material = Enum.Material.Plastic
                    target.Color = Color3.new(1, 1, 1) -- Сброс на белый
                end
            end
        end
    end
end

CombatSection:Toggle({
    Title = "Enable Hitbox Expander",
    Callback = function(state)
        hb_enabled = state
        updateHitboxes()
    end
})

CombatSection:Input({
    Title = "Hitbox Size",
    Desc = "Размер куба (напр. 10 или 20) + ENTER",
    Callback = function(v)
        hb_size = tonumber(v) or 2
        if hb_enabled then updateHitboxes() end
    end
})

CombatSection:Input({
    Title = "Hitbox Transparency",
    Desc = "Прозрачность от 0 до 1 (напр. 0.5) + ENTER",
    Callback = function(v)
        hb_transparency = tonumber(v) or 0.7
        if hb_enabled then updateHitboxes() end
    end
})

-- Авто-обновление при респавне
game.Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function()
        task.wait(1)
        if hb_enabled then updateHitboxes() end
    end)
end)

local clickTP_on = false
local UIS = game:GetService("UserInputService")

local function performClickTP()
    local mouse = player:GetMouse()
    if clickTP_on and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local targetPos = mouse.Hit.p
        -- Смещение вверх на 3 студа, чтобы не застрять в полу
        player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos) + Vector3.new(0, 3, 0)
    end
end

-- Слушатель клика мыши
UIS.InputBegan:Connect(function(input, proc)
    if not proc and input.UserInputType == Enum.UserInputType.MouseButton1 then
        if clickTP_on then
            performClickTP()
        end
    end
end)

MainSection:Toggle({
    Title = "Click TP",
    Desc = "Телепортация в точку клика мышки",
    Callback = function(state)
        clickTP_on = state
    end
})

local flinging = false
local oldPos = nil

-- ФУНКЦИЯ ЗАПУСКА
local function startFling()
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root or not selectedPlayer or not selectedPlayer.Character then return end

    oldPos = root.CFrame 
    flinging = true

    local bV = Instance.new("BodyVelocity", root)
    bV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bV.Velocity = Vector3.new(9e9, 9e9, 9e9)

    local bAV = Instance.new("BodyAngularVelocity", root)
    bAV.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bAV.AngularVelocity = Vector3.new(99999, 99999, 99999)

    local noclip = game:GetService("RunService").Stepped:Connect(function()
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end)

    task.spawn(function()
        while flinging and selectedPlayer and selectedPlayer.Character do
            local tRoot = selectedPlayer.Character:FindFirstChild("HumanoidRootPart")
            local tHum = selectedPlayer.Character:FindFirstChildOfClass("Humanoid")

            if tRoot and tHum and tHum.Health > 0 then
                root.CFrame = tRoot.CFrame * CFrame.Angles(math.random(), math.random(), math.random())
                if (tRoot.Position - oldPos.p).Magnitude > 400 or tRoot.Position.Y < -50 then break end
            else
                break
            end
            task.wait()
        end

        flinging = false
        if noclip then noclip:Disconnect() end
        if bV then bV:Destroy() end
        if bAV then bAV:Destroy() end
        
        root.Velocity = Vector3.new(0, 0, 0)
        root.RotVelocity = Vector3.new(0, 0, 0)
        root.Anchored = true
        task.wait(0.1)
        
        -- ВОЗВРАТ НА 5 СТУДОВ ВЫШЕ
        root.CFrame = oldPos + Vector3.new(0, 5, 0)
        
        task.wait(0.1)
        root.Anchored = false
        
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end)
end

-- КНОПКИ ДЛЯ МЕНЮ
PlayerSection:Button({
    Title = "Fling Target",
    Desc = "Ударить и вернуться на 5 выше",
    Callback = function()
        startFling()
    end
})

PlayerSection:Button({
    Title = "Stop Fling",
    Desc = "Остановить атаку немедленно",
    Callback = function()
        flinging = false
    end
})

local hip_val = 0

-- Цикл для принудительного удержания HipHeight
RunService.RenderStepped:Connect(function()
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        -- Если значение изменено, применяем его постоянно
        if hip_val ~= 0 then
            hum.HipHeight = hip_val
        end
    end
end)

MainSection:Input({
    Title = "HipHeight",
    Desc = "Высота над землей (напр. 5 или 10) + ENTER",
    Placeholder = "0 - стандарт",
    Callback = function(t)
        local num = tonumber(t)
        if num then
            hip_val = num
            local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.HipHeight = num end
        end
    end
})

MainSection:Input({
    Title = "Gravity",
    Desc = "Стандарт: 196.2. Введи число и нажми ENTER",
    Placeholder = "Напр: 50",
    Callback = function(text)
        local num = tonumber(text)
        if num then
            workspace.Gravity = num
        end
    end
})

local af_on = false
local af_conn

local function toggleAF(s)
    af_on = s
    if s then
        af_conn = game:GetService("RunService").Stepped:Connect(function()
            if not af_on then return end
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= player and p.Character then
                    for _, part in pairs(p.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                            part.Velocity = Vector3.new(0, 0, 0)
                            part.RotVelocity = Vector3.new(0, 0, 0)
                        end
                    end
                end
            end
        end)
    else
        if af_conn then af_conn:Disconnect() end
    end
end

MiscSection:Toggle({
    Title = "Anti-Fling",
    Desc = "Защита от летящих в тебя читеров",
    Callback = function(s) toggleAF(s) end
})

local antikick_on = false
local old_nc

local function toggleAntiKick(state)
    antikick_on = state
    if state then
        -- Перехватываем системные вызовы игры
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        old_nc = mt.__namecall
        
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if antikick_on and tostring(method):lower() == "kick" and self == player then
                print("SuperYield: Попытка кика заблокирована!")
                return nil -- Просто игнорируем вызов Kick
            end
            return old_nc(self, ...)
        end)
        setreadonly(mt, true)
    else
        -- Возвращаем всё как было (если нужно)
        antikick_on = false
    end
end

MiscSection:Toggle({
    Title = "Anti-Kick",
    Desc = "Блокирует попытки игры выкинуть тебя (Local Kick)",
    Callback = function(state)
        toggleAntiKick(state)
    end
})

local fast_remotes = false

local function toggleOptimizer(state)
    fast_remotes = state
    if state then
        -- Увеличиваем частоту обновления данных персонажа для сервера
        settings().Physics.AllowSleep = false
        settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
        
        -- Делаем входящие данные от сервера мгновенными (убирает задержку ESP)
        sethiddenproperty(player, "SimulationRadius", 1000)
        sethiddenproperty(player, "MaxSimulationRadius", 1000)
    else
        settings().Physics.AllowSleep = true
        settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Default
    end
end

MiscSection:Toggle({
    Title = "Performance Booster",
    Desc = "Убирает задержки (Ping/Lag) для функций чита",
    Callback = function(state)
        toggleOptimizer(state)
    end
})

local orbit_on = false
local orbit_speed = 1.8 -- Плавная скорость
local radius_x = 1.3 
local radius_y = 2.5 
local offset_z = 1.4 
local angle = 0

local EffectsTab = Window:Tab({ Title = "Effects", Icon = "sparkles" })
local OrbitSection = EffectsTab:Section({ Title = "Ritual Orbit Settings" })

-- ГЛАВНЫЙ ЦИКЛ (FE)
game:GetService("RunService").Stepped:Connect(function(dt)
    if orbit_on and player.Character then
        local root = player.Character:FindFirstChild("HumanoidRootPart")
        
        -- АВТО-ПОИСК
        local targetAcc = nil
        for _, v in pairs(player.Character:GetChildren()) do
            if v:IsA("Accessory") and (string.find(v.Name:lower(), "health") or string.find(v.Name:lower(), "bar")) then
                targetAcc = v
                break
            end
        end
        
        if root and targetAcc and targetAcc:FindFirstChild("Handle") then
            local handle = targetAcc.Handle
            
            for _, joint in pairs(handle:GetChildren()) do
                if joint:IsA("Weld") or joint:IsA("ManualWeld") or joint:IsA("WeldConstraint") then
                    joint.Enabled = false
                end
            end

            angle = angle + (orbit_speed * dt)
            
            local x = math.sin(angle) * radius_x
            local y = math.cos(angle) * radius_y + 1.2
            
            handle.CFrame = root.CFrame * CFrame.new(x, y, offset_z) * CFrame.Angles(0, 0, math.rad(90))
        end
    end
end)

-- ПЕРЕКЛЮЧАТЕЛЬ
OrbitSection:Toggle({
    Title = "Back Ritual Orbit (FE)",
    Desc = "Включить вертикальное вращение",
    Callback = function(state) orbit_on = state end
})

-- НАСТРОЙКИ ЧЕРЕЗ ВВОД ТЕКСТА
OrbitSection:Input({
    Title = "Rotation Speed",
    Placeholder = "1.8 (рекомендую)",
    Callback = function(t) orbit_speed = tonumber(t) or 1.8 end
})

OrbitSection:Input({
    Title = "Orbit Width (X)",
    Placeholder = "1.3",
    Callback = function(t) radius_x = tonumber(t) or 1.3 end
})

OrbitSection:Input({
    Title = "Orbit Height (Y)",
    Placeholder = "2.5",
    Callback = function(t) radius_y = tonumber(t) or 2.5 end
})

OrbitSection:Input({
    Title = "Distance (Z)",
    Placeholder = "1.4",
    Callback = function(t) offset_z = tonumber(t) or 1.4 end
})

local glitch_on = false

local function runGlitch()
    task.spawn(function()
        while glitch_on do
            -- 1. Короткая пауза (4-9 секунд)
            task.wait(math.random(2, 3))
            
            if not glitch_on then break end

    local TweenService = game:GetService("TweenService")
local h_active = false
local h_ob        -- 2. Быстрый "электрический" разряд (0.3 - 0.5 сек)
            for i = 1, math.random(4, 8) do
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        -- Резкие скачки прозрачности (от почти невидимого до обычного)
                        part.LocalTransparencyModifier = math.random(1, 9) / 10
                    end
                end
                task.wait(0.02) -- Ультра-скорость помех
            end

            -- 3. Мгновенный возврат в норму
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.LocalTransparencyModifier = 0
                end
            end
        end
    end)
end

OrbitSection:Toggle({
    Title = "Glitch Aura (Unstable)",
    Desc = "Частые помехи Guest 666 (раз в 4-9 сек)",
    Callback = function(s) 
        glitch_on = s 
        if s then runGlitch() end
    end
})

-- 1. ГЛАВНЫЕ ПЕРЕМЕННЫЕ
local player = game:GetService("Players").LocalPlayer
local h_active = false
local h_obj = nil
local h_weld = nil 
local is_striking = false

-- 2. СЕКЦИЯ В ТВОЕМ МЕНЮ ( WindUI )
local HammerFinalSection = EffectsTab:Section({ Title = "Admin Weapon" })

-- 3. ФУНКЦИЯ ЗАКРЕПЛЕНИЯ (МЕРТВАЯ СВАРКА К КИСТИ)
local function equipHammer()
    local char = player.Character
    local hand = char and (char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm"))
    if not hand then return end

    if not h_obj or h_obj.Parent == nil then
        for _, v in pairs(char:GetChildren()) do
            if v:IsA("Accessory") and (v:FindFirstChild("Handle") and v.Handle:FindFirstChild("WaistAttachment") or v.AccessoryType == Enum.AccessoryType.Waist) then
                h_obj = v:FindFirstChildWhichIsA("BasePart") or v:FindFirstChild("Handle")
                break 
            end
        end
    end

    if h_obj then
        local oldWeld = h_obj:FindFirstChildWhichIsA("Weld") or h_obj:FindFirstChild("AccessoryWeld")
        if oldWeld then oldWeld.Enabled = false end
        h_obj.CanCollide = false
        h_obj.Massless = true
        
        if h_weld then h_weld:Destroy() end
        h_weld = Instance.new("Weld")
        h_weld.Part0 = hand
        h_weld.Part1 = h_obj
        h_weld.C0 = CFrame.new(0, -1, -1.5) * CFrame.Angles(math.rad(-90), 0, 0)
        h_weld.Parent = h_obj
    end
end

-- 4. АНИМАЦИЯ ТОЛЬКО ПРАВОЙ РУКИ ( Right Shoulder C0 )
local function playArmStrike()
    if is_striking or not h_active then return end
    local char = player.Character
    -- Находим плечевой сустав, который держит всю выделенную руку
    local shoulder = char and (char:FindFirstChild("Right Shoulder", true) or char:FindFirstChild("RightShoulder", true))
    
    if shoulder then
        is_striking = true
        local oldC0 = shoulder.C0
        -- Траектория из видео (Дуга вверх -> Удар вниз)
        local pose_up = oldC0 * CFrame.Angles(math.rad(115), 0, math.rad(-25))
        local pose_down = oldC0 * CFrame.Angles(math.rad(-75), 0, math.rad(-15))
        
        task.spawn(function()
            -- 1. ЗАМАХ (Вся рука идет вверх)
            for i = 0, 1, 0.2 do
                if not h_active then break end
                shoulder.C0 = shoulder.C0:Lerp(pose_up, i)
                task.wait(0.01)
            end
            task.wait(0.04)
            -- 2. УДАР (Вся рука рубит вниз)
            for i = 0, 1, 0.4 do
                if not h_active then break end
                shoulder.C0 = shoulder.C0:Lerp(pose_down, i)
                task.wait(0.01)
            end
            task.wait(0.12)
            -- 3. ВОЗВРАТ
            for i = 0, 1, 0.1 do
                if not h_active then break end
                shoulder.C0 = shoulder.C0:Lerp(oldC0, i)
                task.wait(0.01)
            end
            shoulder.C0 = oldC0
            is_striking = false
        end)
    end
end

-- 5. ТВОЙ TOGGLE
HammerFinalSection:Toggle({
    Title = "Equip Isolated Hammer",
    Desc = "Анимация выделенной руки. 0% переворотов.",
    Callback = function(state)
        h_active = state
        if state then equipHammer() else
            if h_weld then h_weld:Destroy() h_weld = nil end
            if h_obj then
                local w = h_obj:FindFirstChildWhichIsA("Weld") or h_obj:FindFirstChild("AccessoryWeld")
                if w then w.Enabled = true end
            end
            h_obj = nil
        end
    end
})

-- КЛИК
player:GetMouse().MouseButton1Down:Connect(function()
    if h_active then playArmStrike() end
end)

-- 1. ГЛАВНЫЕ ПЕРЕМЕННЫЕ
local player = game:GetService("Players").LocalPlayer
local h_obj, h_weld, troll_tool = nil, nil, nil

-- 2. СОЗДАНИЕ СЕКЦИИ (СТРОГО ПО ТВОЕМУ ПРИМЕРУ)
local TrollSection = Tab:Section({ Title = "Troll Admin Arsenal" })

-- 3. ФУНКЦИЯ ЗАКРЕПЛЕНИЯ (МЕТОД C0 - БЕЗ ПЕРЕВОРОТОВ)
local function equipHammer()
    local char = player.Character
    local hand = char and (char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm"))
    if not hand then return end

    -- Поиск поясного молота (Waist)
    if not h_obj or h_obj.Parent == nil then
        for _, v in pairs(char:GetChildren()) do
            if v:IsA("Accessory") and (v:FindFirstChild("Handle") and v.Handle:FindFirstChild("WaistAttachment") or v.AccessoryType == Enum.AccessoryType.Waist) then
                h_obj = v:FindFirstChildWhichIsA("BasePart") or v:FindFirstChild("Handle")
                break 
            end
        end
    end

    if h_obj then
        -- Отключаем старую сварку
        local oldWeld = h_obj:FindFirstChildWhichIsA("Weld") or h_obj:FindFirstChild("AccessoryWeld")
        if oldWeld then oldWeld.Enabled = false end
        h_obj.CanCollide = false
        h_obj.Massless = true
        
        -- ПРИВАРИВАЕМ К РУКЕ ЧЕРЕЗ C0
        if h_weld then h_weld:Destroy() end
        h_weld = Instance.new("Weld", h_obj)
        h_weld.Part0 = hand
        h_weld.Part1 = h_obj
        -- Настройка хвата молота (C0)
        h_weld.C0 = CFrame.new(0, -1, -1.5) * CFrame.Angles(math.rad(-90), 0, 0)
    end
end

-- 4. ТВОЯ КНОПКА ( ТЕПЕРЬ 100% В МЕНЮ )
TrollSection:Toggle({
    Title = "Get FAKE KNIFE (MM2 Style)",
    Desc = "Добавляет нож в инвентарь. Взял - молот в руках.",
    Callback = function(state)
        if state then
            -- СОЗДАЕМ ПРЕДМЕТ В ИНВЕНТАРЕ (MM2 Style)
            troll_tool = Instance.new("Tool")
            troll_tool.Name = "FAKE KNIFE"
            troll_tool.RequiresHandle = false
            troll_tool.Parent = player.Backpack
            
            -- ЛОГИКА ЭКИПИРОВКИ
            troll_tool.Equipped:Connect(equipHammer)
            troll_tool.Unequipped:Connect(function()
                if h_weld then h_weld:Destroy() h_weld = nil end
                if h_obj then
                    -- Возвращаем молот на пояс
                    local w = h_obj:FindFirstChildWhichIsA("Weld") or h_obj:FindFirstChild("AccessoryWeld")
                    if w then w.Enabled = true end
                end
            end)
        else
            -- УДАЛЯЕМ ПРЕДМЕТ
            if troll_tool then troll_tool:Destroy() troll_tool = nil end
            if h_weld then h_weld:Destroy() h_weld = nil end
            h_obj = nil
        end
    end
})


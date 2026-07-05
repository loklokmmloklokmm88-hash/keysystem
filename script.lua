-- ⚠️ IMPORTANT: Put this code at the VERY TOP of your Main Script (before obfuscating) ⚠️

local ProtectionConfig = {
    -- 🔴 CRITICAL: This MUST exactly match the 'Secret' value in your Key System's Config!
    -- If your Key System has: Secret = "Test"
    -- Then this must also be: SecretKey = "Test"
    SecretKey = "c00l",
    
    -- The name of your Hub (shown in the kick message if they try to bypass)
    HubName = "c00lgui"
}

-- Anti-Bypass Logic: Checks if the Key System successfully set the global variable
if not _G[ProtectionConfig.SecretKey] then
    local player = game:GetService("Players").LocalPlayer
    if player then
        player:Kick("\n🛡️ Unauthorized Execution 🛡️\n\nPlease use the official Key System to run " .. ProtectionConfig.HubName)
    end
    return -- Stops the rest of the script from loading!
end

-------------------------------------------------------------------------------
-- 👇 YOUR MAIN SCRIPT CODE STARTS HERE 👇
-------------------------------------------------------------------------------

print(ProtectionConfig.HubName .. " Loaded Successfully!")

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- [DÜZELTİLDİ] Aimbot ilk açıldığında kafaya kilitlenmesi için varsayılan değer eklendi
_G.aimTargetPart = "Head"

if CoreGui:FindFirstChild("PcPremiumVipMenu") then CoreGui.PcPremiumVipMenu:Destroy() end

 
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PcPremiumVipMenu"
ScreenGui.Parent = CoreGui
 
-- Sol Alttaki Yuvarlak Aç/Kapat Butonu (★)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 20, 1, -65)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 0, 50)
ToggleBtn.Text = "★"
ToggleBtn.TextSize = 22
ToggleBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local btnStroke = Instance.new("UIStroke", ToggleBtn)
btnStroke.Color = Color3.fromRGB(255, 0, 50)
btnStroke.Thickness = 1.5
ToggleBtn.Parent = ScreenGui
 
-- ANA PANEL (Gelişmiş Premium PC Tasarımı)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 540, 0, 360)
MainFrame.Position = UDim2.new(0, 20, 1, 100) 
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.BorderSizePixel = 0
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
 
-- SMOOTH YAVAS RGB ÇİZGİ
local RgbStroke = Instance.new("UIStroke", MainFrame)
RgbStroke.Thickness = 1.8
RgbStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainFrame.Parent = ScreenGui
 
task.spawn(function()
    local counter = 0
    while task.wait(0.02) do
        counter = counter + 0.002
        RgbStroke.Color = Color3.fromHSV(counter % 1, 1, 1)
    end
end)
 
-- Pürüzsüz Sürükleme (Smooth Drag)
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPos = MainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
MainFrame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        TweenService:Create(MainFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play()
    end
end)
 
-- Üst Başlık Çubuğu
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
TitleBar.BorderSizePixel = 0
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 8)
 
local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.Font = Enum.Font.GothamBold
Title.Text = "C00LGUI v45.6 // ULTRA PANEL"
Title.TextXAlignment = Enum.TextXAlignment.Left
 
-- Yan Menü (Sidebar)
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Size = UDim2.new(0, 140, 1, -38)
Sidebar.Position = UDim2.new(0, 0, 0, 38)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Sidebar.BorderSizePixel = 0
 
-- İçerik Kutusu (Container)
local Container = Instance.new("Frame", MainFrame)
Container.Size = UDim2.new(1, -150, 1, -48)
Container.Position = UDim2.new(0, 145, 0, 43)
Container.BackgroundTransparency = 1
 
-- Sekme Sistemi
local pages = {}
local function createPage(name)
    local page = Instance.new("ScrollingFrame", Container)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 1
    page.Visible = false
    
    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 8)
    
    -- [TAMİR EDİLDİ] Sayfaya ne kadar çok buton eklersen ekle, boyutu otomatik aşağı doğru uzatır!
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 25)
    end)
    
    pages[name] = page
    return page
end
 
local function createTabButton(name, index)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(1, -14, 0, 34)
    btn.Position = UDim2.new(0, 7, 0, 8 + (index * 38))
    btn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    btn.TextColor3 = Color3.fromRGB(160, 160, 160)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 11
    btn.Text = name
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
 
    btn.MouseButton1Click:Connect(function()
        for k, v in pairs(pages) do v.Visible = false end
        for _, sBtn in pairs(Sidebar:GetChildren()) do 
            if sBtn:IsA("TextButton") then sBtn.TextColor3 = Color3.fromRGB(160, 160, 160) sBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 22) end
        end
        pages[name].Visible = true
        btn.TextColor3 = Color3.fromRGB(255, 0, 50)
        btn.BackgroundColor3 = Color3.fromRGB(28, 16, 18)
    end)
    if index == 0 then pages[name].Visible = true btn.TextColor3 = Color3.fromRGB(255, 0, 50) btn.BackgroundColor3 = Color3.fromRGB(28, 16, 18) end
end
 
local combatPage = createPage("Savaş / Makro")
local motionPage = createPage("Hareket Hileleri")
local visualPage = createPage("Görüş / ESP")
local tpPage = createPage("Işınlanma")
local configPage = createPage("Ayarlar")
local funPage = createPage("Fun / Eğlence")
local executorPage = createPage("Executor")

createTabButton("Savaş / Makro", 0)
createTabButton("Hareket Hileleri", 1)
createTabButton("Görüş / ESP", 2)
createTabButton("Işınlanma", 3)
createTabButton("Fun / Eğlence", 5)
createTabButton("Ayarlar", 6)
createTabButton("Executor", 4)

 
-- Eleman Oluşturucular
local function addToggle(page, labelText, desc, callback)
    local frame = Instance.new("Frame", page)
    frame.Size = UDim2.new(1, -5, 0, 48)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 5)
 
    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(1, -70, 0, 25)
    lbl.Position = UDim2.new(0, 10, 0, 3)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(240, 240, 240)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 12
    lbl.Text = labelText
    lbl.TextXAlignment = Enum.TextXAlignment.Left
 
    local dsc = Instance.new("TextLabel", frame)
    dsc.Size = UDim2.new(1, -70, 0, 15)
    dsc.Position = UDim2.new(0, 10, 0, 24)
    dsc.BackgroundTransparency = 1
    dsc.TextColor3 = Color3.fromRGB(140, 140, 140)
    dsc.Font = Enum.Font.Gotham
    dsc.TextSize = 10
    dsc.Text = desc
    dsc.TextXAlignment = Enum.TextXAlignment.Left
 
    local tgl = Instance.new("TextButton", frame)
    tgl.Size = UDim2.new(0, 50, 0, 24)
    tgl.Position = UDim2.new(1, -60, 0, 12)
    tgl.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    tgl.TextColor3 = Color3.fromRGB(200, 200, 200)
    tgl.Font = Enum.Font.SourceSansBold
    tgl.TextSize = 12
    tgl.Text = "KAPALI"
    Instance.new("UICorner", tgl).CornerRadius = UDim.new(0, 4)
 
    local state = false
    tgl.MouseButton1Click:Connect(function()
        state = not state
        tgl.Text = state and "AÇIK" or "KAPALI"
        tgl.BackgroundColor3 = state and Color3.fromRGB(255, 0, 50) or Color3.fromRGB(35, 35, 35)
        tgl.TextColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
        callback(state)
    end)
end
 
local function addSlider(page, labelText, min, max, default, callback)
    local frame = Instance.new("Frame", page)
    frame.Size = UDim2.new(1, -5, 0, 52)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 5)
 
    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(1, -20, 0, 25)
    lbl.Position = UDim2.new(0, 10, 0, 3)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(240, 240, 240)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 12
    lbl.Text = labelText .. " (Değer: " .. default .. ")"
    lbl.TextXAlignment = Enum.TextXAlignment.Left
 
    local sliderFrame = Instance.new("Frame", frame)
    sliderFrame.Size = UDim2.new(1, -20, 0, 6)
    sliderFrame.Position = UDim2.new(0, 10, 0, 34)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", sliderFrame).CornerRadius = UDim.new(1, 0)
 
    local fill = Instance.new("Frame", sliderFrame)
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
 
    local sliderBtn = Instance.new("TextButton", sliderFrame)
    sliderBtn.Size = UDim2.new(0, 12, 0, 12)
    sliderBtn.Position = UDim2.new((default - min) / (max - min), -6, 0, -3)
    sliderBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderBtn.Text = ""
    Instance.new("UICorner", sliderBtn).CornerRadius = UDim.new(1, 0)
 
    local sliding = false
    sliderBtn.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = true end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = false end end)
 
    UserInputService.InputChanged:Connect(function(input)
        if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
            local relativeX = input.Position.X - sliderFrame.AbsolutePosition.X
            local percentage = math.clamp(relativeX / sliderFrame.AbsoluteSize.X, 0, 1)
            local val = math.floor(min + (percentage * (max - min)))
            lbl.Text = labelText .. " (Değer: " .. val .. ")"
            fill.Size = UDim2.new(percentage, 0, 1, 0)
            sliderBtn.Position = UDim2.new(percentage, -6, 0, -3)
            callback(val)
        end
    end)
end
 
local function addButton(page, labelText, callback)
 
 
local btn = Instance.new("TextButton", page)
btn.Size = UDim2.new(1, -5, 0, 36)
btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.Text = labelText
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
btn.MouseButton1Click:Connect(callback)
end
local function addTextBox(page, placeholder, callback)
local box = Instance.new("TextBox", page)
box.Size = UDim2.new(1, -5, 0, 36)
box.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.PlaceholderText = placeholder
box.Font = Enum.Font.Gotham
box.TextSize = 12
box.Text = ""
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 5)
box.FocusLost:Connect(function(enterPressed) if enterPressed then callback(box.Text) end end)
end

-- =====================================================================
-- [GÜNCELLENDİ] FE OYUNCU ÇARPIŞMASI (GÖRÜNMEZ PLATFORM BYPASS - %100 FE)
-- =====================================================================
local CollisionActive = false
local fakePlatform = nil

addToggle(funPage, "FE Oyuncu Çarpışması", "Açtığınızda diğer oyuncular kafanıza basıp zıplayabilir, üzerinizde durabilir!", function(state)
    CollisionActive = state
    
    -- Hile kapatıldığında görünmez platformu dünyadan tamamen siler
    if not CollisionActive then
        if fakePlatform then
            pcall(function() fakePlatform:Destroy() end)
            fakePlatform = nil
        end
    end
end)

-- Platformu her karede kafanın üstüne milimetrik ışınlayan motor
RunService.RenderStepped:Connect(function()
    local char = game.Players.LocalPlayer.Character
    local head = char and char:FindFirstChild("Head")
    
    if CollisionActive and head then
        pcall(function()
            -- Eğer platform henüz oluşturulmadıysa sıfırdan yarat
            if not fakePlatform or not fakePlatform.Parent then
                fakePlatform = Instance.new("Part")
                fakePlatform.Name = "SinirKriziCollisionPlate"
                fakePlatform.Size = Vector3.new(3, 0.2, 3) -- Üstünde rahat durulması için ideal genişlik
                fakePlatform.Transparency = 1 -- %100 Görünmez yapar, etrafı kirletmez
                fakePlatform.Anchored = true -- Havada sabit kalması için kilitle
                fakePlatform.CanCollide = true -- Katı nesne yapar, millet basabilsin!
                fakePlatform.Parent = workspace
            end
            
            -- Platformu tam kafanın üst çizgisine yerleştirir (Boyun bükülse bile kafayı takip eder)
            fakePlatform.CFrame = head.CFrame * CFrame.new(0, 1.2, 0)
        end)
    else
        -- Hile kapalıysa veya karakter öldüyse platformu gizle/temizle
        if fakePlatform then
            pcall(function() fakePlatform:Destroy() end)
            fakePlatform = nil
        end
    end
end)


-- =====================================================================
-- [GÜNCELLENDİ] ASLA DÜŞMEYEN CFRAME FE SPIN BOT (SLIDER UYUMLU - %100 FE)
-- =====================================================================
local SpinActive = false
local currentSpinSpeed = 10 -- Başlangıç dönüş hızı (CFrame için 10-15 arası idealdir)
local RunService = game:GetService("RunService")
local spinAngle = 0

-- 1. Açma / Kapama Butonumuz
addToggle(funPage, "Beyblade Spin Bot", "Açtığınızda karakteriniz kendi etrafında dönmeye başlar. Yürümeniz bozulmaz!", function(state)
    SpinActive = state
end)

-- 2. Hız Ayarlama Çubuğu (Slider)
-- CFrame dönüşü milimetrik olduğu için sınırları 1 ile 100 arasında çok daha hassas yaptım adamım!
addSlider(funPage, "Spin Bot Dönme Hızı", 1, 1000, 15, function(val)
    currentSpinSpeed = val
end)

-- Her karede karakteri fiziksel güce ihtiyaç duymadan ışık hızıyla döndüren motor
RunService.RenderStepped:Connect(function()
    if SpinActive then
        local char = game.Players.LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        
        if root and hum and hum.Health > 0 then
            -- Açıyı senin seçtiğin hız katsayısına göre her karede arttırır
            spinAngle = (spinAngle + currentSpinSpeed) % 360
            
            -- [KÖKTEN ÇÖZÜM] Fiziksel ivme verilmez! Karakterin duruş açısı anlık olarak havada çevrilir.
            -- Karakterin yön duygusunu bozmadan, kendi ekseninde kusursuz dönmesini sağlar.
            root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, math.rad(spinAngle), 0)
        end
    end
end)


-- =====================================================================
-- 1. SEKME: SAVAŞ VE MAKRO MODLARI (AIMBOT EKLENDİ)
-- =====================================================================

-- =====================================================================
-- [SAVAŞ] BASILI TUTUNCA ÇALIŞAN OTO CLICKER (M1 HOLD SPAMMER)
-- =====================================================================

local AutoClickerActive = false
local mouse = game.Players.LocalPlayer:GetMouse()
local uis = game:GetService("UserInputService")

-- Savaş sekmesindeki o şık yeni butonun
addToggle(combatPage, "M1 Oto Clicker (Basılı Tut)", "Açtıktan sonra sol tıka basılı tuttuğunuz sürece makro hızında sol tık spamlar.", function(state)
    AutoClickerActive = state
end)

-- Sol tıka basılı tutma durumunu milisaniyelik tarayan bağımsız canavar döngü
task.spawn(function()
    while true do
        -- Solara'yı dondurmaması ve sunucu korumasına takılmaması için mikro nefes alma süresi
        task.wait(0.01) 
        
        -- Eğer hile AKTİF ise VE oyuncu klavye/fare ile sol tıka (M1) basılı tutuyorsa
        if AutoClickerActive and uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            pcall(function()
                -- Solara'nın kendi donanımsal tıklama komutlarını tetikliyoruz
                if mouse1press and mouse1release then
                    mouse1press()
                    task.wait(0.005)
                    mouse1release()
                else
                    -- Eğer Solara o gün komutları kapattıysa B Planı (Zorla silah tetikleme)
                    local char = game.Players.LocalPlayer.Character
                    local tool = char and char:FindFirstChildOfClass("Tool")
                    if tool then tool:Activate() end
                end
            end)
        end
    end
end)

local fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 1.5
fovCircle.NumSides = 60
fovCircle.Radius = 150
fovCircle.Filled = false
fovCircle.Color = Color3.fromRGB(255, 0, 50)
fovCircle.Visible = false

local fovConnection
addToggle(combatPage, "Aimbot FOV Çemberi Göster", "Aimbotun kilitlenme alanını gösteren neon bir halka açar.", function(state)
    fovCircle.Visible = state
    if state then
        fovConnection = game:GetService("RunService").RenderStepped:Connect(function()
            fovCircle.Position = game:GetService("UserInputService"):GetMouseLocation()
        end)
    else
        if fovConnection then fovConnection:Disconnect() end
    end
end)

local aimbotEnabled = false
local camera = workspace.CurrentCamera
local teamCheckEnabled = true -- Varsayılan olarak takım koruması açık başlar

-- MANUEL KONTROLLÜ SAVAŞ MOTORU
local function getClosestPlayerInFOV()
    local closest, dist = nil, fovCircle.Radius
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild(_G.aimTargetPart) then
            
            -- BUTON AÇIKSA VE TAKIMLAR AYNIYSA BU OYUNCUYU PAS GEÇ
            if teamCheckEnabled and LocalPlayer.Team and p.Team and LocalPlayer.Team == p.Team then
                continue
            end
            
            local pos, onScreen = camera:WorldToScreenPoint(p.Character[_G.aimTargetPart].Position)
            if onScreen then
                local mouseLoc = game:GetService("UserInputService"):GetMouseLocation()
                local magnitude = (Vector2.new(pos.X, pos.Y) - mouseLoc).Magnitude
                if magnitude < dist then 
                    -- [TAMİR EDİLDİ] Butondan seçtiğin kemiğe (Kafa veya Gövde) milimetrik kilitlenir!
                    closest = p.Character:FindFirstChild(_G.aimTargetPart)
                    dist = magnitude 
                end
            end
        end
    end
    return closest
end
-- Aimbot Kilitlenme Döngüsü
game:GetService("RunService").RenderStepped:Connect(function()
    if aimbotEnabled then
        local target = getClosestPlayerInFOV()
        if target then 
            camera.CFrame = CFrame.new(camera.CFrame.Position, target.Position) 
        end
    end
end)

-- Savaş Sekmesi Elemanları
addToggle(combatPage, "Evrensel Cam-Aimbot", "SADECE ekrandaki FOV çemberinin içindeki en yakın düşmana otomatik kilitlenir.", function(state) 
    aimbotEnabled = state 
end)

addToggle(combatPage, "Hedef Modu (AÇIK: Kafa / KAPALI: Gövde)", "AÇIK ise direkt Kafaya (Headshot), KAPALI ise Gövdeye (Legit) kilitlenir.", function(state)
    if state then _G.aimTargetPart = "Head" else _G.aimTargetPart = "HumanoidRootPart" end
end)

addSlider(combatPage, "Aimbot Halka Boyutu (FOV)", 30, 500, 150, function(val)
    if fovCircle then
        fovCircle.Radius = val
    end
end)

addButton(combatPage, "NPC Tutma Scripti (eşya ve gui)", function()
    pcall(function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/GUI-Offical/FileTest/refs/heads/main/Grab%20R6.txt"))()
    end)
end)

-- İSTEDİĞİN MANUEL TAKIM KORUMASI TOGGLE BUTONU
addToggle(combatPage, "Takım Koruması (Team Check)", "AÇIK ise takım arkadaşlarını vurmaz. KAPALI ise kendi takımına da kilitlenir.", function(state)
    teamCheckEnabled = state
end)

-- TRIGGER BOT ENTEGRASYONU (MANUEL TAKIM KORUMALI + MAX HIZ)
local triggerBotEnabled = false
local mouse = LocalPlayer:GetMouse()
local VIM = game:GetService("VirtualInputManager")

addToggle(combatPage, "Trigger Bot", "Fareniz düşmana değdiği an elinizde silah olmasa bile sol tık basarak vurur.", function(state)
    triggerBotEnabled = state
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if triggerBotEnabled and mouse.Target then
        local targetChar = mouse.Target:FindFirstAncestorOfClass("Model")
        if targetChar and targetChar:FindFirstChildOfClass("Humanoid") and targetChar:FindFirstChild("HumanoidRootPart") then
            local targetPlayer = game:GetService("Players"):GetPlayerFromCharacter(targetChar)
            
            if targetPlayer and targetPlayer ~= LocalPlayer and targetChar:FindFirstChildOfClass("Humanoid").Health > 0 then
                
                -- TRIGGER BOT İÇİN MANUEL KONTROL
                if teamCheckEnabled and LocalPlayer.Team and targetPlayer.Team and LocalPlayer.Team == targetPlayer.Team then
                    return
                end
                
                local mouseLoc = game:GetService("UserInputService"):GetMouseLocation()
                VIM:SendMouseButtonEvent(mouseLoc.X, mouseLoc.Y, 0, true, game, 1)
                VIM:SendMouseButtonEvent(mouseLoc.X, mouseLoc.Y, 0, false, game, 1)
            end
        end
    end
end)

-- =====================================================================
-- [TAMİR EDİLDİ] %100 ESNEK NO RECOIL (HER YÖNE SERBEST BAKIŞ)
-- =====================================================================
local NoRecoilActive = false
local camera = workspace.CurrentCamera

-- Savaş sekmesindeki yeni esnek No Recoil butonun
addToggle(combatPage, "No Recoil (Geri Tepme Yok)", "Silahın titremesini tamamen sıfırlar. Düşmanı yukarı/aşağı/sağa/sola pürüzsüzce takip edebilirsiniz.", function(state)
    NoRecoilActive = state
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if NoRecoilActive then
        local lp = game.Players.LocalPlayer
        local char = lp.Character
        
        -- 1. YÖNTEM: Kamera Sarsıntı Filtresi (Ekran Titremesini Yok Eder)
        -- Kameranın kendi eksenini asla kilitlemez! Sadece silah patlarken oluşan ani ve yapay titreme hızlarını (RotVelocity) emer.
        pcall(function()
            if camera then
                -- Silahın kamerayı sarsmak için uyguladığı anlık dönme sarsıntılarını sıfırlar
                camera.RotVelocity = Vector3.new(0, 0, 0)
            end
        end)
        
        -- 2. YÖNTEM: Silah Dosyalarındaki Geri Tepme Ayarlarını Kökten Kapatma (Evrensel Sıfırlayıcı)
        pcall(function()
            local tool = char and char:FindFirstChildOfClass("Tool")
            if tool then
                -- Roblox FPS oyunlarında silahların sekme ayarlarını tutan tüm klasörleri tarar
                local configs = tool:FindFirstChild("Configuration") or tool:FindFirstChild("GunSettings") or tool:FindFirstChild("Settings") or tool
                
                for _, v in pairs(configs:GetDescendants()) do
                    if v:IsA("NumberValue") or v:IsA("IntValue") then
                        local n = string.lower(v.Name)
                        -- Silahın yukarı sekme (Recoil/Kick), sağa sola titreme (Shake/Spread) değerlerini bulur
                        if string.find(n, "recoil") or string.find(n, "kick") or string.find(n, "shake") or string.find(n, "spread") then
                            v.Value = 0 -- Bütün sekme ve dağılma katsayılarını sıfır yapar, silah lazer gibi gider!
                        end
                    end
                end
            end
        end)
    end
end)


-- =====================================================================
-- 2. SEKME: HAREKET HİLELERİ (FLY, INVIS, FLING, TP TOOL)
-- =====================================================================
addSlider(motionPage, "Yürüme Hızı (Normal Speed)", 16, 250, 16, function(val)
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = val end
end)
addSlider(motionPage, "Zıplama Yüksekliği (Jump)", 50, 250, 50, function(val)
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.JumpPower = val; LocalPlayer.Character.Humanoid.UseJumpPower = true end
end)
addSlider(motionPage, "Yerçekimi (Gravity)", 0, 196, 196, function(val)
    workspace.Gravity = val
end)
-- MOMENTUMLU VE TUŞ BIRAKILINCA SIFIRLANAN UÇMA FİZİĞİ
local flying = false
local flyConnection, bv, bg
local currentVelocity = Vector3.new(0,0,0)
local currentFlySpeed = 38
addToggle(motionPage, "Uçma Modu (Fly Fiziği)", "W-A-S-D basılı tuttukça 38'den hızlanır, bırakılınca hız sıfırlanır ama kayar.", function(state)
flying = state
local char = LocalPlayer.Character
local root = char and char:FindFirstChild("HumanoidRootPart")
local hum = char and char:FindFirstChild("Humanoid")
if not root or not hum then return end
if flying then
hum.PlatformStand = true
bv = Instance.new("BodyVelocity", root)
bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
bg = Instance.new("BodyGyro", root)
bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
currentFlySpeed = 38
flyConnection = RunService.RenderStepped:Connect(function()
local cam = workspace.CurrentCamera
local moveDir = Vector3.new(0,0,0)
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
if moveDir.Magnitude > 0 then
if currentFlySpeed < 200 then currentFlySpeed = currentFlySpeed + 0.35 end
currentVelocity = currentVelocity:Lerp(moveDir.Unit * currentFlySpeed, 0.15)
else
currentFlySpeed = 38
currentVelocity = currentVelocity:Lerp(Vector3.new(0,0,0), currentVelocity.Magnitude > 50 and 0.08 or 0.25)
end
bv.Velocity = currentVelocity; bg.CFrame = cam.CFrame
end)
else
if flyConnection then flyConnection:Disconnect() end
if bv then bv:Destroy() end; if bg then bg:Destroy() end
hum.PlatformStand = false; currentVelocity = Vector3.new(0,0,0); currentFlySpeed = 38
end
end)
-- =====================================================================
-- HAREKET SEKRESİ - ARARÜZ BUTON SIRALAMASI (DÜZELTİLDİ)
-- =====================================================================

-- 1. FE GÖRÜNMEZLİK DÜĞMESİ
addButton(motionPage, "FE Görünmezlik Scripti Çalıştır", function()
    pcall(function()
        loadstring(game:HttpGet('https://pastebin.com/raw/3Rnd9rHf'))()
    end)
end)

-- 2. TOUCH FLING DÜĞMESİ
addButton(motionPage, "Touch Fling Aç", function()
    pcall(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-TOUCH-FLING-30401"))()
    end)
end)

-- 3. TELEPORT TOOL DÜĞMESİ
addButton(motionPage, "TP Tool Al (Eşya)", function()
    local tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "Teleport Tool"
    tool.Activated:Connect(function()
        local pos = LocalPlayer:GetMouse().Hit.p
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
        end
    end)
    tool.Parent = LocalPlayer.Backpack
end)

local infiniteJump = false
local infJumpConnection

addToggle(motionPage, "Sonsuz Hava Zıplaması", "Havada ne zaman space tuşuna basarsanız basın pürüzsüzce yukarı tırmanmanızı sağlar.", function(state) 
    infiniteJump = state
    
    if infiniteJump then
        -- Space tuşuna her basıldığında karakteri yukarı fırlatan güçlü fizik döngüsü
        infJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
            if infiniteJump then
                local char = LocalPlayer.Character
                local rootPart = char and char:FindFirstChild("HumanoidRootPart")
                local humanoid = char and char:FindFirstChildOfClass("Humanoid")
                
                if rootPart and humanoid then
                    -- Oyunun zıplama gücü slider ayarını okur, eğer ayarlanmadıysa varsayılan 50 gücünü kullanır
                    local jumpForce = humanoid.JumpPower > 0 and humanoid.JumpPower or 50
                    
                    -- [FİZİK TABANLI YUKARI İTİŞ] Karakterin yatay hızını bozmadan sadece dikey (Y) eksenine zıplama gücü pompalar
                    rootPart.Velocity = Vector3.new(rootPart.Velocity.X, jumpForce, rootPart.Velocity.Z)
                end
            end
        end)
    else
        -- Kapatıldığında tuş dinleyicisini tamamen öldürür
        if infJumpConnection then
            infJumpConnection:Disconnect()
            infJumpConnection = nil
        end
    end
end)
-- =====================================================================
-- [GÜNCELLENDİ] KESİN ZIPLAYAN ROBLOX BHOP (SOLARA %100 STABİL)
-- =====================================================================
-- =====================================================================
-- [DEVFORUM] SOURCE ENGINE / QUAKE & SURF BHOP MOTORU (SOLARA UYUMLU)
-- =====================================================================
local BhopActive = false
local ContextActionService = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera

-- Fizik Ayarları (Bulduğun kodun orijinal Quake değerleri)
local settings = {
    moveSpeed = 30,
    runAccel = 5,
    runDeaccel = 5,
    airAccel = 2.5,
    airDeaccel = 2.5,
    sideStrafeAccel = 100,
    sideStrafeSpeed = 1,
    friction = 8,
    airFriction = 3,
    maxSpeed = 999999, -- Üst hız sınırı tamamen kapatıldı!
    jumpBuffer = 0.1
}

local Cmd = { upMove = false, downMove = false, leftMove = false, rightMove = false, lastUp = false, lastLeft = false, jump = false }
local playerVel = Vector3.new(0, 0, 0)
local forwardMove, sideMove = 0, 0
local wishJump = false

-- Klavye ve Tuş Dinleyicileri
local function onUp(_, state) Cmd.upMove = (state == Enum.UserInputState.Begin); Cmd.lastUp = true end
local function onLeft(_, state) Cmd.leftMove = (state == Enum.UserInputState.Begin); Cmd.lastLeft = true end
local function onDown(_, state) Cmd.downMove = (state == Enum.UserInputState.Begin); Cmd.lastUp = false end
local function onRight(_, state) Cmd.rightMove = (state == Enum.UserInputState.Begin); Cmd.lastLeft = false end
local function onJump(_, state) Cmd.jump = (state == Enum.UserInputState.Begin) end

local function ApplyFriction(t, inAir)
    local vec = Vector3.new(playerVel.X, 0, playerVel.Z)
    local speed = vec.Magnitude
    if speed == 0 then return end
    local newFriction = inAir and settings.airFriction or settings.friction
    local control = math.max(speed, settings.runDeaccel)
    local drop = control * newFriction * 0.016 * t
    local newspeed = math.max(0, speed - drop) / speed
    playerVel = Vector3.new(playerVel.X * newspeed, playerVel.Y, playerVel.Z * newspeed)
end

local function Accelerate(wishDir, wishSpeed, accel)
    local currentspeed = playerVel:Dot(wishDir)
    local addSpeed = wishSpeed - currentspeed
    if addSpeed <= 0 then return end
    
    -- Hızın her saniye katlanarak artması için ivme çarpanı eklendi
    local accelSpeed = math.min(accel * 0.016 * wishSpeed, addSpeed)
    
    -- Havadaysak ve hareket ediyorsak hızı her karede %5 daha fazla pompala
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid").FloorMaterial == Enum.Material.Air then
        accelSpeed = accelSpeed * 2.85 -- Hızlanma şiddeti (Daha da uçmak istersen burayı artır!)
    end
    
    playerVel = playerVel + (wishDir * accelSpeed)
    
    -- Roblox'un yürütme gücünü zorla bypass edip hızı doğrudan gövdeye enjekte eder
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root then
        root.AssemblyLinearVelocity = Vector3.new(playerVel.X, root.AssemblyLinearVelocity.Y, playerVel.Z)
    end
end


-- Havada ve Sörf Bloklarında Hızlanma Mantığı
local function AirMove(char)
    if forwardMove ~= 0 then ApplyFriction(1, true) end
    local wishDir = Camera.CFrame:VectorToWorldSpace(Vector3.new(sideMove, 0, forwardMove))
    wishDir = Vector3.new(wishDir.X, 0, wishDir.Z)
    local wishSpeed = wishDir.Magnitude * settings.moveSpeed
    if wishDir ~= Vector3.new(0, 0, 0) then wishDir = wishDir.Unit end
    
    local accel = playerVel:Dot(wishDir) < 0 and settings.airDeaccel or settings.airAccel
    if forwardMove == 0 and sideMove ~= 0 then
        wishSpeed = math.min(wishSpeed, settings.sideStrafeSpeed)
        accel = settings.sideStrafeAccel
    end
    Accelerate(wishDir, wishSpeed, accel)
end

local function GroundMove(char, hum)
    ApplyFriction(wishJump and 0 or 1, false)
    local wishDir = Camera.CFrame:VectorToWorldSpace(Vector3.new(sideMove, 0, forwardMove))
    wishDir = Vector3.new(wishDir.X, 0, wishDir.Z)
    if wishDir ~= Vector3.new(0, 0, 0) then wishDir = wishDir.Unit end
    
    Accelerate(wishDir, wishDir.Magnitude * settings.moveSpeed, settings.runAccel)
    playerVel = Vector3.new(playerVel.X, 0, playerVel.Z)
    
    if wishJump then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
        wishJump = false
    end
end

-- Ana Döngü (RenderStepped)
local bhopLoop
local function UpdateBhop()
    if not BhopActive then return end
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end
    
    sideMove = (Cmd.leftMove and Cmd.rightMove) and (Cmd.lastLeft and -1 or 1) or (Cmd.leftMove and -1 or Cmd.rightMove and 1 or 0)
    forwardMove = (Cmd.upMove and Cmd.downMove) and (Cmd.lastUp and -1 or 1) or (Cmd.upMove and -1 or Cmd.downMove and 1 or 0)
    wishJump = Cmd.jump
    
    local grounded = (hum.FloorMaterial ~= Enum.Material.Air) or (hum:GetState() == Enum.HumanoidStateType.Climbing)
    if grounded then GroundMove(char, hum) else AirMove(char) end
    
    local newDir = playerVel ~= Vector3.new(0, 0, 0) and playerVel.Unit or Vector3.new()
    hum.WalkSpeed = math.clamp(playerVel.Magnitude, 0, settings.maxSpeed)
    hum:Move(newDir, false)
end

-- Buton Tetikleyicisi
addToggle(motionPage, "Auto-Bhop (Quake Fiziği)", "Space tuşuna basılı tutunca hızlanırsınız.", function(state)
    BhopActive = state
    if BhopActive then
        ContextActionService:BindAction("BhopUp", onUp, false, "w")
        ContextActionService:BindAction("BhopLeft", onLeft, false, "a")
        ContextActionService:BindAction("BhopDown", onDown, false, "s")
        ContextActionService:BindAction("BhopRight", onRight, false, "d")
        ContextActionService:BindAction("BhopJump", onJump, false, Enum.KeyCode.Space)
        bhopLoop = RunService.RenderStepped:Connect(UpdateBhop)
    else
        if bhopLoop then bhopLoop:Disconnect() end
        ContextActionService:UnbindAction("BhopUp")
        ContextActionService:UnbindAction("BhopLeft")
        ContextActionService:UnbindAction("BhopDown")
        ContextActionService:UnbindAction("BhopRight")
        ContextActionService:UnbindAction("BhopJump")
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 16 end
        playerVel = Vector3.new(0,0,0)
    end
end)

-- =====================================================================
-- [TAMİR EDİLDİ] ÖLÜNCE KAPANMAYAN GERÇEK NO-CLIP MOTORU
-- =====================================================================
local noclip = false

-- Her fizik karesinde (Stepped) noclip kelimesi True ise duvarları kapatır
game:GetService("RunService").Stepped:Connect(function()
    if noclip and game.Players.LocalPlayer.Character then
        -- GetDescendants sayesinde karakterin şapkası, saçı dahil her şeyi hayalet yapar
        for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Senin o çok sevdiğin, ölsen bile sıfırlanmayan orijinal butonun adamım!
addToggle(motionPage, "Noclip (Duvar İçinden Geçme)", "Ölüp yeniden doğsanız bile duvarların içinden geçmeye devam edersiniz.", function(state) 
    noclip = state 
end)

local antiRagdollEnabled = false
local ragdollConnection
addToggle(motionPage, "Anti-Ragdoll & Anti-Sit", "Yere düşmenizi, sarsılmanızı veya koltuklara otomatik oturmanızı tamamen engeller.", function(state)
    antiRagdollEnabled = state
    local char = LocalPlayer.Character
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")
    
    if antiRagdollEnabled then
        ragdollConnection = game:GetService("RunService").Stepped:Connect(function()
            if antiRagdollEnabled and humanoid then
                -- Karakter durumlarını (Düşme, Oturma, Bayılma) sürekli reddeder
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                if humanoid.Sit then humanoid.Sit = false end
            end
        end)
    else
        if ragdollConnection then ragdollConnection:Disconnect() ragdollConnection = nil end
        if humanoid then
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        end
    end
end)
-- =====================================================================
-- FE (HERKESE GİDEN) GERÇEK TOOL SES BOMBASI TROLL
-- =====================================================================
local FE_SoundSpamActive = false

addToggle(motionPage, "Ses Bombası TROLL (FE)", "Elinize ses çıkaran bir eşya (Tool) alın ve açın. Sesi sunucudaki herkese spamlar!", function(state)
    FE_SoundSpamActive = state
end)

task.spawn(function()
    while true do
        task.wait(0) -- Makro hızı (Eşyayı saniyede onlarca kez takıp çıkarır)
        if FE_SoundSpamActive then
            local char = LocalPlayer.Character
            local backpack = LocalPlayer:FindFirstChild("Backpack")
            
            if char and backpack then
                -- Önce elindeki ses çıkaran ilk eşyayı (Tool) bulur
                local tool = char:FindFirstChildOfClass("Tool") or backpack:FindFirstChildOfClass("Tool")
                
                if tool then
                    pcall(function()
                        -- Eşyayı sırt çantasından eline alır (Equip)
                        tool.Parent = char
                        -- Eşyayı saliseler içinde anında çantaya geri koyar (Unequip)
                        tool.Parent = backpack
                    end)
                end
            end
        end
    end
end)


-- 3. SEKME: GÖRÜŞ VE ESP (SPECTATE, FOV)
-- =====================================================================
local activeHighlights = {}
local chamsConnection = nil 
local characterConnections = {} -- [TAMİR EDİLDİ] Her oyuncunun doğma takibini tutan yeni liste

addToggle(visualPage, "Chams ESP (Neon Röntgen)", "Herkesi duvar arkasından parlayan neon katmanla kaplar.", function(state)
    if state then
        if chamsConnection then chamsConnection:Disconnect() end
        
        local function addHighlight(player)
            if player == LocalPlayer then return end
            
            local function apply(char)
                if not AirWalkActive and not state then return end -- Güvenlik kilidi
                
                if char:FindFirstChild("PcHighlight") then
                    char.PcHighlight:Destroy()
                end
                
                local hl = Instance.new("Highlight")
                hl.Name = "PcHighlight"
                hl.FillColor = Color3.fromRGB(255, 0, 50)
                hl.FillTransparency = 0.4
                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                hl.Parent = char
                
                activeHighlights[player.Name] = hl
            end
            
            if player.Character then apply(player.Character) end
            
            -- [TAMİR EDİLDİ] Oyuncunun doğma bağlantısını hafızaya alıyoruz
            if characterConnections[player.Name] then characterConnections[player.Name]:Disconnect() end
            characterConnections[player.Name] = player.CharacterAdded:Connect(apply)
        end
        
        for _, p in ipairs(Players:GetPlayers()) do addHighlight(p) end
        chamsConnection = Players.PlayerAdded:Connect(addHighlight)
        
        -- Oyuncu oyundan çıkınca temizlik yap
        local removeConnection
        removeConnection = Players.PlayerRemoving:Connect(function(leftPlayer)
            if activeHighlights[leftPlayer.Name] then
                pcall(function() activeHighlights[leftPlayer.Name]:Destroy() end)
                activeHighlights[leftPlayer.Name] = nil
            end
            if characterConnections[leftPlayer.Name] then
                characterConnections[leftPlayer.Name]:Disconnect()
                characterConnections[leftPlayer.Name] = nil
            end
        end)
    else
        -- [TAMİR EDİLDİ] Hileyi kapattığında arka plandaki TÜM doğma takipleri durdurulur!
        if chamsConnection then chamsConnection:Disconnect() chamsConnection = nil end
        
        for name, conn in pairs(characterConnections) do
            if conn then conn:Disconnect() end
        end
        characterConnections = {} -- Listeyi sıfırla
        
        for name, hl in pairs(activeHighlights) do 
            if hl and hl.Parent then 
                pcall(function() hl:Destroy() end) 
            end 
        end
        activeHighlights = {} 
    end
end)


local antiInvisEnabled = false
task.spawn(function()
    while task.wait(1) do
        if antiInvisEnabled then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    for _, part in pairs(p.Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.Transparency > 0.7 then
                            part.Transparency = 0.4 
                        end
                    end
                end
            end
        end
    end
end)

addToggle(visualPage, "Anti-Invis (Görünmezleri İfşala)", "Sunucuda gizlenmiş veya görünmezlik hilesi açmış herkesi görünür yapar.", function(state)
    antiInvisEnabled = state
end)
local fullbrightEnabled = false
local lighting = game:GetService("Lighting")
addToggle(visualPage, "Fullbright (Gece Görüşü)", "Haritadaki tüm karanlığı, sisleri ve gölgeleri kaldırarak her yeri tamamen aydınlatır.", function(state)
    fullbrightEnabled = state
    if fullbrightEnabled then
        lighting.Ambient = Color3.fromRGB(255, 255, 255)
        lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        lighting.Brightness = 2
        lighting.FogEnd = 999999
    else
        -- Ayarları oyunun orijinal haline döndürür
        lighting.Ambient = Color3.fromRGB(128, 128, 128)
        lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        lighting.Brightness = 1
        lighting.FogEnd = 10000
    end
end)

-- =====================================================================
-- [GÜNCELLENDİ] PERSPEKTİF DENGELİ + FARE UÇLU RGB ESP & TRACER
-- =====================================================================

-- =====================================================================
-- [OPTIMIZE] TAM BARLI HvH ESP MOTORU (KISALTILMIŞ TAM SÜRÜM)
-- =====================================================================
local EspActive, trackedPlayers = false, {}
_G.showName, _G.showHealthBar, _G.showDistanceBar, _G.showSpeedBar = false, false, false, false

local function createLine(thick, color, filled)
    local line = Drawing.new(filled and "Square" or "Square")
    line.Thickness, line.Filled, line.Color, line.Visible = thick, filled, color, false
    return line
end

local function createEspElements(player)
    if trackedPlayers[player] or not (player.Character and player.Character:FindFirstChild("Head")) then return end
    local head = player.Character.Head

    local billboard = Instance.new("BillboardGui")
    billboard.Name, billboard.Size, billboard.AlwaysOnTop, billboard.ExtentsOffset, billboard.Parent = "S_Tag", UDim2.new(0, 200, 0, 50), true, Vector3.new(0, 2.5, 0), head
    
    local lbl = Instance.new("TextLabel", billboard)
    lbl.Size, lbl.BackgroundTransparency, lbl.TextColor3, lbl.TextStrokeTransparency, lbl.Font, lbl.TextSize, lbl.Text, lbl.Visible = UDim2.new(1,0,1,0), 1, Color3.new(1,1,1), 0.2, Enum.Font.SourceSansBold, 16, player.Name, false

    trackedPlayers[player] = {
        Box = createLine(1, Color3.fromRGB(255,0,0), false),
        Tracer = Drawing.new("Line"),
        H_Bg = createLine(1, Color3.new(0,0,0), true), H_Bar = createLine(1, Color3.new(0,1,0), true),
        S_Bg = createLine(1, Color3.new(0,0,0), true), S_Bar = createLine(1, Color3.fromRGB(0,150,255), true),
        D_Bg = createLine(1, Color3.new(0,0,0), true), D_Bar = createLine(1, Color3.fromRGB(255,200,0), true),
        BB = billboard, Lbl = lbl
    }
    trackedPlayers[player].Tracer.Thickness, trackedPlayers[player].Tracer.Visible = 1.5, false
end

local function removeEspElements(player)
    if trackedPlayers[player] then
        pcall(function()
            local e = trackedPlayers[player]
            e.Box:Remove() e.Tracer:Remove() e.H_Bg:Remove() e.H_Bar:Remove() e.S_Bg:Remove() e.S_Bar:Remove() e.D_Bg:Remove() e.D_Bar:Remove() e.BB:Destroy()
        end)
        trackedPlayers[player] = nil
    end
end

addToggle(visualPage, "Ana ESP & Çizgiyi Aç", "Kutuları ve çizgileri aktif eder.", function(state)
    EspActive = state if not EspActive then for p,_ in pairs(trackedPlayers) do removeEspElements(p) end end
end)
addToggle(visualPage, "Orijinal İsimleri Göster", "Kafada sabit isim gösterir.", function(state) _G.showName = state end)
addToggle(visualPage, "Dikey Can Çubuğunu Göster", "Sol kenara can barı çizer.", function(state) _G.showHealthBar = state end)
addToggle(visualPage, "Dikey Hız Çubuğunu Göster", "Sağ kenara hız barı çizer.", function(state) _G.showSpeedBar = state end)
addToggle(visualPage, "Yatay Mesafe Çubuğunu Göster", "Alt kenara yakınlık barı çizer.", function(state) _G.showDistanceBar = state end)

RunService.RenderStepped:Connect(function()
    if not EspActive then return end
    local m = LocalPlayer:GetMouse()
    local sX, sY = m.X, m.Y + 60

    for _, p in ipairs(game.Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Head") and p.Character:FindFirstChildOfClass("Humanoid") then
            if teamCheckEnabled and LocalPlayer.Team and p.Team and LocalPlayer.Team == p.Team then removeEspElements(p) continue end
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            
            if hum.Health > 0 then
                createEspElements(p)
                local e = trackedPlayers[p]
                if e then
                    local root = p.Character.HumanoidRootPart
                    local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
                    
                    e.BB.Enabled, e.Lbl.Visible = _G.showName, _G.showName
                    
                    if onScreen then
                        local dist = (Camera.CFrame.Position - root.Position).Magnitude
                        local h = math.clamp((1000 / dist) * 3.5, 10, 250)
                        local w, x, y = h * 0.65, pos.X - (h * 0.65 / 2), pos.Y - (h / 2)
                        
                        e.Tracer.Color = Color3.fromHSV((tick() % 3) / 3, 1, 1)
                        e.Tracer.From, e.Tracer.To, e.Tracer.Visible = Vector2.new(sX, sY), Vector2.new(pos.X, pos.Y), true
                        e.Box.Size, e.Box.Position, e.Box.Visible = Vector2.new(w, h), Vector2.new(x, y), true
                        
                        if _G.showHealthBar then
                            local r = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                            e.H_Bg.Size, e.H_Bg.Position, e.H_Bg.Visible = Vector2.new(2, h), Vector2.new(x - 5, y), true
                            e.H_Bar.Size, e.H_Bar.Position, e.H_Bar.Color, e.H_Bar.Visible = Vector2.new(2, h * r), Vector2.new(x - 5, y + (h * (1 - r))), Color3.fromRGB(255 * (1 - r), 255 * r, 0), true
                        else e.H_Bg.Visible, e.H_Bar.Visible = false, false end
                        
                        if _G.showSpeedBar then
                            local r = math.clamp(hum.WalkSpeed / 100, 0, 1)
                            e.S_Bg.Size, e.S_Bg.Position, e.S_Bg.Visible = Vector2.new(2, h), Vector2.new(x + w + 5, y), true
                            e.S_Bar.Size, e.S_Bar.Position, e.S_Bar.Visible = Vector2.new(2, h * r), Vector2.new(x + w + 5, y + (h * (1 - r))), true
                        else e.S_Bg.Visible, e.S_Bar.Visible = false, false end
                        
                        if _G.showDistanceBar then
                            local r = math.clamp(1 - (dist / 400), 0, 1)
                            e.D_Bg.Size, e.D_Bg.Position, e.D_Bg.Visible = Vector2.new(w, 2), Vector2.new(x, y + h + 5), true
                            e.D_Bar.Size, e.D_Bar.Position, e.D_Bar.Visible = Vector2.new(w * r, 2), Vector2.new(x, y + h + 5), true
                        else e.D_Bg.Visible, e.D_Bar.Visible = false, false end
                    else
                        e.Tracer.Visible, e.Box.Visible, e.H_Bg.Visible, e.H_Bar.Visible, e.S_Bg.Visible, e.S_Bar.Visible, e.D_Bg.Visible, e.D_Bar.Visible = false, false, false, false, false, false, false, false
                    end
                end
            else removeEspElements(p) end
        else removeEspElements(p) end
    end
end)
game.Players.PlayerRemoving:Connect(removeEspElements)


-- [YENİ] OYUNCU İZLEME (SPECTATE)
local spectating = false
addTextBox(visualPage, "İzlenecek Oyuncu Adı", function(txt)
local target = nil
for _, p in ipairs(Players:GetPlayers()) do
if p.Name:lower():sub(1, #txt) == txt:lower() then target = p; break end
end
if target and target.Character and target.Character:FindFirstChild("Humanoid") then
camera.CameraSubject = target.Character.Humanoid
else
camera.CameraSubject = LocalPlayer.Character:FindFirstChild("Humanoid")
end
end)
-- [YENİ] ADVANCED FOV SLIDER
addSlider(visualPage, "Görüş Alanı (FOV)", 70, 120, 70, function(val)
camera.FieldOfView = val
end)
-- =====================================================================
-- 4. SEKME: IŞINLANMA SİSTEMLERİ (DOĞRUDAN SAYFA İSMİNE BAĞLANDI)
-- =====================================================================
 
-- Oyuncu Yanına Işınlanma (TP PLAYER)
addTextBox(pages["Işınlanma"], "Işınlanılacak Oyuncu Adı (Enter)", function(txt)
    for _, v in pairs(Players:GetPlayers()) do
        if v.Name:lower():sub(1, #txt) == txt:lower() or v.DisplayName:lower():sub(1, #txt) == txt:lower() then
            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character then
                LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                break
            end
        end
    end
end)
 
-- Oyuncu Yanına Çekme Simülasyonu (BRING PLAYER)
addTextBox(pages["Işınlanma"], "Yanına Çekilecek Oyuncu Adı (Enter)", function(txt)
    for _, v in pairs(Players:GetPlayers()) do
        if v.Name:lower():sub(1, #txt) == txt:lower() then
            if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character then
                v.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                break
            end
        end
    end
end)

-- ==========================================
-- SADECE: ORIJINAL INFINITE YIELD GOD MODE
-- ==========================================
addButton(motionPage, "Ölümsüzlük (God Mode)", function()
    -- Infinite Yield sisteminin çalışması için gereken speaker tanımlaması
    local speaker = game:GetService("Players").LocalPlayer
    local char = speaker.Character -- char değişkeni küçük harf olarak eklendi
    
    local Cam = workspace.CurrentCamera
    local Char, Pos = speaker.Character, Cam.CFrame
    local pos = Pos -- pos değişkeni küçük harf olarak eklendi
    local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
    local nHuman = Human:Clone()
    nHuman.Parent = char
    speaker.Character = nil
    nHuman:SetStateEnabled(15, false)
    nHuman:SetStateEnabled(1, false)
    nHuman:SetStateEnabled(0, false)
    nHuman.BreakJointsOnDeath = true
    Human:Destroy()
    speaker.Character = char
    Cam.CameraSubject = nHuman
    Cam.CFrame = task.wait() and pos
    nHuman.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    local Script = Char:FindFirstChild("Animate")
    if Script then
        Script.Disabled = true
        task.wait()
        Script.Disabled = false
    end
    nHuman.Health = nHuman.MaxHealth
end)


-- =====================================================================
-- 5. SEKME: AYARLAR (GOOGLE DOCS EKSİK KISIM BURADA KAPATILDI!)
-- =====================================================================
addToggle(configPage, "FPS Booster Pro", "Grafik yüklerini tamamen plastiğe çevirerek FPS uçurur.", function(state)
if state then
game:GetService("Lighting").GlobalShadows = false
for _, v in pairs(game:GetDescendants()) do
            if v:IsA("Part") or v:IsA("MeshPart") then 
                v.Material = Enum.Material.SmoothPlastic 
            end
        end
    end
end)
 
-- HAVALI ELASTİK AÇILIŞ ANİMASYONU VE TOGGLE MANTIĞI
local frameOpen = true
MainFrame.Position = UDim2.new(0, 20, 1, 100)
TweenService:Create(MainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Position = UDim2.new(0, 20, 1, -440)}):Play()
local function toggleMenu()
frameOpen = not frameOpen
local targetPos = frameOpen and UDim2.new(0, 20, 1, -440) or UDim2.new(0, 20, 1, 100)
local style = frameOpen and Enum.EasingStyle.Elastic or Enum.EasingStyle.Quad
local dir = frameOpen and Enum.EasingDirection.Out or Enum.EasingDirection.In
TweenService:Create(MainFrame, TweenInfo.new(frameOpen and 0.8 or 0.3, style, dir), {Position = targetPos}):Play()
end
ToggleBtn.MouseButton1Click:Connect(toggleMenu)
UserInputService.InputBegan:Connect(function(input, gpe)
if not gpe and input.KeyCode == Enum.KeyCode.LeftAlt then toggleMenu() end
end)
local destBtn = Instance.new("TextButton", configPage)
destBtn.Size = UDim2.new(1, -5, 0, 36)
destBtn.BackgroundColor3 = Color3.fromRGB(160, 0, 30)
destBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
destBtn.Font = Enum.Font.GothamBold
destBtn.TextSize = 11
destBtn.Text = "HİLEYİ TAMAMEN SİL (DESTROY)"
Instance.new("UICorner", destBtn).CornerRadius = UDim.new(0, 5)
destBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
 
-- =====================================================================
-- [ÖZEL SEKME] EVRENSAL SMART EXECUTOR SAYFA MOTORU (TAM SÜRÜM)
-- =====================================================================
local executorPageUI = executorPage

-- 1. HARİCİ KOD YAPIŞTIRMA ALANI (Büyük Manuel Kod Kutusu)
local CodeBox = Instance.new("TextBox")
CodeBox.Size = UDim2.new(1, -20, 0, 160) -- Kod yazman için kocaman simsiyah alan
CodeBox.Position = UDim2.new(0, 10, 0, 10)
CodeBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
CodeBox.TextColor3 = Color3.fromRGB(0, 255, 100) -- Canlı matrix yeşili kod rengi
CodeBox.ClearTextOnFocus = false
CodeBox.MultiLine = true -- Alt satırlara geçebilen kod editörü
CodeBox.TextSize = 13
CodeBox.Font = Enum.Font.Code
CodeBox.Text = "-- Yapistirdiginiz harici hile kodlarini buradan calistirabilirsiniz..."
CodeBox.PlaceholderText = "loadstring(game:HttpGet(...))()"
CodeBox.Parent = executorPageUI

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 6)
BoxCorner.Parent = CodeBox

-- Manuel Kod Tetikleme Butonları
addButton(executorPageUI, "Kodu Çalıştır (Execute)", function()
    local scriptToRun = CodeBox.Text
    if scriptToRun and scriptToRun ~= "" then
        pcall(function() 
            assert(loadstring(scriptToRun))() 
        end)
    end
end)

addButton(executorPageUI, "Kutuyu Temizle (Clear)", function() 
    CodeBox.Text = "" 
end)

-- =====================================================================
-- [KUTU DIŞI] EN POPÜLER EVRENSAL HİLE SİSTEMLERİ (HIZLI YÜKLEYİCİLER)
-- =====================================================================

-- 1. EVRENSAL SCRIPT HUB (Infinite Yield - Roblox'un En Büyük Hile Konsolu)
addButton(executorPageUI, "Evrensel Admin Paneli Aç (Infinite Yield)", function()
    pcall(function()
        -- İçinde uçma, ışınlanma, içinden geçme dahil 1000'den fazla komut barındıran efsanevi hile konsolu
        loadstring(game:HttpGet("loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()"))()
    end)
end)

-- 2. EVRENSAL OYUN DEPOSU (EzHub - Girdiğin Oyunu Tanıyan Akıllı Panel)
addButton(executorPageUI, "Akıllı Oyun Script Havuzu Aç (EzHub)", function()
    pcall(function()
        -- Build a Boat dahil girdiğin neredeyse her oyunu otomatik algılayıp ona göre hile açan devasa havuz
        loadstring(game:HttpGet("loadstring(game:HttpGet(('https://raw.githubusercontent.com/debug42O/Ez-Industries-Launcher-Data/master/Launcher.lua'),true))()"))()
    end)
end)

-- 3. EVRENSAL CHAT TROLL PANELI (Nameless Admin)
addButton(executorPageUI, "Troll & Sunucu Karıştırma Paneli Aç", function()
    pcall(function()
        -- Sunucuda çılgın troller yapmanı, animasyonları manipüle etmeni sağlayan panel
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ltseverydayyou/Nameless-Admin/main/Source.lua"))()
    end)
end)

-- ==========================================
-- TAM İSTEDİĞİN GİBİ: DEVASA VE GÖRÜNMEZ HAVADA YÜRÜME
-- ==========================================
local AirWalkActive = false
local airPlatform = nil
local currentYHeight = nil

-- Senin şablonuna göre hazırlandı, açıklama kısmı eklendi
addToggle(motionPage, "Havada Yürüme Modu", "Havada tamamen görünmez ve devasa bir zemin oluşturarak boşlukta yürümenizi sağlar.", function(state)
    AirWalkActive = state
    
    -- Hile kapatıldığında haritadaki platformu temizler
    if not state then
        if airPlatform then
            airPlatform:Destroy()
            airPlatform = nil
        end
        currentYHeight = nil
    end
end)

-- Arka planda sürekli çalışıp zemini yöneten döngü
task.spawn(function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    while true do
        task.wait(0.01) -- Makro hızı
        
        if AirWalkActive then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local hrp = character.HumanoidRootPart
                
                -- Hileyi açtığın andaki yüksekliği (Y koordinatını) bir kez kilitler
                if not currentYHeight then
                    currentYHeight = hrp.Position.Y - 3.4
                end
                
                -- Eğer platform henüz oluşturulmadıysa oluşturur
                if not airPlatform or not airPlatform.Parent then
                    airPlatform = Instance.new("Part")
                    airPlatform.Name = "InvisibleMegaPlatform"
                    
                    -- [DEĞİŞİKLİK] Boyut devasa yapıldı, haritayı kaplar!
                    airPlatform.Size = Vector3.new(50000, 0.5, 50000) 
                    
                    -- [DEĞİŞİKLİK] Tamamen görünmez yapıldı!
                    airPlatform.Transparency = 1 
                    
                    airPlatform.Anchored = true
                    airPlatform.CanCollide = true
                    airPlatform.Parent = workspace
                end
                
                -- Platform sadece X ve Z'de (yürüdüğün yönde) seni takip eder.
                -- Yüksekliği sabit tutar, böylece zıpladığında seninle yukarı fırlamaz!
                airPlatform.CFrame = CFrame.new(hrp.Position.X, currentYHeight, hrp.Position.Z)
            end
        end
    end
end)

-- ==========================================
-- HAREKET: DONMAYAN VE KORUMALI HIZ SLIDER (BYPASS)
-- ==========================================
local CustomSpeedValue = 16 -- Başlangıçta normal Roblox hızı (16)

-- Senin orijinal şablonuna birebir uygun dizilim (Min: 16, Max: 250, Default: 16)
addSlider(motionPage, "Korumalı Yürüme Hızı (Bypass)", 16, 250, 16, function(val)
    CustomSpeedValue = val
end)

task.spawn(function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    while true do
        task.wait(0.01) -- Işık hızı döngü
        
        -- Eğer slider normal hızdan (16'dan) yüksek bir değere çekildiyse hile çalışır
        if CustomSpeedValue > 16 then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChildOfClass("Humanoid") then
                local hrp = character.HumanoidRootPart
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                
                -- W-A-S-D tuşlarına basıldığı an karakteri anti-chate yakalanmadan ileri fırlatır
                if humanoid.MoveDirection.Magnitude > 0 then
                    -- Hız değerini 16'dan ne kadar uzağa çektiysen o oranda pürüzsüzce hızlandırır
                    local boostFactor = (CustomSpeedValue - 16) / 70
                    hrp.CFrame = hrp.CFrame + (humanoid.MoveDirection * boostFactor)
                end
            end
        end
    end
end)

-- ==========================================
-- HAREKET: FE TÜM EŞYALARI VER (KESİN ÇÖZÜM)
-- ==========================================
local FE_ToolGiverActive = false

-- Senin orijinal 4 parametreli Toggle şablonuna birebir uygun dizilim
addToggle(motionPage, "FE Tüm Eşyaları Ver", "Oyunun gizli depolarında duran tüm orijinal silah ve eşyaları envanterinize kopyalar.", function(state)
    FE_ToolGiverActive = state
end)

-- Değişken hatalarını önlemek için bağımsız ve doğrudan erişimli döngü
task.spawn(function()
    while true do
        task.wait(0.5) -- Tarama hızını yarım saniyeye düşürerek daha agresif arama yapmasını sağlıyoruz
        
        if FE_ToolGiverActive then
            -- Oyuncuyu ve sırt çantasını oyun servisinden doğrudan buluyoruz (Hata riskini sıfırlar)
            local p = game:GetService("Players").LocalPlayer
            local backpack = p and p:FindFirstChild("Backpack")
            local char = p and p.Character
            
            if backpack then
                -- Eşyaların saklanabileceği TÜM olası Roblox depoları (InsertService ve ReplicatedStorage dahil)
                local storageLocations = {
                    game:GetService("ReplicatedStorage"),
                    game:GetService("Lighting"),
                    game:GetService("InsertService"),
                    workspace
                }
                
                for _, storage in pairs(storageLocations) do
                    pcall(function()
                        for _, obj in pairs(storage:GetDescendants()) do
                            -- Nesne bir eşyaysa (Tool), isminde koruma yoksa ve envanterimizde henüz mevcut değilse
                            if obj:IsA("Tool") then
                                local hasTool = backpack:FindFirstChild(obj.Name) or (char and char:FindFirstChild(obj.Name))
                                
                                if not hasTool then
                                    -- Depodaki orijinal silahı klonlayıp direkt sırt çantasına fırlatıyoruz
                                    local clonedTool = obj:Clone()
                                    clonedTool.Parent = backpack
                                end
                            end
                        end
                    end)
                end
            end
        end
    end
end)

-- ==========================================
-- GÖRÜŞ: Gelişmiş X-Ray (Duvarları Şeffaf Yap)
-- ==========================================
local XRayActive = false
local originalTransparencies = {} -- Duvarların eski hallerini bozmamak için hafıza kartı

-- Senin orijinal 4 parametreli Toggle şablonuna birebir uygun dizilim
addToggle(visualPage, "X-Ray (Duvar Arkası)", "Haritadaki tüm binaları ve duvarları yarı saydam cam haline getirerek arkalarını gösterir.", function(state)
    XRayActive = state
    
    -- Workspace (harita) içindeki tüm nesneleri tarıyoruz
    for _, obj in pairs(workspace:GetDescendants()) do
        -- Sadece haritadaki yapılara, duvarlara ve zeminlere odaklan (Oyuncuların gövdesini bozmamak için)
        if obj:IsA("BasePart") and not obj:IsDescendantOf(game:GetService("Players").LocalPlayer.Character) and not obj.Parent:FindFirstChildOfClass("Humanoid") then
            
            if XRayActive then
                -- Duvarın orijinal şeffaflığını daha sonra geri yüklemek için hafızaya kaydediyoruz
                if not originalTransparencies[obj] then
                    originalTransparencies[obj] = obj.Transparency
                end
                -- Duvarı yarı saydam neon cama çeviriyoruz
                obj.Transparency = 0.55
            else
                -- Hile kapatıldığında duvarları hafızadaki eski orijinal şeffaflığına geri döndürüyoruz
                if originalTransparencies[obj] then
                    obj.Transparency = originalTransparencies[obj]
                end
            end
            
        end
    end
    
    -- Hile kapatıldıysa hafıza listesini temizle
    if not state then
        originalTransparencies = {}
    end
end)

-- ==========================================
-- GÖRÜŞ: ORIJINAL INFINITE YIELD DAY & NIGHT SİSTEMİ
-- ==========================================
local Lighting = game:GetService("Lighting")

addButton(visualPage, "Haritayı Gündüz Yap (Day)", function()
    -- Infinite Yield orijinal 'day' komut satırı
    Lighting.ClockTime = 14
end)

addButton(visualPage, "Haritayı Gece Yap (Night)", function()
    -- Infinite Yield orijinal 'night' komut satırı
    Lighting.ClockTime = 0
end)

-- ==========================================
-- TÜM SLIDER'LAR İÇİN MOBİL DOKUNMATİK DESTEĞİ (ONE-TAP FIX)
-- ==========================================
task.spawn(function()
    local CoreGui = game:GetService("CoreGui")
    
    -- Panel yüklenene kadar küçük bir saniye bekliyoruz
    task.wait(2) 
    
    -- Senin hile panelini buluyoruz
    local menu = CoreGui:FindFirstChild("PcPremiumVipMenu")
    if menu then
        -- Panel içindeki tüm nesneleri (butonlar, sürgüler vb.) tarıyoruz
        for _, obj in pairs(menu:GetDescendants()) do
            -- Eğer nesne bir metin kutusu, buton veya kaydırma çubuğu ise
            if obj:IsA("GuiObject") then
                -- [SİHİRLİ DOKUNUŞ] Telefon ekranından gelen parmak dokunuşlarını 
                -- algılaması için kilitli olan tüm mobil izinlerini zorla açıyoruz!
                obj.Active = true
                obj.Selectable = true
                
                -- Eğer sürgünün arka planında bir buton gizliyse onun da dokunmatik iznini aç
                if obj:IsA("TextButton") or obj:IsA("ImageButton") then
                    obj.AutoButtonColor = true
                end
            end
        end
    end
end)

-- ==========================================
-- HAREKET: S TUŞSUZ KARİZMATİK IRON MAN FLY (ASLA ÖLDÜRMEZ)
-- ==========================================
local BaseFlySpeed = 50 
local CurrentFlySpeed = BaseFlySpeed
local IsFlyingActive = false

local forwardHold = 0
-- [TAMİR EDİLDİ] 'back' (geri) bayrağı listeden tamamen kaldırıldı!
local inputFlags = { forward = false, left = false, right = false, up = false, down = false }

local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)

local bodyGyro = Instance.new("BodyGyro")
bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)

local function newAnim(id)
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. id
    return anim
end

-- Geri gitme animasyonları tamamen temizlendi, sadece havalı uçuşlar kaldı!
local animations = {
    forward = newAnim(90872539),
    up = newAnim(90872539),
    right1 = newAnim(136801964),
    right2 = newAnim(142495255),
    left1 = newAnim(136801964),
    left2 = newAnim(142495255),
    flyLow1 = newAnim(97169019),
    flyLow2 = newAnim(282574440),
    flyFast = newAnim(282574440),
    down = newAnim(233322916),
    idle1 = newAnim(97171309)
}

local tracks = {}
local animsLoaded = false

addToggle(motionPage, "Uçuş. (PC)", "Uçuş animasyonlarıyla Iron Man gibi uçmasınızı sağlar.", function(state)
    IsFlyingActive = state
    
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local HRP = character and character:FindFirstChild("HumanoidRootPart")
    
    if state then
        if HRP and humanoid then
            if not animsLoaded then
                for name, anim in pairs(animations) do
                    tracks[name] = humanoid:LoadAnimation(anim)
                end
                animsLoaded = true
            end
            
            forwardHold = 0
            CurrentFlySpeed = BaseFlySpeed
            bodyVelocity.Parent = HRP
            bodyGyro.Parent = HRP
            
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Massless = true
                end
            end
        end
    else
        bodyVelocity.Parent = nil
        bodyGyro.Parent = nil
        
        if character then
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Massless = false
                end
            end
        end
        
        for _, track in pairs(tracks) do
            if track then track:Stop() end
        end
    end
end)

local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.W then inputFlags.forward = true end
    -- S tuşu basılma dinleyicisi tamamen silindi!
    if input.KeyCode == Enum.KeyCode.A then inputFlags.left = true end
    if input.KeyCode == Enum.KeyCode.D then inputFlags.right = true end
    if input.KeyCode == Enum.KeyCode.E then inputFlags.up = true end 
    if input.KeyCode == Enum.KeyCode.Q then inputFlags.down = true end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then inputFlags.forward = false end
    -- S tuşu bırakılma dinleyicisi tamamen silindi!
    if input.KeyCode == Enum.KeyCode.A then inputFlags.left = false end
    if input.KeyCode == Enum.KeyCode.D then inputFlags.right = false end
    if input.KeyCode == Enum.KeyCode.E then inputFlags.up = false end 
    if input.KeyCode == Enum.KeyCode.Q then inputFlags.down = false end
end)

game:GetService("RunService").RenderStepped:Connect(function(dt)
    if not IsFlyingActive then return end
    
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    local character = LocalPlayer.Character
    local HRP = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if HRP and humanoid and bodyVelocity and bodyGyro then
        if not inputFlags.forward then forwardHold = 0 end

        humanoid:ChangeState(Enum.HumanoidStateType.Running)

        local dir = Vector3.new(0, 0, 0)
        local camCF = Camera.CFrame

        if inputFlags.forward then dir = dir + camCF.LookVector end
        -- Geriye doğru yön hesaplaması tamamen kaldırıldı!
        if inputFlags.left then dir = dir - camCF.RightVector end
        if inputFlags.right then dir = dir + camCF.RightVector end
        if inputFlags.up then dir = dir + Vector3.new(0, 1, 0) end
        if inputFlags.down then dir = dir - Vector3.new(0, 1, 0) end

        if dir.Magnitude > 0 then dir = dir.Unit end

        bodyVelocity.Velocity = dir * CurrentFlySpeed
        bodyGyro.CFrame = camCF

        local function stopAll()
            for _, track in pairs(tracks) do if track then track:Stop() end end
        end

        if inputFlags.up then
            if tracks.up and not tracks.up.IsPlaying then stopAll(); tracks.up:Play() end
        elseif inputFlags.down then
            if tracks.down and not tracks.down.IsPlaying then stopAll(); tracks.down:Play() end
        elseif inputFlags.left then
            if tracks.left1 and not tracks.left1.IsPlaying then
                stopAll()
                tracks.left1:Play(); tracks.left1.TimePosition = 2.0; tracks.left1:AdjustSpeed(0)
                tracks.left2:Play(); tracks.left2.TimePosition = 0.5; tracks.left2:AdjustSpeed(0)
            end
        elseif inputFlags.right then
            if tracks.right1 and not tracks.right1.IsPlaying then
                stopAll()
                tracks.right1:Play(); tracks.right1.TimePosition = 1.1; tracks.right1:AdjustSpeed(0)
                tracks.right2:Play(); tracks.right2.TimePosition = 0.5; tracks.right2:AdjustSpeed(0)
            end
        elseif inputFlags.forward then
            forwardHold = forwardHold + dt
            if forwardHold >= 3 then
                if tracks.flyFast and not tracks.flyFast.IsPlaying then
                    stopAll()
                    CurrentFlySpeed = BaseFlySpeed * 1.5 
                    tracks.flyFast:Play(); tracks.flyFast:AdjustSpeed(0.05)
                end
            else
                if tracks.flyLow1 and not tracks.flyLow1.IsPlaying then
                    stopAll()
                    CurrentFlySpeed = BaseFlySpeed
                    tracks.flyLow1:Play()
                    tracks.flyLow2:Play()
                end
            end
        else
            if tracks.idle1 and not tracks.idle1.IsPlaying then
                stopAll()
                tracks.idle1:Play(); tracks.idle1:AdjustSpeed(0)
            end
        end
    end
end)


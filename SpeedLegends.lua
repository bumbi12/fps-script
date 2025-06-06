--[[
  SPEED LEGENDS HUB - AUTO FARM PREMIUM
  Phiên bản: 3.0 Hoàn Thiện
  Author: TP SpeedLegendsHub
  Tính năng:
    - Auto farm ngẫu nhiên toàn bộ Orbs/Gem trong map
    - Giao diện Premium với logo
    - Tốc độ cao, khoảng cách nhặt rộng
]]--

local Player = game:GetService("Players").LocalPlayer
local Running = false
local CollectedItems = 0
local TeleportSpeed = 0
local CollectDistance = 250

-- =============================================
-- PHẦN GIAO DIỆN CAO CẤP
-- =============================================
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local AuthLabel = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local ToggleButton = Instance.new("TextButton")
local KillButton = Instance.new("TextButton")
local CounterLabel = Instance.new("TextLabel")
local StatusLabel = Instance.new("TextLabel")
local LogoFrame = Instance.new("Frame")
local LogoImage = Instance.new("ImageLabel")

-- Cấu hình GUI
ScreenGui.Name = "SpeedLegendsHub"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.7, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 200)
MainFrame.Active = true
MainFrame.Draggable = true

TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 35)

Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(0, 250, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "SPEED LEGENDS HUB"
Title.TextColor3 = Color3.fromRGB(100, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

AuthLabel.Name = "AuthLabel"
AuthLabel.Parent = TopBar
AuthLabel.BackgroundTransparency = 1
AuthLabel.Position = UDim2.new(0, 15, 0, 18)
AuthLabel.Size = UDim2.new(0, 250, 0, 15)
AuthLabel.Font = Enum.Font.Gotham
AuthLabel.Text = "By TP SpeedLegendsHub"
AuthLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
AuthLabel.TextSize = 11
AuthLabel.TextXAlignment = Enum.TextXAlignment.Left

CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -30, 0.5, -10)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16

LogoFrame.Name = "LogoFrame"
LogoFrame.Parent = MainFrame
LogoFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
LogoFrame.BorderSizePixel = 0
LogoFrame.Position = UDim2.new(0.7, 5, 0.18, 0)
LogoFrame.Size = UDim2.new(0, 110, 0, 130)

LogoImage.Name = "LogoImage"
LogoImage.Parent = LogoFrame
LogoImage.BackgroundTransparency = 1
LogoImage.Size = UDim2.new(1, -5, 1, -5)
LogoImage.Image = "https://i.imgur.com/9lA2c8V.jpeg"
LogoImage.ImageTransparency = 0
LogoImage.ScaleType = Enum.ScaleType.Fit

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
ToggleButton.BorderSizePixel = 0
ToggleButton.Position = UDim2.new(0.05, 0, 0.3, 0)
ToggleButton.Size = UDim2.new(0.6, 0, 0, 35)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "BẮT ĐẦU"
ToggleButton.TextColor3 = Color3.fromRGB(200, 255, 200)
ToggleButton.TextSize = 14

KillButton.Name = "KillButton"
KillButton.Parent = MainFrame
KillButton.BackgroundColor3 = Color3.fromRGB(80, 40, 60)
KillButton.BorderSizePixel = 0
KillButton.Position = UDim2.new(0.05, 0, 0.55, 0)
KillButton.Size = UDim2.new(0.6, 0, 0, 35)
KillButton.Font = Enum.Font.GothamBold
KillButton.Text = "DỪNG HẲN"
KillButton.TextColor3 = Color3.fromRGB(255, 200, 200)
KillButton.TextSize = 14

CounterLabel.Name = "CounterLabel"
CounterLabel.Parent = MainFrame
CounterLabel.BackgroundTransparency = 1
CounterLabel.Position = UDim2.new(0.05, 0, 0.78, 0)
CounterLabel.Size = UDim2.new(0.6, 0, 0, 20)
CounterLabel.Font = Enum.Font.GothamBold
CounterLabel.Text = "Đã nhặt: 0"
CounterLabel.TextColor3 = Color3.fromRGB(100, 255, 255)
CounterLabel.TextSize = 13

StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0.05, 0, 0.88, 0)
StatusLabel.Size = UDim2.new(0.6, 0, 0, 15)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "🟢 Đang chờ"
StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
StatusLabel.TextSize = 12

-- =============================================
-- PHẦN CHỨC NĂNG AUTO FARM
-- =============================================
local TweenService = game:GetService("TweenService")

local function Notify(message, color)
    local statusColor = color or Color3.fromRGB(100, 255, 100)
    StatusLabel.TextColor3 = statusColor
    
    if message:find("Đang chạy") then
        StatusLabel.Text = "🟠 "..message
    elseif message:find("dừng") or message:find("DỪNG") then
        StatusLabel.Text = "🔴 "..message
    else
        StatusLabel.Text = "🟢 "..message
    end
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "SPEED LEGENDS",
        Text = message,
        Duration = 3,
        Icon = "rbxassetid://6723928012"
    })
end

local function CollectItem(item)
    if item and item:IsA("BasePart") and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = Player.Character.HumanoidRootPart
        firetouchinterest(hrp, item, 0)
        firetouchinterest(hrp, item, 1)
        CollectedItems += 1
        CounterLabel.Text = "Đã nhặt: "..CollectedItems
        return true
    end
    return false
end

local function TeleportToPosition(position)
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(position + Vector3.new(0, 3, 0))
    end
end

local function GetRandomOrb()
    local cityOrbs = workspace.orbFolder.City:GetChildren()
    if #cityOrbs == 0 then return nil end
    
    -- Chọn ngẫu nhiên một orb
    local randomOrb = cityOrbs[math.random(1, #cityOrbs)]
    
    -- Ưu tiên nhặt các loại item quan trọng trước
    local targetItem = randomOrb:FindFirstChild("innerGem") or 
                      randomOrb:FindFirstChild("outerGem") or
                      randomOrb:FindFirstChild("innerOrb") or
                      randomOrb:FindFirstChild("outerOrb")
    
    return targetItem or randomOrb
end

local function AutoFarm()
    while Running and task.wait() do
        if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
            Notify("Không tìm thấy nhân vật!", Color3.fromRGB(255, 150, 150))
            task.wait(1)
            continue
        end
        
        local targetItem = GetRandomOrb()
        if targetItem then
            TeleportToPosition(targetItem.Position)
            task.wait(0.1)
            CollectItem(targetItem)
            task.wait(TeleportSpeed)
        else
            Notify("Không tìm thấy vật phẩm!", Color3.fromRGB(255, 150, 150))
            task.wait(1)
        end
    end
end

-- =============================================
-- HIỆU ỨNG VÀ SỰ KIỆN
-- =============================================
local function ButtonHoverEffect(button, hoverColor, normalColor)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = normalColor}):Play()
    end)
end

ButtonHoverEffect(ToggleButton, Color3.fromRGB(70, 70, 100), Color3.fromRGB(50, 50, 80))
ButtonHoverEffect(KillButton, Color3.fromRGB(100, 50, 70), Color3.fromRGB(80, 40, 60))
ButtonHoverEffect(CloseButton, Color3.fromRGB(255, 80, 80), Color3.fromRGB(255, 60, 60))

CloseButton.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 400, 0, 0)}):Play()
    task.wait(0.3)
    ScreenGui:Destroy()
end)

ToggleButton.MouseButton1Click:Connect(function()
    Running = not Running
    if Running then
        ToggleButton.Text = "TẠM DỪNG"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
        Notify("Đang chạy Auto Farm...")
        AutoFarm()
    else
        ToggleButton.Text = "BẮT ĐẦU"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
        Notify("Đã tạm dừng")
    end
end)

KillButton.MouseButton1Click:Connect(function()
    Running = false
    Notify("Đã dừng script", Color3.fromRGB(255, 100, 100))
    task.wait(0.5)
    ScreenGui:Destroy()
end)

-- =============================================
-- KHỞI ĐỘNG
-- =============================================
MainFrame.Size = UDim2.new(0, 0, 0, 200)
TweenService:Create(MainFrame, TweenInfo.new(0.5), {Size = UDim2.new(0, 400, 0, 200)}):Play()
Notify("SPEED LEGENDS HUB ĐÃ SẴN SÀNG!")

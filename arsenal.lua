local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Tạo GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 350, 0, 280)
Frame.Position = UDim2.new(0.5, -175, 0.5, -140)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.BackgroundTransparency = 1
Frame.Active = true
Frame.Draggable = true

-- Bo góc & viền sáng
local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 12)

local UIStroke = Instance.new("UIStroke", Frame)
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 255, 150) -- Viền phát sáng
UIStroke.Transparency = 0.5

-- Hiệu ứng xuất hiện GUI
Frame.Position = UDim2.new(0.5, -175, 0.5, -200)
local TweenInfoGui = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
TweenService:Create(Frame, TweenInfoGui, {BackgroundTransparency = 0, Position = UDim2.new(0.5, -175, 0.5, -140)}):Play()

-- Tạo tiêu đề
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "🔥 TP Arsenal HUB 🔥"
Title.TextSize = 24
Title.Font = Enum.Font.GothamBlack
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.BorderSizePixel = 0

-- Label hiển thị tên nhân vật
local PlayerLabel = Instance.new("TextLabel", Frame)
PlayerLabel.Size = UDim2.new(1, 0, 0, 25)
PlayerLabel.Position = UDim2.new(0, 0, 0, 50)
PlayerLabel.Text = "👤 Người chơi: " .. Player.Name
PlayerLabel.TextSize = 18
PlayerLabel.Font = Enum.Font.Gotham
PlayerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerLabel.BackgroundTransparency = 1

-- Label hiển thị tên hiển thị
local DisplayNameLabel = Instance.new("TextLabel", Frame)
DisplayNameLabel.Size = UDim2.new(1, 0, 0, 25)
DisplayNameLabel.Position = UDim2.new(0, 0, 0, 75)
DisplayNameLabel.Text = "🏷️ Tên hiển thị: " .. Player.DisplayName
DisplayNameLabel.TextSize = 18
DisplayNameLabel.Font = Enum.Font.Gotham
DisplayNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DisplayNameLabel.BackgroundTransparency = 1

-- Label hiển thị FPS
local FPSLabel = Instance.new("TextLabel", Frame)
FPSLabel.Size = UDim2.new(1, 0, 0, 25)
FPSLabel.Position = UDim2.new(0, 0, 0, 100)
FPSLabel.Text = "⏳ FPS: Đang tải..."
FPSLabel.TextSize = 18
FPSLabel.Font = Enum.Font.Gotham
FPSLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FPSLabel.BackgroundTransparency = 1

-- Hàm cập nhật FPS mỗi giây
spawn(function()
    while wait(1) do
        local fps = math.floor(1 / RunService.RenderStepped:Wait())
        FPSLabel.Text = "⏳ FPS: " .. fps
    end
end)

-- Hàm tạo button
local function createButton(text, posY, color)
    local Button = Instance.new("TextButton", Frame)
    Button.Size = UDim2.new(1, -20, 0, 40) -- Giảm chiều cao nút xuống 40
    Button.Position = UDim2.new(0, 10, 0, posY)
    Button.Text = text
    Button.TextSize = 20
    Button.Font = Enum.Font.GothamBold
    Button.BackgroundColor3 = color
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.BorderSizePixel = 0

    local UICornerButton = Instance.new("UICorner", Button)
    UICornerButton.CornerRadius = UDim.new(0, 10)

    -- Viền sáng
    local UIStrokeButton = Instance.new("UIStroke", Button)
    UIStrokeButton.Thickness = 2
    UIStrokeButton.Color = color:Lerp(Color3.fromRGB(255, 255, 255), 0.3)
    UIStrokeButton.Transparency = 0.5

    -- Hiệu ứng hover
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = color:Lerp(Color3.new(1,1,1), 0.2)}):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
    end)

    -- Hiệu ứng click
    Button.MouseButton1Down:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundTransparency = 0.5}):Play()
    end)
    Button.MouseButton1Up:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
    end)

    return Button
end

local StartButton = createButton("▶ Bắt Đầu", 130, Color3.fromRGB(0, 200, 100))
local StopButton = createButton("⛔ Tắt Script", 180, Color3.fromRGB(200, 50, 50))
local CloseButton = createButton("❌ Đóng & Thoát", 230, Color3.fromRGB(255, 50, 50))

-- Biến kiểm soát script
local running = false
local hackCoroutine = nil

local function startHack()
    running = true
    hackCoroutine = coroutine.create(function()
        while running do
            wait(1)
            for _, b in pairs(Players:GetPlayers()) do
                if b ~= Player and b.Character then
                    local parts = {"RightUpperLeg", "LeftUpperLeg", "HeadHB", "HumanoidRootPart"}
                    for _, part in pairs(parts) do
                        if b.Character:FindFirstChild(part) then
                            local p = b.Character[part]
                            p.CanCollide = false
                            p.Transparency = 10
                            p.Size = Vector3.new(13, 13, 13)
                        end
                    end
                end
            end
        end
    end)
    coroutine.resume(hackCoroutine)
end

local function stopHack()
    running = false
end

StartButton.MouseButton1Click:Connect(function()
    if not running then
        startHack()
    end
end)

StopButton.MouseButton1Click:Connect(function()
    stopHack()
end)

CloseButton.MouseButton1Click:Connect(function()
    stopHack()
    ScreenGui:Destroy()
    script:Destroy()
end)

-- Ẩn/Hiện GUI bằng RightShift
UIS.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.RightShift and not gameProcessed then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

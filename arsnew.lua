local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 350, 0, 380)
Frame.Position = UDim2.new(0.5, -175, 0.5, -175)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.BackgroundTransparency = 1
Frame.Active = true
Frame.Draggable = true

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 12)

local UIStroke = Instance.new("UIStroke", Frame)
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 255, 150)
UIStroke.Transparency = 0.5

Frame.Position = UDim2.new(0.5, -175, 0.5, -200)
local TweenInfoGui = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
TweenService:Create(Frame, TweenInfoGui, {BackgroundTransparency = 0, Position = UDim2.new(0.5, -175, 0.5, -175)}):Play()

local function createLabel(text, posY, parent)
    local label = Instance.new("TextLabel", parent)
    label.Size = UDim2.new(1, 0, 0, 25)
    label.Position = UDim2.new(0, 0, 0, posY)
    label.Text = text
    label.TextSize = 18
    label.Font = Enum.Font.Gotham
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    return label
end

local Title = createLabel("🔥 TP Arsenal HUB 🔥", 0, Frame)
Title.TextSize = 24
Title.Font = Enum.Font.GothamBlack
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Title.TextColor3 = Color3.fromRGB(0, 255, 150)

local PlayerLabel = createLabel("👤 Người chơi: " .. Player.Name, 50, Frame)
local DisplayNameLabel = createLabel("🏷️ Tên hiển thị: " .. Player.DisplayName, 75, Frame)
local FPSLabel = createLabel("⏳ FPS: Đang tải...", 100, Frame)
local BodyFixLabel = createLabel("🔧 BodyFix: Tắt", 125, Frame)
local ESPLabel = createLabel("👁️ ESP: Tắt", 150, Frame)

local function updateFPS()
    local fps = math.floor(1 / RunService.RenderStepped:Wait())
    FPSLabel.Text = "⏳ FPS: " .. fps
end

spawn(function()
    while true do
        updateFPS()
        RunService.RenderStepped:Wait()
    end
end)

local function createButton(text, posY, color)
    local Button = Instance.new("TextButton", Frame)
    Button.Size = UDim2.new(1, -20, 0, 40)
    Button.Position = UDim2.new(0, 10, 0, posY)
    Button.Text = text
    Button.TextSize = 20
    Button.Font = Enum.Font.GothamBold
    Button.BackgroundColor3 = color
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.BorderSizePixel = 0

    local UICornerButton = Instance.new("UICorner", Button)
    UICornerButton.CornerRadius = UDim.new(0, 10)

    local UIStrokeButton = Instance.new("UIStroke", Button)
    UIStrokeButton.Thickness = 2
    UIStrokeButton.Color = color:Lerp(Color3.fromRGB(255, 255, 255), 0.3)
    UIStrokeButton.Transparency = 0.5

    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = color:Lerp(Color3.new(1,1,1), 0.2)}):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
    end)

    Button.MouseButton1Down:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundTransparency = 0.5}):Play()
    end)
    Button.MouseButton1Up:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
    end)

    return Button
end

local StartButton = createButton("▶ Bắt Đầu", 175, Color3.fromRGB(0, 200, 100))
local StopButton = createButton("⛔ Tắt Script", 225, Color3.fromRGB(200, 50, 50))
local CloseButton = createButton("❌ Đóng & Thoát", 275, Color3.fromRGB(255, 50, 50))
local ESPButton = createButton("👁️ Bật/Tắt ESP", 325, Color3.fromRGB(100, 100, 255))

local espEnabled = false
local espTable = {}

local function createESP(player)
    if player.Character and player.Character:FindFirstChild("Head") then
        local head = player.Character.Head
        local billboard = Instance.new("BillboardGui", head)
        billboard.Adornee = head
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 2, 0)
        billboard.AlwaysOnTop = true

        local textLabel = Instance.new("TextLabel", billboard)
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.Text = "🎮 " .. player.Name
        textLabel.TextColor3 = Color3.new(1, 1, 1)
        textLabel.BackgroundTransparency = 1
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextSize = 18

        espTable[player] = billboard
    end
end

local function removeESP(player)
    if espTable[player] then
        espTable[player]:Destroy()
        espTable[player] = nil
    end
end

local function toggleESP()
    espEnabled = not espEnabled

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Player then
            if espEnabled then
                createESP(player)
            else
                removeESP(player)
            end
        end
    end

    ESPLabel.Text = "👁️ ESP: " .. (espEnabled and "Bật" or "Tắt")

    local newColor = espEnabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    TweenService:Create(ESPButton, TweenInfo.new(0.3), {BackgroundColor3 = newColor}):Play()
end

ESPButton.MouseButton1Click:Connect(toggleESP)

Players.PlayerAdded:Connect(function(player)
    if espEnabled then
        createESP(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
end)

local running = false
local hackCoroutine = nil

local function startHack()
    running = true
    hackCoroutine = coroutine.create(function()
        while running do
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
            RunService.Heartbeat:Wait()
        end
    end)
    coroutine.resume(hackCoroutine)
    BodyFixLabel.Text = "🔧 BodyFix: Bật"
end

local function stopHack()
    running = false
    BodyFixLabel.Text = "🔧 BodyFix: Tắt"
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

UIS.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.RightShift and not gameProcessed then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)
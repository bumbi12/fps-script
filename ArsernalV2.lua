local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Teams = game:GetService("Teams")

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 350, 0, 430) -- Tăng chiều cao để thêm nút
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

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "🔥 TP Arsenal HUB 🔥"
Title.TextSize = 24
Title.Font = Enum.Font.GothamBlack
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.BorderSizePixel = 0

local PlayerLabel = Instance.new("TextLabel", Frame)
PlayerLabel.Size = UDim2.new(1, 0, 0, 25)
PlayerLabel.Position = UDim2.new(0, 0, 0, 50)
PlayerLabel.Text = "👤 Người chơi: " .. Player.Name
PlayerLabel.TextSize = 18
PlayerLabel.Font = Enum.Font.Gotham
PlayerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerLabel.BackgroundTransparency = 1

local DisplayNameLabel = Instance.new("TextLabel", Frame)
DisplayNameLabel.Size = UDim2.new(1, 0, 0, 25)
DisplayNameLabel.Position = UDim2.new(0, 0, 0, 75)
DisplayNameLabel.Text = "🏷️ Tên hiển thị: " .. Player.DisplayName
DisplayNameLabel.TextSize = 18
DisplayNameLabel.Font = Enum.Font.Gotham
DisplayNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DisplayNameLabel.BackgroundTransparency = 1

local FPSLabel = Instance.new("TextLabel", Frame)
FPSLabel.Size = UDim2.new(1, 0, 0, 25)
FPSLabel.Position = UDim2.new(0, 0, 0, 100)
FPSLabel.Text = "⏳ FPS: Đang tải..."
FPSLabel.TextSize = 18
FPSLabel.Font = Enum.Font.Gotham
FPSLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FPSLabel.BackgroundTransparency = 1

local BodyFixLabel = Instance.new("TextLabel", Frame)
BodyFixLabel.Size = UDim2.new(1, 0, 0, 25)
BodyFixLabel.Position = UDim2.new(0, 0, 0, 125)
BodyFixLabel.Text = "🔧 BodyFix: Tắt"
BodyFixLabel.TextSize = 18
BodyFixLabel.Font = Enum.Font.Gotham
BodyFixLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
BodyFixLabel.BackgroundTransparency = 1

local ESPLabel = Instance.new("TextLabel", Frame)
ESPLabel.Size = UDim2.new(1, 0, 0, 25)
ESPLabel.Position = UDim2.new(0, 0, 0, 150)
ESPLabel.Text = "👁️ ESP: Tắt"
ESPLabel.TextSize = 18
ESPLabel.Font = Enum.Font.Gotham
ESPLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPLabel.BackgroundTransparency = 1

local TracerLabel = Instance.new("TextLabel", Frame)
TracerLabel.Size = UDim2.new(1, 0, 0, 25)
TracerLabel.Position = UDim2.new(0, 0, 0, 175)
TracerLabel.Text = "📌 Tracer: Tắt"
TracerLabel.TextSize = 18
TracerLabel.Font = Enum.Font.Gotham
TracerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TracerLabel.BackgroundTransparency = 1

spawn(function()
    while wait(1) do
        local fps = math.floor(1 / RunService.RenderStepped:Wait())
        FPSLabel.Text = "⏳ FPS: " .. fps
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

local StartButton = createButton("▶ Bắt Đầu", 200, Color3.fromRGB(0, 200, 100))
local StopButton = createButton("⛔ Tắt Script", 250, Color3.fromRGB(200, 50, 50))
local CloseButton = createButton("❌ Đóng & Thoát", 300, Color3.fromRGB(255, 50, 50))

local ESPButton = createButton("👁️ Bật/Tắt ESP", 350, Color3.fromRGB(100, 100, 255))
local TracerButton = createButton("📌 Bật/Tắt Tracer", 400, Color3.fromRGB(150, 100, 255))

-- Cấu hình ESP từ script highlight ban đầu
local nameOffset = Vector3.new(0, 3, 0)
local defaultColor = Color3.fromRGB(255, 255, 255)
local textSize = 2
local showTeamName = true
local showDistance = true
local showWallHiding = true
local espEnabled = false
local tracerEnabled = false

local function createNameTag(character, player)
    if not character:FindFirstChild("Head") then
        character:WaitForChild("Head")
    end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PlayerNameTag"
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = nameOffset
    billboard.Adornee = character.Head
    billboard.Parent = character
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = defaultColor
    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.Parent = billboard
    
    local tracer
    if tracerEnabled then
        tracer = Instance.new("Frame")
        tracer.Name = "Tracer_"..player.Name
        tracer.AnchorPoint = Vector2.new(0.5, 0.5)
        tracer.BackgroundColor3 = defaultColor
        tracer.BorderSizePixel = 0
        tracer.Size = UDim2.new(0, 1, 0, 1)
        tracer.Parent = ScreenGui
    end
    
    local function updateTeamColor()
        local team = player.Team
        if team then
            nameLabel.TextColor3 = team.TeamColor.Color
            nameLabel.Text = showTeamName and (player.Name .. " (" .. team.Name .. ")") or player.Name
        else
            nameLabel.TextColor3 = defaultColor
            nameLabel.Text = player.Name
        end
    end
    
    player:GetPropertyChangedSignal("Team"):Connect(updateTeamColor)
    updateTeamColor()
    
    local function update()
        if not character or not character.Parent or not character:FindFirstChild("Head") then
            if billboard then billboard:Destroy() end
            if tracer then tracer:Destroy() end
            return
        end
        
        if showDistance then
            local distance = (Player.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
            nameLabel.Text = nameLabel.Text:gsub("%[.+%]", "") .. string.format(" [%.1fm]", distance)
        end
        
        if showWallHiding then
            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = {Player.Character, character}
            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
            
            local raycastResult = workspace:Raycast(
                workspace.CurrentCamera.CFrame.Position,
                character.Head.Position - workspace.CurrentCamera.CFrame.Position,
                raycastParams
            )
            
            if raycastResult then
                nameLabel.Text = nameLabel.Text:gsub(" %(Hide%)", "") .. " (Hide)"
            else
                nameLabel.Text = nameLabel.Text:gsub(" %(Hide%)", "")
            end
        end
        
        if tracer then
            local origin = Vector2.new(ScreenGui.AbsoluteSize.X/2, ScreenGui.AbsoluteSize.Y)
            local headPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(character.Head.Position)
            
            if onScreen then
                tracer.Visible = true
                tracer.Position = UDim2.new(0, origin.X, 0, origin.Y)
                tracer.Size = UDim2.new(0, 2, 0, (Vector2.new(headPos.X, headPos.Y) - origin).Magnitude)
                tracer.Rotation = math.deg(math.atan2(headPos.Y - origin.Y, headPos.X - origin.X)) + 90
                tracer.BackgroundColor3 = nameLabel.TextColor3
            else
                tracer.Visible = false
            end
        end
    end
    
    local connection
    connection = RunService.RenderStepped:Connect(function()
        if not espEnabled or not character or not character.Parent then
            connection:Disconnect()
            if billboard then billboard:Destroy() end
            if tracer then tracer:Destroy() end
            return
        end
        update()
    end)
end

local function removeNameTag(player)
    if player.Character then
        for _, child in pairs(player.Character:GetDescendants()) do
            if child.Name == "PlayerNameTag" then
                child:Destroy()
            end
        end
    end
    for _, child in pairs(ScreenGui:GetChildren()) do
        if child.Name == "Tracer_"..player.Name then
            child:Destroy()
        end
    end
end

local function toggleESP()
    espEnabled = not espEnabled
    
    if espEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Player then
                if player.Character then
                    createNameTag(player.Character, player)
                end
                player.CharacterAdded:Connect(function(character)
                    createNameTag(character, player)
                end)
            end
        end
    else
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Player then
                removeNameTag(player)
            end
        end
    end
    
    ESPLabel.Text = "👁️ ESP: " .. (espEnabled and "Bật" or "Tắt")
    local newColor = espEnabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    TweenService:Create(ESPButton, TweenInfo.new(0.3), {BackgroundColor3 = newColor}):Play()
end

local function toggleTracer()
    tracerEnabled = not tracerEnabled
    
    if espEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= Player then
                removeNameTag(player)
                if player.Character then
                    createNameTag(player.Character, player)
                end
            end
        end
    end
    
    TracerLabel.Text = "📌 Tracer: " .. (tracerEnabled and "Bật" or "Tắt")
    local newColor = tracerEnabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    TweenService:Create(TracerButton, TweenInfo.new(0.3), {BackgroundColor3 = newColor}):Play()
end

ESPButton.MouseButton1Click:Connect(toggleESP)
TracerButton.MouseButton1Click:Connect(toggleTracer)

Players.PlayerAdded:Connect(function(player)
    if espEnabled then
        player.CharacterAdded:Connect(function(character)
            createNameTag(character, player)
        end)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    removeNameTag(player)
end)

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

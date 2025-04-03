getgenv().Config = {
    WalkSpeed = 16,
    FlySpeed = 50,
    Flying = false,
    Teleporting = false,
    AutoCollectCoins = false,
    CoinCheckInterval = 0.5,
    GuiEnabled = true
}

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- Color Scheme
local ColorPalette = {
    Background = Color3.fromRGB(20, 20, 25),
    Header = Color3.fromRGB(15, 15, 20),
    TabButton = Color3.fromRGB(30, 30, 40),
    TabButtonActive = Color3.fromRGB(80, 50, 120),
    Text = Color3.fromRGB(240, 240, 240),
    Accent = Color3.fromRGB(140, 80, 200),
    Button = Color3.fromRGB(50, 50, 70),
    ButtonActive = Color3.fromRGB(100, 60, 160),
    Warning = Color3.fromRGB(200, 80, 80),
    Success = Color3.fromRGB(80, 200, 120),
    Info = Color3.fromRGB(100, 180, 240)
}

-- UI Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TPHideNSeekHUB"
ScreenGui.Parent = CoreGui

local MainWindow = Instance.new("Frame")
MainWindow.Name = "MainWindow"
MainWindow.Size = UDim2.new(0, 320, 0, 330)
MainWindow.Position = UDim2.new(0.5, -160, 0.5, -140)
MainWindow.AnchorPoint = Vector2.new(0.5, 0.5)
MainWindow.BackgroundColor3 = ColorPalette.Background
MainWindow.BorderSizePixel = 0
MainWindow.Active = true
MainWindow.Draggable = true
MainWindow.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainWindow

local DropShadow = Instance.new("ImageLabel")
DropShadow.Name = "DropShadow"
DropShadow.Size = UDim2.new(1, 10, 1, 10)
DropShadow.Position = UDim2.new(0, -5, 0, -5)
DropShadow.BackgroundTransparency = 1
DropShadow.Image = "rbxassetid://1316045217"
DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
DropShadow.ImageTransparency = 0.8
DropShadow.ScaleType = Enum.ScaleType.Slice
DropShadow.SliceCenter = Rect.new(10, 10, 118, 118)
DropShadow.Parent = MainWindow

-- Header
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 35)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = ColorPalette.Header
Header.BorderSizePixel = 0
Header.Parent = MainWindow

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = ColorPalette.Text
Title.Text = "TP HideNSeek HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0.5, -12)
CloseButton.BackgroundColor3 = ColorPalette.Warning
CloseButton.TextColor3 = ColorPalette.Text
CloseButton.Text = "×"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = Header

local CloseButtonCorner = Instance.new("UICorner")
CloseButtonCorner.CornerRadius = UDim.new(1, 0)
CloseButtonCorner.Parent = CloseButton

-- Tab Buttons
local TabButtons = Instance.new("Frame")
TabButtons.Name = "TabButtons"
TabButtons.Size = UDim2.new(1, -20, 0, 30)
TabButtons.Position = UDim2.new(0, 10, 0, 40)
TabButtons.BackgroundTransparency = 1
TabButtons.Parent = MainWindow

local MovementTabButton = Instance.new("TextButton")
MovementTabButton.Name = "MovementTabButton"
MovementTabButton.Size = UDim2.new(0.5, -5, 1, 0)
MovementTabButton.Position = UDim2.new(0, 0, 0, 0)
MovementTabButton.BackgroundColor3 = ColorPalette.TabButtonActive
MovementTabButton.TextColor3 = ColorPalette.Text
MovementTabButton.Text = "MOVEMENT"
MovementTabButton.Font = Enum.Font.GothamBold
MovementTabButton.TextSize = 12
MovementTabButton.Parent = TabButtons

local MovementTabButtonCorner = Instance.new("UICorner")
MovementTabButtonCorner.CornerRadius = UDim.new(0, 6)
MovementTabButtonCorner.Parent = MovementTabButton

local CoinTabButton = Instance.new("TextButton")
CoinTabButton.Name = "CoinTabButton"
CoinTabButton.Size = UDim2.new(0.5, -5, 1, 0)
CoinTabButton.Position = UDim2.new(0.5, 5, 0, 0)
CoinTabButton.BackgroundColor3 = ColorPalette.TabButton
CoinTabButton.TextColor3 = ColorPalette.Text
CoinTabButton.Text = "COIN COLLECTOR"
CoinTabButton.Font = Enum.Font.GothamBold
CoinTabButton.TextSize = 12
CoinTabButton.Parent = TabButtons

local CoinTabButtonCorner = Instance.new("UICorner")
CoinTabButtonCorner.CornerRadius = UDim.new(0, 6)
CoinTabButtonCorner.Parent = CoinTabButton

-- Tab Content
local TabContent = Instance.new("Frame")
TabContent.Name = "TabContent"
TabContent.Size = UDim2.new(1, -20, 1, -85)
TabContent.Position = UDim2.new(0, 10, 0, 75)
TabContent.BackgroundTransparency = 1
TabContent.Parent = MainWindow

-- Movement Tab
local MovementTab = Instance.new("Frame")
MovementTab.Name = "MovementTab"
MovementTab.Size = UDim2.new(1, 0, 1, 0)
MovementTab.BackgroundTransparency = 1
MovementTab.Visible = true
MovementTab.Parent = TabContent

local SpeedContainer = Instance.new("Frame")
SpeedContainer.Name = "SpeedContainer"
SpeedContainer.Size = UDim2.new(1, 0, 0, 60)
SpeedContainer.Position = UDim2.new(0, 0, 0, 0)
SpeedContainer.BackgroundTransparency = 1
SpeedContainer.Parent = MovementTab

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Name = "SpeedLabel"
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0, 0, 0, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.TextColor3 = ColorPalette.Text
SpeedLabel.Text = "WALK SPEED"
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 12
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = SpeedContainer

local SpeedBox = Instance.new("TextBox")
SpeedBox.Name = "SpeedBox"
SpeedBox.Size = UDim2.new(1, 0, 0, 30)
SpeedBox.Position = UDim2.new(0, 0, 0, 25)
SpeedBox.BackgroundColor3 = ColorPalette.Button
SpeedBox.TextColor3 = ColorPalette.Text
SpeedBox.Text = tostring(getgenv().Config.WalkSpeed)
SpeedBox.Font = Enum.Font.Gotham
SpeedBox.TextSize = 14
SpeedBox.Parent = SpeedContainer

local SpeedBoxCorner = Instance.new("UICorner")
SpeedBoxCorner.CornerRadius = UDim.new(0, 6)
SpeedBoxCorner.Parent = SpeedBox

local FlySpeedContainer = Instance.new("Frame")
FlySpeedContainer.Name = "FlySpeedContainer"
FlySpeedContainer.Size = UDim2.new(1, 0, 0, 60)
FlySpeedContainer.Position = UDim2.new(0, 0, 0, 70)
FlySpeedContainer.BackgroundTransparency = 1
FlySpeedContainer.Parent = MovementTab

local FlySpeedLabel = Instance.new("TextLabel")
FlySpeedLabel.Name = "FlySpeedLabel"
FlySpeedLabel.Size = UDim2.new(1, 0, 0, 20)
FlySpeedLabel.Position = UDim2.new(0, 0, 0, 0)
FlySpeedLabel.BackgroundTransparency = 1
FlySpeedLabel.TextColor3 = ColorPalette.Text
FlySpeedLabel.Text = "FLY SPEED"
FlySpeedLabel.Font = Enum.Font.Gotham
FlySpeedLabel.TextSize = 12
FlySpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
FlySpeedLabel.Parent = FlySpeedContainer

local FlySpeedBox = Instance.new("TextBox")
FlySpeedBox.Name = "FlySpeedBox"
FlySpeedBox.Size = UDim2.new(1, 0, 0, 30)
FlySpeedBox.Position = UDim2.new(0, 0, 0, 25)
FlySpeedBox.BackgroundColor3 = ColorPalette.Button
FlySpeedBox.TextColor3 = ColorPalette.Text
FlySpeedBox.Text = tostring(getgenv().Config.FlySpeed)
FlySpeedBox.Font = Enum.Font.Gotham
FlySpeedBox.TextSize = 14
FlySpeedBox.Parent = FlySpeedContainer

local FlySpeedBoxCorner = Instance.new("UICorner")
FlySpeedBoxCorner.CornerRadius = UDim.new(0, 6)
FlySpeedBoxCorner.Parent = FlySpeedBox

local FlyButton = Instance.new("TextButton")
FlyButton.Name = "FlyButton"
FlyButton.Size = UDim2.new(1, 0, 0, 40)
FlyButton.Position = UDim2.new(0, 0, 0, 140)
FlyButton.BackgroundColor3 = ColorPalette.Button
FlyButton.TextColor3 = ColorPalette.Text
FlyButton.Text = "TOGGLE FLY [F]"
FlyButton.Font = Enum.Font.GothamBold
FlyButton.TextSize = 14
FlyButton.Parent = MovementTab

local FlyButtonCorner = Instance.new("UICorner")
FlyButtonCorner.CornerRadius = UDim.new(0, 6)
FlyButtonCorner.Parent = FlyButton

local TeleportInfo = Instance.new("TextLabel")
TeleportInfo.Name = "TeleportInfo"
TeleportInfo.Size = UDim2.new(1, 0, 0, 40)
TeleportInfo.Position = UDim2.new(0, 0, 1, -40)
TeleportInfo.BackgroundTransparency = 1
TeleportInfo.TextColor3 = ColorPalette.Info
TeleportInfo.Text = "Hold CTRL + Click to teleport\nPress F to toggle fly"
TeleportInfo.Font = Enum.Font.Gotham
TeleportInfo.TextSize = 11
TeleportInfo.TextWrapped = true
TeleportInfo.Parent = MovementTab

-- Coin Tab
local CoinTab = Instance.new("Frame")
CoinTab.Name = "CoinTab"
CoinTab.Size = UDim2.new(1, 0, 1, 0)
CoinTab.BackgroundTransparency = 1
CoinTab.Visible = false
CoinTab.Parent = TabContent

local AutoCollectButton = Instance.new("TextButton")
AutoCollectButton.Name = "AutoCollectButton"
AutoCollectButton.Size = UDim2.new(1, 0, 0, 40)
AutoCollectButton.Position = UDim2.new(0, 0, 0, 0)
AutoCollectButton.BackgroundColor3 = ColorPalette.Button
AutoCollectButton.TextColor3 = ColorPalette.Text
AutoCollectButton.Text = "AUTO COLLECT: OFF"
AutoCollectButton.Font = Enum.Font.GothamBold
AutoCollectButton.TextSize = 14
AutoCollectButton.Parent = CoinTab

local AutoCollectButtonCorner = Instance.new("UICorner")
AutoCollectButtonCorner.CornerRadius = UDim.new(0, 6)
AutoCollectButtonCorner.Parent = AutoCollectButton

local NearestCoinButton = Instance.new("TextButton")
NearestCoinButton.Name = "NearestCoinButton"
NearestCoinButton.Size = UDim2.new(1, 0, 0, 40)
NearestCoinButton.Position = UDim2.new(0, 0, 0, 50)
NearestCoinButton.BackgroundColor3 = ColorPalette.Button
NearestCoinButton.TextColor3 = ColorPalette.Text
NearestCoinButton.Text = "TP TO NEAREST COIN"
NearestCoinButton.Font = Enum.Font.GothamBold
NearestCoinButton.TextSize = 14
NearestCoinButton.Parent = CoinTab

local NearestCoinButtonCorner = Instance.new("UICorner")
NearestCoinButtonCorner.CornerRadius = UDim.new(0, 6)
NearestCoinButtonCorner.Parent = NearestCoinButton

local CoinStatus = Instance.new("TextLabel")
CoinStatus.Name = "CoinStatus"
CoinStatus.Size = UDim2.new(1, 0, 0, 20)
CoinStatus.Position = UDim2.new(0, 0, 1, -30)
CoinStatus.BackgroundTransparency = 1
CoinStatus.TextColor3 = ColorPalette.Info
CoinStatus.Text = "🪙 Coins remaining: Loading..."
CoinStatus.Font = Enum.Font.Gotham
CoinStatus.TextSize = 12
CoinStatus.TextXAlignment = Enum.TextXAlignment.Left
CoinStatus.Parent = CoinTab

-- Functions
local function switchTab(tabName)
    for _, tab in ipairs(TabContent:GetChildren()) do
        tab.Visible = false
    end
    
    if tabName == "Movement" then
        MovementTab.Visible = true
        MovementTabButton.BackgroundColor3 = ColorPalette.TabButtonActive
        CoinTabButton.BackgroundColor3 = ColorPalette.TabButton
    elseif tabName == "Coins" then
        CoinTab.Visible = true
        MovementTabButton.BackgroundColor3 = ColorPalette.TabButton
        CoinTabButton.BackgroundColor3 = ColorPalette.TabButtonActive
    end
end

local function getCoins()
    local coins = {}
    local coinFolder = workspace:FindFirstChild("GameObjects")
    if coinFolder then
        for _, obj in ipairs(coinFolder:GetChildren()) do
            if obj.Name == "Coin" or obj:IsA("BasePart") then
                table.insert(coins, obj)
            end
        end
    end
    return coins
end

local function updateCoinStatus()
    local coins = getCoins()
    CoinStatus.Text = "🪙 Coins remaining: "..#coins
end

local function findNearestCoin()
    local character = LocalPlayer.Character
    if not character then return nil end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
    if not rootPart then return nil end
    
    local coins = getCoins()
    local nearestCoin = nil
    local shortestDistance = math.huge
    
    for _, coin in ipairs(coins) do
        local distance = (rootPart.Position - coin.Position).Magnitude
        if distance < shortestDistance then
            shortestDistance = distance
            nearestCoin = coin
        end
    end
    
    return nearestCoin
end

local function teleportToCoin()
    local coin = findNearestCoin()
    if coin then
        local character = LocalPlayer.Character
        if not character then return end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
        if not rootPart then return end
        
        rootPart.CFrame = CFrame.new(coin.Position + Vector3.new(0, 3, 0))
    end
end

local function autoCollectCoins()
    while getgenv().Config.AutoCollectCoins do
        local coin = findNearestCoin()
        if coin then
            teleportToCoin()
        end
        wait(getgenv().Config.CoinCheckInterval)
    end
end

local flyBodyVelocity, flyBodyGyro

local function startFlying()
    if getgenv().Config.Flying then return end
    
    local character = LocalPlayer.Character
    if not character then return end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
    if not rootPart then return end
    
    flyBodyVelocity = Instance.new("BodyVelocity")
    flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
    flyBodyVelocity.MaxForce = Vector3.new(0, 0, 0)
    flyBodyVelocity.P = 1000
    flyBodyVelocity.Parent = rootPart
    
    flyBodyGyro = Instance.new("BodyGyro")
    flyBodyGyro.MaxTorque = Vector3.new(0, 0, 0)
    flyBodyGyro.P = 1000
    flyBodyGyro.D = 50
    flyBodyGyro.Parent = rootPart
    
    flyBodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    flyBodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    
    getgenv().Config.Flying = true
    FlyButton.BackgroundColor3 = ColorPalette.ButtonActive
    FlyButton.Text = "FLYING [F]"
    
    local flyConnection
    flyConnection = RunService.Heartbeat:Connect(function()
        if not getgenv().Config.Flying then 
            flyConnection:Disconnect()
            return 
        end
        
        local character = LocalPlayer.Character
        if not character or not rootPart or rootPart.Parent ~= character then
            getgenv().Config.Flying = false
            flyConnection:Disconnect()
            return
        end
        
        local camera = workspace.CurrentCamera
        local direction = Vector3.new()
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            direction = direction + (camera.CFrame.LookVector * getgenv().Config.FlySpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            direction = direction - (camera.CFrame.LookVector * getgenv().Config.FlySpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            direction = direction - (camera.CFrame.RightVector * getgenv().Config.FlySpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            direction = direction + (camera.CFrame.RightVector * getgenv().Config.FlySpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            direction = direction + Vector3.new(0, getgenv().Config.FlySpeed, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            direction = direction - Vector3.new(0, getgenv().Config.FlySpeed, 0)
        end
        
        flyBodyVelocity.Velocity = direction
        flyBodyGyro.CFrame = camera.CFrame
    end)
end

local function stopFlying()
    if not getgenv().Config.Flying then return end
    
    if flyBodyVelocity then flyBodyVelocity:Destroy() end
    if flyBodyGyro then flyBodyGyro:Destroy() end
    
    getgenv().Config.Flying = false
    FlyButton.BackgroundColor3 = ColorPalette.Button
    FlyButton.Text = "TOGGLE FLY [F]"
end

local function toggleFly()
    if getgenv().Config.Flying then
        stopFlying()
    else
        startFlying()
    end
end

local function setSpeed(speed)
    if tonumber(speed) then
        getgenv().Config.WalkSpeed = tonumber(speed)
        SpeedBox.Text = tostring(getgenv().Config.WalkSpeed)
        
        if LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = getgenv().Config.WalkSpeed
            end
        end
    end
end

local function setFlySpeed(speed)
    if tonumber(speed) then
        getgenv().Config.FlySpeed = tonumber(speed)
        FlySpeedBox.Text = tostring(getgenv().Config.FlySpeed)
    end
end

local function toggleAutoCollect()
    getgenv().Config.AutoCollectCoins = not getgenv().Config.AutoCollectCoins
    if getgenv().Config.AutoCollectCoins then
        AutoCollectButton.BackgroundColor3 = ColorPalette.Success
        AutoCollectButton.Text = "AUTO COLLECT: ON"
        autoCollectCoins()
    else
        AutoCollectButton.BackgroundColor3 = ColorPalette.Button
        AutoCollectButton.Text = "AUTO COLLECT: OFF"
    end
end

-- Connections
MovementTabButton.MouseButton1Click:Connect(function()
    switchTab("Movement")
end)

CoinTabButton.MouseButton1Click:Connect(function()
    switchTab("Coins")
end)

FlyButton.MouseButton1Click:Connect(toggleFly)
AutoCollectButton.MouseButton1Click:Connect(toggleAutoCollect)
NearestCoinButton.MouseButton1Click:Connect(teleportToCoin)

FlySpeedBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then setFlySpeed(FlySpeedBox.Text) end
end)

SpeedBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then setSpeed(SpeedBox.Text) end
end)

CloseButton.MouseButton1Click:Connect(function()
    stopFlying()
    getgenv().Config.AutoCollectCoins = false
    ScreenGui:Destroy()
    getgenv().Config.GuiEnabled = false
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not getgenv().Config.GuiEnabled then return end
    
    if input.KeyCode == Enum.KeyCode.F and not gameProcessed then
        toggleFly()
    end
    
    if input.UserInputType == Enum.UserInputType.MouseButton1 and 
       (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)) then
        local targetPosition = Mouse.Hit.Position
        local character = LocalPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
            if rootPart then
                rootPart.CFrame = CFrame.new(targetPosition)
            end
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(character)
    wait(0.5)
    setSpeed(getgenv().Config.WalkSpeed)
    if getgenv().Config.Flying then
        wait(0.2)
        startFlying()
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F5 then
        MainWindow.Visible = not MainWindow.Visible
    end
end)

-- Initialize
setSpeed(getgenv().Config.WalkSpeed)
setFlySpeed(getgenv().Config.FlySpeed)
switchTab("Movement")

spawn(function()
    while wait(1) do
        if getgenv().Config.GuiEnabled then
            updateCoinStatus()
        else
            break
        end
    end
end)

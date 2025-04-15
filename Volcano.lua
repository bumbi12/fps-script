local Player = game:GetService("Players").LocalPlayer
local VolcanoModule = {Running = false, Connection = nil}
local OriginalPosition = nil

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShinraiDungeonControl"
ScreenGui.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 320, 0, 180)
Frame.Position = UDim2.new(0.5, -160, 0.5, -90)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Frame

local borderParts = {}
local borderThickness = 3
local borderAnimationSpeed = 0.02

for i = 1, 4 do
    local part = Instance.new("Frame")
    part.BorderSizePixel = 0
    part.ZIndex = 2
    part.Parent = Frame
    
    if i == 1 then
        part.Size = UDim2.new(1, 0, 0, borderThickness)
        part.Position = UDim2.new(0, 0, 0, 0)
    elseif i == 2 then
        part.Size = UDim2.new(0, borderThickness, 1, 0)
        part.Position = UDim2.new(1, -borderThickness, 0, 0)
    elseif i == 3 then
        part.Size = UDim2.new(1, 0, 0, borderThickness)
        part.Position = UDim2.new(0, 0, 1, -borderThickness)
    elseif i == 4 then
        part.Size = UDim2.new(0, borderThickness, 1, 0)
        part.Position = UDim2.new(0, 0, 0, 0)
    end
    
    table.insert(borderParts, part)
end

task.spawn(function()
    local hue = 0
    while ScreenGui.Parent do
        hue = (hue + 0.005) % 1
        for _, part in ipairs(borderParts) do
            part.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
        end
        task.wait(borderAnimationSpeed)
    end
end)

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Frame

local UICornerTitle = Instance.new("UICorner")
UICornerTitle.CornerRadius = UDim.new(0, 12)
UICornerTitle.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Text = "SHINRAI DUNGEON"
Title.Size = UDim2.new(0.8, 0, 1, 0)
Title.Position = UDim2.new(0.1, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Text = "×"
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.GothamBlack
CloseButton.TextSize = 20
CloseButton.Parent = TitleBar

local UICornerClose = Instance.new("UICorner")
UICornerClose.CornerRadius = UDim.new(0, 12)
UICornerClose.Parent = CloseButton

CloseButton.MouseEnter:Connect(function()
    CloseButton.BackgroundColor3 = Color3.fromRGB(220, 70, 70)
end)

CloseButton.MouseLeave:Connect(function()
    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
end)

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -60)
Content.Position = UDim2.new(0, 10, 0, 50)
Content.BackgroundTransparency = 1
Content.Parent = Frame

local ModuleLabel = Instance.new("TextLabel")
ModuleLabel.Text = "TỰ PHÁ NÚI LỬA"
ModuleLabel.Size = UDim2.new(1, 0, 0, 24)
ModuleLabel.BackgroundTransparency = 1
ModuleLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
ModuleLabel.Font = Enum.Font.GothamBold
ModuleLabel.TextSize = 14
ModuleLabel.TextXAlignment = Enum.TextXAlignment.Left
ModuleLabel.Parent = Content

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Text = "Trạng thái: TẮT"
StatusLabel.Size = UDim2.new(0.5, 0, 0, 24)
StatusLabel.Position = UDim2.new(0.5, 0, 0, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextSize = 14
StatusLabel.TextXAlignment = Enum.TextXAlignment.Right
StatusLabel.Parent = Content

local ToggleButton = Instance.new("TextButton")
ToggleButton.Text = "BẬT"
ToggleButton.Size = UDim2.new(1, 0, 0, 32)
ToggleButton.Position = UDim2.new(0, 0, 0, 30)
ToggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 14
ToggleButton.Parent = Content

local UICornerToggle = Instance.new("UICorner")
UICornerToggle.CornerRadius = UDim.new(0, 8)
UICornerToggle.Parent = ToggleButton

ToggleButton.MouseEnter:Connect(function()
    ToggleButton.BackgroundColor3 = Color3.fromRGB(90, 90, 110)
end)

ToggleButton.MouseLeave:Connect(function()
    if not VolcanoModule.Running then
        ToggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
    end
end)

local CreditLabel = Instance.new("TextLabel")
CreditLabel.Text = "Script by TamPham"
CreditLabel.Size = UDim2.new(1, -10, 0, 20)
CreditLabel.Position = UDim2.new(0, 10, 1, -25)
CreditLabel.BackgroundTransparency = 1
CreditLabel.Font = Enum.Font.Gotham
CreditLabel.TextSize = 12
CreditLabel.TextXAlignment = Enum.TextXAlignment.Right
CreditLabel.Parent = Frame

task.spawn(function()
    local hue = 0
    while ScreenGui.Parent do
        hue = (hue + 0.01) % 1
        CreditLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
        task.wait(0.05)
    end
end)

local function processVolcanoes()
    local character = Player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    if not OriginalPosition then
        OriginalPosition = character.HumanoidRootPart.CFrame
    end
    
    local rootPart = character.HumanoidRootPart
    local volcanoes = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Volcanoes")
    if not volcanoes then return end
    
    for _, v in ipairs(volcanoes:GetChildren()) do
        if not VolcanoModule.Running then break end
        local prompt = v:FindFirstChild("ProximityPrompt")
        if prompt and prompt.Enabled then
            rootPart.CFrame = v.PrimaryPart.CFrame + Vector3.new(0, 3, 0)
            task.wait(0.2)
            for _ = 1, 3 do
                fireproximityprompt(prompt)
                task.wait(0.1)
            end
            while VolcanoModule.Running and prompt and prompt.Enabled do
                task.wait(0.5)
            end
        end
    end
    
    if VolcanoModule.Running and OriginalPosition then
        rootPart.CFrame = OriginalPosition
    end
end

local function runModule()
    if VolcanoModule.Running then
        while VolcanoModule.Running and task.wait(1) do
            pcall(processVolcanoes)
        end
    end
end

local function updateStatus()
    if VolcanoModule.Running then
        StatusLabel.Text = "Trạng thái: BẬT"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        ToggleButton.Text = "TẮT"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    else
        StatusLabel.Text = "Trạng thái: TẮT"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        ToggleButton.Text = "BẬT"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
    end
end

ToggleButton.MouseButton1Click:Connect(function()
    VolcanoModule.Running = not VolcanoModule.Running
    if VolcanoModule.Running then
        if VolcanoModule.Connection then
            VolcanoModule.Connection:Disconnect()
        end
        VolcanoModule.Connection = game:GetService("RunService").Heartbeat:Connect(runModule)
    else
        if VolcanoModule.Connection then
            VolcanoModule.Connection:Disconnect()
            VolcanoModule.Connection = nil
        end
    end
    updateStatus()
end)

CloseButton.MouseButton1Click:Connect(function()
    if VolcanoModule.Connection then
        VolcanoModule.Connection:Disconnect()
    end
    ScreenGui:Destroy()
end)

updateStatus()

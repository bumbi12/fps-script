-- Tạo GUI
local gui = Instance.new("ScreenGui")
gui.Name = "PingFPSPanel"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

-- Tạo Frame
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 200, 0, 100)
panel.Position = UDim2.new(0.02, 0, 0.02, 0)
panel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
panel.BackgroundTransparency = 0.2
panel.BorderSizePixel = 0
panel.Active = true
panel.Draggable = true
panel.Parent = gui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = panel

-- Tiêu đề
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 20)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "TPM Fisch Hub v1"
title.Font = Enum.Font.GothamBold
title.TextSize = 12
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = panel

-- Hiển thị FPS
local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(1, 0, 0, 25)
fpsLabel.Position = UDim2.new(0, 0, 0, 25)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: Calculating..."
fpsLabel.Font = Enum.Font.Gotham
fpsLabel.TextSize = 12
fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
fpsLabel.Parent = panel

-- Hiển thị Ping
local pingLabel = Instance.new("TextLabel")
pingLabel.Size = UDim2.new(1, 0, 0, 25)
pingLabel.Position = UDim2.new(0, 0, 0, 50)
pingLabel.BackgroundTransparency = 1
pingLabel.Text = "Ping: Calculating..."
pingLabel.Font = Enum.Font.Gotham
pingLabel.TextSize = 12
pingLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
pingLabel.Parent = panel

-- Nút ẩn/hiện
local function createButton(text, position, color)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 60, 0, 20)
    button.Position = position
    button.BackgroundColor3 = color
    button.Text = text
    button.Font = Enum.Font.GothamBold
    button.TextSize = 12
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    button.Parent = panel
    return button
end

local toggleButton = createButton("Ẩn", UDim2.new(1, -130, 0, 75), Color3.fromRGB(255, 100, 100))
local killButton = createButton("Kill", UDim2.new(1, -65, 0, 75), Color3.fromRGB(255, 50, 50))

toggleButton.MouseButton1Click:Connect(function()
    panel.Visible = not panel.Visible
    toggleButton.Text = panel.Visible and "Ẩn" or "Hiện"
end)

killButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Cập nhật FPS và Ping
local RunService = game:GetService("RunService")
local lastTick = tick()
local fps
local updateConnection

updateConnection = RunService.Heartbeat:Connect(function()
    local currentTick = tick()
    fps = math.floor(1 / (currentTick - lastTick))
    lastTick = currentTick

    local success, ping = pcall(function()
        return math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
    end)

    fpsLabel.Text = "FPS: " .. tostring(fps)
    pingLabel.Text = "Ping: " .. (success and tostring(ping) .. " ms" or "N/A")
end)

killButton.MouseButton1Click:Connect(function()
    updateConnection:Disconnect()
    gui:Destroy()
end)

print("Ping & FPS Panel Loaded.")

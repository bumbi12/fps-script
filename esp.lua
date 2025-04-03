local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local RunService = game:GetService("RunService")

local nameOffset = Vector3.new(0, 2, 0)
local defaultColor = Color3.fromRGB(255, 255, 255)
local textSize = 1.2
local showTeamName = true
local showDistance = true
local showWallHiding = true

local function createNameTag(character, player)
    if not character:FindFirstChild("Head") then
        character:WaitForChild("Head")
    end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PlayerNameTag"
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 150, 0, 40)
    billboard.StudsOffset = nameOffset
    billboard.Adornee = character.Head
    billboard.Parent = character
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, 0, 0.6, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = defaultColor
    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextSize = textSize
    nameLabel.Parent = billboard

    local distanceLabel = showDistance and Instance.new("TextLabel") or nil
    if distanceLabel then
        distanceLabel.Name = "DistanceLabel"
        distanceLabel.Size = UDim2.new(1, 0, 0.4, 0)
        distanceLabel.Position = UDim2.new(0, 0, 0.6, 0)
        distanceLabel.BackgroundTransparency = 1
        distanceLabel.Text = "0m"
        distanceLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        distanceLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
        distanceLabel.TextStrokeTransparency = 0
        distanceLabel.TextScaled = true
        distanceLabel.Font = Enum.Font.SourceSans
        distanceLabel.TextSize = textSize * 0.8
        distanceLabel.Parent = billboard
    end

    local function updateTeamColor()
        local team = player.Team
        local baseName = player.Name
        if team then
            nameLabel.TextColor3 = team.TeamColor.Color
            baseName = showTeamName and (baseName .. " (" .. team.Name .. ")") or baseName
        else
            nameLabel.TextColor3 = defaultColor
        end
        nameLabel.Text = baseName
    end

    player:GetPropertyChangedSignal("Team"):Connect(updateTeamColor)
    updateTeamColor()

    if showDistance or showWallHiding then
        local localPlayer = Players.LocalPlayer
        local localCharacter = localPlayer.Character or localPlayer.CharacterAdded:Wait()
        local localHead = localCharacter:WaitForChild("Head")
        local baseName = player.Name
        
        local connection
        connection = RunService.Heartbeat:Connect(function()
            if not character or not character.Parent or not character:FindFirstChild("Head") then
                connection:Disconnect()
                return
            end
            
            if showDistance and distanceLabel then
                local distance = (localHead.Position - character.Head.Position).Magnitude
                distanceLabel.Text = string.format("%.1fm", distance)
            end
            
            if showWallHiding then
                local raycastParams = RaycastParams.new()
                raycastParams.FilterDescendantsInstances = {localCharacter, character}
                raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                
                local raycastResult = workspace:Raycast(localHead.Position, character.Head.Position - localHead.Position, raycastParams)
                local isHiding = raycastResult and true or false
                
                local team = player.Team
                local displayName = baseName
                
                if team and showTeamName then
                    displayName = displayName .. " (" .. team.Name .. ")"
                end
                
                if isHiding then
                    displayName = displayName .. " (Hide)"
                end
                
                nameLabel.Text = displayName
            end
        end)

        character.AncestryChanged:Connect(function(_, parent)
            if not parent then
                connection:Disconnect()
            end
        end)
    end
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        createNameTag(character, player)
    end)
    
    if player.Character then
        createNameTag(player.Character, player)
    end
end

Players.PlayerAdded:Connect(onPlayerAdded)

for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

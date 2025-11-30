local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

local baseplateFolder = Workspace:FindFirstChild("InfiniteBaseplates")
if not baseplateFolder then
    baseplateFolder = Instance.new("Folder")
    baseplateFolder.Name = "InfiniteBaseplates"
    baseplateFolder.Parent = Workspace
end

local baseplateSize = 2000
local baseplateSpacing = 0
local baseplateThickness = 4

local baseplateGrid = {}

local selectedColor = Color3.fromRGB(128, 128, 128)
local baseplateYOffset = 0
local updateLoop = false
local lastYOffset = 0

local function getBaseplateYPosition(playerPosition)
    local character = Player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart = character.HumanoidRootPart
        
        local rayOrigin = humanoidRootPart.Position
        local rayDirection = Vector3.new(0, -1000, 0)
        
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        raycastParams.FilterDescendantsInstances = {character, baseplateFolder}
        
        local raycastResult = Workspace:Raycast(rayOrigin, rayDirection, raycastParams)
        
        if raycastResult then
            return raycastResult.Position.Y - (baseplateThickness / 2) + 0.001 + baseplateYOffset
        else
            return playerPosition.Y - 20 + baseplateYOffset
        end
    end
    
    return baseplateYOffset
end

local function updateAllBaseplatePositions()
    local character = Player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local playerPosition = character.HumanoidRootPart.Position
    local newY = getBaseplateYPosition(playerPosition)
    
    for key, baseplate in pairs(baseplateGrid) do
        if baseplate and baseplate.Parent then
            local currentPos = baseplate.Position
            baseplate.Position = Vector3.new(currentPos.X, newY, currentPos.Z)
        end
    end
end

local function updateAllBaseplateColors(newColor)
    for _, baseplate in pairs(baseplateGrid) do
        if baseplate and baseplate.Parent then
            baseplate.Color = newColor
        end
    end
end

local function addGrassBaseplate(position, isPreview)
    local key = tostring(position.X) .. "," .. tostring(position.Z)
    if baseplateGrid[key] then return end

    local grassBaseplate = Instance.new("Part")
    grassBaseplate.Name = "GrassBaseplate"
    grassBaseplate.Size = Vector3.new(baseplateSize, baseplateThickness, baseplateSize)
    grassBaseplate.Anchored = true
    grassBaseplate.Material = Enum.Material.SmoothPlastic
    grassBaseplate.Color = selectedColor
    grassBaseplate.Position = position
    grassBaseplate.Transparency = isPreview and 0 or 0.5
    grassBaseplate.CanCollide = not isPreview
    grassBaseplate.Parent = baseplateFolder
    
    baseplateGrid[key] = grassBaseplate
end

local function applyBaseplates()
    for _, baseplate in pairs(baseplateGrid) do
        if baseplate and baseplate.Parent then
            baseplate.Transparency = 0.5
            baseplate.CanCollide = true
        end
    end
end

local function createBaseplatesAroundPlayer(isPreview)
    local character = Player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end

    local playerPosition = character.HumanoidRootPart.Position
    local sizeMultiplier = baseplateSize + baseplateSpacing
    
    local baseplateY = getBaseplateYPosition(playerPosition)
    
    for x = -1, 1 do
        for z = -1, 1 do
            local gridX = math.floor(playerPosition.X / sizeMultiplier) * sizeMultiplier + (x * sizeMultiplier)
            local gridZ = math.floor(playerPosition.Z / sizeMultiplier) * sizeMultiplier + (z * sizeMultiplier)
            
            local position = Vector3.new(gridX, baseplateY, gridZ)
            addGrassBaseplate(position, isPreview)
        end
    end
end

local function deleteAllBaseplates()
    updateLoop = false
    
    for key, baseplate in pairs(baseplateGrid) do
        if baseplate and baseplate.Parent then
            baseplate:Destroy()
        end
    end
    baseplateGrid = {}
    
    for _, child in ipairs(baseplateFolder:GetChildren()) do
        if child.Name == "GrassBaseplate" then
            child:Destroy()
        end
    end
end

local function createColorSelectionGUI()
    local baseplatesExist = false
    for _, child in ipairs(baseplateFolder:GetChildren()) do
        if child.Name == "GrassBaseplate" then
            baseplatesExist = true
            break
        end
    end
    
    for _, gui in ipairs(Player.PlayerGui:GetChildren()) do
        if gui.Name == "BaseplateColorGUI" then
            gui:Destroy()
        end
    end
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BaseplateColorGUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = Player.PlayerGui
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 310, 0, baseplatesExist and 312 or 312)
    mainFrame.Position = UDim2.new(0.5, -155, 0.5, baseplatesExist and -156 or -156)
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.BackgroundTransparency = 0.7
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = ScreenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame
    
    local akLabel = Instance.new("TextLabel")
    akLabel.Size = UDim2.new(0, 80, 0, 18)
    akLabel.Position = UDim2.new(0, 15, 0, 12)
    akLabel.BackgroundTransparency = 1
    akLabel.Text = "AK ADMIN"
    akLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    akLabel.TextSize = 10
    akLabel.Font = Enum.Font.GothamBold
    akLabel.TextXAlignment = Enum.TextXAlignment.Left
    akLabel.Parent = mainFrame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -30, 0, 22)
    title.Position = UDim2.new(0, 15, 0, 35)
    title.BackgroundTransparency = 1
    title.Text = "Baseplate Settings"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 14
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Center
    title.Parent = mainFrame
    
    local colors = {
        {name = "Grey", color = Color3.fromRGB(128, 128, 128)},
        {name = "Green", color = Color3.fromRGB(34, 139, 34)},
        {name = "Blue", color = Color3.fromRGB(65, 105, 225)},
        {name = "Red", color = Color3.fromRGB(220, 20, 60)},
        {name = "Yellow", color = Color3.fromRGB(255, 215, 0)},
        {name = "Purple", color = Color3.fromRGB(128, 0, 128)},
        {name = "Orange", color = Color3.fromRGB(255, 94, 77)},
        {name = "Cyan", color = Color3.fromRGB(0, 255, 255)}
    }
    
    local colorContainer = Instance.new("Frame")
    colorContainer.Size = UDim2.new(1, -30, 0, 110)
    colorContainer.Position = UDim2.new(0, 15, 0, 68)
    colorContainer.BackgroundTransparency = 1
    colorContainer.Parent = mainFrame
    
    local gridLayout = Instance.new("UIGridLayout")
    gridLayout.CellSize = UDim2.new(0.25, -10, 0, 24)
    gridLayout.CellPadding = UDim2.new(0, 10, 0, 10)
    gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    gridLayout.Parent = colorContainer
    
    for i, colorInfo in ipairs(colors) do
        local button = Instance.new("TextButton")
        button.BackgroundColor3 = colorInfo.color
        button.BorderSizePixel = colorInfo.color == selectedColor and 3 or 1
        button.BorderColor3 = colorInfo.color == selectedColor and Color3.fromRGB(255, 255, 0) or Color3.fromRGB(255, 255, 255)
        button.Text = ""
        button.LayoutOrder = i
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 4)
        buttonCorner.Parent = button
        
        button.MouseButton1Click:Connect(function()
            for _, otherButton in ipairs(colorContainer:GetChildren()) do
                if otherButton:IsA("TextButton") then
                    otherButton.BorderSizePixel = 1
                    otherButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
                end
            end
            button.BorderSizePixel = 3
            button.BorderColor3 = Color3.fromRGB(255, 255, 0)
            selectedColor = colorInfo.color
            updateAllBaseplateColors(selectedColor)
        end)
        
        button.Parent = colorContainer
    end
    
    local heightLabel = Instance.new("TextLabel")
    heightLabel.Size = UDim2.new(0.4, 0, 0, 28)
    heightLabel.Position = UDim2.new(0, 15, 0, 190)
    heightLabel.BackgroundTransparency = 1
    heightLabel.Text = "Height: 0"
    heightLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    heightLabel.TextSize = 12
    heightLabel.Font = Enum.Font.Gotham
    heightLabel.TextXAlignment = Enum.TextXAlignment.Left
    heightLabel.Parent = mainFrame
    
    local upButton = Instance.new("TextButton")
    upButton.Size = UDim2.new(0.28, 0, 0, 28)
    upButton.Position = UDim2.new(0.42, 0, 0, 190)
    upButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    upButton.BackgroundTransparency = 0.7
    upButton.Text = "▲"
    upButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    upButton.TextSize = 14
    upButton.Font = Enum.Font.GothamBold
    
    local upCorner = Instance.new("UICorner")
    upCorner.CornerRadius = UDim.new(0, 5)
    upCorner.Parent = upButton
    upButton.Parent = mainFrame
    
    local downButton = Instance.new("TextButton")
    downButton.Size = UDim2.new(0.28, 0, 0, 28)
    downButton.Position = UDim2.new(0.7, 0, 0, 190)
    downButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    downButton.BackgroundTransparency = 0.7
    downButton.Text = "▼"
    downButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    downButton.TextSize = 14
    downButton.Font = Enum.Font.GothamBold
    
    local downCorner = Instance.new("UICorner")
    downCorner.CornerRadius = UDim.new(0, 5)
    downCorner.Parent = downButton
    downButton.Parent = mainFrame
    
    upButton.MouseButton1Click:Connect(function()
        baseplateYOffset = baseplateYOffset + 1
        heightLabel.Text = "Height: " .. baseplateYOffset
        updateAllBaseplatePositions()
    end)
    
    downButton.MouseButton1Click:Connect(function()
        baseplateYOffset = baseplateYOffset - 1
        heightLabel.Text = "Height: " .. baseplateYOffset
        updateAllBaseplatePositions()
    end)
    
    local previewButton = Instance.new("TextButton")
    previewButton.Size = UDim2.new(1, -30, 0, 30)
    previewButton.Position = UDim2.new(0, 15, 0, 225)
    previewButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    previewButton.BackgroundTransparency = 0.7
    previewButton.Text = "Preview"
    previewButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    previewButton.TextSize = 14
    previewButton.Font = Enum.Font.GothamBold
    
    local previewCorner = Instance.new("UICorner")
    previewCorner.CornerRadius = UDim.new(0, 6)
    previewCorner.Parent = previewButton
    
    previewButton.MouseButton1Click:Connect(function()
        createBaseplatesAroundPlayer(true)
    end)
    
    previewButton.Parent = mainFrame
    
    if baseplatesExist then
        local deleteButton = Instance.new("TextButton")
        deleteButton.Size = UDim2.new(0.485, 0, 0, 32)
        deleteButton.Position = UDim2.new(0, 15, 0, 265)
        deleteButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        deleteButton.BackgroundTransparency = 0.7
        deleteButton.Text = "Delete"
        deleteButton.TextColor3 = Color3.fromRGB(220, 20, 60)
        deleteButton.TextSize = 14
        deleteButton.Font = Enum.Font.GothamBold
        
        local deleteCorner = Instance.new("UICorner")
        deleteCorner.CornerRadius = UDim.new(0, 6)
        deleteCorner.Parent = deleteButton
        
        deleteButton.MouseButton1Click:Connect(function()
            deleteAllBaseplates()
            ScreenGui:Destroy()
        end)
        
        deleteButton.Parent = mainFrame
    end
    
    local applyButton = Instance.new("TextButton")
    applyButton.Size = UDim2.new(baseplatesExist and 0.485 or 1, baseplatesExist and 0 or -30, 0, 32)
    applyButton.Position = UDim2.new(baseplatesExist and 0.515 or 0, baseplatesExist and 0 or 15, 0, 265)
    applyButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    applyButton.BackgroundTransparency = 0.7
    applyButton.Text = baseplatesExist and "Apply" or "Create"
    applyButton.TextColor3 = Color3.fromRGB(46, 204, 113)
    applyButton.TextSize = 14
    applyButton.Font = Enum.Font.GothamBold
    
    local applyCorner = Instance.new("UICorner")
    applyCorner.CornerRadius = UDim.new(0, 6)
    applyCorner.Parent = applyButton
    
    applyButton.MouseButton1Click:Connect(function()
        if baseplatesExist then
            deleteAllBaseplates()
        end
        
        applyBaseplates()
        lastYOffset = baseplateYOffset
        ScreenGui:Destroy()
        
        if not updateLoop then
            updateLoop = true
            spawn(function()
                while updateLoop do
                    createBaseplatesAroundPlayer(false)
                    wait(1)
                end
            end)
        end
    end)
    
    applyButton.Parent = mainFrame
end

createColorSelectionGUI()
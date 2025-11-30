local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local bodyParts = {
    "Head", "UpperTorso", "LowerTorso",
    "LeftUpperArm", "LeftLowerArm", "LeftHand",
    "RightUpperArm", "RightLowerArm", "RightHand",
    "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
    "RightUpperLeg", "RightLowerLeg", "RightFoot",
    "HumanoidRootPart"
}

local partVerticalOffsets = {
    ["Head"] = 0, ["UpperTorso"] = 0, ["LowerTorso"] = 0,
    ["LeftUpperArm"] = 0, ["LeftLowerArm"] = 0, ["LeftHand"] = 0,
    ["RightUpperArm"] = 0, ["RightLowerArm"] = 0, ["RightHand"] = 0,
    ["LeftUpperLeg"] = 0, ["LeftLowerLeg"] = 0, ["LeftFoot"] = 0,
    ["RightUpperLeg"] = 0, ["RightLowerLeg"] = 0, ["RightFoot"] = 0,
    ["HumanoidRootPart"]= 0
}

local enableHandCircling = true
local circleRadius = 1.5
local circleSpeed = 2
local circleVerticalOffset = 0.5

local MIN_RADIUS = 0.01
local MAX_RADIUS = 100.0
local MIN_SPEED = -100.0
local MAX_SPEED = 100.0
local MIN_HEIGHT = -100.0
local MAX_HEIGHT = 100.0

local ghostEnabled = false
local originalCharacter
local ghostClone
local originalCFrame
local originalAnimateScript
local updateConnection
local currentCircleAngle = 0

local preservedGuis = {}

local function preserveGuis()
    local playerGui = LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
    if playerGui then
        for _, gui in ipairs(playerGui:GetChildren()) do
            if gui:IsA("ScreenGui") and gui.Name ~= "LimbOrbitGui" and gui.ResetOnSpawn then
                table.insert(preservedGuis, gui)
                gui.ResetOnSpawn = false
            end
        end
    end
end

local function restoreGuis()
    for _, gui in ipairs(preservedGuis) do
        if gui and gui.Parent then
            gui.ResetOnSpawn = true
        end
    end
    table.clear(preservedGuis)
end

local function updateRagdolledParts(dt)
    if not ghostEnabled or not originalCharacter or not originalCharacter.Parent or not ghostClone or not ghostClone.Parent then
        if updateConnection then
            updateConnection:Disconnect()
            updateConnection = nil
        end
        return
    end

    if enableHandCircling then
        currentCircleAngle = (currentCircleAngle + circleSpeed * dt) % (2 * math.pi)
    end

    local originalHead = originalCharacter:FindFirstChild("Head")

    for _, partName in ipairs(bodyParts) do
        local originalPart = originalCharacter:FindFirstChild(partName)
        local clonePart = ghostClone:FindFirstChild(partName)

        if originalPart and clonePart then
            local targetCFrame

            if enableHandCircling and originalHead and (partName == "LeftHand" or partName == "RightHand" or partName == "LeftFoot" or partName == "RightFoot") then
                local headPos = originalHead.Position
                local angleOffset = 0

                if partName == "LeftHand" then
                    angleOffset = math.pi
                elseif partName == "RightHand" then
                    angleOffset = 0
                elseif partName == "LeftFoot" then
                    angleOffset = math.pi/2
                elseif partName == "RightFoot" then
                    angleOffset = 3*math.pi/2
                end

                local partAngle = currentCircleAngle + angleOffset
                local offsetX = circleRadius * math.cos(partAngle)
                local offsetZ = circleRadius * math.sin(partAngle)
                local targetPosition = headPos + Vector3.new(offsetX, circleVerticalOffset, offsetZ)
                local rotation = clonePart.CFrame - clonePart.Position
                targetCFrame = CFrame.new(targetPosition) * rotation
            else
                local verticalOffset = partVerticalOffsets[partName] or 0
                local targetPosition = clonePart.Position + Vector3.new(0, -verticalOffset, 0)
                local rotation = clonePart.CFrame - clonePart.Position
                targetCFrame = CFrame.new(targetPosition) * rotation
            end

            originalPart.CFrame = targetCFrame
            originalPart.AssemblyLinearVelocity = Vector3.zero
            originalPart.AssemblyAngularVelocity = Vector3.zero

        elseif originalPart and partName == "HumanoidRootPart" and ghostClone.PrimaryPart and not clonePart then
             local verticalOffset = partVerticalOffsets[partName] or 0
             local targetPosition = ghostClone.PrimaryPart.Position + Vector3.new(0, -verticalOffset, 0)
             local rotation = ghostClone.PrimaryPart.CFrame - ghostClone.PrimaryPart.Position
             local targetCFrame = CFrame.new(targetPosition) * rotation
             originalPart.CFrame = targetCFrame
             originalPart.AssemblyLinearVelocity = Vector3.zero
             originalPart.AssemblyAngularVelocity = Vector3.zero
        end
    end
end

local function setGhostEnabled(newState)
    ghostEnabled = newState

    if ghostEnabled then
        local char = LocalPlayer.Character
        if not char then return end
        local humanoid = char:FindFirstChildWhichIsA("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        if not humanoid or not root then return end
        if originalCharacter or ghostClone then return end

        originalCharacter = char
        originalCFrame = root.CFrame
        char.Archivable = true
        ghostClone = char:Clone()
        char.Archivable = false
        ghostClone.Name = originalCharacter.Name .. "_clone"
        local ghostHumanoid = ghostClone:FindFirstChildWhichIsA("Humanoid")
        if ghostHumanoid then
            ghostHumanoid.DisplayName = originalCharacter.Name .. "_clone"
            ghostHumanoid:ChangeState(Enum.HumanoidStateType.Physics)
        end
        if not ghostClone.PrimaryPart then
            local hrp = ghostClone:FindFirstChild("HumanoidRootPart")
            if hrp then ghostClone.PrimaryPart = hrp end
        end
        for _, part in ipairs(ghostClone:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
                part.CanCollide = false
                part.Anchored = false
                part.CanQuery = false
            elseif part:IsA("Decal") then
                part.Transparency = 1
            elseif part:IsA("Accessory") then
                local handle = part:FindFirstChild("Handle")
                if handle then
                    handle.Transparency = 1
                    handle.CanCollide = false
                    handle.CanQuery = false
                end
            end
        end
        local animate = originalCharacter:FindFirstChild("Animate")
        if animate then
            originalAnimateScript = animate
            originalAnimateScript.Disabled = true
            originalAnimateScript.Parent = ghostClone
        end
        preserveGuis()
        ghostClone.Parent = Workspace
        LocalPlayer.Character = ghostClone
        if ghostHumanoid then
            Workspace.CurrentCamera.CameraSubject = ghostHumanoid
        end
        restoreGuis()
        if originalAnimateScript and originalAnimateScript.Parent == ghostClone then
            originalAnimateScript.Disabled = false
        end
        
local args = {"Hinge"}
game:GetService("ReplicatedStorage"):WaitForChild("event_rag"):FireServer(unpack(args))
        
        currentCircleAngle = 0
        if updateConnection then updateConnection:Disconnect() end
        updateConnection = RunService.Heartbeat:Connect(updateRagdolledParts)
    else
        if not originalCharacter or not ghostClone then return end
        if updateConnection then
            updateConnection:Disconnect()
            updateConnection = nil
        end
        
        for i = 1, 3 do
local args = {"Hinge"}
game:GetService("ReplicatedStorage"):WaitForChild("event_rag"):FireServer(unpack(args))
            task.wait(0.1)
        end
        
        local targetCFrame = originalCFrame
        local ghostPrimary = ghostClone.PrimaryPart
        if ghostPrimary then targetCFrame = ghostPrimary.CFrame end
        local animate = ghostClone:FindFirstChild("Animate")
        if animate then
            animate.Disabled = true
            animate.Parent = originalCharacter
        end
        ghostClone:Destroy()
        ghostClone = nil
        if originalCharacter and originalCharacter.Parent then
            local origRoot = originalCharacter:FindFirstChild("HumanoidRootPart")
            local origHumanoid = originalCharacter:FindFirstChildWhichIsA("Humanoid")
            if origRoot then
                origRoot.CFrame = targetCFrame
                origRoot.AssemblyLinearVelocity = Vector3.zero
                origRoot.AssemblyAngularVelocity = Vector3.zero
            end
            preserveGuis()
            LocalPlayer.Character = originalCharacter
            if origHumanoid then
                Workspace.CurrentCamera.CameraSubject = origHumanoid
                origHumanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
            restoreGuis()
            if animate and animate.Parent == originalCharacter then
                task.wait(0.1)
                animate.Disabled = false
            end
        end
        originalCharacter = nil
        originalAnimateScript = nil
    end
end

local function createGui()
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    
    if playerGui:FindFirstChild("LimbOrbitGui") then
        playerGui.LimbOrbitGui:Destroy()
    end

    local screengui = Instance.new("ScreenGui")
    screengui.Name = "LimbOrbitGui"
    screengui.ResetOnSpawn = false
    screengui.Parent = playerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 200, 0, 195)
    mainFrame.Position = UDim2.new(0.5, -100, 0.5, -97)
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.BackgroundTransparency = 0.6
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screengui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 8)
    mainCorner.Parent = mainFrame

    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 25)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundTransparency = 1
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    local akAdminLabel = Instance.new("TextLabel")
    akAdminLabel.Name = "AKAdminLabel"
    akAdminLabel.Size = UDim2.new(0, 80, 0, 15)
    akAdminLabel.Position = UDim2.new(0, 8, 0, 5)
    akAdminLabel.BackgroundTransparency = 1
    akAdminLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    akAdminLabel.Text = "AK ADMIN"
    akAdminLabel.TextSize = 9
    akAdminLabel.Font = Enum.Font.GothamBold
    akAdminLabel.TextXAlignment = Enum.TextXAlignment.Left
    akAdminLabel.Parent = mainFrame

    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.Size = UDim2.new(0, 18, 0, 18)
    minimizeButton.Position = UDim2.new(1, -42, 0, 5)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    minimizeButton.BackgroundTransparency = 0.6
    minimizeButton.BorderSizePixel = 0
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.Text = "-"
    minimizeButton.TextSize = 14
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.Parent = mainFrame

    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 4)
    minimizeCorner.Parent = minimizeButton

    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 18, 0, 18)
    closeButton.Position = UDim2.new(1, -20, 0, 5)
    closeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    closeButton.BackgroundTransparency = 0.6
    closeButton.BorderSizePixel = 0
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.Text = "X"
    closeButton.TextSize = 12
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = mainFrame

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 4)
    closeCorner.Parent = closeButton

    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, 0, 1, -25)
    contentFrame.Position = UDim2.new(0, 0, 0, 25)
    contentFrame.BackgroundTransparency = 1
    contentFrame.BorderSizePixel = 0
    contentFrame.Parent = mainFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(0, 150, 0, 20)
    titleLabel.Position = UDim2.new(0.5, -75, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Text = "Limb Orbit"
    titleLabel.TextSize = 16
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.Parent = contentFrame

    local radiusLabel = Instance.new("TextLabel")
    radiusLabel.Name = "RadiusLabel"
    radiusLabel.Size = UDim2.new(0, 100, 0, 15)
    radiusLabel.Position = UDim2.new(0, 10, 0, 25)
    radiusLabel.BackgroundTransparency = 1
    radiusLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    radiusLabel.Text = "Radius: 1.50"
    radiusLabel.TextSize = 10
    radiusLabel.Font = Enum.Font.GothamBold
    radiusLabel.TextXAlignment = Enum.TextXAlignment.Left
    radiusLabel.Parent = contentFrame

    local radiusSlider = Instance.new("Frame")
    radiusSlider.Name = "RadiusSlider"
    radiusSlider.Size = UDim2.new(0, 180, 0, 6)
    radiusSlider.Position = UDim2.new(0, 10, 0, 45)
    radiusSlider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    radiusSlider.BackgroundTransparency = 0.6
    radiusSlider.BorderSizePixel = 0
    radiusSlider.Parent = contentFrame

    local radiusSliderCorner = Instance.new("UICorner")
    radiusSliderCorner.CornerRadius = UDim.new(0, 3)
    radiusSliderCorner.Parent = radiusSlider

    local radiusHandle = Instance.new("TextButton")
    radiusHandle.Name = "RadiusHandle"
    radiusHandle.Size = UDim2.new(0, 14, 0, 14)
    radiusHandle.Position = UDim2.new(0, 0, 0, -4)
    radiusHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    radiusHandle.BorderSizePixel = 0
    radiusHandle.Text = ""
    radiusHandle.Parent = radiusSlider

    local radiusHandleCorner = Instance.new("UICorner")
    radiusHandleCorner.CornerRadius = UDim.new(1, 0)
    radiusHandleCorner.Parent = radiusHandle

    local speedLabel = Instance.new("TextLabel")
    speedLabel.Name = "SpeedLabel"
    speedLabel.Size = UDim2.new(0, 100, 0, 15)
    speedLabel.Position = UDim2.new(0, 10, 0, 60)
    speedLabel.BackgroundTransparency = 1
    speedLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    speedLabel.Text = "Speed: 2.00"
    speedLabel.TextSize = 10
    speedLabel.Font = Enum.Font.GothamBold
    speedLabel.TextXAlignment = Enum.TextXAlignment.Left
    speedLabel.Parent = contentFrame

    local speedSlider = Instance.new("Frame")
    speedSlider.Name = "SpeedSlider"
    speedSlider.Size = UDim2.new(0, 180, 0, 6)
    speedSlider.Position = UDim2.new(0, 10, 0, 80)
    speedSlider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    speedSlider.BackgroundTransparency = 0.6
    speedSlider.BorderSizePixel = 0
    speedSlider.Parent = contentFrame

    local speedSliderCorner = Instance.new("UICorner")
    speedSliderCorner.CornerRadius = UDim.new(0, 3)
    speedSliderCorner.Parent = speedSlider

    local speedHandle = Instance.new("TextButton")
    speedHandle.Name = "SpeedHandle"
    speedHandle.Size = UDim2.new(0, 14, 0, 14)
    speedHandle.Position = UDim2.new(0, 0, 0, -4)
    speedHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    speedHandle.BorderSizePixel = 0
    speedHandle.Text = ""
    speedHandle.Parent = speedSlider

    local speedHandleCorner = Instance.new("UICorner")
    speedHandleCorner.CornerRadius = UDim.new(1, 0)
    speedHandleCorner.Parent = speedHandle

    local heightLabel = Instance.new("TextLabel")
    heightLabel.Name = "HeightLabel"
    heightLabel.Size = UDim2.new(0, 100, 0, 15)
    heightLabel.Position = UDim2.new(0, 10, 0, 95)
    heightLabel.BackgroundTransparency = 1
    heightLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    heightLabel.Text = "Height: 0.50"
    heightLabel.TextSize = 10
    heightLabel.Font = Enum.Font.GothamBold
    heightLabel.TextXAlignment = Enum.TextXAlignment.Left
    heightLabel.Parent = contentFrame

    local heightSlider = Instance.new("Frame")
    heightSlider.Name = "HeightSlider"
    heightSlider.Size = UDim2.new(0, 180, 0, 6)
    heightSlider.Position = UDim2.new(0, 10, 0, 115)
    heightSlider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    heightSlider.BackgroundTransparency = 0.6
    heightSlider.BorderSizePixel = 0
    heightSlider.Parent = contentFrame

    local heightSliderCorner = Instance.new("UICorner")
    heightSliderCorner.CornerRadius = UDim.new(0, 3)
    heightSliderCorner.Parent = heightSlider

    local heightHandle = Instance.new("TextButton")
    heightHandle.Name = "HeightHandle"
    heightHandle.Size = UDim2.new(0, 14, 0, 14)
    heightHandle.Position = UDim2.new(0, 0, 0, -4)
    heightHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    heightHandle.BorderSizePixel = 0
    heightHandle.Text = ""
    heightHandle.Parent = heightSlider

    local heightHandleCorner = Instance.new("UICorner")
    heightHandleCorner.CornerRadius = UDim.new(1, 0)
    heightHandleCorner.Parent = heightHandle

    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(0, 180, 0, 28)
    toggleButton.Position = UDim2.new(0, 10, 0, 132)
    toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    toggleButton.BackgroundTransparency = 0.6
    toggleButton.BorderSizePixel = 0
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.Text = "OFF"
    toggleButton.TextSize = 12
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.Parent = contentFrame

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggleButton

    local isMinimized = false

    local function updateSlider(slider, handle, value, minValue, maxValue)
        local percentage = (value - minValue) / (maxValue - minValue)
        local newPosition = math.clamp(percentage * (slider.AbsoluteSize.X - handle.AbsoluteSize.X), 0, slider.AbsoluteSize.X - handle.AbsoluteSize.X)
        handle.Position = UDim2.new(0, newPosition, 0, -4)
    end

    local function setupSlider(slider, handle, minValue, maxValue, initialValue, callback)
        local dragging = false
        
        handle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
            end
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local relativeX = input.Position.X - slider.AbsolutePosition.X
                local percentage = math.clamp(relativeX / slider.AbsoluteSize.X, 0, 1)
                local value = minValue + (maxValue - minValue) * percentage
                
                updateSlider(slider, handle, value, minValue, maxValue)
                callback(value)
            end
        end)
        
        updateSlider(slider, handle, initialValue, minValue, maxValue)
    end

    setupSlider(radiusSlider, radiusHandle, MIN_RADIUS, MAX_RADIUS, circleRadius, function(value)
        circleRadius = value
        radiusLabel.Text = "Radius: " .. string.format("%.2f", value)
    end)

    setupSlider(speedSlider, speedHandle, MIN_SPEED, MAX_SPEED, circleSpeed, function(value)
        circleSpeed = value
        speedLabel.Text = "Speed: " .. string.format("%.2f", value)
    end)

    setupSlider(heightSlider, heightHandle, MIN_HEIGHT, MAX_HEIGHT, circleVerticalOffset, function(value)
        circleVerticalOffset = value
        heightLabel.Text = "Height: " .. string.format("%.2f", value)
    end)

    local function updateToggleButtons()
        if ghostEnabled then
            toggleButton.Text = "ON"
            toggleButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
            toggleButton.BackgroundTransparency = 0.4
        else
            toggleButton.Text = "OFF"
            toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            toggleButton.BackgroundTransparency = 0.6
        end
    end

    toggleButton.MouseButton1Click:Connect(function()
        local newState = not ghostEnabled
        setGhostEnabled(newState)
        updateToggleButtons()
    end)

    minimizeButton.MouseButton1Click:Connect(function()
        if not isMinimized then
            mainFrame:TweenSize(UDim2.new(0, 200, 0, 25), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
            minimizeButton.Text = "+"
            isMinimized = true
        else
            mainFrame:TweenSize(UDim2.new(0, 200, 0, 195), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
            minimizeButton.Text = "-"
            isMinimized = false
        end
    end)

    closeButton.MouseButton1Click:Connect(function()
        if ghostEnabled then
            setGhostEnabled(false)
            task.wait(0.5)
        end
        screengui:Destroy()
    end)

    local dragStart
    local startPos
    local dragging = false
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    return screengui
end

createGui()

script.Destroying:Connect(function()
    if ghostEnabled then
        setGhostEnabled(false)
    end
    local playerGui = LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
    if playerGui then
        local gui = playerGui:FindFirstChild("LimbOrbitGui")
        if gui then
            gui:Destroy()
        end
    end
    if updateConnection then
        updateConnection:Disconnect()
        updateConnection = nil
    end
end)
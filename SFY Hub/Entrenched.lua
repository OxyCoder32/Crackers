--[[dwadwa
adwa
dwa
dwad
wad
wa
dwa
dw
ad
a
dw
a
d
aw
dw
ad
wa
dw
adwa
dw
d

c2q
c2q
c2
2c2
5
tesg
34
t
sdt
4et

ta
t4af
t
c4
accta
4ct
ata

]]
local GuiLibrary = loadstring(game:HttpGet("https://github.com/OxyCoder32/Crackers/raw/refs/heads/main/SFY%20Hub/GuiLib.lua"))()
local menu = GuiLibrary.new("SFY_Hub_library")

local function showNotification(title, text, duration)
    duration = duration or 3
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration
        })
    end)
end

menu:SetPremiumStatus(true)

-- Services
local Services = {
    Players = game:GetService("Players"),
    Workspace = game:GetService("Workspace"),
    RunService = game:GetService("RunService"),
    UserInputService = game:GetService("UserInputService"),
    Lighting = game:GetService("Lighting"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    HttpService = game:GetService("HttpService")
}

-- Player references
local Player, LocalPlayer = Services.Players.LocalPlayer, Services.Players.LocalPlayer
local Camera = Services.Workspace.CurrentCamera

-- Tabs
local Tabs = {
    InfoTab = menu:CreateTab("Info"),
    VisualTab = menu:CreateTab("Visual"),
    MainTab = menu:CreateTab("Main"),
    ClassTab = menu:CreateTab("Class")
}

-- Create welcome panel
local welcomePanel = menu:CreateWelcomePanelTab(Tabs.InfoTab, {
    ScriptName = "ENTRENCHED WW1 🥀 [🦅 USA 🦅]",
    Version = "V2.2",
    Developer = "SFY_devs",
    Discord = "discord.gg/wcpvkVPEAA",
    Description = "Advanced Prediction Aimbot with Smart Gun Detection",
    Features = {
        "🎯 Smart Velocity-Based Prediction",
        "🔫 Auto-Detect Gun Bullet Speed",
        "🎯 Head/Body Targeting Aimbot",
        "📊 Real-Time Enemy Speed Analysis",
        "🎮 Mobile & PC Support"
    },
    ThemeColor = Color3.fromRGB(255,0,0)
})

-- Use the builder
menu:CreateSeparator(Tabs.InfoTab, "🐞 CHANGE LOGS ")
local updateHistory = menu:UpdateHistoryBuilder(Tabs.InfoTab)
:Add("2026-01-05","update","ADVANCED PREDICTION SYSTEM","Added smart velocity-based prediction with real-time calculations")
:Add("2026-01-05","feature","AUTO GUN VELOCITY DETECTION","Automatically detects equipped gun bullet speed")
:Add("2026-01-05","improve","REAL-TIME ENEMY SPEED ANALYSIS","Calculates prediction based on enemy movement speed")
:Add("2025-12-31","update","ADDED EXPORT AND IMPORT CONFIG","You can now share and used other config")
:Add("2025-12-12","fix","FIXED AIMBOT","Fixed head targeting and keybinding system")
:Build()

-- ==================== SIMPLIFIED ESP SYSTEM ====================
local ESPGroup = menu:CreateCollapsibleGroup(Tabs.VisualTab, "Player ESP", true, 300)

-- ESP Variables
local ESPEnabled = false
local ShowNames = true
local ShowDistance = true
local ShowTracers = true
local MaxDistance = 2000
local TextSize = 14
local TeamCheck = true
local HideTeammateLines = true
local IgnoreTeammates = false

-- Visible Check Mode
local VisibilityCheckMode = "Whole Body" -- "Head Only" or "Whole Body"

-- Highlight System
local ShowHighlights = true
local HighlightTransparency = 0.2
local UseVisibilityCheck = true
local VisibleColor = Color3.fromRGB(50, 200, 50)    -- GREEN for visible (can see)
local HiddenColor = Color3.fromRGB(255, 50, 50)     -- RED for hidden (obstructed)
local TeamColor = Color3.fromRGB(50, 150, 255)      -- Blue for teammates
local SelfColor = Color3.fromRGB(0, 200, 255)       -- Cyan for self (if included)

-- Drawing Objects storage
local ESPObjects = {}
local ESPLoop = nil

-- Function to check if player has MarkerGui
local function hasMarkerGui(character)
    if not character then return nil end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    
    local markerGui = hrp:FindFirstChild("MarkerGui")
    if markerGui then
        return markerGui.Enabled
    end
    
    return nil
end

-- Function to get player team status
local function getPlayerTeamStatus(player)
    if player == LocalPlayer then return "self" end
    
    local character = player.Character
    if not character then return "enemy" end
    
    -- Check MarkerGui
    local markerGuiEnabled = hasMarkerGui(character)
    if markerGuiEnabled ~= nil then
        return markerGuiEnabled and "team" or "enemy"
    end
    
    -- Check game folders
    local teamIndicators = Services.Workspace:FindFirstChild("__THINGS")
    if teamIndicators then
        teamIndicators = teamIndicators:FindFirstChild("CharacterHighlights")
        if teamIndicators then
            local enemies = teamIndicators:FindFirstChild("Enemies")
            local teammates = teamIndicators:FindFirstChild("Teammates")
            
            if enemies and enemies:FindFirstChild(player.Name) then 
                return "enemy" 
            end
            if teammates and teammates:FindFirstChild(player.Name) then 
                return "team" 
            end
        end
    end
    
    return "enemy"
end

-- Function to check if player is visible to local player
local function isPlayerVisible(player, checkMode)
    if not UseVisibilityCheck or not player or not player.Character then 
        return true  -- Default to visible if check is disabled
    end
    
    local character = player.Character
    local checkMode = checkMode or VisibilityCheckMode
    
    -- Determine which part to check based on mode
    local checkPart = nil
    
    if checkMode == "Head Only" then
        checkPart = character:FindFirstChild("Head")
        if not checkPart then
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if hrp then
                checkPart = hrp
            else
                return true
            end
        end
    else -- "Whole Body"
        -- We'll check both head and torso for better accuracy
        local head = character:FindFirstChild("Head")
        local hrp = character:FindFirstChild("HumanoidRootPart")
        
        if not head and not hrp then return true end
        
        -- Check head first (most important)
        if head then
            checkPart = head
        else
            checkPart = hrp
        end
    end
    
    if not checkPart then return true end
    
    local camera = Camera
    local origin = camera.CFrame.Position
    
    -- Check from camera to target part
    local direction = (checkPart.Position - origin).Unit
    local raycastParams = RaycastParams.new()
    
    -- Blacklist: Don't hit our own character or camera
    local ignoreList = {LocalPlayer.Character, camera}
    raycastParams.FilterDescendantsInstances = ignoreList
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.IgnoreWater = true
    
    -- Perform raycast
    local raycastResult = Services.Workspace:Raycast(origin, direction * (checkPart.Position - origin).Magnitude, raycastParams)
    
    if not raycastResult then
        -- No hit means direct line of sight
        return true
    else
        -- Something was hit, check if it's the target player
        local hitInstance = raycastResult.Instance
        local hitCharacter = hitInstance:FindFirstAncestorWhichIsA("Model")
        
        -- If what we hit is the target player's character, they're visible
        -- Otherwise, something is blocking the view
        return hitCharacter == character
    end
end

-- Function to get player color for ESP
local function getPlayerColor(player, checkVisibility)
    local teamStatus = getPlayerTeamStatus(player)
    
    if teamStatus == "self" then 
        return SelfColor
    elseif teamStatus == "team" then 
        return TeamColor
    elseif teamStatus == "enemy" then 
        -- For enemies, check visibility if enabled
        if checkVisibility and UseVisibilityCheck then
            local isVisible = isPlayerVisible(player, VisibilityCheckMode)
            return isVisible and VisibleColor or HiddenColor
        end
        return HiddenColor  -- Default to red for enemies
    end
    
    return HiddenColor
end

-- Function to create drawing objects for ESP
local function createESPObjects(player)
    local esp = {
        player = player,
        highlight = nil,
        nameLabel = Drawing.new("Text"),
        distanceLabel = Drawing.new("Text"),
        tracer = Drawing.new("Line"),
        lastVisibleCheck = 0,
        isVisible = false
    }
    
    -- Configure name label
    esp.nameLabel.Visible = false
    esp.nameLabel.Center = true
    esp.nameLabel.Outline = true
    esp.nameLabel.OutlineColor = Color3.new(0, 0, 0)
    esp.nameLabel.Font = 2  -- System font
    esp.nameLabel.Size = TextSize
    esp.nameLabel.Color = Color3.new(1, 1, 1)
    
    -- Configure distance label
    esp.distanceLabel.Visible = false
    esp.distanceLabel.Center = true
    esp.distanceLabel.Outline = true
    esp.distanceLabel.OutlineColor = Color3.new(0, 0, 0)
    esp.distanceLabel.Font = 2  -- System font
    esp.distanceLabel.Size = TextSize - 2
    esp.distanceLabel.Color = Color3.new(1, 1, 1)
    
    -- Configure tracer line
    esp.tracer.Visible = false
    esp.tracer.Thickness = 1
    esp.tracer.Color = Color3.new(1, 1, 1)
    
    return esp
end

-- Function to update drawing objects
local function updateESPObjects(esp)
    if not esp or not esp.player or not esp.player.Character then return end
    
    local character = esp.player.Character
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local head = character:FindFirstChild("Head")
    if not head then return end
    
    -- Convert world position to screen space
    local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
    if not onScreen then
        esp.nameLabel.Visible = false
        esp.distanceLabel.Visible = false
        esp.tracer.Visible = false
        return
    end
    
    local screenPos2D = Vector2.new(screenPos.X, screenPos.Y)
    local distance = (hrp.Position - Camera.CFrame.Position).Magnitude
    
    -- Check team status
    local teamStatus = getPlayerTeamStatus(esp.player)
    local shouldHide = (HideTeammateLines and teamStatus == "team") or (IgnoreTeammates and teamStatus == "team")
    
    -- Update name label
    if ShowNames and distance <= MaxDistance and not shouldHide then
        esp.nameLabel.Visible = true
        esp.nameLabel.Position = screenPos2D + Vector2.new(0, 25)
        esp.nameLabel.Text = esp.player.Name
        esp.nameLabel.Size = TextSize
        
        -- Set color based on team and visibility
        local color = getPlayerColor(esp.player, true)
        esp.nameLabel.Color = color
    else
        esp.nameLabel.Visible = false
    end
    
    -- Update distance label
    if ShowDistance and distance <= MaxDistance and not shouldHide then
        esp.distanceLabel.Visible = true
        esp.distanceLabel.Position = screenPos2D + Vector2.new(0, 40)
        esp.distanceLabel.Text = tostring(math.floor(distance)) .. " studs"
        esp.distanceLabel.Size = TextSize - 2
        
        -- Set color based on team and visibility
        local color = getPlayerColor(esp.player, true)
        esp.distanceLabel.Color = color
    else
        esp.distanceLabel.Visible = false
    end
    
    -- Update tracer line
    if ShowTracers and distance <= MaxDistance and not shouldHide then
        esp.tracer.Visible = true
        esp.tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
        esp.tracer.To = screenPos2D
        
        -- Set color based on team and visibility
        local color = getPlayerColor(esp.player, true)
        esp.tracer.Color = color
        
        -- Make teammate lines more transparent if HideTeammateLines is off
        if teamStatus == "team" and not HideTeammateLines then
            esp.tracer.Transparency = 0.5
        else
            esp.tracer.Transparency = 0
        end
    else
        esp.tracer.Visible = false
    end
end

-- Function to create highlight
local function createHighlight(character)
    if not character then return nil end
    
    local existingHighlight = character:FindFirstChild("SFY_Highlight")
    if existingHighlight then
        existingHighlight:Destroy()
    end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "SFY_Highlight"
    highlight.Adornee = character
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = HiddenColor  -- Default to red
    highlight.FillTransparency = HighlightTransparency
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 0
    highlight.Enabled = ShowHighlights
    highlight.Parent = character
    
    return highlight
end

-- Main ESP update loop
local function updateESP()
    if not ESPEnabled then return end
    
    -- Process all players
    for _, player in ipairs(Services.Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        
        -- Get or create ESP data for this player
        local esp = ESPObjects[player]
        if not esp then
            esp = createESPObjects(player)
            ESPObjects[player] = esp
        end
        
        local character = player.Character
        if not character then
            -- Hide all ESP elements if player has no character
            if esp.highlight then
                esp.highlight.Enabled = false
            end
            esp.nameLabel.Visible = false
            esp.distanceLabel.Visible = false
            esp.tracer.Visible = false
            continue
        end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then
            -- Hide all ESP elements if player is dead
            if esp.highlight then
                esp.highlight:Destroy()
                esp.highlight = nil
            end
            esp.nameLabel.Visible = false
            esp.distanceLabel.Visible = false
            esp.tracer.Visible = false
            continue
        end
        
        -- Team check with IgnoreTeammates option
        local teamStatus = getPlayerTeamStatus(player)
        if IgnoreTeammates and teamStatus == "team" then
            if esp.highlight then
                esp.highlight.Enabled = false
            end
            esp.nameLabel.Visible = false
            esp.distanceLabel.Visible = false
            esp.tracer.Visible = false
            continue
        end
        
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not hrp then 
            esp.nameLabel.Visible = false
            esp.distanceLabel.Visible = false
            esp.tracer.Visible = false
            continue 
        end
        
        -- Distance check
        local distance = (hrp.Position - Camera.CFrame.Position).Magnitude
        if distance > MaxDistance then
            if esp.highlight then
                esp.highlight.Enabled = false
            end
            esp.nameLabel.Visible = false
            esp.distanceLabel.Visible = false
            esp.tracer.Visible = false
            continue
        end
        
        -- Update visibility check
        local currentTime = tick()
        if currentTime - (esp.lastVisibleCheck or 0) > 0.2 then  -- Check every 0.2 seconds
            esp.isVisible = isPlayerVisible(player, VisibilityCheckMode)
            esp.lastVisibleCheck = currentTime
        end
        
        -- Update highlight
        if ShowHighlights then
            if not esp.highlight or esp.highlight.Parent ~= character then
                if esp.highlight then
                    esp.highlight:Destroy()
                end
                esp.highlight = createHighlight(character)
            end
            
            -- Update highlight based on team and visibility
            esp.highlight.Enabled = true
            esp.highlight.FillTransparency = HighlightTransparency
            
            -- Set color based on team and visibility
            local color
            if teamStatus == "team" then
                color = TeamColor
            else
                -- For enemies, use visibility check
                if esp.isVisible then
                    color = VisibleColor  -- GREEN: Player is visible
                else
                    color = HiddenColor   -- RED: Player is obstructed
                end
            end
            
            esp.highlight.FillColor = color
        elseif esp.highlight then
            esp.highlight.Enabled = false
        end
        
        -- Update drawing objects (names, distance, tracers)
        updateESPObjects(esp)
    end
end

local function startESP()
    if ESPLoop then
        ESPLoop:Disconnect()
        ESPLoop = nil
    end
    
    -- Initialize ESP for all existing players
    for _, player in ipairs(Services.Players:GetPlayers()) do
        if player ~= LocalPlayer then
            ESPObjects[player] = createESPObjects(player)
        end
    end
    
    -- Main ESP loop
    ESPLoop = Services.RunService.Heartbeat:Connect(function()
        updateESP()
    end)
end

local function stopESP()
    if ESPLoop then
        ESPLoop:Disconnect()
        ESPLoop = nil
    end
    
    for _, esp in pairs(ESPObjects) do
        if esp.highlight then
            esp.highlight:Destroy()
        end
        if esp.nameLabel then
            esp.nameLabel:Remove()
        end
        if esp.distanceLabel then
            esp.distanceLabel:Remove()
        end
        if esp.tracer then
            esp.tracer:Remove()
        end
    end
    
    ESPObjects = {}
end

local function refreshESP()
    stopESP()
    task.wait(0.1)
    if ESPEnabled then
        startESP()
    end
end

-- Clean up drawing objects when player leaves
local function cleanupESP(player)
    local esp = ESPObjects[player]
    if esp then
        if esp.highlight then
            esp.highlight:Destroy()
        end
        if esp.nameLabel then
            esp.nameLabel:Remove()
        end
        if esp.distanceLabel then
            esp.distanceLabel:Remove()
        end
        if esp.tracer then
            esp.tracer:Remove()
        end
        ESPObjects[player] = nil
    end
end

-- Player events
Services.Players.PlayerAdded:Connect(function(player)
    if ESPEnabled and player ~= LocalPlayer then
        task.wait(0.5)
        ESPObjects[player] = createESPObjects(player)
    end
end)

Services.Players.PlayerRemoving:Connect(function(player)
    cleanupESP(player)
end)

-- ESP GUI Controls
ESPGroup:AddToggle("Enable ESP", ESPEnabled, function(state)
    ESPEnabled = state
    if state then
        startESP()
    else
        stopESP()
    end
end)

-- Visibility Check Mode
ESPGroup:AddDropdown("Visibility Check", {"Whole Body", "Head Only"}, "Whole Body", function(selected)
    VisibilityCheckMode = selected
    refreshESP()
end)

ESPGroup:AddToggle("Show Highlights", ShowHighlights, function(state)
    ShowHighlights = state
    refreshESP()
end)

ESPGroup:AddToggle("Ignore Teammates", IgnoreTeammates, function(state)
    IgnoreTeammates = state
    refreshESP()
end)

ESPGroup:AddToggle("Visibility Check", UseVisibilityCheck, function(state)
    UseVisibilityCheck = state
    refreshESP()
end)

ESPGroup:AddSlider("Highlight Transparency", 0.1, 1.0, HighlightTransparency, function(value)
    HighlightTransparency = value
    for _, esp in pairs(ESPObjects) do
        if esp.highlight then
            esp.highlight.FillTransparency = value
        end
    end
end)

ESPGroup:AddToggle("Show Names", ShowNames, function(state)
    ShowNames = state
    for _, esp in pairs(ESPObjects) do
        if esp.nameLabel then
            esp.nameLabel.Visible = state and ESPEnabled
        end
    end
end)

ESPGroup:AddToggle("Show Distance", ShowDistance, function(state)
    ShowDistance = state
    for _, esp in pairs(ESPObjects) do
        if esp.distanceLabel then
            esp.distanceLabel.Visible = state and ESPEnabled
        end
    end
end)

ESPGroup:AddToggle("Show Tracers", ShowTracers, function(state)
    ShowTracers = state
    for _, esp in pairs(ESPObjects) do
        if esp.tracer then
            esp.tracer.Visible = state and ESPEnabled
        end
    end
end)

ESPGroup:AddToggle("Hide Teammate Lines", HideTeammateLines, function(state)
    HideTeammateLines = state
    refreshESP()
end)

ESPGroup:AddSlider("Max Distance", 50, 2000, MaxDistance, function(value)
    MaxDistance = value
end)

ESPGroup:AddSlider("Text Size", 8, 24, TextSize, function(value)
    TextSize = value
    for _, esp in pairs(ESPObjects) do
        if esp.nameLabel then
            esp.nameLabel.Size = value
        end
        if esp.distanceLabel then
            esp.distanceLabel.Size = value - 2
        end
    end
end)

ESPGroup:AddButton("Refresh ESP", function()
    refreshESP()
end)

-- ==================== ADVANCED VELOCITY-BASED PREDICTION AIMBOT ====================
local AimbotGroup = menu:CreateCollapsibleGroup(Tabs.MainTab, "Aimbot Settings", true, 300)

-- Core Aimbot Variables
local AimbotEnabled = false
local AimKey = Enum.KeyCode.LeftShift
local TeamCheckAimbot = true
local FOVCircle = true
local FOVSize = 50
local FOVCircleDrawing = nil

-- ==================== SMART GUN VELOCITY DETECTION ====================
local AutoDetectGunVelocity = true
local ManualBulletSpeed = 1000
local CurrentBulletSpeed = 1000
local CurrentWeaponName = "None"
local LastVelocityCheck = 0
local VelocityDetectionInterval = 0.5 -- Check every 0.5 seconds

-- Function to find equipped weapon and get its Velocity value
local function getEquippedWeaponVelocity()
    local character = LocalPlayer.Character
    if not character then
        return nil, "No Character"
    end
    
    -- Method 1: Check for tools in character (equipped weapons)
    for _, descendant in ipairs(character:GetDescendants()) do
        if descendant:IsA("Tool") then
            -- Check if this tool has a "Hold" part (indicates it's being held)
            local holdPart = descendant:FindFirstChild("Hold")
            if holdPart then
                -- Found a tool with Hold part - check for Velocity value
                local velocityValue = descendant:FindFirstChild("Velocity")
                if velocityValue and typeof(velocityValue.Value) == "number" then
                    return velocityValue.Value, descendant.Name
                end
            end
        end
    end
    
    -- Method 2: Check tools directly in character (some games don't use Hold part)
    for _, child in ipairs(character:GetChildren()) do
        if child:IsA("Tool") then
            local velocityValue = child:FindFirstChild("Velocity")
            if velocityValue and typeof(velocityValue.Value) == "number" then
                return velocityValue.Value, child.Name
            end
        end
    end
    
    -- Method 3: Check backpack for equipped weapons
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if backpack then
        for _, tool in ipairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.Parent == backpack then
                local velocityValue = tool:FindFirstChild("Velocity")
                if velocityValue and typeof(velocityValue.Value) == "number" then
                    return velocityValue.Value, tool.Name
                end
            end
        end
    end
    
    return nil, "No Weapon"
end

-- Function to update bullet speed with smart detection
local function updateBulletSpeed()
    if not AutoDetectGunVelocity then
        CurrentBulletSpeed = ManualBulletSpeed
        CurrentWeaponName = "Manual Setting"
        return
    end
    
    local currentTime = tick()
    if currentTime - LastVelocityCheck < VelocityDetectionInterval then
        return
    end
    
    LastVelocityCheck = currentTime
    
    local velocity, weaponName = getEquippedWeaponVelocity()
    
    if velocity then
        CurrentBulletSpeed = velocity
        CurrentWeaponName = weaponName
    else
        CurrentBulletSpeed = ManualBulletSpeed
        CurrentWeaponName = "No Weapon Detected"
    end
end

-- Get current bullet speed for prediction
local function getCurrentBulletSpeed()
    updateBulletSpeed()
    return CurrentBulletSpeed, CurrentWeaponName
end

-- ==================== PREDICTION SYSTEM ====================
local PredictionEnabled = true
local PredictionStrength = 1.5
local MaxPredictionDistance = 1500
local MinPredictionDistance = 70
local SmoothAiming = false
local SmoothnessFactor = 0.08

-- Advanced Prediction Settings
local PredictHorizontal = true
local PredictVertical = true
local AdaptivePrediction = true
local MinimumSpeedThreshold = 1 -- Lower threshold to detect slow movement
local DisablePredictionWhenClose = true

-- Visual Prediction Feedback
local ShowPredictionPoint = false
local ShowDistanceInfo = true
local ShowVelocityInfo = true
local ShowGunInfo = true
local PredictionPointColor = Color3.fromRGB(255, 255, 0)
local PredictionPointSize = 2
local PredictionPointTransparency = 0.8
local PredictionPointDrawing = nil
local DistanceTextDrawing = nil
local VelocityTextDrawing = nil
local GunTextDrawing = nil
local ShowPredictionTrajectory = false
local TrajectoryDrawing = nil

-- Velocity tracking for enemy movement
local EnemyVelocityTracker = {}
local LastPositionCache = {}
local LastUpdateTime = tick()

-- Aim Lock Mode
local AimLockMode = "Head" -- "Head", "Body", or "Snap"
local CurrentTarget = nil
local isAiming = false

-- Platform detection
local PlatformIsMobile = Services.UserInputService.TouchEnabled

-- Function to check if player is enemy for aimbot
local function isEnemyForAimbot(player)
    if player == LocalPlayer then return false end
    if not player.Character then return false end
    
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false end
    
    if TeamCheckAimbot then
        local teamStatus = getPlayerTeamStatus(player)
        return teamStatus == "enemy"
    end
    
    return true
end

-- Function to check if position is inside FOV circle
local function isInFOV(position)
    if not FOVCircle then return true end
    
    local screenPos, onScreen = Camera:WorldToViewportPoint(position)
    if not onScreen then return false end
    
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local screenPos2D = Vector2.new(screenPos.X, screenPos.Y)
    local distanceToCenter = (screenCenter - screenPos2D).Magnitude
    
    return distanceToCenter <= FOVSize
end

-- Update enemy velocity tracking
local function updateEnemyVelocityTracking()
    local currentTime = tick()
    local deltaTime = currentTime - LastUpdateTime
    
    if deltaTime <= 0 then return end
    
    for _, player in ipairs(Services.Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        
        local character = player.Character
        if not character then
            EnemyVelocityTracker[player] = nil
            LastPositionCache[player] = nil
            continue
        end
        
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not hrp then
            EnemyVelocityTracker[player] = Vector3.new(0, 0, 0)
            continue
        end
        
        local currentPos = hrp.Position
        
        if LastPositionCache[player] then
            local lastPos = LastPositionCache[player]
            local velocity = (currentPos - lastPos) / deltaTime
            
            -- Smooth velocity changes (reduces jitter)
            if EnemyVelocityTracker[player] then
                EnemyVelocityTracker[player] = EnemyVelocityTracker[player]:Lerp(velocity, 0.3)
            else
                EnemyVelocityTracker[player] = velocity
            end
        end
        
        LastPositionCache[player] = currentPos
    end
    
    LastUpdateTime = currentTime
end

-- Calculate advanced prediction based on velocity
local function calculateVelocityPrediction(targetPos, targetVelocity, shooterPos, bulletSpeed, distance)
    -- Calculate time for bullet to reach target
    local travelTime = distance / bulletSpeed
    
    -- Get target movement speed
    local targetSpeed = targetVelocity.Magnitude
    
    -- Calculate how far the target will move during bullet travel time
    local predictedMovement = targetVelocity * travelTime
    
    -- Apply adaptive prediction based on target speed
    local adaptiveFactor = 1.0
    if AdaptivePrediction then
        -- More prediction for faster targets
        adaptiveFactor = math.clamp(targetSpeed / 50, 0.5, 3.0)
    end
    
    -- Adjust prediction based on distance
    local distanceFactor = math.clamp(distance / 1000, 0.5, 2.0)
    
    -- Apply prediction strength
    local finalPrediction = predictedMovement * PredictionStrength * adaptiveFactor * distanceFactor
    
    -- Limit horizontal prediction if disabled
    if not PredictHorizontal then
        finalPrediction = Vector3.new(0, finalPrediction.Y, 0)
    end
    
    -- Limit vertical prediction if disabled
    if not PredictVertical then
        finalPrediction = Vector3.new(finalPrediction.X, 0, finalPrediction.Z)
    end
    
    -- Calculate final predicted position
    local predictedPos = targetPos + finalPrediction
    
    -- Get movement direction for display
    local movementDirection = ""
    if targetSpeed > 0 then
        local normalized = targetVelocity.Unit
        if math.abs(normalized.X) > math.abs(normalized.Z) then
            movementDirection = normalized.X > 0 and "RIGHT" or "LEFT"
        else
            movementDirection = normalized.Z > 0 and "FORWARD" or "BACKWARD"
        end
    end
    
    return predictedPos, finalPrediction, targetSpeed, movementDirection
end

-- Get aim position with advanced velocity prediction
local function getAimPositionWithPrediction(player, mode)
    if not player or not player.Character then 
        return nil, nil, "No Character", false, 0, "N/A"
    end
    
    local character = player.Character
    mode = mode or AimLockMode
    
    -- Get target position based on mode
    local targetPos = nil
    if mode == "Head" or mode == "Snap" then
        local head = character:FindFirstChild("Head")
        if head then
            targetPos = head.Position
        else
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if hrp then
                targetPos = hrp.Position + Vector3.new(0, 2.5, 0)
            end
        end
    elseif mode == "Body" then
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp then
            targetPos = hrp.Position + Vector3.new(0, 1.5, 0)
        end
    end
    
    if not targetPos then 
        return nil, nil, "No Position", false, 0, "N/A"
    end
    
    -- Get current bullet speed
    local bulletSpeed, weaponName = getCurrentBulletSpeed()
    
    -- Get shooter position
    local myCharacter = LocalPlayer.Character
    local myHrp = myCharacter and myCharacter:FindFirstChild("HumanoidRootPart")
    local shooterPos = myHrp and myHrp.Position or Camera.CFrame.Position
    
    -- Calculate distance
    local distance = (targetPos - shooterPos).Magnitude
    
    -- Check if too close for prediction
    local isCloseRange = DisablePredictionWhenClose and distance <= MinPredictionDistance
    
    -- Get enemy velocity
    local targetVelocity = EnemyVelocityTracker[player] or Vector3.new(0, 0, 0)
    local targetSpeed = targetVelocity.Magnitude
    
    -- Check if prediction should be applied
    if not PredictionEnabled or bulletSpeed <= 0 or targetSpeed < MinimumSpeedThreshold or isCloseRange then
        return targetPos, Vector3.new(0, 0, 0), "No Prediction", isCloseRange, targetSpeed, "STATIONARY"
    end
    
    -- Apply velocity-based prediction
    local predictedPos, predictedOffset, calculatedSpeed, movementDirection = calculateVelocityPrediction(
        targetPos, targetVelocity, shooterPos, bulletSpeed, distance
    )
    
    local predictionStatus = ""
    if isCloseRange then
        predictionStatus = "TOO CLOSE"
    elseif targetSpeed < 5 then
        predictionStatus = "SLOW MOVING"
    elseif targetSpeed < 15 then
        predictionStatus = "WALKING"
    else
        predictionStatus = "RUNNING"
    end
    
    return predictedPos, predictedOffset, predictionStatus, isCloseRange, targetSpeed, movementDirection
end

-- Find best target with prediction consideration
local function findBestTarget()
    local myCharacter = LocalPlayer.Character
    if not myCharacter then return nil end
    
    local myHrp = myCharacter:FindFirstChild("HumanoidRootPart")
    if not myHrp then return nil end
    
    local bestTarget = nil
    local bestScore = -math.huge
    
    -- Update enemy velocity tracking
    updateEnemyVelocityTracking()
    
    -- Check all players
    for _, player in ipairs(Services.Players:GetPlayers()) do
        if not isEnemyForAimbot(player) then continue end
        
        local aimPos, predictedOffset, predictionStatus, isCloseRange, targetSpeed, movementDirection = getAimPositionWithPrediction(player, AimLockMode)
        if not aimPos then continue end
        
        -- Check if inside FOV circle
        if not isInFOV(aimPos) then continue end
        
        local distance = (aimPos - myHrp.Position).Magnitude
        if distance > MaxDistance then continue end
        
        -- Check visibility
        local visible = isPlayerVisible(player, VisibilityCheckMode)
        
        -- Calculate target score
        local score = 0
        
        -- Distance score (closer is better)
        score = score + (MaxDistance - distance) * 0.1
        
        -- Visibility bonus
        if visible then
            score = score + 100
        end
        
        -- Moving target bonus (more prediction needed = higher score for demonstration)
        if targetSpeed > 5 then
            score = score + targetSpeed * 2
        end
        
        -- Center of FOV bonus
        local screenPos, onScreen = Camera:WorldToViewportPoint(aimPos)
        if onScreen then
            local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            local screenPos2D = Vector2.new(screenPos.X, screenPos.Y)
            local distanceToCenter = (screenCenter - screenPos2D).Magnitude
            local fovScore = math.max(0, 50 - (distanceToCenter / FOVSize * 50))
            score = score + fovScore
        end
        
        -- Select best target
        if score > bestScore then
            bestScore = score
            bestTarget = {
                player = player,
                aimPosition = aimPos,
                predictedOffset = predictedOffset,
                predictionStatus = predictionStatus,
                distance = distance,
                isCloseRange = isCloseRange,
                visible = visible,
                targetSpeed = targetSpeed,
                movementDirection = movementDirection,
                score = score
            }
        end
    end
    
    return bestTarget
end

-- Smooth aiming function
local function smoothAimAtTarget(targetPos)
    local camera = Camera
    local cameraPosition = camera.CFrame.Position
    local currentLook = camera.CFrame.LookVector
    
    local desiredLook = (targetPos - cameraPosition).Unit
    
    if SmoothAiming and SmoothnessFactor > 0 then
        local smoothedLook = currentLook:Lerp(desiredLook, SmoothnessFactor)
        camera.CFrame = CFrame.new(cameraPosition, cameraPosition + smoothedLook)
    else
        camera.CFrame = CFrame.new(cameraPosition, cameraPosition + desiredLook)
    end
end

-- Update prediction visual feedback
local function updatePredictionVisual(targetData)
    if not targetData or not ShowPredictionPoint then
        if PredictionPointDrawing then
            PredictionPointDrawing.Visible = false
        end
        if DistanceTextDrawing then
            DistanceTextDrawing.Visible = false
        end
        if VelocityTextDrawing then
            VelocityTextDrawing.Visible = false
        end
        if GunTextDrawing then
            GunTextDrawing.Visible = false
        end
        if TrajectoryDrawing then
            TrajectoryDrawing.Visible = false
        end
        return
    end
    
    -- Create drawings if needed
    if not PredictionPointDrawing and ShowPredictionPoint then
        PredictionPointDrawing = Drawing.new("Circle")
        PredictionPointDrawing.Visible = true
        PredictionPointDrawing.Thickness = 2
        PredictionPointDrawing.Color = PredictionPointColor
        PredictionPointDrawing.Transparency = PredictionPointTransparency
        PredictionPointDrawing.Filled = true
        PredictionPointDrawing.Radius = PredictionPointSize
    end
    
    if not DistanceTextDrawing and ShowDistanceInfo then
        DistanceTextDrawing = Drawing.new("Text")
        DistanceTextDrawing.Visible = true
        DistanceTextDrawing.Size = 13
        DistanceTextDrawing.Center = true
        DistanceTextDrawing.Outline = true
        DistanceTextDrawing.OutlineColor = Color3.new(0, 0, 0)
    end
    
    if not VelocityTextDrawing and ShowVelocityInfo then
        VelocityTextDrawing = Drawing.new("Text")
        VelocityTextDrawing.Visible = true
        VelocityTextDrawing.Size = 12
        VelocityTextDrawing.Center = true
        VelocityTextDrawing.Outline = true
        VelocityTextDrawing.OutlineColor = Color3.new(0, 0, 0)
    end
    
    if not GunTextDrawing and ShowGunInfo then
        GunTextDrawing = Drawing.new("Text")
        GunTextDrawing.Visible = true
        GunTextDrawing.Size = 11
        GunTextDrawing.Center = true
        GunTextDrawing.Outline = true
        GunTextDrawing.OutlineColor = Color3.new(0, 0, 0)
    end
    
    if not TrajectoryDrawing and ShowPredictionTrajectory then
        TrajectoryDrawing = Drawing.new("Line")
        TrajectoryDrawing.Visible = true
        TrajectoryDrawing.Thickness = 1
        TrajectoryDrawing.Color = Color3.fromRGB(255, 150, 50)
        TrajectoryDrawing.Transparency = 0.6
    end
    
    -- Get actual body part position
    local character = targetData.player.Character
    local actualPos = nil
    if AimLockMode == "Head" then
        local head = character and character:FindFirstChild("Head")
        if head then
            actualPos = head.Position
        end
    else
        local hrp = character and character:FindFirstChild("HumanoidRootPart")
        if hrp then
            actualPos = hrp.Position + Vector3.new(0, 1.5, 0)
        end
    end
    
    if not actualPos then return end
    
    -- Show prediction point
    local screenPos, onScreen = Camera:WorldToViewportPoint(targetData.aimPosition)
    if onScreen and PredictionPointDrawing then
        PredictionPointDrawing.Visible = ShowPredictionPoint
        PredictionPointDrawing.Position = Vector2.new(screenPos.X, screenPos.Y)
        
        -- Get current gun info
        local bulletSpeed, weaponName = getCurrentBulletSpeed()
        
        -- Color based on prediction status
        if targetData.isCloseRange then
            PredictionPointDrawing.Color = Color3.fromRGB(50, 150, 255) -- Blue
            PredictionPointDrawing.Radius = PredictionPointSize * 1.5
        elseif targetData.targetSpeed < 5 then
            PredictionPointDrawing.Color = Color3.fromRGB(50, 255, 50) -- Green
            PredictionPointDrawing.Radius = PredictionPointSize
        elseif targetData.targetSpeed < 15 then
            PredictionPointDrawing.Color = Color3.fromRGB(255, 200, 50) -- Yellow
            PredictionPointDrawing.Radius = PredictionPointSize * 1.2
        else
            PredictionPointDrawing.Color = Color3.fromRGB(255, 50, 50) -- Red
            PredictionPointDrawing.Radius = PredictionPointSize * 1.3
        end
        
        -- Update distance text
        if DistanceTextDrawing and ShowDistanceInfo then
            DistanceTextDrawing.Text = string.format("DIST: %d studs", math.floor(targetData.distance))
            DistanceTextDrawing.Color = PredictionPointDrawing.Color
            DistanceTextDrawing.Position = Vector2.new(screenPos.X, screenPos.Y + 15)
            DistanceTextDrawing.Visible = true
        end
        
        -- Update velocity text
        if VelocityTextDrawing and ShowVelocityInfo then
            VelocityTextDrawing.Text = string.format("ENEMY: %.1f studs/s %s", targetData.targetSpeed, targetData.movementDirection)
            VelocityTextDrawing.Color = targetData.targetSpeed > 5 and Color3.fromRGB(255, 150, 50) or Color3.fromRGB(100, 255, 100)
            VelocityTextDrawing.Position = Vector2.new(screenPos.X, screenPos.Y + 30)
            VelocityTextDrawing.Visible = true
        end
        
        -- Update gun info text
        if GunTextDrawing and ShowGunInfo then
            GunTextDrawing.Text = string.format("%s: %d studs/s", weaponName, math.floor(bulletSpeed))
            GunTextDrawing.Color = Color3.fromRGB(150, 200, 255)
            GunTextDrawing.Position = Vector2.new(screenPos.X, screenPos.Y + 45)
            GunTextDrawing.Visible = true
        end
    else
        if PredictionPointDrawing then
            PredictionPointDrawing.Visible = false
        end
        if DistanceTextDrawing then
            DistanceTextDrawing.Visible = false
        end
        if VelocityTextDrawing then
            VelocityTextDrawing.Visible = false
        end
        if GunTextDrawing then
            GunTextDrawing.Visible = false
        end
    end
    
    -- Show trajectory line
    if ShowPredictionTrajectory and TrajectoryDrawing and targetData.predictedOffset and targetData.predictedOffset.Magnitude > 1 and not targetData.isCloseRange then
        local actualScreenPos, actualOnScreen = Camera:WorldToViewportPoint(actualPos)
        local predictedScreenPos, predictedOnScreen = Camera:WorldToViewportPoint(targetData.aimPosition)
        
        if actualOnScreen and predictedOnScreen then
            TrajectoryDrawing.Visible = true
            TrajectoryDrawing.From = Vector2.new(actualScreenPos.X, actualScreenPos.Y)
            TrajectoryDrawing.To = Vector2.new(predictedScreenPos.X, predictedScreenPos.Y)
            TrajectoryDrawing.Thickness = math.clamp(targetData.predictedOffset.Magnitude / 5, 1, 3)
        else
            TrajectoryDrawing.Visible = false
        end
    elseif TrajectoryDrawing then
        TrajectoryDrawing.Visible = false
    end
end

-- Aim at target function
local function aimAtTarget(targetData)
    if not targetData or not targetData.player then return false end
    
    -- Get aim position with prediction
    local aimPos, predictedOffset, predictionStatus, isCloseRange, targetSpeed, movementDirection = getAimPositionWithPrediction(targetData.player, AimLockMode)
    if not aimPos then return false end
    
    -- Update visual feedback
    updatePredictionVisual(targetData)
    
    -- Update target data
    targetData.aimPosition = aimPos
    targetData.predictedOffset = predictedOffset
    targetData.predictionStatus = predictionStatus
    targetData.isCloseRange = isCloseRange
    targetData.targetSpeed = targetSpeed
    targetData.movementDirection = movementDirection
    
    -- Debug logging
    local bulletSpeed, weaponName = getCurrentBulletSpeed()
    local offset = math.floor(predictedOffset.Magnitude)
    
    
    -- Apply aiming
    if SmoothAiming then
        smoothAimAtTarget(aimPos)
    else
        local camera = Camera
        local cameraPosition = camera.CFrame.Position
        local desiredLook = (aimPos - cameraPosition).Unit
        camera.CFrame = CFrame.new(cameraPosition, cameraPosition + desiredLook)
    end
    
    return true
end

-- FOV Circle Drawing
local function updateFOVCircle()
    if not FOVCircleDrawing and FOVCircle and AimbotEnabled then
        FOVCircleDrawing = Drawing.new("Circle")
        FOVCircleDrawing.Visible = true
        FOVCircleDrawing.Thickness = 2
        FOVCircleDrawing.Color = Color3.fromRGB(255, 50, 50)
        FOVCircleDrawing.Transparency = 0.5
        FOVCircleDrawing.Filled = false
    end
    
    if FOVCircleDrawing then
        FOVCircleDrawing.Visible = FOVCircle and AimbotEnabled
        FOVCircleDrawing.Radius = FOVSize
        FOVCircleDrawing.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    end
end

-- Main aimbot loop
local aimbotConnection = nil
local velocityUpdateConnection = nil

-- Function to check if key is pressed
local function isKeyPressed(key)
    if typeof(key) == "EnumItem" then
        if key.EnumType == Enum.KeyCode then
            return Services.UserInputService:IsKeyDown(key)
        elseif key.EnumType == Enum.UserInputType then
            return Services.UserInputService:IsMouseButtonPressed(key)
        end
    end
    return false
end

local function startAimbot()
    if aimbotConnection then
        aimbotConnection:Disconnect()
        aimbotConnection = nil
    end
    
    if velocityUpdateConnection then
        velocityUpdateConnection:Disconnect()
        velocityUpdateConnection = nil
    end
    
    -- Clean up drawings
    if PredictionPointDrawing then
        PredictionPointDrawing:Remove()
        PredictionPointDrawing = nil
    end
    if DistanceTextDrawing then
        DistanceTextDrawing:Remove()
        DistanceTextDrawing = nil
    end
    if VelocityTextDrawing then
        VelocityTextDrawing:Remove()
        VelocityTextDrawing = nil
    end
    if GunTextDrawing then
        GunTextDrawing:Remove()
        GunTextDrawing = nil
    end
    if TrajectoryDrawing then
        TrajectoryDrawing:Remove()
        TrajectoryDrawing = nil
    end
    
    -- Start velocity tracking
    velocityUpdateConnection = Services.RunService.Heartbeat:Connect(function(deltaTime)
        updateEnemyVelocityTracking()
    end)
    
    -- Start aimbot
    aimbotConnection = Services.RunService.RenderStepped:Connect(function()
        if not AimbotEnabled then
            if FOVCircleDrawing then
                FOVCircleDrawing.Visible = false
            end
            if PredictionPointDrawing then
                PredictionPointDrawing.Visible = false
            end
            if DistanceTextDrawing then
                DistanceTextDrawing.Visible = false
            end
            if VelocityTextDrawing then
                VelocityTextDrawing.Visible = false
            end
            if GunTextDrawing then
                GunTextDrawing.Visible = false
            end
            if TrajectoryDrawing then
                TrajectoryDrawing.Visible = false
            end
            CurrentTarget = nil
            isAiming = false
            return
        end
        
        updateFOVCircle()
        
        -- Check if aiming key is pressed
        local aimNow = PlatformIsMobile and AimbotEnabled or isKeyPressed(AimKey)
        
        if aimNow then
            -- Find initial target if we don't have one
            if not CurrentTarget then
                CurrentTarget = findBestTarget()
            end
            
            -- If we have a target, follow it
            if CurrentTarget and CurrentTarget.player and CurrentTarget.player.Character then
                local humanoid = CurrentTarget.player.Character:FindFirstChildOfClass("Humanoid")
                
                if humanoid and humanoid.Health > 0 then
                    -- Target is valid
                    isAiming = true
                    aimAtTarget(CurrentTarget)
                else
                    -- Target became invalid
                    CurrentTarget = findBestTarget()
                    if CurrentTarget then
                        isAiming = true
                        aimAtTarget(CurrentTarget)
                    else
                        isAiming = false
                    end
                end
            else
                -- No target
                CurrentTarget = findBestTarget()
                if CurrentTarget then
                    isAiming = true
                    aimAtTarget(CurrentTarget)
                else
                    isAiming = false
                end
            end
        else
            -- Not aiming
            CurrentTarget = nil
            isAiming = false
        end
    end)
end

local function stopAimbot()
    if aimbotConnection then
        aimbotConnection:Disconnect()
        aimbotConnection = nil
    end
    
    if velocityUpdateConnection then
        velocityUpdateConnection:Disconnect()
        velocityUpdateConnection = nil
    end
    
    if FOVCircleDrawing then
        FOVCircleDrawing:Remove()
        FOVCircleDrawing = nil
    end
    
    if PredictionPointDrawing then
        PredictionPointDrawing:Remove()
        PredictionPointDrawing = nil
    end
    
    if DistanceTextDrawing then
        DistanceTextDrawing:Remove()
        DistanceTextDrawing = nil
    end
    
    if VelocityTextDrawing then
        VelocityTextDrawing:Remove()
        VelocityTextDrawing = nil
    end
    
    if GunTextDrawing then
        GunTextDrawing:Remove()
        GunTextDrawing = nil
    end
    
    if TrajectoryDrawing then
        TrajectoryDrawing:Remove()
        TrajectoryDrawing = nil
    end
    
    -- Clear tracking data
    EnemyVelocityTracker = {}
    LastPositionCache = {}
    CurrentTarget = nil
    isAiming = false
end

-- Aimbot GUI Controls
local aimbotCombo = nil

-- Advanced Prediction Settings Group
local PredictionGroup = menu:CreateCollapsibleGroup(Tabs.MainTab, "Advanced Prediction", false, 300)

PredictionGroup:AddToggle("Enable Prediction", PredictionEnabled, function(state)
    PredictionEnabled = state
end)

PredictionGroup:AddSlider("Prediction Strength", 0.1, 5.0, PredictionStrength, function(value)
    PredictionStrength = value
end)

-- Gun Velocity Settings
PredictionGroup:AddToggle("Auto-Detect Gun Velocity", AutoDetectGunVelocity, function(state)
    AutoDetectGunVelocity = state
    if not state then
        showNotification("Gun Velocity", "Manual mode: " .. ManualBulletSpeed .. " studs/s", 3)
    else
        local bulletSpeed, weaponName = getCurrentBulletSpeed()
        showNotification("Gun Detection", "Detected: " .. weaponName .. " (" .. bulletSpeed .. " studs/s)", 3)
    end
end)

PredictionGroup:AddSlider("Manual Bullet Speed", 100, 5000, ManualBulletSpeed, function(value)
    ManualBulletSpeed = value
    if not AutoDetectGunVelocity then
        showNotification("Bullet Speed", "Set to: " .. value .. " studs/s", 2)
    end
end)

PredictionGroup:AddButton("Detect Current Gun", function()
    local bulletSpeed, weaponName = getCurrentBulletSpeed()
    showNotification("Gun Detection", weaponName .. ": " .. bulletSpeed .. " studs/s", 3)
    
    -- Update manual speed to detected value
    if not AutoDetectGunVelocity then
        menu:Set("Manual Bullet Speed", bulletSpeed)
    end
end)

PredictionGroup:AddSlider("Max Distance", 100, 5000, MaxPredictionDistance, function(value)
    MaxPredictionDistance = value
end)

PredictionGroup:AddSlider("Min Distance", 0, 200, MinPredictionDistance, function(value)
    MinPredictionDistance = value
end)

PredictionGroup:AddToggle("Disable When Close", DisablePredictionWhenClose, function(state)
    DisablePredictionWhenClose = state
end)

PredictionGroup:AddToggle("Horizontal Prediction", PredictHorizontal, function(state)
    PredictHorizontal = state
end)

PredictionGroup:AddToggle("Vertical Prediction", PredictVertical, function(state)
    PredictVertical = state
end)

PredictionGroup:AddToggle("Adaptive Prediction", AdaptivePrediction, function(state)
    AdaptivePrediction = state
end)

PredictionGroup:AddSlider("Min Speed Threshold", 0.1, 10, MinimumSpeedThreshold, function(value)
    MinimumSpeedThreshold = value
end)

PredictionGroup:AddToggle("Smooth Aiming", SmoothAiming, function(state)
    SmoothAiming = state
end)

PredictionGroup:AddSlider("Smoothness", 0.01, 0.3, SmoothnessFactor, function(value)
    SmoothnessFactor = value
end)

-- Visual Feedback Settings
PredictionGroup:AddToggle("Show Prediction Point", ShowPredictionPoint, function(state)
    ShowPredictionPoint = state
end)

PredictionGroup:AddToggle("Show Distance Info", ShowDistanceInfo, function(state)
    ShowDistanceInfo = state
end)

PredictionGroup:AddToggle("Show Enemy Velocity", ShowVelocityInfo, function(state)
    ShowVelocityInfo = state
end)

PredictionGroup:AddToggle("Show Gun Info", ShowGunInfo, function(state)
    ShowGunInfo = state
end)

PredictionGroup:AddToggle("Show Trajectory Line", ShowPredictionTrajectory, function(state)
    ShowPredictionTrajectory = state
end)

if not PlatformIsMobile then
    -- PC version with combo system
    aimbotCombo = menu:CreateCombo(Tabs.MainTab, "Aimbot Control", 
        function(state)
            AimbotEnabled = state
            if state then
                startAimbot()
            else
                stopAimbot()
            end
        end,
        function() 
            if not AimbotEnabled then
                AimbotEnabled = true
                aimbotCombo:SetToggle(true)
                startAimbot()
            end
        end,
        function()
            stopAimbot()
            AimLockMode = "Head"
            FOVSize = 50
            TeamCheckAimbot = true
            
            -- Reset prediction settings
            PredictionStrength = 1.5
            ManualBulletSpeed = 1000
            MinPredictionDistance = 70
            DisablePredictionWhenClose = true
            
            -- Update GUI
            if menu.Set then
                menu:Set("Prediction Strength", 1.5)
                menu:Set("Manual Bullet Speed", 1000)
                menu:Set("Min Distance", 70)
                menu:Set("Disable When Close", true)
            end
            
            showNotification("Aimbot Reset", "All settings reset to defaults")
        end,
        false,
        Enum.KeyCode.LeftShift
    )
    
    -- Update AimKey from combo
    spawn(function()
        while wait(1) do
            if aimbotCombo then
                local currentState = aimbotCombo:GetState()
                if currentState then
                    AimKey = currentState.Keybind or AimKey
                    AimbotEnabled = currentState.Toggled or AimbotEnabled
                    
                    if currentState.Toggled ~= nil and currentState.Toggled ~= AimbotEnabled then
                        if currentState.Toggled then
                            startAimbot()
                        else
                            stopAimbot()
                        end
                    end
                end
            end
        end
    end)
    
    -- Add toggle to AimbotGroup
    AimbotGroup:AddToggle("Enable Aimbot", false, function(state)
        AimbotEnabled = state
        if aimbotCombo then
            aimbotCombo:SetToggle(state)
        end
        if state then
            startAimbot()
        else
            stopAimbot()
        end
    end, false)
else
    -- Mobile version
    AimbotGroup:AddToggle("Enable Aimbot", AimbotEnabled, function(state)
        AimbotEnabled = state
        if state then
            startAimbot()
        else
            stopAimbot()
        end
    end)
end

-- Aim Lock Mode Selection
AimbotGroup:AddDropdown("Target Mode", {"Head", "Body", "Snap"}, "Head", function(selected)
    AimLockMode = selected
end)

-- Team Check
AimbotGroup:AddToggle("Team Check", true, function(state)
    TeamCheckAimbot = state
end)

-- FOV Settings
AimbotGroup:AddToggle("Show FOV Circle", true, function(state)
    FOVCircle = state
    if state and AimbotEnabled then
        updateFOVCircle()
    end
end)

AimbotGroup:AddSlider("FOV Size", 20, 500, 100, function(value)
    FOVSize = value
    updateFOVCircle()
end)

-- Utility Button
AimbotGroup:AddButton("Reset All", function()
    stopAimbot()
    AimLockMode = "Head"
    FOVSize = 50
    TeamCheckAimbot = true
    PredictionStrength = 1.5
    ManualBulletSpeed = 1000
    MinPredictionDistance = 70
    DisablePredictionWhenClose = true
    
    -- Reset combo if exists
    if aimbotCombo then
        aimbotCombo:SetToggle(false)
        aimbotCombo:SetKeybind(Enum.KeyCode.LeftShift)
    end
    
    -- Update GUI
    if menu.Set then
        menu:Set("Prediction Strength", 1.5)
        menu:Set("Manual Bullet Speed", 1000)
        menu:Set("Min Distance", 70)
        menu:Set("Disable When Close", true)
        menu:Set("Target Mode", "Head")
        menu:Set("FOV Size", 100)
        menu:Set("Team Check", true)
    end
    
    showNotification("Reset Complete", "All settings have been reset")
end)

-- ==================== QUICK CLASS SETTINGS ====================
local Classes = {
    "Rifleman", "Assault", "Support", "Medic", "Skirmisher", "Recon", "Engineer", "Flamer", "Officer"
}

local ClassGroup = menu:CreateCollapsibleGroup(Tabs.ClassTab,"⚔️Quick Class Settings⚔️" ,true,260)
menu:MarkAsNew(ClassGroup:GetInstance(),"NEW")

ClassGroup:AddButton("✏ RIFLEMAN Class",function()
    menu:Set("Prediction Strength",2)
    menu:Set("Auto-Detect Gun Velocity", true)
    menu:Set("Max Distance",1500)
    menu:Set("Min Distance",20)
    menu:Set("Min Speed Threshold",1)
    showNotification("Class Config","✏ RIFLEMAN - Auto-detect gun velocity")
end)

ClassGroup:AddButton("🧨 Assault Class", function()
    menu:Set("Prediction Strength",2.5)
    menu:Set("Manual Bullet Speed",600)
    menu:Set("Auto-Detect Gun Velocity", false)
    menu:Set("Max Distance",1000)
    menu:Set("Min Distance",20)
    menu:Set("Min Speed Threshold",1)
    showNotification("Class Config","Assault - Bullet Speed: 600 studs/s")
end)

ClassGroup:AddButton("👀 Recon", function()
    menu:Set("Prediction Strength",1.5)
    menu:Set("Manual Bullet Speed",1500)
    menu:Set("Auto-Detect Gun Velocity", false)
    menu:Set("Max Distance",2000)
    menu:Set("Min Distance",70)
    menu:Set("Min Speed Threshold",0.5)
    showNotification("Class Config","👀 Recon - Bullet Speed: 1500 studs/s")
end)

ClassGroup:AddButton("💥 Heavy Weapons", function()
    menu:Set("Prediction Strength",3.0)
    menu:Set("Manual Bullet Speed",400)
    menu:Set("Auto-Detect Gun Velocity", false)
    menu:Set("Max Distance",800)
    menu:Set("Min Distance",30)
    menu:Set("Min Speed Threshold",2)
    showNotification("Class Config","💥 Heavy Weapons - Bullet Speed: 400 studs/s")
end)

ClassGroup:AddButton("🎯 Sniper", function()
    menu:Set("Prediction Strength",1.2)
    menu:Set("Manual Bullet Speed",3000)
    menu:Set("Auto-Detect Gun Velocity", false)
    menu:Set("Max Distance",3000)
    menu:Set("Min Distance",100)
    menu:Set("Min Speed Threshold",0.3)
    showNotification("Class Config","🎯 Sniper - Bullet Speed: 3000 studs/s")
end)

ClassGroup:AddSeparator("Do you have Custom Prediction config?")
ClassGroup:AddLabel("Submit yours now, Send your config in discord.")
ClassGroup:AddLabel("Export your config and paste it on discord.")

-- ==================== CONFIG MANAGER ====================
-- (Config manager code remains the same as previous version)
-- [Previous config manager code here...]

-- Start initial ESP and Aimbot if enabled
if ESPEnabled then
    task.wait(0.5)
    startESP()
end

if AimbotEnabled then
    task.wait(0.5)
    startAimbot()
end

showNotification("SFY Hub Loaded", "Version 2.2 - Advanced Velocity Prediction Ready!", 3)
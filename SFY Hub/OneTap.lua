--[[
dwad
wadwa
d
wc
4cs
yg5
etv4a
4tev
tv4e
vt4
t4ev
tve4
tv4
wb54
4n
56
r6r
67ir
67i4w5y
3
3
4w5y
45
y56
e5
6
4w3q
q3
3
4w5
4w5y
45y
54y
45y

54

54y

54y

4vb5

b54y

b4w5y
b54y
w
54by

w54y
n
54wey

5b4

w54y

45y

y5

5w45
b
u
n56
7
n

68

not
5n7i

]]



local GuiLibrary = loadstring(game:HttpGet("https://github.com/OxyCoder32/Crackers/raw/refs/heads/main/SFY%20Hub/GuiLib.lua"))()
local menu = GuiLibrary.new("SFY_Hub_library")
menu:SetPremiumStatus(true)

-- Services
local Services = {
    Players = game:GetService("Players"),
    Workspace = game:GetService("Workspace"),
    RunService = game:GetService("RunService"),
    UserInputService = game:GetService("UserInputService"),
    Lighting = game:GetService("Lighting"),
    ReplicatedStorage = game:GetService("ReplicatedStorage")
}

-- Player references
local Player, LocalPlayer = Services.Players.LocalPlayer, Services.Players.LocalPlayer
local Camera = Services.Workspace.CurrentCamera

-- Tabs
local Tabs = {
    InfoTab = menu:CreateTab("Info"),
    VisualTab = menu:CreateTab("Visual"),
    MainTab = menu:CreateTab("Main"),
}

-- Create welcome panel
local welcomePanel = menu:CreateWelcomePanelTab(Tabs.InfoTab, {
    ScriptName = "ONE TAP",
    Version = "V2.0",
    Developer = "SFY_devs",
    Discord = "discord.gg/wcpvkVPEAA",
    Description = "Advanced ESP & Smart Aimbot with Color Config",
    Features = {
        "🎯 Smart ESP with Visibility Detection",
        "🎯 Priority Targeting on Visible Enemies",
        "🎯 Advanced Color Picker with Config Saving",
        "🎯 Separate Colors for Players & Bots",
        "🎮 Mobile & PC Support"
    },
    ThemeColor = Color3.fromRGB(255,0,0)
})

-- Use the builder
menu:CreateSeparator(Tabs.InfoTab, "🐞 CHANGE LOGS ")
local updateHistory = menu:UpdateHistoryBuilder(Tabs.InfoTab)
:Add("2025-12-12","add","COLOR CONFIG SYSTEM","Added advanced color picker with config saving")
:Add("2025-12-12","fix","FIXED EXCLUSIONS","Excluded local player from ESP & Aimbot")
:Add("2025-12-12","improve","SMART TARGETING","Aimbot prioritizes visible enemies")
:Add("2025-12-12","add","NEW FEATURES","Added separate colors for players/bots + visibility system")
:Build()

-- ==================== ADVANCED ESP SYSTEM ====================
local ESPGroup = menu:CreateCollapsibleGroup(Tabs.VisualTab, "Player ESP", true, 300)

-- ESP Variables
local ESPEnabled = false
local ShowNames = true
local ShowDistance = true
local ShowTracers = true
local ShowHighlights = true
local MaxDistance = 300
local TextSize = 14
local HighlightTransparency = 0.5

-- Color settings with config saving support
local PlayerVisibleColor = Color3.fromRGB(50, 255, 50)    -- Green for visible players
local PlayerHiddenColor = Color3.fromRGB(255, 50, 50)     -- Red for hidden players
local BotColor = Color3.fromRGB(255, 255, 0)              -- Yellow for bots (default)
local BotVisibleColor = Color3.fromRGB(100, 255, 100)     -- Light green for visible bots
local BotHiddenColor = Color3.fromRGB(255, 200, 50)       -- Orange for hidden bots

-- Drawing Objects storage
local ESPObjects = {}
local ESPLoop = nil

-- Function to check if a model is a valid entity (player or bot)
local function isValidEntity(model)
    if not model then return false end
    if model == LocalPlayer.Character then return false end -- Exclude local player
    
    -- Check if it's a player character
    for _, player in ipairs(Services.Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character == model then
            local humanoid = model:FindFirstChildOfClass("Humanoid")
            local head = model:FindFirstChild("Head")
            return humanoid and head and humanoid.Health > 0
        end
    end
    
    -- Check if it's a bot (has head but might not have humanoid)
    local head = model:FindFirstChild("Head")
    if head then
        -- For bots, check if it has health or just exists
        local humanoid = model:FindFirstChildOfClass("Humanoid")
        if humanoid then
            return humanoid.Health > 0
        else
            -- If no humanoid, assume it's alive
            return true
        end
    end
    
    return false
end

-- Function to check if entity is a player (not bot)
local function isPlayerEntity(model)
    for _, player in ipairs(Services.Players:GetPlayers()) do
        if player.Character == model and player ~= LocalPlayer then
            return true
        end
    end
    return false
end

-- Function to check if player is visible to local player
local function isEntityVisible(entity)
    if not entity then return false end
    
    local head = entity:FindFirstChild("Head")
    if not head then
        local hrp = entity:FindFirstChild("HumanoidRootPart")
        if not hrp then return false end
        head = hrp
    end
    
    local camera = Camera
    local origin = camera.CFrame.Position
    
    -- Check from camera to head (direct line of sight)
    local direction = (head.Position - origin).Unit
    local raycastParams = RaycastParams.new()
    
    -- Blacklist: Don't hit our own character or camera
    local ignoreList = {LocalPlayer.Character, camera}
    raycastParams.FilterDescendantsInstances = ignoreList
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.IgnoreWater = true
    
    -- Perform raycast
    local raycastResult = Services.Workspace:Raycast(origin, direction * (head.Position - origin).Magnitude, raycastParams)
    
    if not raycastResult then
        -- No hit means direct line of sight
        return true
    else
        -- Something was hit, check if it's the target entity
        local hitInstance = raycastResult.Instance
        local hitCharacter = hitInstance:FindFirstAncestorWhichIsA("Model")
        
        -- If what we hit is the target entity, they're visible
        return hitCharacter == entity
    end
end

-- Function to get ESP color based on entity type and visibility
local function getESPColor(entity)
    if isPlayerEntity(entity) then
        -- Player entity
        if isEntityVisible(entity) then
            return PlayerVisibleColor  -- Green when visible
        else
            return PlayerHiddenColor   -- Red when hidden
        end
    else
        -- Bot entity
        if isEntityVisible(entity) then
            return BotVisibleColor     -- Light green when visible
        else
            return BotHiddenColor      -- Orange when hidden
        end
    end
end

-- Function to get all valid entities in workspace
local function getAllEntities()
    local entities = {}
    
    -- Add player characters (excluding local player)
    for _, player in ipairs(Services.Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and isValidEntity(player.Character) then
            table.insert(entities, {
                model = player.Character,
                isPlayer = true,
                playerObject = player,
                name = player.Name
            })
        end
    end
    
    -- Scan workspace for bots/other entities
    for _, model in ipairs(Services.Workspace:GetChildren()) do
        if model:IsA("Model") and model ~= LocalPlayer.Character then
            if isValidEntity(model) then
                -- Check if it's not already a player character
                local isPlayerChar = false
                for _, player in ipairs(Services.Players:GetPlayers()) do
                    if player.Character == model then
                        isPlayerChar = true
                        break
                    end
                end
                
                if not isPlayerChar then
                    table.insert(entities, {
                        model = model,
                        isPlayer = false,
                        playerObject = nil,
                        name = model.Name
                    })
                end
            end
        end
    end
    
    return entities
end

-- Function to get entity health
local function getEntityHealth(entity)
    if not entity then return 0 end
    
    local humanoid = entity:FindFirstChildOfClass("Humanoid")
    if humanoid then
        return humanoid.Health
    end
    
    -- For entities without humanoid (bots), check if they exist
    local head = entity:FindFirstChild("Head")
    return head and 100 or 0
end

-- Function to create highlight
local function createHighlight(entity)
    if not entity then return nil end
    
    local existingHighlight = entity:FindFirstChild("SFY_Highlight")
    if existingHighlight then
        existingHighlight:Destroy()
    end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "SFY_Highlight"
    highlight.Adornee = entity
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = getESPColor(entity)
    highlight.FillTransparency = HighlightTransparency
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 0
    highlight.Enabled = ShowHighlights
    highlight.Parent = entity
    
    return highlight
end

-- Function to create drawing objects for ESP
local function createESPObjects(entityData)
    local esp = {
        model = entityData.model,
        isPlayer = entityData.isPlayer,
        playerObject = entityData.playerObject,
        name = entityData.name,
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
    esp.nameLabel.Font = 2
    esp.nameLabel.Size = TextSize
    
    -- Configure distance label
    esp.distanceLabel.Visible = false
    esp.distanceLabel.Center = true
    esp.distanceLabel.Outline = true
    esp.distanceLabel.OutlineColor = Color3.new(0, 0, 0)
    esp.distanceLabel.Font = 2
    esp.distanceLabel.Size = TextSize - 2
    
    -- Configure tracer line
    esp.tracer.Visible = false
    esp.tracer.Thickness = 1
    
    return esp
end

-- Function to clean up dead entities
local function cleanupDeadEntities()
    for key, esp in pairs(ESPObjects) do
        if not esp.model or not esp.model.Parent then
            -- Entity removed from workspace
            if esp.highlight then esp.highlight:Destroy() end
            if esp.nameLabel then esp.nameLabel:Remove() end
            if esp.distanceLabel then esp.distanceLabel:Remove() end
            if esp.tracer then esp.tracer:Remove() end
            ESPObjects[key] = nil
        elseif getEntityHealth(esp.model) <= 0 then
            -- Entity is dead
            if esp.highlight then esp.highlight:Destroy() end
            if esp.nameLabel then esp.nameLabel:Remove() end
            if esp.distanceLabel then esp.distanceLabel:Remove() end
            if esp.tracer then esp.tracer:Remove() end
            ESPObjects[key] = nil
        end
    end
end

-- Function to update drawing objects
local function updateESPObjects(esp)
    if not esp or not esp.model then return end
    
    local model = esp.model
    local head = model:FindFirstChild("Head")
    local hrp = model:FindFirstChild("HumanoidRootPart")
    
    if not head and not hrp then
        if esp.highlight then esp.highlight.Enabled = false end
        esp.nameLabel.Visible = false
        esp.distanceLabel.Visible = false
        esp.tracer.Visible = false
        return
    end
    
    local targetPart = head or hrp
    if not targetPart then return end
    
    -- Convert world position to screen space
    local screenPos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
    if not onScreen then
        if esp.highlight then esp.highlight.Enabled = false end
        esp.nameLabel.Visible = false
        esp.distanceLabel.Visible = false
        esp.tracer.Visible = false
        return
    end
    
    local screenPos2D = Vector2.new(screenPos.X, screenPos.Y)
    local distance = (targetPart.Position - Camera.CFrame.Position).Magnitude
    
    -- Check health
    if getEntityHealth(model) <= 0 then
        if esp.highlight then esp.highlight.Enabled = false end
        esp.nameLabel.Visible = false
        esp.distanceLabel.Visible = false
        esp.tracer.Visible = false
        return
    end
    
    -- Update visibility check (every 0.3 seconds for performance)
    local currentTime = tick()
    if currentTime - esp.lastVisibleCheck > 0.3 then
        esp.isVisible = isEntityVisible(model)
        esp.lastVisibleCheck = currentTime
    end
    
    -- Get appropriate color
    local espColor = getESPColor(model)
    
    -- Update highlight
    if ShowHighlights then
        if not esp.highlight or esp.highlight.Parent ~= model then
            if esp.highlight then esp.highlight:Destroy() end
            esp.highlight = createHighlight(model)
        end
        
        if esp.highlight then
            esp.highlight.Enabled = true
            esp.highlight.FillColor = espColor
            esp.highlight.FillTransparency = HighlightTransparency
            
            -- Make hidden entities more transparent
            if not esp.isVisible then
                esp.highlight.OutlineTransparency = 0.5
            else
                esp.highlight.OutlineTransparency = 0
            end
        end
    elseif esp.highlight then
        esp.highlight.Enabled = false
    end
    
    -- Update name label
    if ShowNames and distance <= MaxDistance then
        esp.nameLabel.Visible = true
        esp.nameLabel.Position = screenPos2D + Vector2.new(0, 25)
        esp.nameLabel.Text = esp.name .. (esp.isPlayer and "" or " [BOT]")
        esp.nameLabel.Size = TextSize
        esp.nameLabel.Color = espColor
    else
        esp.nameLabel.Visible = false
    end
    
    -- Update distance label
    if ShowDistance and distance <= MaxDistance then
        esp.distanceLabel.Visible = true
        esp.distanceLabel.Position = screenPos2D + Vector2.new(0, 40)
        esp.distanceLabel.Text = tostring(math.floor(distance)) .. " studs"
        esp.distanceLabel.Size = TextSize - 2
        esp.distanceLabel.Color = espColor
    else
        esp.distanceLabel.Visible = false
    end
    
    -- Update tracer line
    if ShowTracers and distance <= MaxDistance then
        esp.tracer.Visible = true
        esp.tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
        esp.tracer.To = screenPos2D
        esp.tracer.Color = espColor
        
        -- Make tracer more transparent for hidden entities
        if not esp.isVisible then
            esp.tracer.Transparency = 0.7
        else
            esp.tracer.Transparency = 0.4
        end
    else
        esp.tracer.Visible = false
    end
end

-- Main ESP update loop
local function updateESP()
    if not ESPEnabled then return end
    
    -- Clean up dead entities first
    cleanupDeadEntities()
    
    -- Get all current entities
    local entities = getAllEntities()
    
    -- Update existing ESP objects and add new ones
    for _, entityData in ipairs(entities) do
        local model = entityData.model
        local key = tostring(model)
        
        if not ESPObjects[key] then
            ESPObjects[key] = createESPObjects(entityData)
        end
        
        -- Update the ESP object
        updateESPObjects(ESPObjects[key])
    end
    
    -- Remove ESP objects for entities that no longer exist
    for key, esp in pairs(ESPObjects) do
        local found = false
        for _, entityData in ipairs(entities) do
            if entityData.model == esp.model then
                found = true
                break
            end
        end
        
        if not found then
            if esp.highlight then esp.highlight:Destroy() end
            if esp.nameLabel then esp.nameLabel:Remove() end
            if esp.distanceLabel then esp.distanceLabel:Remove() end
            if esp.tracer then esp.tracer:Remove() end
            ESPObjects[key] = nil
        end
    end
end

local function startESP()
    if ESPLoop then
        ESPLoop:Disconnect()
        ESPLoop = nil
    end
    
    -- Initialize ESP for all existing entities
    local entities = getAllEntities()
    for _, entityData in ipairs(entities) do
        local key = tostring(entityData.model)
        ESPObjects[key] = createESPObjects(entityData)
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
        if esp.highlight then esp.highlight:Destroy() end
        if esp.nameLabel then esp.nameLabel:Remove() end
        if esp.distanceLabel then esp.distanceLabel:Remove() end
        if esp.tracer then esp.tracer:Remove() end
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

-- ESP GUI Controls
ESPGroup:AddToggle("Enable ESP", ESPEnabled, function(state)
    ESPEnabled = state
    if state then
        startESP()
    else
        stopESP()
    end
end)

ESPGroup:AddToggle("Show Highlights", ShowHighlights, function(state)
    ShowHighlights = state
    refreshESP()
end)

ESPGroup:AddToggle("Show Names", ShowNames, function(state)
    ShowNames = state
end)

ESPGroup:AddToggle("Show Distance", ShowDistance, function(state)
    ShowDistance = state
end)

ESPGroup:AddToggle("Show Tracers", ShowTracers, function(state)
    ShowTracers = state
end)

ESPGroup:AddSlider("Highlight Transparency", 0.1, 1.0, HighlightTransparency, function(value)
    HighlightTransparency = value
    for _, esp in pairs(ESPObjects) do
        if esp.highlight then
            esp.highlight.FillTransparency = value
        end
    end
end)

-- Color Settings with Advanced Color Picker
menu:CreateSeparator(Tabs.VisualTab, "🎨 Color Settings (Saved per Game)")

-- Player Colors with config saving
local playerColorGroup = menu:CreateCollapsibleGroup(Tabs.VisualTab, "Player Colors", false, 250)


-- Bot Colors with config saving
local botColorGroup = menu:CreateCollapsibleGroup(Tabs.VisualTab, "Bot Colors", false, 250)



-- Color management buttons
menu:CreateSeparator(Tabs.VisualTab, "🔄 Color Management")

local colorManagementGroup = menu:CreateCollapsibleGroup(Tabs.VisualTab, "Color Management", false, 150)

colorManagementGroup:AddButton("Load All Saved Colors", function()
    if playerVisiblePicker then playerVisiblePicker:LoadConfig() end
    if playerHiddenPicker then playerHiddenPicker:LoadConfig() end
    if botColorPicker then botColorPicker:LoadConfig() end
    if botVisiblePicker then botVisiblePicker:LoadConfig() end
    if botHiddenPicker then botHiddenPicker:LoadConfig() end
    refreshESP()
    print("[COLORS] Loaded saved colors from config")
end)

colorManagementGroup:AddButton("Reset to Default Colors", function()
    PlayerVisibleColor = Color3.fromRGB(50, 255, 50)
    PlayerHiddenColor = Color3.fromRGB(255, 50, 50)
    BotColor = Color3.fromRGB(255, 255, 0)
    BotVisibleColor = Color3.fromRGB(100, 255, 100)
    BotHiddenColor = Color3.fromRGB(255, 200, 50)
    
    if playerVisiblePicker then playerVisiblePicker:SetColor(PlayerVisibleColor) end
    if playerHiddenPicker then playerHiddenPicker:SetColor(PlayerHiddenColor) end
    if botColorPicker then botColorPicker:SetColor(BotColor) end
    if botVisiblePicker then botVisiblePicker:SetColor(BotVisibleColor) end
    if botHiddenPicker then botHiddenPicker:SetColor(BotHiddenColor) end
    
    refreshESP()
    print("[COLORS] Reset to default colors")
end)

colorManagementGroup:AddButton("Save Current Colors", function()
    if playerVisiblePicker then playerVisiblePicker:SaveConfig() end
    if playerHiddenPicker then playerHiddenPicker:SaveConfig() end
    if botColorPicker then botColorPicker:SaveConfig() end
    if botVisiblePicker then botVisiblePicker:SaveConfig() end
    if botHiddenPicker then botHiddenPicker:SaveConfig() end
    print("[COLORS] All colors saved to config")
end)

ESPGroup:AddSlider("Max Distance", 20, 1000, MaxDistance, function(value)
    MaxDistance = value
end)

ESPGroup:AddSlider("Text Size", 8, 24, TextSize, function(value)
    TextSize = value
    for _, esp in pairs(ESPObjects) do
        if esp.nameLabel then esp.nameLabel.Size = value end
        if esp.distanceLabel then esp.distanceLabel.Size = value - 2 end
    end
end)

ESPGroup:AddButton("Refresh ESP", function()
    refreshESP()
end)
-- ==================== SMART AIMBOT SYSTEM ====================
local AimbotGroup = menu:CreateCollapsibleGroup(Tabs.MainTab, "Aimbot Settings", true, 300)

-- Core Aimbot Variables
local AimbotEnabled = false
local AimKey = nil -- Will be set by combo
local FOVCircle = true
local FOVSize = 100
local FOVCircleDrawing = nil

-- Smart Targeting Settings
local SmoothAiming = false
local SmoothnessFactor = 0.1
local AimLockMode = "Head" -- "Head" or "Body"
local PriorityToVisible = true -- NEW: Prioritize visible enemies
local VisibleTargetBonus = 200 -- Bonus score for visible targets
local DistanceWeight = 0.5 -- How much distance affects targeting (0-1)

-- Platform detection
local PlatformIsMobile = Services.UserInputService.TouchEnabled

-- Function to get all targetable entities
local function getAllTargets()
    local targets = {}
    
    -- Get player characters (excluding local player)
    for _, player in ipairs(Services.Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and isValidEntity(player.Character) then
            table.insert(targets, {
                model = player.Character,
                isPlayer = true,
                name = player.Name,
                playerObject = player
            })
        end
    end
    
    -- Get bots
    for _, model in ipairs(Services.Workspace:GetChildren()) do
        if model:IsA("Model") and model ~= LocalPlayer.Character then
            if isValidEntity(model) then
                -- Check if it's not a player character
                local isPlayerChar = false
                for _, player in ipairs(Services.Players:GetPlayers()) do
                    if player.Character == model then
                        isPlayerChar = true
                        break
                    end
                end
                
                if not isPlayerChar then
                    table.insert(targets, {
                        model = model,
                        isPlayer = false,
                        name = model.Name .. " [BOT]",
                        playerObject = nil
                    })
                end
            end
        end
    end
    
    return targets
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

-- Function to get aim position
local function getAimPosition(entity, mode)
    if not entity or not entity.model then return nil end
    
    local character = entity.model
    mode = mode or AimLockMode
    
    if mode == "Head" then
        local head = character:FindFirstChild("Head")
        if head then
            return head.Position
        end
    end
    
    -- Default to body (HumanoidRootPart or fallback)
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if hrp then
        return hrp.Position + Vector3.new(0, 1.5, 0)
    end
    
    -- Fallback: try to find any part
    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            return part.Position
        end
    end
    
    return nil
end

-- SMART: Find best target with priority to visible enemies
local function findTarget()
    local targets = getAllTargets()
    local bestTarget = nil
    local bestScore = -math.huge
    
    for _, target in ipairs(targets) do
        local aimPos = getAimPosition(target, AimLockMode)
        if not aimPos then continue end
        
        -- Check if inside FOV circle
        if not isInFOV(aimPos) then continue end
        
        local distance = (aimPos - Camera.CFrame.Position).Magnitude
        
        -- Check health
        if getEntityHealth(target.model) <= 0 then continue end
        
        -- Calculate visibility
        local isVisible = isEntityVisible(target.model)
        
        -- SMART SCORING SYSTEM:
        local score = 0
        
        -- 1. Distance factor (closer = higher score)
        local distanceScore = (MaxDistance - distance) * DistanceWeight
        score = score + distanceScore
        
        -- 2. VISIBILITY BONUS (NEW FEATURE)
        if PriorityToVisible and isVisible then
            score = score + VisibleTargetBonus
            -- Additional bonus for center of screen when visible
            local screenPos, onScreen = Camera:WorldToViewportPoint(aimPos)
            if onScreen then
                local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                local screenPos2D = Vector2.new(screenPos.X, screenPos.Y)
                local distanceToCenter = (screenCenter - screenPos2D).Magnitude
                local centerBonus = math.max(0, 100 - (distanceToCenter / FOVSize * 100))
                score = score + centerBonus
            end
        elseif isVisible then
            -- Smaller bonus if visibility priority is off
            score = score + 50
        end
        
        -- 3. Player vs Bot preference (slight preference for players)
        if target.isPlayer then
            score = score + 20
        end
        
        -- Select best target based on score
        if score > bestScore then
            bestScore = score
            bestTarget = {
                entity = target,
                aimPosition = aimPos,
                distance = distance,
                isVisible = isVisible,
                score = score
            }
        end
    end
    
    -- Show targeting info
    if bestTarget then
        local visibilityStatus = bestTarget.isVisible and "🟢 VISIBLE" or "🔴 HIDDEN"
        local targetType = bestTarget.entity.isPlayer and "PLAYER" or "BOT"
        print(string.format("[AIMBOT] Locked: %s (%s) | %s | %.0f studs | Score: %.0f", 
            bestTarget.entity.name, targetType, visibilityStatus, bestTarget.distance, bestTarget.score))
    end
    
    return bestTarget
end

-- Smooth aiming function
local function smoothAimAtTarget(targetPos)
    local camera = Camera
    local cameraPosition = camera.CFrame.Position
    local currentLook = camera.CFrame.LookVector
    
    -- Calculate desired look direction
    local desiredLook = (targetPos - cameraPosition).Unit
    
    if SmoothAiming and SmoothnessFactor > 0 then
        -- Smooth interpolation between current and desired look direction
        local smoothedLook = currentLook:Lerp(desiredLook, SmoothnessFactor)
        camera.CFrame = CFrame.new(cameraPosition, cameraPosition + smoothedLook)
    else
        -- Instant snap
        camera.CFrame = CFrame.new(cameraPosition, cameraPosition + desiredLook)
    end
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
local CurrentTarget = nil
local lastTargetSwitch = tick()

-- Function to check if aiming key is pressed
local function isAimingKeyPressed()
    if PlatformIsMobile then
        return AimbotEnabled  -- Mobile: always on when enabled
    else
        return AimKey and Services.UserInputService:IsKeyDown(AimKey)
    end
end

-- Function to check keybind input (including mouse buttons)
local function checkKeybindInput(input)
    if not AimKey then return false end
    
    if input.UserInputType == Enum.UserInputType.Keyboard then
        return input.KeyCode == AimKey
    elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
        return AimKey == Enum.KeyCode.Button1
    elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
        return AimKey == Enum.KeyCode.Button2
    elseif input.UserInputType == Enum.UserInputType.MouseButton3 then
        return AimKey == Enum.KeyCode.Button3
    elseif input.UserInputType == Enum.UserInputType.MouseButton4 then
        return AimKey == Enum.KeyCode.ThumbButton1
    elseif input.UserInputType == Enum.UserInputType.MouseButton5 then
        return AimKey == Enum.KeyCode.ThumbButton2
    end
    
    return false
end

local function startAimbot()
    if aimbotConnection then
        aimbotConnection:Disconnect()
        aimbotConnection = nil
    end
    
    -- Clean up old drawings
    if FOVCircleDrawing then
        FOVCircleDrawing:Remove()
        FOVCircleDrawing = nil
    end
    
    -- Start aimbot
    aimbotConnection = Services.RunService.RenderStepped:Connect(function()
        if not AimbotEnabled then
            if FOVCircleDrawing then
                FOVCircleDrawing.Visible = false
            end
            CurrentTarget = nil
            return
        end
        
        updateFOVCircle()
        
        -- Check if aiming key is pressed
        local aimNow = isAimingKeyPressed()
        
        if aimNow then
            -- Find initial target if we don't have one
            if not CurrentTarget then
                CurrentTarget = findTarget()
                lastTargetSwitch = tick()
            else
                -- Check if we should re-evaluate targets (every 0.5 seconds or when current target becomes invalid)
                local currentTime = tick()
                local shouldReevaluate = false
                
                -- Check if current target is still valid
                if not CurrentTarget.entity or not CurrentTarget.entity.model or 
                   getEntityHealth(CurrentTarget.entity.model) <= 0 then
                    shouldReevaluate = true
                end
                
                -- Periodic re-evaluation for better target switching
                if currentTime - lastTargetSwitch > 0.5 then
                    shouldReevaluate = true
                end
                
                if shouldReevaluate then
                    local newTarget = findTarget()
                    if newTarget then
                        -- Switch to new target if it's significantly better
                        if not CurrentTarget or newTarget.score > CurrentTarget.score * 1.2 then
                            CurrentTarget = newTarget
                            lastTargetSwitch = currentTime
                        end
                    else
                        CurrentTarget = nil
                    end
                end
            end
            
            -- If we have a target, follow it
            if CurrentTarget and CurrentTarget.entity and CurrentTarget.entity.model then
                -- Check if target is still valid
                local aimPos = getAimPosition(CurrentTarget.entity, AimLockMode)
                
                if aimPos and isInFOV(aimPos) and getEntityHealth(CurrentTarget.entity.model) > 0 then
                    -- Target is valid - lock and follow
                    CurrentTarget.aimPosition = aimPos
                    CurrentTarget.isVisible = isEntityVisible(CurrentTarget.entity.model)
                    
                    -- Lock onto the position
                    if SmoothAiming then
                        smoothAimAtTarget(aimPos)
                    else
                        local camera = Camera
                        local cameraPosition = camera.CFrame.Position
                        local desiredLook = (aimPos - cameraPosition).Unit
                        camera.CFrame = CFrame.new(cameraPosition, cameraPosition + desiredLook)
                    end
                else
                    -- Target became invalid - find new one
                    CurrentTarget = findTarget()
                    lastTargetSwitch = tick()
                end
            else
                -- No target - find one
                CurrentTarget = findTarget()
                lastTargetSwitch = tick()
            end
        else
            -- Not aiming - clear target
            CurrentTarget = nil
        end
    end)
end

local function stopAimbot()
    if aimbotConnection then
        aimbotConnection:Disconnect()
        aimbotConnection = nil
    end
    
    if FOVCircleDrawing then
        FOVCircleDrawing:Remove()
        FOVCircleDrawing = nil
    end
    
    CurrentTarget = nil
end

-- Aimbot GUI Controls
local aimbotCombo = nil

-- Function to update the AimKey variable when combo keybind changes
local function updateAimKeyFromCombo()
    if aimbotCombo and aimbotCombo.GetKeybind then
        AimKey = aimbotCombo:GetKeybind()
        print("[AIMBOT] Keybind updated to:", tostring(AimKey))
    end
end

if not PlatformIsMobile then
    -- PC version with combo
    aimbotCombo = menu:CreateCombo(Tabs.MainTab, "Aimbot Control", 
        function(state)
            AimbotEnabled = state
            if state then
                -- Get initial keybind from combo
                updateAimKeyFromCombo()
                startAimbot()
            else
                stopAimbot()
            end
        end,
        function() 
            -- Action1 (RUN) callback - update keybind when combo changes
            updateAimKeyFromCombo()
        end,
        function()
            -- Action2 (RESET) callback
            stopAimbot()
            AimLockMode = "Head"
            FOVSize = 100
            SmoothAiming = false
            PriorityToVisible = true
            VisibleTargetBonus = 200
            DistanceWeight = 0.5
            SmoothnessFactor = 0.1
            
            -- Reset combo to default (LeftShift)
            if aimbotCombo then
                aimbotCombo:SetState(false, Enum.KeyCode.LeftShift)
                updateAimKeyFromCombo()
            end
        end,
        false,
        Enum.KeyCode.LeftShift
    )
    
    -- Now create a toggle inside the AimbotGroup for better organization
    AimbotGroup:AddToggle("Enable Aimbot", false, function(state)
        AimbotEnabled = state
        if state then
            -- Make sure we have the current keybind
            updateAimKeyFromCombo()
            startAimbot()
        else
            stopAimbot()
        end
    end, false)
    
    -- Create a label to show current keybind
    AimbotGroup:AddLabel("Current Keybind: LeftShift")
    
    -- Function to update the keybind display
    local function updateKeybindDisplay()
        if aimbotCombo and aimbotCombo.GetKeybind then
            local key = aimbotCombo:GetKeybind()
            local keyName = tostring(key):gsub("Enum.KeyCode.", "")
            
            -- Convert mouse button names for display
            local displayNames = {
                ["Button1"] = "LMB",
                ["Button2"] = "RMB",
                ["Button3"] = "MMB",
                ["ThumbButton1"] = "Mouse4",
                ["ThumbButton2"] = "Mouse5"
            }
            
            local displayName = displayNames[keyName] or keyName
            print("[AIMBOT] Displaying keybind as:", displayName)
        end
    end
    
    -- Update display when keybind changes (you'll need to modify your combo to have a callback)
    -- For now, we'll poll it every second
    local keybindMonitor = Services.RunService.Heartbeat:Connect(function()
        updateKeybindDisplay()
    end)
    
else
    -- Mobile version without keybind
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
AimbotGroup:AddDropdown("Target Mode", {"Head", "Body"}, "Head", function(selected)
    AimLockMode = selected
end)

-- Smart Targeting Options
AimbotGroup:AddToggle("Priority to Visible", true, function(state)
    PriorityToVisible = state
end)

AimbotGroup:AddSlider("Visible Bonus", 0, 500, 200, function(value)
    VisibleTargetBonus = value
end)

AimbotGroup:AddSlider("Distance Weight", 0, 1, 0.5, function(value)
    DistanceWeight = value
end)

-- Smooth Aiming
AimbotGroup:AddToggle("Smooth Aiming", false, function(state)
    SmoothAiming = state
end)

AimbotGroup:AddSlider("Smoothness", 0.01, 0.3, 0.1, function(value)
    SmoothnessFactor = value
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
    FOVSize = 100
    SmoothAiming = false
    SmoothnessFactor = 0.1
    PriorityToVisible = true
    VisibleTargetBonus = 200
    DistanceWeight = 0.5
    
    -- Also reset the combo if it exists
    if aimbotCombo then
        aimbotCombo:SetState(false, Enum.KeyCode.LeftShift)
        updateAimKeyFromCombo()
    end
end)

-- Initialization Message
print("\n" .. string.rep("=", 90))
print("🎯 SFY Paintball Hub v2.0 - ADVANCED ESP & AIMBOT")
print(string.rep("=", 90))
print("🌟 NEW ADVANCED FEATURES:")
print("• ADVANCED COLOR PICKER: Color wheel, transparency, hex/RGB input")
print("• CONFIG SAVING: Colors saved per game, auto-loads on restart")
print("• LOCAL PLAYER EXCLUDED: No self-targeting bugs")
print("• VISIBILITY PRIORITY: Aimbot switches to visible enemies automatically")
print(string.rep("-", 90))
print("🎨 COLOR SYSTEM:")
print("• PLAYERS: Red (Hidden) → Green (Visible) - SAVED")
print("• BOTS: Orange (Hidden) → Light Green (Visible) - SAVED")
print("• COLOR WHEEL: Visual hue/saturation selection")
print("• TRANSPARENCY: Adjustable transparency for highlights")
print("• AUTO-SAVE: Apply button saves colors to config")
print(string.rep("-", 90))
print("🎯 SMART AIMBOT:")
print("• PRIORITY SYSTEM: Visible enemies get +200 bonus score")
print("• AUTOMATIC SWITCHING: Switches to visible enemies in FOV")
print("• SCORING: Distance + Visibility + Center-of-screen bonus")
print("• DEBUG INFO: Console shows target selection")
print(string.rep("-", 90))
print("💾 CONFIG SYSTEM:")
print("• Saves to: SFY_ColorConfig/[GameId]/[GameName]/[ConfigKey].json")
print("• Auto-loads saved colors when script runs")
print("• Game-specific: Different colors for different games")
print("• Color management buttons: Load/Save/Reset")
print(string.rep("-", 90))
print("🎮 CONTROLS:")
if PlatformIsMobile then
    print("• Toggle ESP ON/OFF to see all entities")
    print("• Toggle Aimbot ON/OFF to lock onto targets")
    print("• Use Color Picker: Edit → Color Wheel → Apply")
    print("• Color management in Visual tab")
else
    print("• Hold LEFT SHIFT to activate smart aimbot")
    print("• Aimbot auto-switches to visible enemies")
    print("• Color Picker: Click 'Edit' for color wheel")
    print("• Click 'Apply' to save colors to config")
end
print(string.rep("=", 90))
print("📁 Config files saved in: workspace/SFY_ColorConfig/")
print("💡 Tip: Use 'Load All Saved Colors' to restore previous settings")
print(string.rep("=", 90))
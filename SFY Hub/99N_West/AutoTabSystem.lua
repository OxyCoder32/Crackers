--[[
dawdwa
ca
wdcA

D

d

C
C


D
W
D 

WAC


2

2
eca2
d2c2
a 
d

d2a da2.
ad
.a
d.
.a2
.2c
a.d
ca2.
d.
a2.
d.a2c.d
.a2
.d
.ac
.d
2a.
dc.a.d
ca
d
a

da
d
a
d
ca2
c
a2
cda2

cda


dc2
c
da2d
2a
d


ac
d2a

dc

a2c
dac2

2
]]

local AutoTabSystem = {}
 
function AutoTabSystem:Init(menu, Tabs)
    -- Store references
    self.menu = menu
    self.Tabs = Tabs or {}
 
    -- Create tabs if not provided
    if not self.Tabs.AutoTab then
        self.Tabs.AutoTab = menu:CreateTab("Auto")
    end
 
    -- ADD MISSING SERVICES AND REFERENCES
    local Services = {
    	Players = game:GetService("Players"),
    	Workspace = game:GetService("Workspace"),
    	RunService = game:GetService("RunService"),
    	UserInputService = game:GetService("UserInputService"),
    	Lighting = game:GetService("Lighting"),
    	VirtualInputManager = game:GetService("VirtualInputManager"),
    	ReplicatedStorage = game:GetService("ReplicatedStorage")
}
    -- Player references
	local Player, LocalPlayer = Services.Players.LocalPlayer, Services.Players.LocalPlayer
	local Camera = Services.Workspace.CurrentCamera	
	--// ⚙️ Base Variables (minimized)
	local Character = Player.Character or Player.CharacterAdded:Wait()
	local Humanoid = Character:WaitForChild("Humanoid")
 
    local Player = Services.Players.LocalPlayer
    local Camera = Services.Workspace.CurrentCamera
 
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
 
-- new added



--Auto plant start

-- Enhanced Auto Plant System with Planting Patterns
local AutoPlant = {
    Enabled = false,
    PlantRange = 50,
    PlantCooldown = 0.2,
    LastPlantTime = 0,
    Connection = nil,
    Status = "Ready",
    TreeSeeds = {},
    Character = nil,
    HumanoidRootPart = nil,
    CustomLocation = nil,
    LocationMarker = nil,
    PlantingPattern = "Single Point",
    PlantCount = 500,
    PlantSpacing = 3,
    CampfireCenter = Vector3.new(1, 13, 1),
    OutsideRange = Vector3.new(-56, 7, 28)
}

-- Get the plant remote event
local PlantTreeC2S = Services.ReplicatedStorage:WaitForChild("Events"):WaitForChild("Game"):WaitForChild("PlantTreeC2S")

-- Get the drag remote event (same as Bring system)
local DragRemote
local remoteEvents = {"DragItemC2S"}
for _, eventName in pairs(remoteEvents) do
    local eventsFolder = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
    if eventsFolder then
        local playerFolder = eventsFolder:FindFirstChild("Player")
        if playerFolder then
            local targetEvent = playerFolder:FindFirstChild(eventName)
            if targetEvent then
                DragRemote = targetEvent
                break
            end
        end
    end
end

-- Function to use dragging remote (same as Bring system)
local function useDraggingRemote(itemObject, state)
    if not DragRemote then
        return false
    end
    
    local success = pcall(function()
        if state then
            DragRemote:FireServer(itemObject)
        else
            DragRemote:FireServer()
        end
        return true
    end)
    
    return success
end

-- Function to find all items in workspace (same as Bring system)
local function findAllItems()
    local foundItems = {}
    
    local function scanForItems(parent)
        for _, item in pairs(parent:GetChildren()) do
            if item:IsA("Model") then
                local itemName = item.Name
                -- For tree seeds, we look for "Core" part
                if itemName == "Tree seed" then
                    local targetPart = item:FindFirstChild("Core")
                    if targetPart and targetPart:IsA("BasePart") then
                        table.insert(foundItems, {
                            Model = item,
                            Part = targetPart,
                            Name = itemName
                        })
                    end
                end
            end
            scanForItems(item)
        end
    end
    
    scanForItems(game:GetService("Workspace"))
    return foundItems
end

-- Function to get teleport position (same as Bring system)
local function getTeleportPosition()
    local character = Player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return nil end
    
    local hrp = character.HumanoidRootPart
    return hrp.CFrame + Vector3.new(0, 5, 0)
end

-- Function to create location marker for auto plant
local function createPlantLocationMarker(position)
    -- Remove existing marker
    if AutoPlant.LocationMarker then
        AutoPlant.LocationMarker:Destroy()
        AutoPlant.LocationMarker = nil
    end
    
    -- Create new marker
    local marker = Instance.new("Part")
    marker.Name = "AutoPlant_LocationMarker"
    marker.Size = Vector3.new(6, 0.2, 6)
    marker.Position = position + Vector3.new(0, -3, 0)
    marker.Anchored = true
    marker.CanCollide = false
    marker.Material = Enum.Material.Neon
    
    -- Set color based on planting pattern
    local patternColors = {
        ["Single Point"] = BrickColor.new("Bright green"),
        ["Circle"] = BrickColor.new("Bright blue"),
        ["Grid"] = BrickColor.new("Bright yellow")
    }
    
    marker.BrickColor = patternColors[AutoPlant.PlantingPattern] or BrickColor.new("Bright green")
    marker.Transparency = 0.3
    
    -- Add surface GUI with label
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PlantLocationLabel"
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.Adornee = marker
    billboard.AlwaysOnTop = false
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "🌱 " .. AutoPlant.PlantingPattern .. " Planting"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextStrokeTransparency = 0
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.Parent = billboard
    
    billboard.Parent = marker
    marker.Parent = game:GetService("Workspace")
    
    AutoPlant.LocationMarker = marker
    AutoPlant.CustomLocation = position
    
    print("📍 " .. AutoPlant.PlantingPattern .. " planting location set at: " .. tostring(position))
end

-- Function to remove location marker
local function removePlantLocationMarker()
    if AutoPlant.LocationMarker then
        AutoPlant.LocationMarker:Destroy()
        AutoPlant.LocationMarker = nil
    end
    AutoPlant.CustomLocation = nil
    print("🗑️ Auto Plant location removed")
end

-- Function to set current position as plant location
local function setCurrentPlantLocation()
    local character = Player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        print("❌ No character found!")
        return false
    end
    
    local position = character.HumanoidRootPart.Position
    createPlantLocationMarker(position)
    return true
end

-- Function to teleport to plant location
local function teleportToPlantLocation()
    if not AutoPlant.CustomLocation then
        print("❌ No Auto Plant location set!")
        return false
    end
    
    local character = Player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        print("❌ No character found!")
        return false
    end
    
    character.HumanoidRootPart.CFrame = CFrame.new(AutoPlant.CustomLocation + Vector3.new(0, 3, 0))
    print("🚀 Teleported to Auto Plant location")
    return true
end

-- Function to calculate circle positions around campfire
local function calculateCirclePositions()
    local positions = {}
    local center = AutoPlant.CampfireCenter
    local radius = (AutoPlant.OutsideRange - center).Magnitude
    
    for i = 1, AutoPlant.PlantCount do
        local angle = (i / AutoPlant.PlantCount) * math.pi * 2
        local x = center.X + math.cos(angle) * radius
        local z = center.Z + math.sin(angle) * radius
        local position = Vector3.new(x, center.Y, z)
        table.insert(positions, position)
    end
    
    return positions
end

-- Function to calculate grid positions
local function calculateGridPositions()
    local positions = {}
    local center = AutoPlant.CustomLocation or (AutoPlant.HumanoidRootPart and AutoPlant.HumanoidRootPart.Position)
    if not center then return positions end
    
    local sideLength = math.ceil(math.sqrt(AutoPlant.PlantCount))
    
    for x = 0, sideLength - 1 do
        for z = 0, sideLength - 1 do
            if #positions < AutoPlant.PlantCount then
                local offsetX = (x - (sideLength - 1) / 2) * AutoPlant.PlantSpacing
                local offsetZ = (z - (sideLength - 1) / 2) * AutoPlant.PlantSpacing
                local position = Vector3.new(
                    center.X + offsetX,
                    center.Y,
                    center.Z + offsetZ
                )
                table.insert(positions, position)
            end
        end
    end
    
    return positions
end

-- Function to find tree seeds in workspace
local function findTreeSeeds()
    AutoPlant.TreeSeeds = {}
    
    local function scanForSeeds(parent)
        for _, item in pairs(parent:GetChildren()) do
            if item:IsA("Model") and item.Name == "Tree seed" then
                local corePart = item:FindFirstChild("Core")
                if corePart and corePart:IsA("BasePart") then
                    table.insert(AutoPlant.TreeSeeds, {
                        Model = item,
                        Part = corePart,
                        Name = item.Name
                    })
                end
            end
            scanForSeeds(item)
        end
    end
    
    scanForSeeds(game:GetService("Workspace"))
    print("🌱 Found " .. #AutoPlant.TreeSeeds .. " tree seeds")
    return AutoPlant.TreeSeeds
end

-- Function to instantly plant all tree seeds with patterns
local function instantPlantAllSeeds()
    local seeds = findTreeSeeds()
    local plantedCount = 0
    
    if #seeds == 0 then
        AutoPlant.Status = "❌ No tree seeds found to plant"
        return 0
    end
    
    print("🌱 INSTANT PLANT: Planting " .. #seeds .. " tree seeds in " .. AutoPlant.PlantingPattern .. " pattern...")
    
    -- Calculate planting positions based on pattern
    local plantingPositions = {}
    
    if AutoPlant.PlantingPattern == "Single Point" then
        local plantPos = AutoPlant.CustomLocation or (AutoPlant.HumanoidRootPart and AutoPlant.HumanoidRootPart.Position)
        if plantPos then
            for i = 1, math.min(#seeds, AutoPlant.PlantCount) do
                table.insert(plantingPositions, plantPos)
            end
        end
    elseif AutoPlant.PlantingPattern == "Circle" then
        plantingPositions = calculateCirclePositions()
    elseif AutoPlant.PlantingPattern == "Grid" then
        plantingPositions = calculateGridPositions()
    end
    
    if #plantingPositions == 0 then
        AutoPlant.Status = "❌ No valid planting positions calculated"
        return 0
    end
    
    -- Plant seeds at calculated positions
    for i, seed in pairs(seeds) do
        if i > AutoPlant.PlantCount then break end
        
        if seed.Part and seed.Part.Parent then
            local plantPos = plantingPositions[i] or plantingPositions[1]
            
            if plantPos then
                local args = {
                    Vector3.new(plantPos.X, plantPos.Y, plantPos.Z),
                    seed.Model
                }
                
                -- Fire the plant remote event
                local success = pcall(function()
                    PlantTreeC2S:FireServer(unpack(args))
                    return true
                end)
                
                if success then
                    plantedCount = plantedCount + 1
                    AutoPlant.Status = "🌱 Planting " .. plantedCount .. "/" .. math.min(#seeds, AutoPlant.PlantCount) .. " seeds"
                end
            end
        end
        
        -- Small delay to prevent server overload
        task.wait(0.05)
    end
    
    -- Update the seeds list after planting
    findTreeSeeds()
    
    AutoPlant.Status = "✅ Instantly planted " .. plantedCount .. " seeds in " .. AutoPlant.PlantingPattern .. " pattern"
    print("✅ INSTANT PLANT: Successfully planted " .. plantedCount .. " tree seeds")
    
    return plantedCount
end

-- Function to plant tree seeds in range (for auto mode)
local function plantSeedsInRange()
    if not AutoPlant.Enabled then return end
    
    local currentTime = tick()
    if currentTime - AutoPlant.LastPlantTime < AutoPlant.PlantCooldown then
        return
    end
    
    local seeds = AutoPlant.TreeSeeds
    local plantedAny = false
    
    for _, seed in pairs(seeds) do
        if seed.Part and seed.Part.Parent then
            local targetPosition = AutoPlant.CustomLocation or 
                                 (AutoPlant.HumanoidRootPart and AutoPlant.HumanoidRootPart.Position)
            
            if not targetPosition then return end
            
            local distance = (targetPosition - seed.Part.Position).Magnitude
            if distance <= AutoPlant.PlantRange then
                local plantPos = AutoPlant.CustomLocation or AutoPlant.HumanoidRootPart.Position
                
                local args = {
                    Vector3.new(plantPos.X, plantPos.Y, plantPos.Z),
                    seed.Model
                }
                
                PlantTreeC2S:FireServer(unpack(args))
                plantedAny = true
                
                local locationType = AutoPlant.CustomLocation and "custom location" or "player"
                AutoPlant.Status = "🌱 Planting at " .. locationType .. " (" .. math.floor(distance) .. " studs)"
            end
        end
    end
    
    if plantedAny then
        AutoPlant.LastPlantTime = currentTime
    else
        local locationType = AutoPlant.CustomLocation and "custom location" or "player"
        AutoPlant.Status = "🔍 Active - No seeds near " .. locationType
    end
end

-- Character setup
local function setupCharacter()
    AutoPlant.Character = Player.Character or Player.CharacterAdded:Wait()
    AutoPlant.HumanoidRootPart = AutoPlant.Character:WaitForChild("HumanoidRootPart")
    
    if AutoPlant.Enabled then
        findTreeSeeds()
    end
end

-- Function to start auto plant
local function startAutoPlant()
    if AutoPlant.Enabled then return end
    
    if not AutoPlant.Character then
        setupCharacter()
    end
    
    if not AutoPlant.CustomLocation and not AutoPlant.HumanoidRootPart then
        AutoPlant.Status = "❌ No location available"
        return
    end
    
    findTreeSeeds()
    
    if #AutoPlant.TreeSeeds == 0 then
        AutoPlant.Status = "❌ No tree seeds found"
        return
    end
    
    AutoPlant.Enabled = true
    local locationType = AutoPlant.CustomLocation and "custom location" or "player position"
    AutoPlant.Status = "🟢 Auto Plant Started at " .. locationType
    
    AutoPlant.Connection = Services.RunService.Heartbeat:Connect(function()
        if not AutoPlant.Enabled then
            if AutoPlant.Connection then
                AutoPlant.Connection:Disconnect()
                AutoPlant.Connection = nil
            end
            return
        end
        
        pcall(plantSeedsInRange)
        
        if tick() % 3 < 0.1 then
            findTreeSeeds()
        end
    end)
end

-- Function to stop auto plant
local function stopAutoPlant()
    AutoPlant.Enabled = false
    
    if AutoPlant.Connection then
        AutoPlant.Connection:Disconnect()
        AutoPlant.Connection = nil
    end
    
    AutoPlant.Status = "🛑 Auto Plant Stopped"
end

-- Function to toggle auto plant
local function toggleAutoPlant(state)
    if state then
        startAutoPlant()
    else
        stopAutoPlant()
    end
end

-- Function to manually bring tree seeds to location (separate button)
local function bringTreeSeedsToLocation()
    if not Player.Character then
        print("❌ No character found!")
        return 0
    end
    
    local allSeeds = findAllItems()
    
    local foundSeeds = {}
    for _, itemData in ipairs(allSeeds) do
        if itemData.Name == "Tree seed" then
            table.insert(foundSeeds, itemData)
        end
    end

    local seedsToMove = {}
    for i = 1, math.min(#foundSeeds, 50) do
        table.insert(seedsToMove, foundSeeds[i])
    end

    local totalToMove = #seedsToMove
    print("🌱 Found " .. #foundSeeds .. " tree seeds, moving " .. totalToMove)

    local targetPosition
    if AutoPlant.CustomLocation then
        targetPosition = AutoPlant.CustomLocation + Vector3.new(0, 5, 0)
        print("🚀 Bringing seeds to custom location...")
    else
        local teleportCF = getTeleportPosition()
        targetPosition = teleportCF and teleportCF.Position or Player.Character.HumanoidRootPart.Position
        print("🚀 Bringing seeds to player...")
    end
    
    if not targetPosition then
        print("❌ Cannot get target position!")
        return 0
    end

    local moved = 0

    if totalToMove > 0 then
        local locationType = AutoPlant.CustomLocation and "custom location" or "player"
        print("🚀 Bringing " .. totalToMove .. " tree seeds to " .. locationType)
    end

    for i, seedData in ipairs(seedsToMove) do
        local targetPos = targetPosition + Vector3.new(
            math.cos(i * 0.5) * 3,
            0,
            math.sin(i * 0.5) * 3
        )
        
        local dragEnabled = useDraggingRemote(seedData.Model, true)
        
        if seedData.Part and seedData.Part.Parent then
            seedData.Part.CFrame = CFrame.new(targetPos)
        end
        
        if dragEnabled then
            useDraggingRemote(seedData.Model, false)
        end
        
        moved = moved + 1
        task.wait(0.05)
    end
    
    if moved > 0 then
        local locationType = AutoPlant.CustomLocation and "custom location" or "player"
        print("✅ Successfully brought " .. moved .. " tree seeds to " .. locationType)
        findTreeSeeds()
    else
        print("❌ No tree seeds found to bring")
    end
    
    return moved
end



-- Create GUI for Auto Plant using the library

local autoPlantGroup = self.menu:CreateCollapsibleGroup(self.Tabs.AutoTab, "🌱 AUTO PLANT SYSTEM", false, 350)
self.menu:MarkAsNew(autoPlantGroup:GetInstance(), "NEW")


-- Location Combo (Run button now instantly plants all seeds with patterns)
local plantLocationCombo = autoPlantGroup:AddCombo(
    "📍 Set Plant Location",
    function(toggleState)
        if toggleState then
            print("📍 Setting Auto Plant location...")
            local success = setCurrentPlantLocation()
            if not success then
                plantLocationCombo:SetToggle(false)
                print("❌ Failed to set Auto Plant location")
            else
                print("✅ Auto Plant location set successfully")
            end
        else
            print("🔄 Removing Auto Plant location...")
            removePlantLocationMarker()
            print("🗑️ Auto Plant location removed (toggle turned off)")
        end
    end,
    function()
        -- CHANGED: Run button now instantly plants all seeds with patterns
        local plantedCount = instantPlantAllSeeds()
        AutoPlant.Status = "⚡ Planted " .. plantedCount .. " seeds in " .. AutoPlant.PlantingPattern .. " pattern"
    end,
    function()
        print("🔄 Resetting Auto Plant location...")
        removePlantLocationMarker()
        plantLocationCombo:SetToggle(false)
        print("🗑️ Auto Plant location reset and toggle turned off")
    end,
    false,
    Enum.KeyCode.F1
)

-- Main Toggle
autoPlantGroup:AddToggle("🌱 Turn on Auto Plant", false, function(state)
    toggleAutoPlant(state)
end)
-- Planting Pattern Dropdown
autoPlantGroup:AddDropdown("📐 Planting Pattern", {"Single Point", "Circle", "Grid"}, AutoPlant.PlantingPattern, function(selected)
    AutoPlant.PlantingPattern = selected
    -- Update marker color if location exists
    if AutoPlant.CustomLocation then
        createPlantLocationMarker(AutoPlant.CustomLocation)
    end
    print("📐 Planting pattern set to: " .. selected)
end)

-- Plant Count Slider
autoPlantGroup:AddSlider("🔢 Plants to Place", 1, 1000, AutoPlant.PlantCount, function(value)
    AutoPlant.PlantCount = value
end)

-- Plant Spacing Slider (for Grid pattern)
autoPlantGroup:AddSlider("📏 Plant Spacing", 1, 20, AutoPlant.PlantSpacing, function(value)
    AutoPlant.PlantSpacing = value
end)


-- Bring Seeds Button (separate button for bringing seeds)
autoPlantGroup:AddButton("📥 Bring Tree Seeds to Location", function()
    local count = bringTreeSeedsToLocation()
    local locationType = AutoPlant.CustomLocation and "custom location" or "player"
    AutoPlant.Status = "📥 Brought " .. count .. " seeds to " .. locationType
end)

-- Refresh Seeds Button
autoPlantGroup:AddButton("🔄 Refresh Seeds Scan", function()
    local count = #findTreeSeeds()
    AutoPlant.Status = "🔍 Found " .. count .. " tree seeds"
end)

-- Plant Range Slider
autoPlantGroup:AddSlider("🔗 Plant Range", 10, 100, AutoPlant.PlantRange, function(value)
    AutoPlant.PlantRange = value
end)

-- Plant Cooldown Slider
autoPlantGroup:AddSlider("⚡ Plant Speed", 0.5, 3, AutoPlant.PlantCooldown, function(value)
    AutoPlant.PlantCooldown = value
end)

-- Teleport to Location Button
autoPlantGroup:AddButton("🚀 Teleport to Plant Location", function()
    if teleportToPlantLocation() then
        AutoPlant.Status = "🚀 Teleported to plant location"
    end
end)

-- Pattern Info Display
local patternInfoLabel = autoPlantGroup:AddLabel("Pattern: " .. AutoPlant.PlantingPattern)

-- Location Status Display
local locationStatusLabel = autoPlantGroup:AddLabel("Location: Player Position")

-- Seeds Count Display
local seedsCountLabel = autoPlantGroup:AddLabel("Tree Seeds: " .. #AutoPlant.TreeSeeds)

-- Status Display
local plantStatusLabel = autoPlantGroup:AddLabel("Status: " .. AutoPlant.Status)


-- Hook into AutoPlant table to auto-update UI
local autoPlantMetatable = {
    __newindex = function(self, key, value)
        if key == "Status" or key == "TreeSeeds" or key == "CustomLocation" or key == "PlantingPattern" then
            rawset(self, key, value)
        else
            rawset(self, key, value)
        end
    end
}

setmetatable(AutoPlant, autoPlantMetatable)

-- Setup character when player joins
Player.CharacterAdded:Connect(function(character)
    setupCharacter()
end)

-- Initial setup
task.spawn(function()
    task.wait(2)
    setupCharacter()
    findTreeSeeds()
    
    if AutoPlant.CustomLocation then
        plantLocationCombo:SetToggle(true)
    end
end)

-- Auto-stop when player dies
task.spawn(function()
    while true do
        task.wait(3)
        if AutoPlant.Enabled then
            local character = Player.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") or 
               (character:FindFirstChild("Humanoid") and character.Humanoid.Health <= 0) then
                stopAutoPlant()
            end
        end
    end
end)

print("✅ Enhanced Auto Plant System with Planting Patterns Loaded!")
--Auto plant end

-- Auto Eat System - OPTIMIZED VERSION with Cooking Feature
local AutoEat = {
    Enabled = false,
    EatThreshold = 200,     -- When to start eating
    FullThreshold = 290,    -- When to stop eating (full)
    MaxHunger = 300,        -- Default value, will be updated from game
    Connection = nil,
    Status = "Ready",
    Character = nil,
    HumanoidRootPart = nil,
    IsEatingLoop = false,   -- Whether we're currently in an eating loop
    FoodScanRange = 500,    -- Increased for better coverage
    
    -- Campfire position for cooking
    CampfirePosition = nil,
    
    -- All available food items
    AllFoodItems = {
        "Steak",
        "Meat", 
        "Carrot",
        "Soup",
        "Pumpkin",
        "Watermelon",
        "Turkey",
        "TomatoSoup"
    },
    
    -- Currently selected food items (default: all selected)
    SelectedFoodItems = {},
    
    -- Food part names
    FoodParts = {
        ["Steak"] = "RootPart",
        ["Meat"] = "RootPart",
        ["Carrot"] = "RootPart",
        ["Soup"] = "Handle",
        ["Pumpkin"] = "RootPart",
        ["Watermelon"] = "RootPart",
        ["Turkey"] = "ç”Ÿ",
        ["TomatoSoup"] = "RootPart"
    },
    
    -- Foods that need cooking before eating
    FoodsNeedCooking = {
        ["Steak"] = true,
        ["Meat"] = true
    }
}

-- Initialize SelectedFoodItems with all foods selected
for _, food in ipairs(AutoEat.AllFoodItems) do
    AutoEat.SelectedFoodItems[food] = true
end

-- Get the Eat remote event
local EatRemote = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("EatC2S")

-- Function to find campfire position
local function findCampfirePosition()
    local map = game:GetService("Workspace"):FindFirstChild("Map")
    if map then
        local campfire = map:FindFirstChild("Campfire")
        if campfire then
            local rootPart = campfire:FindFirstChild("RootPart")
            if rootPart then
                AutoEat.CampfirePosition = rootPart.Position + Vector3.new(0, 3, 0)
                print("🔥 Found campfire at: " .. tostring(AutoEat.CampfirePosition))
                return true
            end
        end
    end
    print("⚠️ Campfire not found, cooking feature disabled")
    return false
end

-- Get hunger values from player
local function getHungerValue()
    local player = game:GetService("Players").LocalPlayer
    if player and player:FindFirstChild("Values") then
        local values = player.Values
        if values:FindFirstChild("hunger") and values:FindFirstChild("maxHunger") then
            local hunger = values.hunger.Value
            local maxHunger = values.maxHunger.Value
            AutoEat.MaxHunger = maxHunger
            return hunger, maxHunger
        end
    end
    return 0, 300
end

-- Check if should start eating
local function shouldStartEating()
    local currentHunger = getHungerValue()
    return currentHunger < AutoEat.EatThreshold
end

-- Check if should stop eating
local function shouldStopEating()
    local currentHunger = getHungerValue()
    return currentHunger >= AutoEat.FullThreshold
end

-- OPTIMIZED: Single food scan when needed
local function findAnyFoodInMap()
    local foundFoods = {}
    local startTime = tick()
    
    -- Only scan if we're hungry
    if not shouldStartEating() then
        return foundFoods
    end
    
    -- Scan entire workspace for selected foods (ONE TIME SCAN)
    for _, foodName in pairs(AutoEat.AllFoodItems) do
        if AutoEat.SelectedFoodItems[foodName] then
            -- Find all instances of this food in workspace
            local foodInstances = game:GetService("Workspace"):GetDescendants()
            for _, item in ipairs(foodInstances) do
                if item:IsA("Model") and item.Name == foodName then
                    local partName = AutoEat.FoodParts[foodName]
                    local part = item:FindFirstChild(partName) or item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
                    
                    if part and part:IsA("BasePart") then
                        table.insert(foundFoods, {
                            Model = item,
                            Part = part,
                            Name = item.Name,
                            NeedsCooking = AutoEat.FoodsNeedCooking[item.Name] or false,
                            Distance = AutoEat.HumanoidRootPart and (AutoEat.HumanoidRootPart.Position - part.Position).Magnitude or math.huge
                        })
                    end
                end
            end
        end
    end
    
    -- Sort by distance if we have a character
    if AutoEat.HumanoidRootPart then
        table.sort(foundFoods, function(a, b)
            -- Prioritize foods that don't need cooking
            if a.NeedsCooking and not b.NeedsCooking then
                return false
            elseif not a.NeedsCooking and b.NeedsCooking then
                return true
            end
            return a.Distance < b.Distance
        end)
    end
    
    local scanTime = tick() - startTime
    print("🔍 Food scan completed in " .. string.format("%.3f", scanTime) .. "s, found " .. #foundFoods .. " items")
    
    return foundFoods
end

-- Function to cook food at campfire (for Steak and Meat)
local function cookFoodAtCampfire(foodItem)
    if not AutoEat.CampfirePosition then
        if not findCampfirePosition() then
            print("⚠️ Cannot cook " .. foodItem.Name .. " - campfire not found")
            return false
        end
    end
    
    AutoEat.Status = "🔥 Cooking " .. foodItem.Name
    
    -- Use drag system if available
    if DragRemote then
        local success = pcall(function()
            -- Drag the food to campfire
            DragRemote:FireServer(foodItem.Model)
            
            -- Teleport food to campfire
            if foodItem.Part and foodItem.Part.Parent then
                foodItem.Part.CFrame = CFrame.new(AutoEat.CampfirePosition)
            end
            
            -- Wait a moment for cooking animation/effect
            task.wait(1.5)
            
            -- Undrag
            DragRemote:FireServer()
            
            return true
        end)
        
        if success then
            print("✅ Cooked " .. foodItem.Name .. " at campfire")
            return true
        end
    else
        -- Direct teleport to campfire
        if foodItem.Part and foodItem.Part.Parent then
            foodItem.Part.CFrame = CFrame.new(AutoEat.CampfirePosition)
            task.wait(1.5) -- Wait for cooking
            print("✅ Cooked " .. foodItem.Name .. " at campfire (no drag)")
            return true
        end
    end
    
    print("❌ Failed to cook " .. foodItem.Name)
    return false
end

-- Function to bring food to player (after cooking if needed)
local function bringFoodToPlayer(foodItem)
    if not AutoEat.Character or not AutoEat.HumanoidRootPart or not foodItem then
        return false
    end
    
    local hrp = AutoEat.HumanoidRootPart
    local targetPosition = hrp.Position + Vector3.new(0, 3, 0)
    
    -- Use drag system if available
    if DragRemote then
        local success = pcall(function()
            DragRemote:FireServer(foodItem.Model)
            if foodItem.Part and foodItem.Part.Parent then
                foodItem.Part.CFrame = CFrame.new(targetPosition)
            end
            DragRemote:FireServer()
            return true
        end)
        return success
    else
        -- Direct teleport
        if foodItem.Part and foodItem.Part.Parent then
            foodItem.Part.CFrame = CFrame.new(targetPosition)
            return true
        end
    end
    
    return false
end

-- Function to eat a food item
local function eatSingleFood(foodItem)
    if not foodItem or not foodItem.Model then
        return false
    end
    
    local success, err = pcall(function()
        EatRemote:FireServer(foodItem.Model)
        return true
    end)
    
    if success then
        task.wait(0.3) -- Short delay for eating
        return true
    else
        warn("❌ Failed to eat " .. foodItem.Name .. ": " .. tostring(err))
        return false
    end
end

-- Complete food processing (cook if needed, then bring to player)
local function processFoodItem(foodItem)
    -- Step 1: Cook if needed
    if foodItem.NeedsCooking and AutoEat.CampfirePosition then
        if not cookFoodAtCampfire(foodItem) then
            AutoEat.Status = "❌ Failed to cook " .. foodItem.Name
            return false
        end
    elseif foodItem.NeedsCooking and not AutoEat.CampfirePosition then
        AutoEat.Status = "⚠️ " .. foodItem.Name .. " needs cooking but campfire not found"
        return false
    end
    
    -- Step 2: Bring to player
    if not bringFoodToPlayer(foodItem) then
        AutoEat.Status = "❌ Failed to bring " .. foodItem.Name
        return false
    end
    
    -- Step 3: Eat
    if not eatSingleFood(foodItem) then
        AutoEat.Status = "❌ Failed to eat " .. foodItem.Name
        return false
    end
    
    return true
end

-- OPTIMIZED: Main eating loop
local function eatingLoop()
    if not AutoEat.Enabled or not AutoEat.IsEatingLoop then
        return
    end
    
    print("🔄 Starting optimized eating loop with cooking...")
    
    -- Try to find campfire position
    findCampfirePosition()
    
    -- Scan once for all available foods
    local availableFoods = findAnyFoodInMap()
    
    if #availableFoods == 0 then
        AutoEat.Status = "❌ No food found in map"
        AutoEat.IsEatingLoop = false
        return
    end
    
    local foodIndex = 1
    
    -- Keep eating until full or no food left
    while AutoEat.IsEatingLoop and AutoEat.Enabled and foodIndex <= #availableFoods do
        -- Check if we should stop eating
        if shouldStopEating() then
            local hunger = getHungerValue()
            AutoEat.Status = "✅ Full! Hunger: " .. hunger
            AutoEat.IsEatingLoop = false
            break
        end
        
        local foodItem = availableFoods[foodIndex]
        
        if foodItem then
            AutoEat.Status = "🍽️ Processing " .. foodItem.Name
            
            -- Process food (cook if needed, then eat)
            if processFoodItem(foodItem) then
                local hunger = getHungerValue()
                AutoEat.Status = "✅ Ate " .. foodItem.Name .. " | Hunger: " .. hunger
                foodIndex = foodIndex + 1
            else
                -- Try next food item if this one failed
                foodIndex = foodIndex + 1
            end
            
            -- Check hunger after each eat
            task.wait(0.5) -- Slightly longer delay for cooking
        else
            break
        end
    end
    
    -- If we ran out of food but still hungry
    if foodIndex > #availableFoods and not shouldStopEating() then
        AutoEat.Status = "⚠️ No more food available"
    end
    
    AutoEat.IsEatingLoop = false
end

-- OPTIMIZED: Simple monitor (no constant UI updates)
local function monitorHunger()
    if not AutoEat.Enabled then return end
    
    local hunger, maxHunger = getHungerValue()
    
    -- Only start eating if hungry AND not already eating
    if shouldStartEating() and not AutoEat.IsEatingLoop then
        AutoEat.IsEatingLoop = true
        AutoEat.Status = "🔄 Eating to " .. AutoEat.FullThreshold
        
        -- Start eating loop
        spawn(function()
            eatingLoop()
        end)
    end
end

-- Character setup
local function setupCharacter()
    AutoEat.Character = Player.Character or Player.CharacterAdded:Wait()
    AutoEat.HumanoidRootPart = AutoEat.Character:WaitForChild("HumanoidRootPart")
end

-- Function to start auto eat
local function startAutoEat()
    if AutoEat.Enabled then return end
    
    if not AutoEat.Character then
        setupCharacter()
    end
    
    -- Try to find campfire on start
    findCampfirePosition()
    
    local hunger = getHungerValue()
    AutoEat.Status = "🟢 Auto Eat Started"
    AutoEat.Enabled = true
    
    -- Start monitoring (less frequent checks)
    AutoEat.Connection = Services.RunService.Heartbeat:Connect(function()
        if not AutoEat.Enabled then
            if AutoEat.Connection then
                AutoEat.Connection:Disconnect()
                AutoEat.Connection = nil
            end
            return
        end
        
        -- Only check every 5 seconds instead of every frame
        if tick() % 5 < 0.1 then
            if AutoEat.HumanoidRootPart and AutoEat.HumanoidRootPart.Parent then
                pcall(monitorHunger)
            else
                setupCharacter()
            end
        end
    end)
end

-- Function to stop auto eat
local function stopAutoEat()
    AutoEat.Enabled = false
    AutoEat.IsEatingLoop = false
    
    if AutoEat.Connection then
        AutoEat.Connection:Disconnect()
        AutoEat.Connection = nil
    end
    
    AutoEat.Status = "🛑 Auto Eat Stopped"
end

-- Function to toggle auto eat
local function toggleAutoEat(state)
    if state then
        startAutoEat()
    else
        stopAutoEat()
    end
end

-- Create OPTIMIZED GUI for Auto Eat
local autoEatGroup = self.menu:CreateCollapsibleGroup(self.Tabs.AutoTab, "🍽️ AUTO EAT SYSTEM", false, 200)
self.menu:MarkAsNew(autoEatGroup:GetInstance(), "OPTIMIZED")

-- Main Toggle
autoEatGroup:AddToggle("🍽️ Enable Auto Eat", false, function(state)
    toggleAutoEat(state)
end)

-- MultiDropdown for Food Selection
autoEatGroup:AddMultiDropdown("🍎 Food Types", AutoEat.AllFoodItems, AutoEat.SelectedFoodItems, function(selectedFoodsArray)
    -- Update selection
    for foodName, _ in pairs(AutoEat.SelectedFoodItems) do
        AutoEat.SelectedFoodItems[foodName] = false
    end
    
    for _, foodName in ipairs(selectedFoodsArray) do
        AutoEat.SelectedFoodItems[foodName] = true
    end
    
    AutoEat.Status = "🍎 Selected " .. #selectedFoodsArray .. " food type(s)"
end)

-- Cooking toggle for Steak/Meat
autoEatGroup:AddToggle("🔥 Auto-Cook Steak/Meat", true, function(state)
    if state then
        -- Enable cooking for steak and meat
        AutoEat.FoodsNeedCooking["Steak"] = true
        AutoEat.FoodsNeedCooking["Meat"] = true
        AutoEat.Status = "🔥 Cooking enabled for Steak/Meat"
    else
        -- Disable cooking (eat raw)
        AutoEat.FoodsNeedCooking["Steak"] = false
        AutoEat.FoodsNeedCooking["Meat"] = false
        AutoEat.Status = "❄️ Cooking disabled - eating raw"
    end
end)

-- Eat Threshold Slider
autoEatGroup:AddSlider("🍽️ Start Eating Below", 1, 300, AutoEat.EatThreshold, function(value)
    AutoEat.EatThreshold = math.min(value, AutoEat.FullThreshold - 1)
end)

-- Full Threshold Slider
autoEatGroup:AddSlider("✅ Stop Eating At", AutoEat.EatThreshold + 10, 300, AutoEat.FullThreshold, function(value)
    AutoEat.FullThreshold = math.max(value, AutoEat.EatThreshold + 10)
end)

-- Simple status display (updated only when something happens)
local autoEatStatusLabel = autoEatGroup:AddLabel("Status: " .. AutoEat.Status)

-- Manual eat button
autoEatGroup:AddButton("⚡ Eat Now", function()
    if not AutoEat.Enabled then
        AutoEat.Status = "❌ Enable Auto Eat first"
        return
    end
    
    if AutoEat.IsEatingLoop then
        AutoEat.Status = "⚠️ Already eating"
        return
    end
    
    AutoEat.IsEatingLoop = true
    AutoEat.Status = "🔁 Manual eating started"
    
    spawn(function()
        eatingLoop()
    end)
end)

-- Find campfire button
autoEatGroup:AddButton("📍 Find Campfire", function()
    if findCampfirePosition() then
        AutoEat.Status = "✅ Campfire found at: " .. string.format("X:%.1f, Y:%.1f, Z:%.1f", 
            AutoEat.CampfirePosition.X, AutoEat.CampfirePosition.Y, AutoEat.CampfirePosition.Z)
    else
        AutoEat.Status = "❌ Campfire not found"
    end
end)

-- Update status label when status changes (ONLY when needed)
local function updateStatusLabel()
    autoEatStatusLabel.Text = "Status: " .. AutoEat.Status
end

-- Hook into AutoEat table to update status only when it changes
local originalStatus = AutoEat.Status
setmetatable(AutoEat, {
    __newindex = function(self, key, value)
        rawset(self, key, value)
        if key == "Status" and value ~= originalStatus then
            originalStatus = value
            updateStatusLabel()
        end
    end
})

-- Setup character when player joins
Player.CharacterAdded:Connect(function(character)
    setupCharacter()
end)

-- Initial setup
task.spawn(function()
    task.wait(3)
    setupCharacter()
    findCampfirePosition()
    print("🍽️ OPTIMIZED Auto Eat System with Cooking Loaded!")
    print("🍽️ Eat threshold: " .. AutoEat.EatThreshold)
    print("🍽️ Full threshold: " .. AutoEat.FullThreshold)
    print("🍽️ Cooking enabled for: Steak, Meat")
    print("🔥 Campfire found: " .. tostring(AutoEat.CampfirePosition ~= nil))
end)

print("✅ OPTIMIZED Auto Eat System with Cooking Feature Loaded!")

-- Add this code after your existing Reveal Map system


-- Auto Anti-Freeze System (Bring Fruit to Player)
local AntiFreeze = {
    Enabled = false,
    FreezeThreshold = 35,  -- Default: 35 (between 30-40)
    MaxFreezeMeter = 100,  -- Will be updated from game
    Connection = nil,
    Status = "Ready",
    Character = nil,
    HumanoidRootPart = nil,
    IsProcessing = false,
    ScanRange = 1000,
    
    -- Warm fruit tracking
    WarmFruitName = "Warm fruit",
    WarmFruitPart = "RootPart",  -- Adjust if different
    WarmFruitModel = nil,
    WarmFruitPartObj = nil,
    
    -- Eating speed
    EatDelay = 0.5,
    
    -- Bring settings
    BringHeight = 5,  -- Height to bring item to
    BringAttempts = 0,
    MaxBringAttempts = 3
}

-- Get the Eat remote event (same as AutoEat)
local EatRemote = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("EatC2S")

-- Get the drag remote (same as Bring system)
local DragRemote
local remoteEvents = {"DragItemC2S"}

for _, eventName in pairs(remoteEvents) do
    local eventsFolder = game:GetService("ReplicatedStorage"):FindFirstChild("Events")
    if eventsFolder then
        local playerFolder = eventsFolder:FindFirstChild("Player")
        if playerFolder then
            local targetEvent = playerFolder:FindFirstChild(eventName)
            if targetEvent then
                DragRemote = targetEvent
                break
            end
        end
    end
end

-- Get freeze meter value for local player
local function getFreezeMeterValue()
    local player = game:GetService("Players").LocalPlayer
    
    -- Method 1: Check values folder
    if player and player:FindFirstChild("Values") then
        local values = player.Values
        if values:FindFirstChild("freezeMeter") then
            local freezeValue = values.freezeMeter.Value
            -- Try to get max freeze meter if available
            if values:FindFirstChild("maxFreezeMeter") then
                AntiFreeze.MaxFreezeMeter = values.maxFreezeMeter.Value
            end
            return freezeValue
        end
    end
    
    -- Method 2: Check other common locations
    local character = player.Character
    if character then
        -- Check if freeze meter is in character
        local valuesInChar = character:FindFirstChild("Values")
        if valuesInChar and valuesInChar:FindFirstChild("freezeMeter") then
            return valuesInChar.freezeMeter.Value
        end
        
        -- Check for any freeze-related value
        for _, obj in pairs(character:GetDescendants()) do
            if obj:IsA("NumberValue") and (obj.Name:lower():find("freeze") or obj.Name:lower():find("cold")) then
                return obj.Value
            end
        end
    end
    
    -- Method 3: Check workspace (as mentioned in description)
    local workspaceFreeze = workspace:FindFirstChild(player.Name .. ".Values")
    if workspaceFreeze and workspaceFreeze:FindFirstChild("freezeMeter") then
        return workspaceFreeze.freezeMeter.Value
    end
    
    return 0  -- Default if not found
end

-- Check if should warm up
local function shouldWarmUp()
    if not AntiFreeze.Enabled then return false end
    
    local freezeValue = getFreezeMeterValue()
    return freezeValue >= AntiFreeze.FreezeThreshold
end

-- Find warm fruit in the map
local function findWarmFruit()
    AntiFreeze.WarmFruitModel = nil
    AntiFreeze.WarmFruitPartObj = nil
    AntiFreeze.BringAttempts = 0
    
    -- Search entire workspace for warm fruit
    for _, obj in pairs(game:GetService("Workspace"):GetDescendants()) do
        if obj:IsA("Model") and obj.Name == AntiFreeze.WarmFruitName then
            local partName = AntiFreeze.WarmFruitPart
            local part = obj:FindFirstChild(partName) or obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
            
            if part and part:IsA("BasePart") then
                AntiFreeze.WarmFruitModel = obj
                AntiFreeze.WarmFruitPartObj = part
                
                -- Calculate distance if we have a character
                if AntiFreeze.HumanoidRootPart then
                    local distance = (AntiFreeze.HumanoidRootPart.Position - part.Position).Magnitude
                    AntiFreeze.Status = "📍 Found warm fruit (" .. math.floor(distance) .. " studs away)"
                else
                    AntiFreeze.Status = "📍 Found warm fruit"
                end
                
                return true
            end
        end
    end
    
    AntiFreeze.Status = "❌ No warm fruit found in map"
    return false
end

-- Use dragging remote (same as Bring system)
local function useDraggingRemote(itemObject, state)
    if not DragRemote then
        return false
    end
    
    local success = pcall(function()
        if state then
            DragRemote:FireServer(itemObject)
        else
            DragRemote:FireServer()
        end
        return true
    end)
    
    return success
end

-- Get teleport position (same as Bring system)
local function getTeleportPosition()
    local character = AntiFreeze.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return nil end
    
    local hrp = character.HumanoidRootPart
    return hrp.CFrame + Vector3.new(0, AntiFreeze.BringHeight, 0)
end

-- Bring warm fruit to player
local function bringWarmFruitToPlayer()
    if not AntiFreeze.WarmFruitModel or not AntiFreeze.WarmFruitPartObj then
        if not findWarmFruit() then
            return false
        end
    end
    
    AntiFreeze.BringAttempts = AntiFreeze.BringAttempts + 1
    
    if AntiFreeze.BringAttempts > AntiFreeze.MaxBringAttempts then
        AntiFreeze.Status = "❌ Failed to bring warm fruit after " .. AntiFreeze.MaxBringAttempts .. " attempts"
        AntiFreeze.WarmFruitModel = nil  -- Reset to find new fruit
        AntiFreeze.WarmFruitPartObj = nil
        return false
    end
    
    -- Get player position
    local teleportCF = getTeleportPosition()
    if not teleportCF then
        AntiFreeze.Status = "❌ Cannot get player position"
        return false
    end
    
    -- Use drag system if available
    local dragSuccess = false
    if DragRemote then
        dragSuccess = useDraggingRemote(AntiFreeze.WarmFruitModel, true)
        
        -- Small delay to ensure drag is registered
        task.wait(0.1)
    end
    
    -- Bring the fruit to player
    if AntiFreeze.WarmFruitPartObj and AntiFreeze.WarmFruitPartObj.Parent then
        AntiFreeze.WarmFruitPartObj.CFrame = teleportCF
        AntiFreeze.Status = "🚀 Bringing warm fruit to player (Attempt " .. AntiFreeze.BringAttempts .. ")"
        
        -- Release drag
        if dragSuccess then
            useDraggingRemote(AntiFreeze.WarmFruitModel, false)
        end
        
        -- Wait a moment for the fruit to arrive
        task.wait(0.3)
        
        return true
    else
        AntiFreeze.Status = "❌ Warm fruit disappeared during transport"
        AntiFreeze.WarmFruitModel = nil
        AntiFreeze.WarmFruitPartObj = nil
        return false
    end
end

-- Eat the warm fruit
local function eatWarmFruit()
    if not AntiFreeze.WarmFruitModel then
        AntiFreeze.Status = "❌ No warm fruit to eat"
        return false
    end
    
    local success, err = pcall(function()
        EatRemote:FireServer(AntiFreeze.WarmFruitModel)
        return true
    end)
    
    if success then
        local freezeBefore = getFreezeMeterValue()
        
        -- Wait for the eating to register
        task.wait(AntiFreeze.EatDelay)
        
        local freezeAfter = getFreezeMeterValue()
        local freezeReduction = freezeBefore - freezeAfter
        
        if freezeReduction > 0 then
            AntiFreeze.Status = "✅ Ate warm fruit | Freeze -" .. freezeReduction .. " (" .. freezeAfter .. ")"
        else
            AntiFreeze.Status = "✅ Ate warm fruit | Freeze: " .. freezeAfter
        end
        
        -- Reset attempts counter after successful eat
        AntiFreeze.BringAttempts = 0
        
        return true
    else
        AntiFreeze.Status = "❌ Failed to eat warm fruit: " .. tostring(err)
        return false
    end
end

-- Complete anti-freeze process (bring + eat)
local function processAntiFreeze()
    if not AntiFreeze.Enabled or AntiFreeze.IsProcessing then
        return false
    end
    
    AntiFreeze.IsProcessing = true
    AntiFreeze.Status = "🔥 Processing anti-freeze..."
    
    -- Step 1: Find warm fruit
    if not findWarmFruit() then
        AntiFreeze.Status = "❌ Cannot find warm fruit in map"
        AntiFreeze.IsProcessing = false
        return false
    end
    
    -- Step 2: Bring warm fruit to player
    if not bringWarmFruitToPlayer() then
        AntiFreeze.Status = "❌ Failed to bring warm fruit to player"
        AntiFreeze.IsProcessing = false
        return false
    end
    
    -- Step 3: Eat warm fruit
    if not eatWarmFruit() then
        AntiFreeze.Status = "❌ Failed to eat warm fruit"
        AntiFreeze.IsProcessing = false
        return false
    end
    
    AntiFreeze.IsProcessing = false
    return true
end

-- Main monitoring loop
local function monitorFreeze()
    if not AntiFreeze.Enabled then return end
    
    local freezeValue = getFreezeMeterValue()
    
    -- Update status with current freeze value
    if tick() % 3 < 0.1 then  -- Update every 3 seconds
        AntiFreeze.Status = "❄️ Freeze: " .. freezeValue .. "/" .. AntiFreeze.MaxFreezeMeter
    end
    
    -- Check if we need to warm up AND not already in the process
    if shouldWarmUp() and not AntiFreeze.IsProcessing then
        local freezeValue = getFreezeMeterValue()
        AntiFreeze.Status = "🔥 Freeze threshold reached! (" .. freezeValue .. ") Warming up..."
        
        -- Start the anti-freeze process
        spawn(function()
            local success = processAntiFreeze()
            if not success then
                -- If failed, try again in a moment
                task.wait(2)
                if shouldWarmUp() then
                    AntiFreeze.Status = "🔄 Retrying anti-freeze process..."
                    processAntiFreeze()
                end
            end
        end)
    end
end

-- Character setup
local function setupCharacter()
    AntiFreeze.Character = game:GetService("Players").LocalPlayer.Character or 
                          game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
    AntiFreeze.HumanoidRootPart = AntiFreeze.Character:WaitForChild("HumanoidRootPart")
end

-- Function to start anti-freeze system
local function startAntiFreeze()
    if AntiFreeze.Enabled then return end
    
    if not AntiFreeze.Character then
        setupCharacter()
    end
    
    local freezeValue = getFreezeMeterValue()
    AntiFreeze.Status = "🟢 Anti-Freeze Started | Freeze: " .. freezeValue
    AntiFreeze.Enabled = true
    AntiFreeze.BringAttempts = 0
    
    -- Start monitoring
    AntiFreeze.Connection = game:GetService("RunService").Heartbeat:Connect(function()
        if not AntiFreeze.Enabled then
            if AntiFreeze.Connection then
                AntiFreeze.Connection:Disconnect()
                AntiFreeze.Connection = nil
            end
            return
        end
        
        -- Monitor less frequently (every 1.5 seconds) to save performance
        if tick() % 1.5 < 0.1 then
            if AntiFreeze.HumanoidRootPart and AntiFreeze.HumanoidRootPart.Parent then
                pcall(monitorFreeze)
            else
                setupCharacter()
            end
        end
    end)
end

-- Function to stop anti-freeze system
local function stopAntiFreeze()
    AntiFreeze.Enabled = false
    AntiFreeze.IsProcessing = false
    AntiFreeze.BringAttempts = 0
    
    if AntiFreeze.Connection then
        AntiFreeze.Connection:Disconnect()
        AntiFreeze.Connection = nil
    end
    
    AntiFreeze.Status = "🛑 Anti-Freeze Stopped"
end

-- Function to toggle anti-freeze
local function toggleAntiFreeze(state)
    if state then
        startAntiFreeze()
    else
        stopAntiFreeze()
    end
end

-- Function to manually warm up (for testing/emergency)
local function manualWarmUp()
    if AntiFreeze.IsProcessing then
        AntiFreeze.Status = "⚠️ Already processing"
        return false
    end
    
    AntiFreeze.Status = "🔥 Manual warm-up started"
    
    spawn(function()
        processAntiFreeze()
    end)
    
    return true
end

-- Function to bring fruit without eating (for testing)
local function bringFruitOnly()
    if not findWarmFruit() then
        return false
    end
    
    AntiFreeze.Status = "📦 Bringing fruit only..."
    return bringWarmFruitToPlayer()
end

-- Create GUI for Auto Anti-Freeze
local antiFreezeGroup = self.menu:CreateCollapsibleGroup(self.Tabs.AutoTab, "❄️ AUTO ANTI-FREEZE (BRING FRUIT)", false, 220)
self.menu:MarkAsNew(antiFreezeGroup:GetInstance(), "NEW")

-- Main Toggle
antiFreezeGroup:AddToggle("❄️ Enable Anti-Freeze", false, function(state)
    toggleAntiFreeze(state)
end)

-- Freeze Threshold Slider
antiFreezeGroup:AddSlider("🔥 Warm Up At Freeze", 30, 40, AntiFreeze.FreezeThreshold, function(value)
    AntiFreeze.FreezeThreshold = value
    AntiFreeze.Status = "❄️ Threshold: " .. value
end)

-- Bring Height Slider
antiFreezeGroup:AddSlider("📏 Bring Height", 2, 10, AntiFreeze.BringHeight, function(value)
    AntiFreeze.BringHeight = value
end)

-- Eat Delay Slider
antiFreezeGroup:AddSlider("⚡ Eat Speed", 0.2, 2, AntiFreeze.EatDelay, function(value)
    AntiFreeze.EatDelay = value
end)

-- Find Warm Fruit Button
antiFreezeGroup:AddButton("🔍 Find Warm Fruit", function()
    if findWarmFruit() and AntiFreeze.WarmFruitPartObj then
        local pos = AntiFreeze.WarmFruitPartObj.Position
        AntiFreeze.Status = "✅ Warm fruit at: " .. 
            string.format("X:%.0f, Y:%.0f, Z:%.0f", pos.X, pos.Y, pos.Z)
    end
end)

-- Bring Fruit Only Button
antiFreezeGroup:AddButton("📦 Bring Fruit Only", function()
    bringFruitOnly()
end)

-- Manual Warm Up Button
antiFreezeGroup:AddButton("🔥 Manual Warm Up", function()
    manualWarmUp()
end)

-- Status Display
local antiFreezeStatusLabel = antiFreezeGroup:AddLabel("Status: " .. AntiFreeze.Status)

-- Current Freeze Display
local freezeValueLabel = antiFreezeGroup:AddLabel("Current Freeze: --")

-- Fruit Info Display
local fruitInfoLabel = antiFreezeGroup:AddLabel("Fruit Status: Not found")

-- Attempts Display
local attemptsLabel = antiFreezeGroup:AddLabel("Attempts: 0/" .. AntiFreeze.MaxBringAttempts)

-- Function to update GUI labels
local function updateAntiFreezeGUI()
    antiFreezeStatusLabel.Text = "Status: " .. AntiFreeze.Status
    
    -- Update freeze value
    local freezeValue = getFreezeMeterValue()
    freezeValueLabel.Text = "Current Freeze: " .. freezeValue .. "/" .. AntiFreeze.MaxFreezeMeter
    
    -- Update fruit info
    if AntiFreeze.WarmFruitModel and AntiFreeze.WarmFruitPartObj then
        if AntiFreeze.HumanoidRootPart then
            local distance = (AntiFreeze.HumanoidRootPart.Position - AntiFreeze.WarmFruitPartObj.Position).Magnitude
            fruitInfoLabel.Text = "Fruit: Found (" .. math.floor(distance) .. " studs)"
        else
            fruitInfoLabel.Text = "Fruit: Found"
        end
    else
        fruitInfoLabel.Text = "Fruit: Not found"
    end
    
    -- Update attempts
    attemptsLabel.Text = "Attempts: " .. AntiFreeze.BringAttempts .. "/" .. AntiFreeze.MaxBringAttempts
end

-- Hook into AntiFreeze table to update GUI
setmetatable(AntiFreeze, {
    __newindex = function(self, key, value)
        rawset(self, key, value)
        if key == "Status" or key == "BringAttempts" or key == "WarmFruitModel" or key == "WarmFruitPartObj" then
            updateAntiFreezeGUI()
        end
    end
})

-- Auto-update freeze value display
task.spawn(function()
    while true do
        task.wait(2)
        if AntiFreeze.Enabled then
            updateAntiFreezeGUI()
        end
    end
end)

-- Setup character when player joins
game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(character)
    setupCharacter()
end)

-- Auto-stop when player dies
task.spawn(function()
    while true do
        task.wait(3)
        if AntiFreeze.Enabled then
            local character = game:GetService("Players").LocalPlayer.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") or 
               (character:FindFirstChild("Humanoid") and character.Humanoid.Health <= 0) then
                stopAntiFreeze()
            end
        end
    end
end)

-- Initial setup
task.spawn(function()
    task.wait(3)
    setupCharacter()
    
    -- Get initial freeze meter value
    local freezeValue = getFreezeMeterValue()
    print("❄️ Auto Anti-Freeze System (Bring Fruit) Loaded!")
    print("❄️ Current Freeze: " .. freezeValue)
    print("🔥 Warm-up Threshold: " .. AntiFreeze.FreezeThreshold)
    print("📏 Bring Height: " .. AntiFreeze.BringHeight)
    print("⚡ Eat Speed: " .. AntiFreeze.EatDelay .. "s")
    
    updateAntiFreezeGUI()
end)

-- Clean up when script ends
game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == game:GetService("Players").LocalPlayer then
        stopAntiFreeze()
    end
end)

print("✅ Auto Anti-Freeze System (Bring Fruit to Player) Loaded!")


end
 
-- RETURN the module so main script can use it
return AutoTabSystem
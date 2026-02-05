--[[dwahduiwahduaihdowauihdiowajdw

ahduaihdowauihdi
ahduaihdowauihdi
ahduaihdowauihdi
ahduaihdowauihdidwa
dwav
ahduaihdowauihdi
awdwa
dad
a
dwa
d
wa
dwa
d
a
d

ad
wdwav
ahduaihdowauihdi
awdwa
dad
a
dwa
d
wa
dwa
d
a
d

ad
w
ad
wa
dw
a
ddwav
ahduaihdowauihdi
awdwa
dad
a
dwa
d
wa
dwa
d
a
d

ad
w
ad
wa
dw
a
d

dw
v

B
2b
3

3
23b
r32
3rb
2r
qb
r32
b2

dw
v

B
2b
3

3
23b
r32
3rb
2r
qb
r32
b2
ad
wa
dw
a
d

dw
v

B
2b
3

3
23b
r32
3rb
2r
qb
r32
b2
qrb
23
b
23
ahduaihdowauihdi
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local GuiLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/thelostsheep199-collab/d-DADSD-DV-DADCAdwxq/refs/heads/main/kabah6v2bs8bsk"))()
local menu = GuiLibrary.new("SFY_ULTIMATE - Build a Bunker V3 ")

-- Check if device is desktop/computer (not mobile)
local isDesktop = not UserInputService.TouchEnabled
-- Create Info tab only for desktop users
local infoTab
if isDesktop then
    infoTab = menu:CreateTab("HOW TO USE?")
end
-- Create main tabs
local Tabs = {
    MainTab = menu:CreateTab("Main"),
    BringTab = menu:CreateTab("Bring Stuff v2"),
    ProjectTab = menu:CreateTab("Build Room"),
    PlayerTab = menu:CreateTab("Local Player"),
    visualTab = menu:CreateTab("Visual")
}


-- Camera System
local camera = workspace.CurrentCamera
local inFirstPerson = true
local thirdPersonDistance = 10

-- GUI State
local isGUIMinimized = false

-- Function to check current GUI state
local function getCurrentGUIState()
    local screenGui = player.PlayerGui:FindFirstChild("VoidwareGUI")
    if not screenGui then return false end
    
    local mainFrame = screenGui:FindFirstChild("MainFrame")
    local minimizedIcon = screenGui:FindFirstChild("MinimizedIcon")
    
    if mainFrame and minimizedIcon then
        return not mainFrame.Visible and minimizedIcon.Visible
    end
    
    return false
end

-- Mouse cursor control (updated)
local function updateMouseCursor()
    local currentState = getCurrentGUIState()
    isGUIMinimized = currentState

    -- Cursor visibility rules:
    -- SHOW cursor if: GUI is open OR third person
    -- HIDE cursor if: GUI minimized AND first person

    if (not isGUIMinimized) or (not inFirstPerson) then
        -- GUI shown OR third person
        UserInputService.MouseIconEnabled = true
    else
        -- GUI minimized AND first person
        UserInputService.MouseIconEnabled = false
    end
end

-- Apply camera mode
local function updateCamera()
    if not player.Character then return end
    
    local humanoid = player.Character:FindFirstChild("Humanoid")
    if not humanoid then return end

    if inFirstPerson then
        -- First Person
        player.CameraMode = Enum.CameraMode.LockFirstPerson
        camera.CameraSubject = humanoid
        camera.FieldOfView = 70
    else
        -- Third Person
        player.CameraMode = Enum.CameraMode.Classic
        camera.CameraType = Enum.CameraType.Custom
        camera.CameraSubject = humanoid
        player.CameraMinZoomDistance = thirdPersonDistance
        player.CameraMaxZoomDistance = thirdPersonDistance
    end

    -- Update mouse cursor based on camera mode
    updateMouseCursor()
end


-- GUI Minimize/Maximize
local function minimizeGUI()
    local screenGui = player.PlayerGui:FindFirstChild("VoidwareGUI")
    if screenGui then
        local mainFrame = screenGui:FindFirstChild("MainFrame")
        local minimizedIcon = screenGui:FindFirstChild("MinimizedIcon")
        
        if mainFrame and minimizedIcon then
            mainFrame.Visible = false
            minimizedIcon.Visible = true
            updateMouseCursor() -- Update mouse cursor state
        end
    end
end

local function maximizeGUI()
    local screenGui = player.PlayerGui:FindFirstChild("VoidwareGUI")
    if screenGui then
        local mainFrame = screenGui:FindFirstChild("MainFrame")
        local minimizedIcon = screenGui:FindFirstChild("MinimizedIcon")
        
        if mainFrame and minimizedIcon then
            mainFrame.Visible = true
            minimizedIcon.Visible = false
            updateMouseCursor() -- Update mouse cursor state
        end
    end
end

local function toggleGUI()
    if isGUIMinimized then
        maximizeGUI()
    else
        minimizeGUI()
    end
end

-- Continuous GUI state monitoring
spawn(function()
    while true do
        updateMouseCursor() -- Always check current state
        wait(0.5) -- Check every 0.5 seconds
    end
end)

-- Also monitor for any GUI visibility changes
local function monitorGUIChanges()
    local screenGui = player.PlayerGui:WaitForChild("VoidwareGUI")
    
    -- Monitor MainFrame visibility changes
    local mainFrame = screenGui:WaitForChild("MainFrame")
    mainFrame:GetPropertyChangedSignal("Visible"):Connect(function()
        updateMouseCursor()
    end)
    
    -- Monitor MinimizedIcon visibility changes
    local minimizedIcon = screenGui:WaitForChild("MinimizedIcon")
    minimizedIcon:GetPropertyChangedSignal("Visible"):Connect(function()
        updateMouseCursor()
    end)
end

-- Start monitoring GUI changes
spawn(monitorGUIChanges)

-- Input Handling
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end

    if input.KeyCode == Enum.KeyCode.F2 then
        -- Toggle GUI minimize/maximize
        toggleGUI()
    elseif input.KeyCode == Enum.KeyCode.RightShift then
        -- Toggle camera mode
        inFirstPerson = not inFirstPerson
        updateCamera()
    end
end)

-- Character Respawn Handling
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    wait(1)
    updateCamera()
    -- Restart GUI monitoring after character respawn
    wait(2)
    monitorGUIChanges()
end)

-- Apply initial camera setting and mouse cursor state
updateCamera()
updateMouseCursor() -- Set initial mouse cursor state



-- Create the welcome panel in the Info tab
local welcomePanel = menu:CreateWelcomePanelTab(Tabs.MainTab, {
    ScriptName = "BUILD A BUNKER",
    Version = "V4.5",
    Developer = "SFY_devs",
    Discord = "discord.gg/m8B5VHfs",
    Description = "Ultimate gaming utility with premium features, ESP, auto-farm, and more! Support the developers by joining our Discord!",
    Features = {
        "1. AUTO COMPLETE ROOM",
		"2. God Mode",
        "3. ITEM ESP",
        "4. BRING STUFF and Item",
        "5. SPEED HACK + FLY HACK"
    },
    ThemeColor = Color3.fromRGB(230,162,60)
})

-- Add premium status indicator
menu:CreateSeparator(Tabs.MainTab, "💎 PREMIUM STATUS")
local premiumStatus = menu:CreateLabel(Tabs.MainTab, "Status: FREE VERSION")
local IsPremium = true -- Define this variable if not already defined

-- Function to update premium status
local function updatePremiumStatus()
    if IsPremium then
        premiumStatus.Text = "Status: PREMIUM ACTIVE 🎉"
        premiumStatus.TextColor3 = Color3.fromRGB(255, 215, 0)
    else
        premiumStatus.Text = "Status: FREE VERSION 🔓"
        premiumStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end

updatePremiumStatus()

-- Add premium upgrade button
menu:CreateButton(Tabs.MainTab, "🔓 UPGRADE TO PREMIUM", function()
    menu:CopyToClipboard("https://discord.gg/m8B5VHfs")
    menu:ShowNotification("📋 Premium link copied to clipboard!", 3)
end)

-- Use the builder
menu:CreateSeparator(Tabs.MainTab, "🐞 CHANGE LOGS ")
local updateHistory = menu:UpdateHistoryBuilder(Tabs.MainTab)
:Add("2026-02-03", "update","God Mode Added", "New Invisibility is Added")
:Add("2026-02-03", "update", "ADVANCE AUTO COMPLETE","Adding Advance Stocking materials")
:Add("2025-12-15","update","CANDY AND SCRAP","Added Auto farm for Candy and scraps")
    :Add("2025-12-11","update","AUTO COMPLETE ROOM","Automatic upgrade room, without doing anything")
    :Add("2025-12-10","optimized","UPDATED UI","Optmized ui menu for both pc and mobile")
    :Add("2025-12-9", "improve", "New Welcome", "Added a welcome menu")
    :Add("2025-11-24", "update","THIRD PERSON ADDED", "Added a option for third person character")
    :Add("2025-11-1", "update","Room", "Added auto complete room")
    :Build()














-- Info Tab Content (only for desktop)
if isDesktop and infoTab then
    menu:CreateSeparator(infoTab, "📋 INSTRUCTIONS")
    
    menu:CreateLabel(infoTab, "🎮 CONTROLS")
    menu:CreateLabel(infoTab, "• Press RightShift to Toggle Camera View")
    
    menu:CreateSeparator(infoTab, "👁️ CAMERA MODES")
    menu:CreateLabel(infoTab, "First Person:")
    menu:CreateLabel(infoTab, "  - Immersive view from character's eyes")
    menu:CreateLabel(infoTab, "  - Better for precise interactions")
    
    menu:CreateLabel(infoTab, "Third Person:")
    menu:CreateLabel(infoTab, "  - View from behind character")
    menu:CreateLabel(infoTab, "  - Better for spatial awareness")
    
    menu:CreateSeparator(infoTab, "🖥️ MENU CONTROLS")
    menu:CreateLabel(infoTab, "Maximized Mode:")
    menu:CreateLabel(infoTab, "  - Full menu interface")
    menu:CreateLabel(infoTab, "  - Mouse cursor automatically visible")
    menu:CreateLabel(infoTab, "  - Access all features")
    
    menu:CreateLabel(infoTab, "Minimized Mode:")
    menu:CreateLabel(infoTab, "  - Small icon in corner")
    menu:CreateLabel(infoTab, "  - Mouse cursor automatically hidden")
    menu:CreateLabel(infoTab, "  - Click to restore full menu")
    
    menu:CreateSeparator(infoTab, "⚡ QUICK TIPS")
    menu:CreateLabel(infoTab, "• Use RightShift to switch perspectives")
    menu:CreateLabel(infoTab, "• Mouse cursor automatically shows/hides with menu")
    menu:CreateLabel(infoTab, "• System continuously monitors menu state")
    menu:CreateLabel(infoTab, "• Adjust camera distance in Local Player tab")
end

local CameraSettingsGroup = menu:CreateCollapsibleGroup(Tabs.PlayerTab,"CAMERA SETTINGS", false,100) 

local cameraToggle = CameraSettingsGroup:AddToggle("First Person Camera", false, function(state)
    inFirstPerson = state
    updateCamera()
end)

local cameraDistance = CameraSettingsGroup:AddSlider("Third Person Distance", 5, 20, 10, function(value)
    thirdPersonDistance = value
    if not inFirstPerson then
        updateCamera()
    end
end)



-- Update mouse status label periodically
spawn(function()
    while true do
        if mouseStatusLabel and mouseStatusLabel.Instance then
            local currentState = getCurrentGUIState()
            mouseStatusLabel.Instance.Text = "Mouse: " .. (currentState and "Hidden (GUI Minimized)" or "Visible (GUI Open)")
        end
        wait(1)
    end
end)

--/////////////////Camera System//////////////////

-- ///////////bring section
-- Get the Knit services for drag remote events
local KnitPath = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit")
local DragService = KnitPath:WaitForChild("Services"):WaitForChild("DragService")
local ReleaseDrag = DragService:WaitForChild("RE"):WaitForChild("ReleaseDrag")
local RequestDrag = DragService:WaitForChild("RF"):WaitForChild("RequestDrag")

-- Create the Part in Loot folder
local function createLootPart()
    local part = Instance.new("Part")
    part.Name = "Part"
    part.Size = Vector3.new(0, 0, 0)
    part.BrickColor = BrickColor.new("Bright blue")
    part.Material = Enum.Material.Neon
    part.Anchored = false
    part.CanCollide = false
    part.Parent = workspace.Loot
    
    -- Add a sparkle effect
    local sparkles = Instance.new("Sparkles")
    sparkles.Parent = part
    
    print("Created Part in workspace.Loot")
    return part
end

-- Ensure the Part exists
local lootPart = workspace.Loot:FindFirstChild("Part") or createLootPart()

-- Store teleport locations and combo references for each category
local teleportLocations = {}
local locationMarkers = {}
local categoryCombos = {}

-- Add GetCombo function to GuiLibrary
function GuiLibrary:GetCombo(comboName)
    return categoryCombos[comboName]
end

-- Function to create glowing location marker
local function createLocationMarker(category, position)
    if locationMarkers[category] then
        locationMarkers[category]:Destroy()
    end
    
    -- Create glowing part
    local marker = Instance.new("Part")
    marker.Name = category .. "LocationMarker"
    marker.Size = Vector3.new(6, 0.5, 6)
    marker.Position = position + Vector3.new(0, -3, 0)
    marker.Anchored = true
    marker.CanCollide = false
    marker.Material = Enum.Material.Neon
    marker.Transparency = 0.8
    
    -- Set color based on category
    local categoryColors = {
        Food = Color3.fromRGB(0, 255, 0),        -- Green
        Item = Color3.fromRGB(0, 100, 255),      -- Blue
        Weapon = Color3.fromRGB(255, 0, 0),      -- Red
        Materials = Color3.fromRGB(255, 165, 0), -- Orange
        Aid = Color3.fromRGB(255, 0, 255),       -- Magenta
        Others = Color3.fromRGB(255, 255, 0),     -- Yellow
        Event = Color3.fromRGB(255, 255, 0)
    }
    
    marker.BrickColor = BrickColor.new(categoryColors[category] or Color3.fromRGB(255, 255, 255))
    marker.Parent = workspace
    
    -- Add sparkle effect
    local sparkles = Instance.new("Sparkles")
    sparkles.SparkleColor = marker.BrickColor.Color
    sparkles.Parent = marker
    
    -- Add light
    local pointLight = Instance.new("PointLight")
    pointLight.Color = marker.BrickColor.Color
    pointLight.Brightness = 0.2
    pointLight.Range = 2
    pointLight.Parent = marker
    
    -- Create billboard label
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "LocationLabel"
    billboard.Size = UDim2.new(0, 150, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 5, 0)
    billboard.AlwaysOnTop = false
    billboard.Adornee = marker
    billboard.Parent = marker

-- Remove the frame completely and put the label directly in the billboard
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1  -- Completely transparent background
    label.Text = category .. " TP Location"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)  -- Add black outline for better visibility
    label.TextStrokeTransparency = 0.3
    label.Parent = billboard
    
    locationMarkers[category] = marker
    return marker
end

-- Function to remove location marker
local function removeLocationMarker(category)
    if locationMarkers[category] then
        locationMarkers[category]:Destroy()
        locationMarkers[category] = nil
    end
    teleportLocations[category] = nil
end

-- Function to teleport item using remote events
local function teleportItemUsingRemoteEvents(itemModel, targetPosition)
    local success = false
    
    if not itemModel or not itemModel:IsA("Model") then
        return false
    end
    
    -- Use pcall to handle any errors with remote events
    local dragSuccess, dragResult = pcall(function()
        -- Request to drag the item
        return RequestDrag:InvokeServer(itemModel)
    end)
    
    if dragSuccess then
        -- Teleport the item to target position
        local teleportCFrame = CFrame.new(targetPosition) + Vector3.new(0, 3, 0) -- Slightly above ground
        
        -- Use PivotTo for models
        if itemModel:IsA("Model") then
            itemModel:PivotTo(teleportCFrame)
        end
        
        -- Wait a brief moment
        wait(0.05)
        
        -- Release the drag
        local releaseSuccess, releaseResult = pcall(function()
            ReleaseDrag:FireServer(itemModel)
        end)
        
        success = releaseSuccess
    else
        warn("❌ Failed to drag item: " .. itemModel:GetFullName() .. " - " .. tostring(dragResult))
        success = false
    end
    
    return success
end

-- Categorized items
local categorizedItems = {
    Food = {
        "Apple", "Banana", "Beans", "Candy", "Canned Ham", "Canned Tuna", 
        "Cereal Box", "Chocolate Bar", "Conk", "Cranzo", "Jolto", "Lotizz", 
        "Spire", "Water Bottle", "Water Jug"
    },
    Item = {
        "Axle", "Battery", "Battery Pack", "Bolt", "Cinder Block", 
        "Cooking Pot", "Coil", "Cup", "Fizzixs", "Floor Lamp", 
        "Fusion Core", "Gold Bar", "Heavy Gear", "Jar of Dirt", 
        "Light Gear", "Metal Sheet", "Money", "Pumpkin", 
        "Rusty Pipe", "Scrap", "Shoe", "Silver Bar", "Toolbox","Circuit Board","Left Roadsign Armor","Television"
    },
    Weapon = {
        "Cultist Knife", "Fireaxe", "Iron Bar", "Knife", "Pistol Ammo", 
        "Repair Hammer", "Rifle Ammo", "Sawblade", "Shotgun Ammo", 
        "Shovel", "Sledgehammer", "Worn Cultist Knife", "Worn Fireaxe", 
        "Worn M1911", "Worn Revolver", "Worn Sawn-Off","Bat","M1911","MRE"
    },
    Materials = {
        "Barbed Wire", "Bike Tire", "Blue Couch", "Bunk Beds", "Chair", 
        "Classic Bookshelf", "Coffee Table", "Compact Bookshelf", 
        "Dinner Table", "Divided Bookshelf", "Double Bed", "Double Door", 
        "Garage Shelf", "Glass Panel", "Neon Sign", "Office Desk", 
        "Open Bookshelf", "Pallet", "Prison Bed", "Red Couch", 
        "Square Table", "Steel Panel", "Storage Rack", "Tire", 
        "Traffic Cone", "Wooden Spikes", "Yellow Couch","Television"
    },
    Aid = {
        "Bandage", "First Aid Kit", "Large Medkit", "Military Medkit", 
        "Revive Serum", "Vitamins"
    },
    Others = {
        "Dr. Anne Miller", "Dr. Walter Hayes", "Mutant Beast's skeleton", 
        "Mutant Brute's skeleton", "Mutant Overlord's skeleton", 
        "Mutant Stalker's skeleton", "Prof. Peter Ellison"
    },
    Event = {
        "Candy Cane","Scrap"
    }
}

-- Store selected items for each category (default all selected)
local selectedItems = {
    Food = {"Apple", "Banana", "Beans", "Candy", "Canned Ham", "Canned Tuna", 
        "Cereal Box", "Chocolate Bar", "Conk", "Cranzo", "Jolto", "Lotizz", 
        "Spire", "Water Bottle","Pumpkin", "Water Jug"},
    Item = {"Axle", "Battery", "Battery Pack", "Bolt", "Cinder Block", 
        "Cooking Pot", "Coil", "Cup", "Fizzixs", "Floor Lamp", 
        "Fusion Core", "Gold Bar", "Heavy Gear", "Jar of Dirt", 
        "Light Gear", "Metal Sheet", "Money", "Pumpkin", 
        "Rusty Pipe", "Scrap", "Shoe", "Silver Bar", "Toolbox","Circuit Board","Left Roadsign Armor","Television"},
    Weapon = {"Cultist Knife", "Fireaxe", "Iron Bar", "Knife", "Pistol Ammo", 
        "Repair Hammer", "Rifle Ammo", "Sawblade", "Shotgun Ammo", 
        "Shovel", "Sledgehammer", "Worn Cultist Knife", "Worn Fireaxe", 
        "Worn M1911", "Worn Revolver", "Worn Sawn-Off","Rusty Pipe","Bat","M1911","MRE"},
    Materials = {"Barbed Wire", "Bike Tire", "Blue Couch", "Bunk Beds", "Chair", 
        "Classic Bookshelf", "Coffee Table", "Compact Bookshelf", 
        "Dinner Table", "Divided Bookshelf", "Double Bed", "Double Door", 
        "Garage Shelf", "Glass Panel", "Neon Sign", "Office Desk", 
        "Open Bookshelf", "Pallet", "Prison Bed", "Red Couch", 
        "Square Table", "Steel Panel", "Storage Rack", "Tire", 
        "Traffic Cone", "Wooden Spikes", "Yellow Couch", "Television"},
    Aid = {"Bandage", "First Aid Kit", "Large Medkit", "Military Medkit", 
        "Revive Serum", "Vitamins"},
    Others = { "Dr. Anne Miller", "Dr. Walter Hayes", "Mutant Beast's skeleton", 
        "Mutant Brute's skeleton", "Mutant Overlord's skeleton", 
        "Mutant Stalker's skeleton", "Prof. Peter Ellison"},
    Event = {
        "Candy Cane","Scrap"
    }
}


local BringStuffGroup = menu:CreateCollapsibleGroup(Tabs.BringTab,"BRING STUFF v2",true,460)

-- Function to find all items of specific types
local function findAllItemsOfTypes(itemTypes)
    local foundItems = {}
    
    local function searchInContainer(container)
        for _, child in ipairs(container:GetDescendants()) do
            for _, itemType in ipairs(itemTypes) do
                if child.Name == itemType and child:IsA("Model") then
                    table.insert(foundItems, {
                        Model = child,
                        Path = child:GetFullName()
                    })
                end
            end
        end
    end
    
    searchInContainer(workspace)
    return foundItems
end

-- Function to teleport selected items from a category using remote events
local function teleportSelectedItems(category, teleportSpeed)
    -- Ensure teleportSpeed is a valid number
    if not teleportSpeed or type(teleportSpeed) ~= "number" then
        teleportSpeed = 1.0 -- Default speed
    end
    
    teleportSpeed = math.max(0.1, teleportSpeed) -- Ensure minimum speed
    
    local itemsToTeleport = selectedItems[category]
    if #itemsToTeleport == 0 then
        print("❌ No items selected in " .. category .. " category")
        return 0
    end
    
    local targetPosition = teleportLocations[category]
    if not targetPosition then
        print("❌ No teleport location set for " .. category)
        return 0
    end
    
    local allItems = findAllItemsOfTypes(itemsToTeleport)
    local teleportedCount = 0
    
    print("🔍 Found " .. #allItems .. " " .. category .. " items to teleport")
    
    if #allItems > 0 then
        for i, itemData in ipairs(allItems) do
            local success = teleportItemUsingRemoteEvents(itemData.Model, targetPosition)
            
            if success then
                teleportedCount += 1
                print("✅ [" .. i .. "/" .. #allItems .. "] Teleported: " .. itemData.Path)
            else
                warn("❌ Error teleporting: " .. itemData.Path)
            end
            
            wait(0.1 / (teleportSpeed * 10)) -- Use slider value to control speed (0.1x to 10x)
        end
    end
    
    return teleportedCount
end

-- Create combos for each category
for category, items in pairs(categorizedItems) do
    BringStuffGroup:AddSeparator(category .. " Items")
    
    -- Get the default selections for this category
    local defaultSelections = selectedItems[category]
    
    -- Create multi-dropdown for the category with default selections
    BringStuffGroup:AddMultiDropdown("Select " .. category, items, defaultSelections, function(selections)
        selectedItems[category] = selections
        print("Selected " .. category .. ":", #selections, "items")
    end)
    
    -- Create combo for teleport functionality
    local comboName = category .. " Teleport"
    local combo = BringStuffGroup:AddCombo(comboName, 
        -- Toggle callback (set location)
        function(isToggled)
            if isToggled then
                -- Set teleport location to player's current position
                teleportLocations[category] = humanoidRootPart.Position + humanoidRootPart.CFrame.LookVector * 8
                createLocationMarker(category, teleportLocations[category])
                print("📍 " .. category .. " teleport location set at " .. tostring(teleportLocations[category]))
            else
                removeLocationMarker(category)
                print("📍 " .. category .. " teleport location removed")
            end
        end,
        -- Action 1 callback (teleport items)
        function()
            if not teleportLocations[category] then
                print("❌ Please set " .. category .. " teleport location first (toggle ON)")
                return
            end
            
            local combo = categoryCombos[comboName]
            if combo then
                local state = combo:GetState()
                -- FIX: Check if SliderValue exists and is a number
                local teleportSpeed = 1.0 -- Default speed
                
                if state and state.SliderValue and type(state.SliderValue) == "number" then
                    teleportSpeed = math.max(0.1, state.SliderValue)
                else
                    print("⚠️ Using default teleport speed (1.0)")
                end
                
                print("🚀 Teleporting " .. category .. " items to marked location...")
                local count = teleportSelectedItems(category, teleportSpeed)
                if count > 0 then
                    print("✅ Successfully teleported " .. count .. " " .. category .. " items")
                else
                    print("❌ No " .. category .. " items found or teleport failed")
                end
            else
                print("❌ Combo not found for " .. category)
            end
        end,
        -- Action 2 callback (reset location)
        function()
            removeLocationMarker(category)
            local combo = categoryCombos[comboName]
            if combo then
                combo:SetToggle(false)
            end
            print("🔄 " .. category .. " teleport location reset")
        end,
        false -- isPremium
    )
    
    -- Store combo reference
    categoryCombos[comboName] = combo
end

-- Original functions for mass teleport (kept for F3 functionality)
local itemTypesToTeleport = {}
for category, items in pairs(categorizedItems) do
    for _, item in ipairs(items) do
        table.insert(itemTypesToTeleport, item)
    end
end

local function findAllItemsOfType(itemType)
    local foundItems = {}
    
    local function searchInContainer(container)
        for _, child in ipairs(container:GetDescendants()) do
            if child.Name == itemType and child:IsA("Model") then
                table.insert(foundItems, {
                    Model = child,
                    Path = child:GetFullName()
                })
            end
        end
    end
    
    searchInContainer(workspace)
    return foundItems
end

local function teleportAllItemsOfTypeToPlayer(itemType)
    local allItems = findAllItemsOfType(itemType)
    local teleportedCount = 0
    
    if #allItems > 0 then
        for i, itemData in ipairs(allItems) do
            local targetPosition = humanoidRootPart.Position + humanoidRootPart.CFrame.LookVector * 5
            local success = teleportItemUsingRemoteEvents(itemData.Model, targetPosition)
            
            if success then
                teleportedCount += 1
            else
                warn("❌ Error teleporting: " .. itemData.Path)
            end
            
            wait(0.1) -- Delay to prevent rate limiting
        end
    end
    
    return teleportedCount
end

local function teleportAllItemsInMapToPlayer()
    local totalTeleported = 0
    local typeCounts = {}
    
    -- Refresh reference to lootPart
    lootPart = workspace.Loot:FindFirstChild("Part")
    if not lootPart then
        lootPart = createLootPart()
    end
    
    print("=== SEARCHING ENTIRE MAP FOR ITEMS ===")
    
    -- Teleport ALL items of each type from the entire map using remote events
    for _, itemType in ipairs(itemTypesToTeleport) do
        local count = teleportAllItemsOfTypeToPlayer(itemType)
        typeCounts[itemType] = count
        totalTeleported += count
        
        if count > 0 then
            print("✅ Found and teleported " .. count .. " " .. itemType .. "(s) using remote events")
        end
        
        wait(0.05)
    end
    
    -- Teleport lootPart to the same single point (no remote events needed for this)
    lootPart.CFrame = humanoidRootPart.CFrame + humanoidRootPart.CFrame.LookVector * 5 + Vector3.new(0, 2, 0)
    
    print("\n=== TELEPORTATION COMPLETE ===")
    print("🎯 ALL ITEMS TELEPORTED USING REMOTE EVENTS")
    print("📊 Total items teleported: " .. totalTeleported)
end

-- Connect to F3 key press
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F3 then
        teleportAllItemsInMapToPlayer()
    end
end)





--//////////////bring End






--[[
--Room
local ProjectRoom1Group = menu:CreateCollapsibleGroup(Tabs.ProjectTab,"BUILD ROOM 1",false,350)
local ProjectRoom2Group = menu:CreateCollapsibleGroup(Tabs.ProjectTab,"BUILD ROOM 2",false,350)
local ProjectRoom3Group = menu:CreateCollapsibleGroup(Tabs.ProjectTab,"BUILD ROOM 3",false,350)
local ProjectRoom4Group = menu:CreateCollapsibleGroup(Tabs.ProjectTab,"BUILD ROOM 4",false,350)
local ProjectRoom5Group = menu:CreateCollapsibleGroup(Tabs.ProjectTab,"BUILD ROOM 5 (Coming Soon)",false,350)
-- Project requirements data organized by levels
local projectRequirements = {
    -- LEVEL 1 Projects
    ["Power Room"] = {
        projectName = "Power Room0",
        items = {
            {name = "Heavy Gear", count = 1},
            {name = "Toolbox", count = 1},
            {name = "Bolt", count = 1}
        },
        buildZonePath = "workspace.Projects.Power Room0.BuildZone"
    },
    ["Sales Room"] = {
        projectName = "Sales Room1", 
        items = {
            {name = "Nut", count = 1},
            {name = "Steel Panel", count = 1},
            {name = "Light Gear", count = 1},
            {name = "Bolt", count = 1},
            {name = "Cinder Block", count = 1}
        },
        buildZonePath = "workspace.Projects.Sales Room1.BuildZone"
    },
    ["Vacant Room"] = {
        projectName = "Vacant Room2",
        items = {
            {name = "Metal Sheet", count = 1},
            {name = "Tire", count = 1},
            {name = "Traffic Cone", count = 1},
            {name = "Pallet", count = 1},
            {name = "Cinder Block", count = 1}
        },
        buildZonePath = "workspace.Projects.Vacant Room2.BuildZone"
    },
    ["Med Bay"] = {
        projectName = "Med Bay1",
        items = {
            {name = "Bandage", count = 2},
            {name = "Pallet", count = 1},
            {name = "Bolt", count = 1},
            {name = "First Aid Kit", count = 1},
            {name = "Cinder Block", count = 1}
        },
        buildZonePath = "workspace.Projects.Med Bay1.BuildZone"
    },
    ["Food Pantry"] = {
        projectName = "Food Pantry2",
        items = {
            {name = "Jar of Dirt", count = 1},
            {name = "Cooking Pot", count = 1},
            {name = "Beans", count = 1},
            {name = "Pallet", count = 1},
            {name = "Tire", count = 1}
        },
        buildZonePath = "workspace.Projects.Food Pantry2.BuildZone"
    },
    
    -- LEVEL 2 Projects
    ["Recycling Room"] = {
        projectName = "Recycling Room",
        items = {
            {name = "Battery Pack", count = 2},
            {name = "Metal Sheet", count = 1},
            {name = "Light Gear", count = 2},
            {name = "Sawblade", count = 2},
            {name = "Axle", count = 2}
        },
        buildZonePath = "workspace.Projects.Recycling Room.BuildZone"
    },
    ["Storage Room"] = {
        projectName = "Storage Room",
        items = {
            {name = "Toolbox", count = 1},
            {name = "Storage Rack", count = 1},
            {name = "Garage Shelf", count = 1},
            {name = "Pallet", count = 3},
            {name = "Cinder Block", count = 1}
        },
        buildZonePath = "workspace.Projects.Storage Room.BuildZone"
    },
    ["Filter Room"] = {
        projectName = "Filter Room",
        items = {
            {name = "Barbed Wire", count = 1},
            {name = "Toolbox", count = 1},
            {name = "Metal Sheet", count = 1},
            {name = "Heavy Gear", count = 1},
            {name = "Bike Tire", count = 2}
        },
        buildZonePath = "workspace.Projects.Filter Room.BuildZone"
    },
    ["Armory"] = {
        projectName = "Armory",
        items = {
            {name = "Sawblade", count = 1},
            {name = "Iron Bar", count = 1},
            {name = "Metal Sheet", count = 2},
            {name = "Shovel", count = 1},
            {name = "Pistol Ammo", count = 1}
        },
        buildZonePath = "workspace.Projects.Armory.BuildZone"
    },
    
    -- LEVEL 3 Projects
    ["Boller Room"] = {
        projectName = "Boller Room",
        items = {
            {name = "Fusion Core", count = 1},
            {name = "Steel Panel", count = 3},
            {name = "Gold Bar", count = 1},
            {name = "Coil", count = 1},
            {name = "Iron Bar", count = 3},
        },
        buildZonePath = "workspace.Projects.Boller Room.BuildZone"
    },
    ["Stairwell"] = {
        projectName = "Stairwell",
        items = {
            {name = "Steel Panel", count = 1},
            {name = "Light Gear", count = 2},
            {name = "Coil", count = 1},
            {name = "Iron Bar", count = 1},
            {name = "Axle", count = 1},
        },
        buildZonePath = "workspace.Projects.Stairwell.BuildZone"
    },
    ["Big Room"] = {
        projectName = "Big Room",
        items = {
            {name = "Steel Panel", count = 3},
            {name = "Heavy Gear", count = 2},
            {name = "Tire", count = 2},
            {name = "Pallet", count = 3},
            {name = "Cinder Block", count = 3},
        },
        buildZonePath = "workspace.Projects.Big Room.BuildZone"
    },
    
    -- LEVEL 4 Projects
    ["Data Room"] = {
        projectName = "Data Room",
        items = {
            {name = "Battery Pack", count = 2},
            {name = "Metal Sheet", count = 3},
            {name = "Neon Sign", count = 2},
            {name = "Light Gear", count = 4},
            {name = "Television", count = 1}
        },
        buildZonePath = "workspace.Projects.Data Room.BuildZone"
    },
    ["Pit Room"] = {
        projectName = "Pit Room",
        items = {
            {name = "Sawblade", count = 1},
            {name = "Iron Bar", count = 3},
            {name = "Coil", count = 2},
            {name = "Shovel", count = 1},
            {name = "Cinder Block", count = 2}
        },
        buildZonePath = "workspace.Projects.Pit Room.BuildZone"
    }
}

-- Store selected items for each project
local projectSelectedItems = {}
for projectName, projectData in pairs(projectRequirements) do
    projectSelectedItems[projectName] = {}
    for _, item in ipairs(projectData.items) do
        table.insert(projectSelectedItems[projectName], item.name)
    end
end

-- Function to find available items in the world
local function findAvailableItems(itemName, maxCount)
    local foundItems = {}
    local count = 0
    
    local function searchInContainer(container)
        for _, child in ipairs(container:GetDescendants()) do
            if child.Name == itemName and child:IsA("Model") and count < maxCount then
                table.insert(foundItems, {
                    Model = child,
                    Path = child:GetFullName()
                })
                count += 1
            end
            if count >= maxCount then break end
        end
    end
    
    searchInContainer(workspace)
    return foundItems
end

-- Function to get build zone position
local function getBuildZonePosition(buildZonePath)
    local success, buildZone = pcall(function()
        return game:GetService("Workspace"):FindFirstChild(buildZonePath, true)
    end)
    
    if success and buildZone then
        return buildZone.Position
    else
        -- Fallback to player position if build zone not found
        return humanoidRootPart.Position
    end
end

-- Function to get project progress and remaining items
local function getRemainingItems(projectData, selectedItemsList)
    local project = workspace.Projects:FindFirstChild(projectData.projectName)
    local remainingItems = {}
    
    if not project then
        print("❌ Project not found: " .. projectData.projectName)
        -- Return only selected items if project not found
        for _, itemReq in ipairs(projectData.items) do
            if table.find(selectedItemsList, itemReq.name) then
                table.insert(remainingItems, {
                    name = itemReq.name,
                    count = itemReq.count
                })
            end
        end
        return remainingItems
    end
    
    local progress = project:FindFirstChild("Progress")
    local currentComponent = project:FindFirstChild("CurrentComponent")
    
    if progress and currentComponent then
        local progressValue = progress.Value
        local currentComponentValue = currentComponent.Value
        
        print("📊 " .. projectData.projectName .. " Progress: " .. progressValue .. "%")
        print("🔧 Current Component: " .. currentComponentValue)
        
        -- If progress is 100%, no items needed
        if progressValue >= 100 then
            print("✅ Project already completed!")
            return {}
        end
        
        -- Return only selected items that are needed
        for _, itemReq in ipairs(projectData.items) do
            if table.find(selectedItemsList, itemReq.name) then
                table.insert(remainingItems, {
                    name = itemReq.name,
                    count = itemReq.count
                })
            end
        end
        
        return remainingItems
    else
        print("❌ Could not read progress for: " .. projectData.projectName)
        -- Return only selected items if progress can't be read
        for _, itemReq in ipairs(projectData.items) do
            if table.find(selectedItemsList, itemReq.name) then
                table.insert(remainingItems, {
                    name = itemReq.name,
                    count = itemReq.count
                })
            end
        end
        return remainingItems
    end
end

-- Function to teleport items for a specific project using remote events
local function teleportProjectItems(projectData, selectedItemsList)
    print("🚀 Starting project: " .. projectData.projectName)
    
    local buildZonePos = getBuildZonePosition(projectData.buildZonePath)
    local totalTeleported = 0
    
    -- Get remaining items needed (with automatic progress check)
    local remainingItems = getRemainingItems(projectData, selectedItemsList)
    
    if #remainingItems == 0 then
        print("✅ No items needed - project may be completed or no items selected!")
        return 0
    end
    
    print("📋 Remaining items needed:")
    for _, itemReq in ipairs(remainingItems) do
        print("   - " .. itemReq.count .. "x " .. itemReq.name)
    end
    
    -- Teleport each remaining item type using remote events
    for _, itemReq in ipairs(remainingItems) do
        local itemName = itemReq.name
        local requiredCount = itemReq.count
        
        print("🔍 Looking for " .. requiredCount .. " " .. itemName .. "(s)")
        
        local availableItems = findAvailableItems(itemName, requiredCount)
        local teleportedCount = 0
        
        if #availableItems > 0 then
            for i, itemData in ipairs(availableItems) do
                if teleportedCount < requiredCount then
                    -- Calculate position with some spacing
                    local offset = Vector3.new(
                        math.random(-3, 3),
                        0,  -- Same height as player
                        math.random(-3, 3)
                    )
                    local targetPosition = buildZonePos + offset
                    
                    local success = teleportItemUsingRemoteEvents(itemData.Model, targetPosition)
                    
                    if success then
                        teleportedCount += 1
                        totalTeleported += 1
                        print("✅ Teleported " .. itemName .. " to project")
                    else
                        warn("❌ Error teleporting: " .. itemData.Path)
                    end
                    
                    wait(0.1) -- Small delay to prevent rate limiting
                else
                    break
                end
            end
        end
        
        if teleportedCount > 0 then
            print("✅ Teleported " .. teleportedCount .. "/" .. requiredCount .. " " .. itemName)
        else
            print("❌ No " .. itemName .. " found (needed: " .. requiredCount .. ")")
        end
    end
    
    print("🎯 Project " .. projectData.projectName .. " items teleported using remote events!")
    print("📦 Total items teleported: " .. totalTeleported)
    
    return totalTeleported
end

-- Function to check project progress with detailed info
local function checkProjectProgress(projectData, selectedItemsList)
    local project = workspace.Projects:FindFirstChild(projectData.projectName)
    
    if project then
        local progress = project:FindFirstChild("Progress")
        local currentComponent = project:FindFirstChild("CurrentComponent")
        local projectNameObj = project:FindFirstChild("ProjectName")
        
        if progress then
            print("📊 " .. projectData.projectName .. " Progress: " .. tostring(progress.Value) .. "%")
        else
            print("❌ Progress not found for: " .. projectData.projectName)
        end
        
        if currentComponent then
            print("🔧 Current Component: " .. tostring(currentComponent.Value))
        end
        
        if projectNameObj then
            print("🏠 Project Name: " .. tostring(projectNameObj.Value))
        end
        
        -- Show remaining items (only selected ones)
        local remainingItems = getRemainingItems(projectData, selectedItemsList)
        if #remainingItems > 0 then
            print("📋 Remaining items needed:")
            for _, itemReq in ipairs(remainingItems) do
                print("   - " .. itemReq.count .. "x " .. itemReq.name)
            end
        else
            print("✅ Project completed or no items needed!")
        end
    else
        print("❌ Project not found: " .. projectData.projectName)
    end
end

-- Create UI for each project organized by levels
ProjectRoom1Group:AddSeparator("🎯 LEVEL 1 PROJECTS")

-- Level 1 Projects
local level1Projects = {"Power Room", "Sales Room", "Vacant Room", "Med Bay", "Food Pantry"}
for _, projectName in ipairs(level1Projects) do
    local projectData = projectRequirements[projectName]
    if projectData then
        ProjectRoom1Group:AddSeparator(projectName)
        
        -- Get all item names for this project
        local projectItemNames = {}
        for _, item in ipairs(projectData.items) do
            table.insert(projectItemNames, item.name)
        end
        
        -- Create teleport button with automatic progress check
        ProjectRoom1Group:AddButton("TP Materials to " .. projectName, function()
            print("\n=== CHECKING " .. projectName:upper() .. " PROGRESS ===")
            teleportProjectItems(projectData, projectSelectedItems[projectName])
        end)
        
        -- Create multi-dropdown for item selection (default all selected)
        ProjectRoom1Group:AddMultiDropdown("Select " .. projectName .. " Items", projectItemNames, projectItemNames, function(selections)
            projectSelectedItems[projectName] = selections
            print("Selected " .. projectName .. " items:", selections)
        end)
    end
end

ProjectRoom2Group:AddSeparator("🎯 LEVEL 2 PROJECTS")

-- Level 2 Projects
local level2Projects = {"Recycling Room", "Storage Room", "Filter Room", "Armory"}
for _, projectName in ipairs(level2Projects) do
    local projectData = projectRequirements[projectName]
    if projectData then
        ProjectRoom2Group:AddSeparator(projectName)
        
        -- Get all item names for this project
        local projectItemNames = {}
        for _, item in ipairs(projectData.items) do
            table.insert(projectItemNames, item.name)
        end
        
        -- Create teleport button with automatic progress check
        ProjectRoom2Group:AddButton("TP Materials to " .. projectName, function()
            print("\n=== CHECKING " .. projectName:upper() .. " PROGRESS ===")
            teleportProjectItems(projectData, projectSelectedItems[projectName])
        end)
        
        -- Create multi-dropdown for item selection (default all selected)
        ProjectRoom2Group:AddMultiDropdown("Select " .. projectName .. " Items", projectItemNames, projectItemNames, function(selections)
            projectSelectedItems[projectName] = selections
            print("Selected " .. projectName .. " items:", selections)
        end)
    end
end

ProjectRoom3Group:AddSeparator("🎯 LEVEL 3 PROJECTS")

-- Level 3 Projects
local level3Projects = {"Boller Room", "Stairwell", "Big Room"}
for _, projectName in ipairs(level3Projects) do
    local projectData = projectRequirements[projectName]
    if projectData then
        ProjectRoom3Group:AddSeparator(projectName)
        
        -- Get all item names for this project
        local projectItemNames = {}
        for _, item in ipairs(projectData.items) do
            table.insert(projectItemNames, item.name)
        end
        
        -- Create teleport button with automatic progress check
        ProjectRoom3Group:AddButton("TP Materials to " .. projectName, function()
            print("\n=== CHECKING " .. projectName:upper() .. " PROGRESS ===")
            teleportProjectItems(projectData, projectSelectedItems[projectName])
        end)
        
        -- Create multi-dropdown for item selection (default all selected)
        ProjectRoom3Group:AddMultiDropdown("Select " .. projectName .. " Items", projectItemNames, projectItemNames, function(selections)
            projectSelectedItems[projectName] = selections
            print("Selected " .. projectName .. " items:", selections)
        end)
    end
end

-- ProjectRoom4Group:AddSeparator("🎯 LEVEL 4 PROJECTS")

-- Level 4 Projects
local level4Projects = {"Data Room", "Pit Room"}
for _, projectName in ipairs(level4Projects) do
    local projectData = projectRequirements[projectName]
    if projectData then
        ProjectRoom4Group:AddSeparator(projectName)
        
        -- Get all item names for this project
        local projectItemNames = {}
        for _, item in ipairs(projectData.items) do
            table.insert(projectItemNames, item.name)
        end
        
        -- Create teleport button with automatic progress check
        ProjectRoom4Group:AddButton("TP Materials to " .. projectName, function()
            print("\n=== CHECKING " .. projectName:upper() .. " PROGRESS ===")
            teleportProjectItems(projectData, projectSelectedItems[projectName])
        end)
        
        -- Create multi-dropdown for item selection (default all selected)
        ProjectRoom4Group:AddMultiDropdown("Select " .. projectName .. " Items", projectItemNames, projectItemNames, function(selections)
            projectSelectedItems[projectName] = selections
            print("Selected " .. projectName .. " items:", selections)
        end)
    end
end

-- Categorized items
local categorizedItems = {
    Food = {
        "Apple", "Banana", "Beans", "Candy", "Canned Ham", "Canned Tuna", 
        "Cereal Box", "Chocolate Bar", "Conk", "Cranzo", "Jolto", "Lotizz", 
        "Spire", "Water Bottle", "Water Jug"
    },
    Item = {
        "Axle", "Battery", "Battery Pack", "Bolt", "Cinder Block", 
        "Cooking Pot", "Coil", "Cup", "Fizzixs", "Floor Lamp", 
        "Fusion Core", "Gold Bar", "Heavy Gear", "Jar of Dirt", 
        "Light Gear", "Metal Sheet", "Money", "Pumpkin", 
        "Rusty Pipe", "Scrap", "Shoe", "Silver Bar", "Toolbox","Television"
    },
    Weapon = {
        "Cultist Knife", "Fireaxe", "Iron Bar", "Knife", "Pistol Ammo", 
        "Repair Hammer", "Rifle Ammo", "Sawblade", "Shotgun Ammo", 
        "Shovel", "Sledgehammer", "Worn Cultist Knife", "Worn Fireaxe", 
        "Worn M1911", "Worn Revolver", "Worn Sawn-Off"
    },
    Materials = {
        "Barbed Wire", "Bike Tire", "Blue Couch", "Bunk Beds", "Chair", 
        "Classic Bookshelf", "Coffee Table", "Compact Bookshelf", 
        "Dinner Table", "Divided Bookshelf", "Double Bed", "Double Door", 
        "Garage Shelf", "Glass Panel", "Neon Sign", "Office Desk", 
        "Open Bookshelf", "Pallet", "Prison Bed", "Red Couch", 
        "Square Table", "Steel Panel", "Storage Rack", "Tire", 
        "Traffic Cone", "Wooden Spikes", "Yellow Couch","Television"
    },
    Aid = {
        "Bandage", "First Aid Kit", "Large Medkit", "Military Medkit", 
        "Revive Serum", "Vitamins"
    },
    Others = {
        "Dr. Anne Miller", "Dr. Walter Hayes", "Mutant Beast's skeleton", 
        "Mutant Brute's skeleton", "Mutant Overlord's skeleton", 
        "Mutant Stalker's skeleton", "Prof. Peter Ellison"
    },
    Event = {
        "Candy Cane","Scrap"
    }
}

]]
local EspSettingsGroup = menu:CreateCollapsibleGroup(Tabs.visualTab,"GENERAL ESP SETTINGS",true,100)
local EspCateGroup = menu:CreateCollapsibleGroup(Tabs.visualTab,"ESP ALL",true,400)

-- Store ESP settings and selections for each category (all enabled by default with all items selected)
local espSettings = {
    Food = { enabled = false, selectedItems = {"Apple", "Banana", "Beans", "Candy", "Canned Ham", "Canned Tuna", 
        "Cereal Box", "Chocolate Bar", "Conk", "Cranzo", "Jolto", "Lotizz", 
        "Spire", "Water Bottle", "Water Jug"} },
    Item = { enabled = false, selectedItems = {"Axle", "Battery", "Battery Pack", "Bolt", "Cinder Block", 
        "Cooking Pot", "Coil", "Cup", "Fizzixs", "Floor Lamp", 
        "Fusion Core", "Gold Bar", "Heavy Gear", "Jar of Dirt", 
        "Light Gear", "MRE", "Metal Sheet", "Money", "Pumpkin", 
        "Rusty Pipe", "Scrap", "Shoe", "Silver Bar", "Toolbox","Television"} },
    Weapon = { enabled = false, selectedItems = {"Cultist Knife", "Fireaxe", "Iron Bar", "Knife", "Pistol Ammo", 
        "Repair Hammer", "Rifle Ammo", "Sawblade", "Shotgun Ammo", 
        "Shovel", "Sledgehammer", "Worn Cultist Knife", "Worn Fireaxe", 
        "Worn M1911", "Worn Revolver", "Worn Sawn-Off"} },
    Materials = { enabled = false, selectedItems = {"Barbed Wire", "Bike Tire", "Blue Couch", "Bunk Beds", "Chair", 
        "Classic Bookshelf", "Coffee Table", "Compact Bookshelf", 
        "Dinner Table", "Divided Bookshelf", "Double Bed", "Double Door", 
        "Garage Shelf", "Glass Panel", "Neon Sign", "Office Desk", 
        "Open Bookshelf", "Pallet", "Prison Bed", "Red Couch", 
        "Square Table", "Steel Panel", "Storage Rack", "Tire", 
        "Traffic Cone", "Wooden Spikes", "Yellow Couch", "Television"} },
    Aid = { enabled = false, selectedItems = {"Bandage", "First Aid Kit", "Large Medkit", "Military Medkit", 
        "Revive Serum", "Vitamins"} },
    Others = { enabled = false, selectedItems = {"Dr. Anne Miller", "Dr. Walter Hayes", "Mutant Beast's skeleton", 
        "Mutant Brute's skeleton", "Mutant Overlord's skeleton", 
        "Mutant Stalker's skeleton", "Prof. Peter Ellison"} },
    Event = {enable = false, selectedItems = {"Candy Cane","Scrap"}}
}

-- Global ESP settings (common to all categories)
local globalEspSettings = {
    maxDistance = 500,
    showDistance = true,
    showLines = true,
    colors = {
        Food = Color3.fromRGB(0, 255, 0),        -- Green
        Item = Color3.fromRGB(255, 165, 0),      -- Orange
        Weapon = Color3.fromRGB(255, 0, 0),      -- Red
        Materials = Color3.fromRGB(0, 191, 255), -- Blue
        Aid = Color3.fromRGB(255, 255, 0),       -- Yellow
        Others = Color3.fromRGB(255, 0, 255)     -- Magenta
    }
}

-- Store ESP objects
local espObjects = {}

-- Function to create ESP for an item
local function createESP(item, category)
    if not item or not item:FindFirstChild("Handle") then return end
    
    local handle = item.Handle
    local itemName = item.Name
    
    -- Remove existing ESP if it exists
    if espObjects[item] then
        espObjects[item]:Remove()
        espObjects[item] = nil
    end
    
    -- Create BillboardGui for name and distance (smaller size)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_" .. itemName
    billboard.Adornee = handle
    billboard.Size = UDim2.new(0, 150, 0, 30) -- Smaller size
    billboard.StudsOffset = Vector3.new(0, 2.5, 0) -- Slightly lower offset
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = globalEspSettings.maxDistance
    
    -- Create background frame
    local background = Instance.new("Frame")
    background.Name = "Background"
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.new(0, 0, 0)
    background.BackgroundTransparency = 0.3
    background.BorderSizePixel = 0
    
    -- Create UIListLayout for text organization
    local listLayout = Instance.new("UIListLayout")
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    listLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    -- Create name label (smaller text)
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, 0, 0.6, 0) -- Smaller height
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = itemName
    nameLabel.TextColor3 = globalEspSettings.colors[category]
    nameLabel.TextScaled = true
    nameLabel.TextSize = 12 -- Smaller text size
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    nameLabel.TextStrokeTransparency = 0
    
    -- Create distance label (smaller text)
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Name = "DistanceLabel"
    distanceLabel.Size = UDim2.new(1, 0, 0.4, 0) -- Smaller height
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.Text = "0m"
    distanceLabel.TextColor3 = Color3.new(1, 1, 1)
    distanceLabel.TextScaled = true
    distanceLabel.TextSize = 10 -- Smaller text size
    distanceLabel.Font = Enum.Font.Gotham
    distanceLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distanceLabel.TextStrokeTransparency = 0
    distanceLabel.Visible = globalEspSettings.showDistance
    
    -- Assemble the billboard
    background.Parent = billboard
    listLayout.Parent = background
    nameLabel.Parent = background
    distanceLabel.Parent = background
    billboard.Parent = game.CoreGui
    
    -- Create line to item if enabled
    local line
    if globalEspSettings.showLines then
        line = Instance.new("LineHandleAdornment")
        line.Name = "ESP_Line_" .. itemName
        line.Adornee = handle
        line.Length = 0
        line.Thickness = 1.5 -- Slightly thinner line
        line.Color3 = globalEspSettings.colors[category]
        line.ZIndex = 1
        line.AlwaysOnTop = true
        line.Parent = handle
    end
    
    -- Store ESP object
    espObjects[item] = {
        billboard = billboard,
        line = line,
        category = category
    }
    
    return billboard
end

-- Function to update ESP
local function updateESP()
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local playerPosition = humanoidRootPart.Position
    
    for item, espData in pairs(espObjects) do
        local categorySettings = espSettings[espData.category]
        
        if item.Parent and item:FindFirstChild("Handle") and categorySettings.enabled then
            local handle = item.Handle
            local distance = (handle.Position - playerPosition).Magnitude
            
            -- Update distance label
            if espData.billboard and espData.billboard:FindFirstChild("Background") then
                local background = espData.billboard.Background
                local distanceLabel = background:FindFirstChild("DistanceLabel")
                if distanceLabel then
                    distanceLabel.Text = string.format("%.1fm", distance)
                    distanceLabel.Visible = globalEspSettings.showDistance
                end
            end
            
            -- Update line
            if globalEspSettings.showLines and espData.line then
                espData.line.Length = distance
                espData.line.CFrame = CFrame.lookAt(humanoidRootPart.Position, handle.Position)
                espData.line.Visible = true
            elseif espData.line then
                espData.line.Visible = false
            end
            
            -- Show/hide based on distance and category enabled state
            if distance > globalEspSettings.maxDistance or not categorySettings.enabled then
                espData.billboard.Enabled = false
                if espData.line then
                    espData.line.Visible = false
                end
            else
                espData.billboard.Enabled = true
            end
        else
            -- Item no longer exists or category disabled, remove ESP
            if espData.billboard then
                espData.billboard:Destroy()
            end
            if espData.line then
                espData.line:Destroy()
            end
            espObjects[item] = nil
        end
    end
end

-- Function to scan for items and create ESP
local function scanForItems()
    -- Clear existing ESP for items that no longer exist or categories are disabled
    for item, espData in pairs(espObjects) do
        if not item.Parent or not espSettings[espData.category].enabled then
            if espData.billboard then
                espData.billboard:Destroy()
            end
            if espData.line then
                espData.line:Destroy()
            end
            espObjects[item] = nil
        end
    end
    
    -- Scan workspace for items
    for category, settings in pairs(espSettings) do
        if settings.enabled and #settings.selectedItems > 0 then
            for _, itemName in ipairs(settings.selectedItems) do
                local foundItems = workspace:GetDescendants()
                for _, item in ipairs(foundItems) do
                    if item.Name == itemName and item:IsA("Model") and item:FindFirstChild("Handle") then
                        -- Check if ESP already exists for this item
                        local alreadyHasESP = false
                        for existingItem in pairs(espObjects) do
                            if existingItem == item then
                                alreadyHasESP = true
                                break
                            end
                        end
                        
                        if not alreadyHasESP then
                            createESP(item, category)
                        end
                    end
                end
            end
        end
    end
end

-- Function to toggle category ESP
local function toggleCategoryESP(category, enabled)
    espSettings[category].enabled = enabled
    
    if not enabled then
        -- Remove ESP objects for this category
        for item, espData in pairs(espObjects) do
            if espData.category == category then
                if espData.billboard then
                    espData.billboard:Destroy()
                end
                if espData.line then
                    espData.line:Destroy()
                end
                espObjects[item] = nil
            end
        end
        print("❌ " .. category .. " ESP Disabled")
    else
        -- Start scanning for this category
        print("✅ " .. category .. " ESP Enabled")
        scanForItems()
    end
end

-- Function to update global ESP settings
local function updateGlobalESPSettings()
    -- Update all existing ESP objects with new global settings
    for item, espData in pairs(espObjects) do
        if espData.billboard and espData.billboard:FindFirstChild("Background") then
            local background = espData.billboard.Background
            local distanceLabel = background:FindFirstChild("DistanceLabel")
            if distanceLabel then
                distanceLabel.Visible = globalEspSettings.showDistance
            end
        end
        
        if espData.line then
            espData.line.Visible = globalEspSettings.showLines
        end
    end
    
    -- Rescan to apply max distance changes
    scanForItems()
end


-- Max Distance Slider
EspSettingsGroup:AddSlider("Max Distance", 50, 1000, 500, function(value)
    globalEspSettings.maxDistance = value
    updateGlobalESPSettings()
end)

-- Settings multi-dropdown for common settings
local settingsOptions = {"Distance", "Line"}
EspSettingsGroup:AddMultiDropdown("ESP Settings", settingsOptions, {"Distance", "Line"}, function(selections)
    -- Update global settings based on selections
    globalEspSettings.showDistance = table.find(selections, "Distance") ~= nil
    globalEspSettings.showLines = table.find(selections, "Line") ~= nil
    
    print("Global ESP Settings updated:")
    print("  - Show Distance: " .. tostring(globalEspSettings.showDistance))
    print("  - Show Lines: " .. tostring(globalEspSettings.showLines))
    
    updateGlobalESPSettings()
end)


for category, items in pairs(categorizedItems) do
    EspCateGroup:AddSeparator( category .. " ESP")
    
    -- Individual category toggle with correct default state
    EspCateGroup:AddToggle("Enable " .. category .. " ESP", espSettings[category].enabled, function(state)
        toggleCategoryESP(category, state)
    end)
    
    -- Item selection multi-dropdown for the category with default selections
    EspCateGroup:AddMultiDropdown("Select " .. category .. " Items", items, espSettings[category].selectedItems, function(selections)
        espSettings[category].selectedItems = selections
        print("Selected " .. category .. " items:", #selections, "items")
        
        -- Update ESP if category is enabled
        if espSettings[category].enabled then
            scanForItems()
        end
    end)
    

  
end

-- Run ESP update loop
RunService.Heartbeat:Connect(function()
    updateESP()
end)

-- Auto-scan every 5 seconds AND on script start
spawn(function()
    -- Initial scan
    wait(2) -- Wait a bit for everything to load
    scanForItems()
    
    -- Periodic scans
    while true do
        wait(500)
        scanForItems()
    end
end)

print("🔍 ESP System Initialized - All categories enabled by default")

--==================Visual end=====================

--/////////////////////Local Player Start////////////////////
local PlayerVisualGroup = menu:CreateCollapsibleGroup(Tabs.PlayerTab,"PLAYER VISUAL",false,200)
local PlayerSpeedGroup = menu:CreateCollapsibleGroup(Tabs.PlayerTab,"PLAYER SPEED",true,150)
local PlayerModsGroup = menu:CreateCollapsibleGroup(Tabs.PlayerTab,"PLAYER MODS",false,200)


-- Store local player settings
local localPlayerSettings = {
    fov = {
        enabled = false,
        value = 70
    },
    speed = {
        enabled = false,
        value = 40
    },
    tpWalk = {
        enabled = false,
        value = 50
    },
    infiniteJump = false,
    noclip = false,
    hipHeight = {
        enabled = false,
        value = 6
    }
}

-- Store original values
local originalFOV = workspace.CurrentCamera.FieldOfView
local originalWalkSpeed = 16
local originalHipHeight = 0

-- Store current humanoid reference
local currentHumanoid = nil

-- FOV Changer Section
PlayerVisualGroup:AddSeparator("Field of View")

-- Monitor for FOV changes to maintain custom FOV
local fovConnection
local function setupFOVMonitoring()
    if fovConnection then
        fovConnection:Disconnect()
    end
    
    fovConnection = RunService.Heartbeat:Connect(function()
        if localPlayerSettings.fov.enabled then
            -- Constantly reapply the custom FOV to override any changes from running
            workspace.CurrentCamera.FieldOfView = localPlayerSettings.fov.value
        end
    end)
end

local fovToggle = PlayerVisualGroup:AddToggle("Enable FOV Changer", false, function(state)
    localPlayerSettings.fov.enabled = state
    if state then
        workspace.CurrentCamera.FieldOfView = localPlayerSettings.fov.value
        setupFOVMonitoring() -- Start monitoring when enabled
        print("✅ FOV Changer Enabled: " .. localPlayerSettings.fov.value)
    else
        if fovConnection then
            fovConnection:Disconnect()
        end
        workspace.CurrentCamera.FieldOfView = originalFOV
        print("❌ FOV Changer Disabled")
    end
end)

PlayerVisualGroup:AddSlider("FOV Value", 30, 120, 70, function(value)
    localPlayerSettings.fov.value = value
    if localPlayerSettings.fov.enabled then
        workspace.CurrentCamera.FieldOfView = value
    end
    print("📐 FOV Set to: " .. value)
end)

-- Player Speed Section
PlayerSpeedGroup:AddSeparator("Movement Speed")

-- Function to handle speed changes and prevent shift key interference
local function updatePlayerSpeed()
    if not currentHumanoid then return end
    
    if localPlayerSettings.speed.enabled then
        currentHumanoid.WalkSpeed = localPlayerSettings.speed.value
    else
        currentHumanoid.WalkSpeed = originalWalkSpeed
    end
end

-- Monitor for running state changes to maintain speed boost
local runningConnection
local function setupSpeedMonitoring()
    if runningConnection then
        runningConnection:Disconnect()
    end
    
    runningConnection = RunService.Heartbeat:Connect(function()
        if currentHumanoid and localPlayerSettings.speed.enabled then
            -- Constantly reapply the speed boost to override any changes from running
            currentHumanoid.WalkSpeed = localPlayerSettings.speed.value
        end
    end)
end

local speedToggle = PlayerSpeedGroup:AddToggle("Enable Speed Boost", false, function(state)
    localPlayerSettings.speed.enabled = state
    if currentHumanoid then
        if state then
            originalWalkSpeed = currentHumanoid.WalkSpeed
            currentHumanoid.WalkSpeed = localPlayerSettings.speed.value
            setupSpeedMonitoring() -- Start monitoring when enabled
            print("✅ Speed Boost Enabled: " .. localPlayerSettings.speed.value)
        else
            if runningConnection then
                runningConnection:Disconnect()
            end
            currentHumanoid.WalkSpeed = originalWalkSpeed
            print("❌ Speed Boost Disabled")
        end
    end
end)

PlayerSpeedGroup:AddSlider("Speed Value", 16, 100, 40, function(value)
    localPlayerSettings.speed.value = value
    if localPlayerSettings.speed.enabled and currentHumanoid then
        currentHumanoid.WalkSpeed = value
    end
    print("🏃 Speed Set to: " .. value)
end)

-- Hip Height Section
PlayerModsGroup:AddSeparator("Hip Height")

local hipHeightToggle = PlayerModsGroup:AddToggle("Enable Hip Height", false, function(state)
    localPlayerSettings.hipHeight.enabled = state
    if currentHumanoid then
        if state then
            originalHipHeight = currentHumanoid.HipHeight
            currentHumanoid.HipHeight = localPlayerSettings.hipHeight.value
            print("✅ Hip Height Enabled: " .. localPlayerSettings.hipHeight.value)
        else
            currentHumanoid.HipHeight = originalHipHeight
            print("❌ Hip Height Disabled")
        end
    end
end)

PlayerModsGroup:AddSlider("Hip Height Value", 0, 50, 10, function(value)
    localPlayerSettings.hipHeight.value = value
    if localPlayerSettings.hipHeight.enabled and currentHumanoid then
        currentHumanoid.HipHeight = value
    end
    print("📏 Hip Height Set to: " .. value)
end)

-- Infinite Jump Section
PlayerModsGroup:AddSeparator("USEFULL FEATURES")

local infiniteJumpToggle = PlayerModsGroup:AddToggle("Enable Infinite Jump", false, function(state)
    localPlayerSettings.infiniteJump = state
    if state then
        print("✅ Infinite Jump Enabled")
    else
        print("❌ Infinite Jump Disabled")
    end
end)

-- Infinite Jump functionality
local infiniteJumpConnection
local function setupInfiniteJump()
    if infiniteJumpConnection then
        infiniteJumpConnection:Disconnect()
    end
    
    infiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
        if localPlayerSettings.infiniteJump and currentHumanoid then
            currentHumanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

-- Initialize Infinite Jump
setupInfiniteJump()

-- Noclip Section
local noclipToggle = PlayerModsGroup:AddToggle("Enable Noclip", false, function(state)
    localPlayerSettings.noclip = state
    if state then
        print("✅ Noclip Enabled")
    else
        print("❌ Noclip Disabled")
    end
end)

-- Noclip functionality
local noclipConnection
local function setupNoclip()
    if noclipConnection then
        noclipConnection:Disconnect()
    end
    
    noclipConnection = RunService.Stepped:Connect(function()
        if localPlayerSettings.noclip and player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end)
end

-- Initialize Noclip
setupNoclip()

-- Function to initialize character settings
local function initializeCharacter(character)
    -- Wait for humanoid to be available
    repeat wait() until character:FindFirstChildOfClass("Humanoid")
    
    currentHumanoid = character:FindFirstChildOfClass("Humanoid")
    originalWalkSpeed = currentHumanoid.WalkSpeed
    originalHipHeight = currentHumanoid.HipHeight
    
    -- Reapply settings if they were enabled
    if localPlayerSettings.fov.enabled then
        workspace.CurrentCamera.FieldOfView = localPlayerSettings.fov.value
        setupFOVMonitoring() -- Restart FOV monitoring
    end
    
    if localPlayerSettings.speed.enabled then
        currentHumanoid.WalkSpeed = localPlayerSettings.speed.value
        setupSpeedMonitoring() -- Restart speed monitoring
    end
    
    if localPlayerSettings.hipHeight.enabled then
        currentHumanoid.HipHeight = localPlayerSettings.hipHeight.value
    end
    
    -- Re-setup connections
    setupInfiniteJump()
    setupNoclip()
    
    print("🔄 Local Player settings reapplied to new character")
end

-- Handle character respawns
player.CharacterAdded:Connect(function(character)
    initializeCharacter(character)
end)

-- Initialize current character if already exists
if player.Character then
    initializeCharacter(player.Character)
end


print("🎮 Local Player tab loaded successfully!")
print("📋 Features: FOV, Speed, Hip Height, Infinite Jump, Noclip")
--====================Local Player end ===========================

-- Auto Complete Room Feature - SIMPLIFIED WORKING VERSION
local AutoCompleteGroup = menu:CreateCollapsibleGroup(Tabs.ProjectTab, "AUTO COMPLETE ROOM", true, 200)

-- Auto Complete Room Settings
local autoCompleteEnabled = false
local activeTasks = {}
local cachedBuildZones = {}
local teleportQueue = {}

-- Performance Settings
local autoCompleteMode = "Fast"
local modeSettings = {
    Fast = {
        checkInterval = 1,
        teleportWait = 0.2,
        retryWait = 0.1,
        maxAttempts = 10
    },
    Medium = {
        checkInterval = 3,
        teleportWait = 0.5,
        retryWait = 0.3,
        maxAttempts = 8
    },
    Slow = {
        checkInterval = 5,
        teleportWait = 1,
        retryWait = 0.5,
        maxAttempts = 5
    }
}

-- Simple function to find BuildZones
local function findBuildZones()
    local buildZones = {}
    local bunker = workspace:FindFirstChild("Bunker")
    
    if bunker then
        for _, room in ipairs(bunker:GetChildren()) do
            local function searchForBuildZones(object)
                if object.Name == "BuildZone" then
                    local touchPart = object:FindFirstChild("Touch")
                    if touchPart then
                        table.insert(buildZones, {
                            TouchPart = touchPart,
                            Position = touchPart.Position,
                            TriedCount = 0
                        })
                    end
                end
                
                for _, child in ipairs(object:GetChildren()) do
                    searchForBuildZones(child)
                end
            end
            
            searchForBuildZones(room)
        end
    end
    
    return buildZones
end

-- Simple function to teleport item
local function teleportItemToBuildZone(itemModel, buildZoneData)
    if not itemModel or not itemModel:IsA("Model") then
        return false
    end
    
    local success = false
    
    -- Try to drag item
    local dragSuccess, dragResult = pcall(function()
        return RequestDrag:InvokeServer(itemModel)
    end)
    
    if dragSuccess then
        -- Teleport to build zone
        local teleportCFrame = CFrame.new(buildZoneData.Position + Vector3.new(0, 3, 0))
        
        if itemModel:IsA("Model") then
            itemModel:PivotTo(teleportCFrame)
        end
        
        wait(0.1)
        
        -- Release drag
        local releaseSuccess, releaseResult = pcall(function()
            ReleaseDrag:FireServer(itemModel)
        end)
        
        success = releaseSuccess
        if success then
            buildZoneData.TriedCount = buildZoneData.TriedCount + 1
        end
    end
    
    return success
end

-- Find items by name
local function findItemByName(itemName)
    for _, item in ipairs(workspace:GetDescendants()) do
        if item.Name == itemName and item:IsA("Model") then
            return item
        end
    end
    return nil
end

-- Main auto-complete function
local function autoCompleteProjects()
    if not autoCompleteEnabled then return 0 end
    
    local projectsFolder = workspace:FindFirstChild("Projects")
    if not projectsFolder then return 0 end
    
    local completedCount = 0
    local buildZones = findBuildZones()
    
    if #buildZones == 0 then
        print("No BuildZones found")
        return 0
    end
    
    -- Sort build zones by least tried
    table.sort(buildZones, function(a, b)
        return a.TriedCount < b.TriedCount
    end)
    
    for _, project in ipairs(projectsFolder:GetChildren()) do
        if not autoCompleteEnabled then break end
        
        local progress = project:FindFirstChild("Progress")
        local currentComponent = project:FindFirstChild("CurrentComponent")
        
        if progress and currentComponent and progress.Value < 100 then
            local neededItem = currentComponent.Value
            if neededItem and neededItem ~= "" then
                
                -- Find the item
                local item = findItemByName(neededItem)
                if item then
                    
                    -- Try multiple build zones
                    local mode = modeSettings[autoCompleteMode]
                    local maxTries = math.min(mode.maxAttempts, #buildZones)
                    
                    for i = 1, maxTries do
                        if not autoCompleteEnabled then break end
                        
                        local buildZone = buildZones[i]
                        local originalProgress = progress.Value
                        
                        local success = teleportItemToBuildZone(item, buildZone)
                        
                        if success then
                            wait(mode.teleportWait)
                            
                            -- Check if progress increased
                            if progress.Value > originalProgress then
                                completedCount = completedCount + 1
                                print("Successfully supplied: " .. neededItem)
                                break
                            end
                            
                            wait(mode.retryWait)
                        end
                    end
                end
            end
        end
    end
    
    return completedCount
end

-- Main loop
local function startAutoCompleteLoop()
    while autoCompleteEnabled do
        local success, result = pcall(autoCompleteProjects)
        
        if not success then
            warn("Auto-complete error: " .. tostring(result))
        end
        
        local mode = modeSettings[autoCompleteMode]
        wait(mode.checkInterval)
    end
end

-- Create the UI elements
AutoCompleteGroup:AddToggle("Enable Auto Complete", false, function(state)
    autoCompleteEnabled = state
    if state then
        print("Auto-complete enabled")
        spawn(startAutoCompleteLoop)
    else
        print("Auto-complete disabled")
    end
end)

AutoCompleteGroup:AddSeparator("Settings")

AutoCompleteGroup:AddDropdown("Mode", {"Fast", "Medium", "Slow"}, "Fast", function(selected)
    autoCompleteMode = selected
    print("Mode set to: " .. selected)
end)

AutoCompleteGroup:AddButton("Manual Check", function()
    if autoCompleteEnabled then
        print("Manual check triggered")
        autoCompleteProjects()
    else
        print("Enable Auto Complete first!")
    end
end)

AutoCompleteGroup:AddButton("Scan BuildZones", function()
    local zones = findBuildZones()
    print("Found " .. #zones .. " BuildZones")
end)

-- Status label
local statusLabel = AutoCompleteGroup:AddLabel("Status: Ready")
local modeLabel = AutoCompleteGroup:AddLabel("Mode: Fast")

-- Update status
spawn(function()
    while true do
        wait(2)
        if statusLabel and statusLabel.Instance then
            if autoCompleteEnabled then
                statusLabel.Instance.Text = "Status: Active"
                statusLabel.Instance.TextColor3 = Color3.fromRGB(0, 255, 0)
            else
                statusLabel.Instance.Text = "Status: Inactive"
                statusLabel.Instance.TextColor3 = Color3.fromRGB(255, 100, 100)
            end
        end
        
        if modeLabel and modeLabel.Instance then
            modeLabel.Instance.Text = "Mode: " .. autoCompleteMode
        end
    end
end)

print("Auto-complete feature loaded!")


-- Create the invisible group in PlayerTab
local invisibleGroup = menu:CreateCollapsibleGroup(Tabs.PlayerTab, "🎭 INVISIBLE SYSTEM", false, 200)
menu:MarkAsNew(invisibleGroup:GetInstance(), "NEW")

-- Invisible System Variables
local InvisibleSystem = {
    Enabled = false,
    Depth = 12,
    MinDepth = 1,
    MaxDepth = 500,
    VisualFade = 0.55,
    RestoreTime = 0.35,
    
    -- Internal states
    _restoring = false,
    _restoreToken = 0,
    _character = nil,
    _humanoid = nil,
    _hrp = nil,
    _trackedParts = {},
    _originalLTM = {},
    _connections = {},
    _didOffset = false,
    _originalCF = nil,
    _originalCam = nil,
    _descendantConn = nil,
    _lastActionTime = 0,
    _toolConnections = {}
}

-- Function to clear tracking
local function clearTracking()
    for part, prev in pairs(InvisibleSystem._originalLTM) do
        if part and part.Parent and part:IsA("BasePart") then
            part.LocalTransparencyModifier = prev
        end
    end
    table.clear(InvisibleSystem._trackedParts)
    table.clear(InvisibleSystem._originalLTM)
    if InvisibleSystem._descendantConn then
        InvisibleSystem._descendantConn:Disconnect()
        InvisibleSystem._descendantConn = nil
    end
end

-- Function to track character parts
local function trackPart(p)
    if not p:IsA("BasePart") then return end
    if InvisibleSystem._originalLTM[p] == nil then
        InvisibleSystem._originalLTM[p] = p.LocalTransparencyModifier
    end
    table.insert(InvisibleSystem._trackedParts, p)

    if InvisibleSystem.Enabled and not InvisibleSystem._restoring then
        p.LocalTransparencyModifier = InvisibleSystem.VisualFade
    end
end

-- Function to scan character
local function scanCharacter()
    clearTracking()
    
    local player = game.Players.LocalPlayer
    InvisibleSystem._character = player.Character or player.CharacterAdded:Wait()
    InvisibleSystem._humanoid = InvisibleSystem._character:WaitForChild("Humanoid")
    InvisibleSystem._hrp = InvisibleSystem._character:WaitForChild("HumanoidRootPart")

    for _, v in ipairs(InvisibleSystem._character:GetDescendants()) do
        if v:IsA("BasePart") then
            trackPart(v)
        end
    end

    -- Track new parts (gear/morph)
    InvisibleSystem._descendantConn = InvisibleSystem._character.DescendantAdded:Connect(function(inst)
        if inst:IsA("BasePart") then
            trackPart(inst)
        end
    end)
end

-- Function to apply visual transparency
local function applyVisual(state)
    for _, p in ipairs(InvisibleSystem._trackedParts) do
        if p and p.Parent then
            if state then
                p.LocalTransparencyModifier = InvisibleSystem.VisualFade
            else
                local prev = InvisibleSystem._originalLTM[p]
                p.LocalTransparencyModifier = (prev ~= nil) and prev or 0
            end
        end
    end
end

-- Function to temporarily restore visibility
local function tempRestore()
    if not InvisibleSystem.Enabled then return end

    InvisibleSystem._restoreToken = InvisibleSystem._restoreToken + 1
    local token = InvisibleSystem._restoreToken

    InvisibleSystem._restoring = true
    applyVisual(false)

    task.delay(InvisibleSystem.RestoreTime, function()
        if token ~= InvisibleSystem._restoreToken then return end
        InvisibleSystem._restoring = false
        if InvisibleSystem.Enabled then
            applyVisual(true)
        end
    end)
end

-- Function to mark action (triggers temporary restore)
local function markAction()
    InvisibleSystem._lastActionTime = os.clock()
    tempRestore()
end

-- Tool hook functions
local function clearToolHooks()
    for _, c in ipairs(InvisibleSystem._toolConnections) do
        pcall(function() c:Disconnect() end)
    end
    table.clear(InvisibleSystem._toolConnections)
end

local function hookTool(t)
    if not t:IsA("Tool") then return end
    if t:GetAttribute("__inv_hooked") then return end
    t:SetAttribute("__inv_hooked", true)

    table.insert(InvisibleSystem._toolConnections, t.Activated:Connect(function()
        if InvisibleSystem.Enabled then markAction() end
    end))
end

local function scanTools()
    clearToolHooks()

    local player = game.Players.LocalPlayer
    local backpack = player:FindFirstChildOfClass("Backpack")
    
    if backpack then
        for _, it in ipairs(backpack:GetChildren()) do
            if it:IsA("Tool") then hookTool(it) end
        end
        table.insert(InvisibleSystem._toolConnections, backpack.ChildAdded:Connect(function(it)
            if it:IsA("Tool") then hookTool(it) end
        end))
    end

    if InvisibleSystem._character then
        for _, it in ipairs(InvisibleSystem._character:GetChildren()) do
            if it:IsA("Tool") then hookTool(it) end
        end
        table.insert(InvisibleSystem._toolConnections, InvisibleSystem._character.ChildAdded:Connect(function(it)
            if it:IsA("Tool") then hookTool(it) end
        end))
    end
end

-- Animation hook
local function hookAnimations()
    if not InvisibleSystem._humanoid then return end
    
    table.insert(InvisibleSystem._connections, InvisibleSystem._humanoid.AnimationPlayed:Connect(function()
        if not InvisibleSystem.Enabled then return end
        -- only treat as action if very recent input/tool happened
        if (os.clock() - InvisibleSystem._lastActionTime) <= 0.25 then
            tempRestore()
        end
    end))
end

-- Main function to set invisible state
local function setInvisible(state)
    InvisibleSystem.Enabled = state
    
    if state then
        -- Initialize if not already
        if not InvisibleSystem._character then
            scanCharacter()
            scanTools()
            hookAnimations()
        end
        
        if not InvisibleSystem._restoring then
            applyVisual(true)
        end
        print("🎭 Invisible: ON")
    else
        applyVisual(false)
        print("🎭 Invisible: OFF")
    end
end

-- Set up the invisible system connections
local function setupInvisibleSystem()
    local UIS = game:GetService("UserInputService")
    local ProximityPromptService = game:GetService("ProximityPromptService")
    local RunService = game:GetService("RunService")
    
    -- ProximityPrompt hooks
    table.insert(InvisibleSystem._connections, ProximityPromptService.PromptButtonHoldBegan:Connect(function()
        if InvisibleSystem.Enabled then markAction() end
    end))
    
    table.insert(InvisibleSystem._connections, ProximityPromptService.PromptTriggered:Connect(function()
        if InvisibleSystem.Enabled then markAction() end
    end))
    
    -- Input hooks (mouse/E/F)
    table.insert(InvisibleSystem._connections, UIS.InputBegan:Connect(function(input, gp)
        if gp then return end
        
        -- Action detection
        if InvisibleSystem.Enabled then
            if input.UserInputType == Enum.UserInputType.MouseButton1 or
               input.KeyCode == Enum.KeyCode.E or
               input.KeyCode == Enum.KeyCode.F then
                markAction()
            end
        end
    end))
    
    -- Heartbeat for offset (moves character down)
    table.insert(InvisibleSystem._connections, RunService.Heartbeat:Connect(function()
        if not InvisibleSystem.Enabled or InvisibleSystem._restoring or 
           not InvisibleSystem._hrp or not InvisibleSystem._humanoid then
            return
        end

        InvisibleSystem._originalCF = InvisibleSystem._hrp.CFrame
        InvisibleSystem._originalCam = InvisibleSystem._humanoid.CameraOffset

        local charHeight = InvisibleSystem._hrp.Size.Y + (InvisibleSystem._humanoid.HipHeight * 2)
        local tempCF = InvisibleSystem._originalCF * CFrame.new(0, -(charHeight * InvisibleSystem.Depth), 0)

        -- Offset (client-owned HRP replicates -> server/NPC may lose target)
        InvisibleSystem._hrp.CFrame = tempCF

        -- Keep camera stable
        InvisibleSystem._humanoid.CameraOffset = tempCF:ToObjectSpace(InvisibleSystem._originalCF).Position

        InvisibleSystem._didOffset = true
    end))
    
    -- RenderStepped for restore (brings character back up visually)
    table.insert(InvisibleSystem._connections, RunService.RenderStepped:Connect(function()
        if not InvisibleSystem._didOffset then return end

        -- If char changed mid-frame, just try to restore safely
        if InvisibleSystem._hrp and InvisibleSystem._originalCF then
            InvisibleSystem._hrp.CFrame = InvisibleSystem._originalCF
        end
        if InvisibleSystem._humanoid and InvisibleSystem._originalCam then
            InvisibleSystem._humanoid.CameraOffset = InvisibleSystem._originalCam
        end

        InvisibleSystem._didOffset = false
    end))
    
    -- Character added event
    table.insert(InvisibleSystem._connections, game.Players.LocalPlayer.CharacterAdded:Connect(function()
        setInvisible(false)
        task.wait(0.35)
        scanCharacter()
        scanTools()
        hookAnimations()
    end))
end

-- Cleanup function
local function cleanupInvisibleSystem()
    setInvisible(false)
    clearTracking()
    clearToolHooks()
    
    for _, conn in ipairs(InvisibleSystem._connections) do
        pcall(function() conn:Disconnect() end)
    end
    table.clear(InvisibleSystem._connections)
end

-- Add UI controls to the invisible group
invisibleGroup:AddToggle("🎭 Enable Invisible", false, function(state)
    setInvisible(state)
end)

invisibleGroup:AddSlider("📏 Depth", InvisibleSystem.MinDepth, InvisibleSystem.MaxDepth, 
    InvisibleSystem.Depth, function(value)
    InvisibleSystem.Depth = value
    print("🎭 Depth set to: " .. value)
end)

invisibleGroup:AddSlider("👁️ Transparency", 0.1, 0.9, InvisibleSystem.VisualFade, function(value)
    InvisibleSystem.VisualFade = value
    if InvisibleSystem.Enabled and not InvisibleSystem._restoring then
        applyVisual(true)
    end
    print("🎭 Transparency set to: " .. value)
end)

invisibleGroup:AddSlider("⏱️ Restore Time", 0.1, 1.0, InvisibleSystem.RestoreTime, function(value)
    InvisibleSystem.RestoreTime = value
    print("🎭 Restore time set to: " .. value .. "s")
end)

invisibleGroup:AddButton("🔄 Refresh Character", function()
    if game.Players.LocalPlayer.Character then
        scanCharacter()
        scanTools()
        hookAnimations()
        print("✅ Character refreshed for invisible system")
    end
end)



-- Initialize the system
task.spawn(function()
    task.wait(2)
    setupInvisibleSystem()
    
    if game.Players.LocalPlayer.Character then
        scanCharacter()
        scanTools()
        hookAnimations()
    end
    
    print("✅ Invisible System Loaded!")
    print("   📏 Depth: " .. InvisibleSystem.Depth)
    print("   👁️ Transparency: " .. InvisibleSystem.VisualFade)
    print("   ⏱️ Restore Time: " .. InvisibleSystem.RestoreTime .. "s")
end)

-- Clean up when script ends
game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == game.Players.LocalPlayer then
        cleanupInvisibleSystem()
    end
end)

print("✅ Invisible Hybrid System (No GUI) Ready for SFY Menu Integration!")



-- Advanced Stocking System
local AdvanceStockingGroup = menu:CreateCollapsibleGroup(Tabs.ProjectTab, "ADVANCE STOCKING", false, 400)
menu:MarkAsNew(AdvanceStockingGroup:GetInstance(),"NEW")
-- Stocking location (will be set by user)
local stockingLocation = nil
local stockingMarker = nil

-- Marked items storage (to prevent re-stocking the same item)
local markedItems = {}
local markedItemsFile = "SFY_Stocking_MarkedItems.json"

-- Function to load marked items from file
local function loadMarkedItems()
    if isfile and isfile(markedItemsFile) then
        local success, data = pcall(function()
            return game:GetService("HttpService"):JSONDecode(readfile(markedItemsFile))
        end)
        if success then
            markedItems = data
            print("📁 Loaded " .. #markedItems .. " marked items from file")
        end
    end
end

-- Function to save marked items to file
local function saveMarkedItems()
    if writefile then
        local success, err = pcall(function()
            writefile(markedItemsFile, game:GetService("HttpService"):JSONEncode(markedItems))
        end)
        if success then
            print("💾 Saved " .. #markedItems .. " marked items to file")
        else
            warn("❌ Failed to save marked items: " .. tostring(err))
        end
    end
end

-- Function to mark an item as stored
local function markItemAsStored(itemId)
    if not table.find(markedItems, itemId) then
        table.insert(markedItems, itemId)
        saveMarkedItems()
        return true
    end
    return false
end

-- Function to unmark all items
local function unmarkAllItems()
    print("🧹 Unmarking all items...")
    markedItems = {}
    saveMarkedItems()
    print("✅ All items unmarked!")
    return true
end

-- Function to check if item is already marked
local function isItemMarked(item)
    if not item or not item:IsA("Model") then return false end
    
    -- Create a unique ID for the item
    local itemId = item:GetFullName() .. "_" .. tostring(item:GetAttribute("StockingID") or item:GetDebugId())
    
    return table.find(markedItems, itemId)
end

-- Function to create VISIBLE location marker
local function createStockingLocationMarker(position)
    if stockingMarker then
        stockingMarker:Destroy()
    end
    
    -- Create VISIBLE marker for the stocking location
    local marker = Instance.new("Part")
    marker.Name = "StockingLocationMarker"
    marker.Size = Vector3.new(10, 0.5, 10)  -- Large, flat platform
    marker.Position = position + Vector3.new(0, -2, 0)
    marker.Anchored = true
    marker.CanCollide = false
    marker.Material = Enum.Material.Neon
    marker.Transparency = 0.3
    marker.BrickColor = BrickColor.new("Bright blue")
    marker.Parent = workspace
    
    -- Add glowing effect
    local sparkles = Instance.new("Sparkles")
    sparkles.SparkleColor = Color3.fromRGB(0, 150, 255)
    sparkles.Parent = marker
    
    -- Add bright light
    local pointLight = Instance.new("PointLight")
    pointLight.Color = Color3.fromRGB(0, 150, 255)
    pointLight.Brightness = 0.5
    pointLight.Range = 15
    pointLight.Parent = marker
    
    -- Create billboard label
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "StockingLocationLabel"
    billboard.Size = UDim2.new(0, 300, 0, 100)
    billboard.StudsOffset = Vector3.new(0, 8, 0)
    billboard.AlwaysOnTop = true
    billboard.Adornee = marker
    billboard.Parent = marker
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 0.7
    label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    label.Text = "📦 STOCKING LOCATION\n" ..
                "All unmarked items will be teleported here!\n"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 16
    label.Font = Enum.Font.GothamBold
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextStrokeTransparency = 0.3
    label.TextWrapped = true
    label.TextScaled = true
    label.Parent = billboard
    
    -- Add pulsing animation
    spawn(function()
        while marker and marker.Parent do
            for i = 0.3, 0.7, 0.05 do
                if not marker or not marker.Parent then break end
                marker.Transparency = i
                wait(0.1)
            end
            for i = 0.7, 0.3, -0.05 do
                if not marker or not marker.Parent then break end
                marker.Transparency = i
                wait(0.1)
            end
        end
    end)
    
    stockingMarker = marker
    return marker
end

-- Function to remove location marker
local function removeStockingLocationMarker()
    if stockingMarker then
        stockingMarker:Destroy()
        stockingMarker = nil
    end
    stockingLocation = nil
end

-- Function to create invisible marker on stocked items
local function createStockedItemMarker(item)
    if not item or not item:FindFirstChild("Handle") then return end
    
    -- Check if marker already exists
    if item.Handle:FindFirstChild("StockedItemMarker") then
        item.Handle.StockedItemMarker:Destroy()
    end
    
    -- Create completely invisible marker (no visuals at all)
    local marker = Instance.new("BoolValue")
    marker.Name = "StockedItemMarker"
    marker.Value = true
    marker.Parent = item.Handle
    
    return marker
end

-- Function to remove all stocked item markers
local function removeAllStockedItemMarkers()
    print("🧹 Removing all stocked item markers...")
    
    -- Remove from workspace
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == "StockedItemMarker" then
            obj:Destroy()
        end
    end
    
    print("✅ All stocked item markers removed!")
end

-- Advanced stocking requirements organized by level and room
local advancedStockingRequirements = {
    -- Level 1 Rooms
    ["Level1_SalesRoom"] = {
        name = "Sales Room (Level 1)",
        items = {
            {name = "Nut", count = 1},
            {name = "Steel Panel", count = 1},
            {name = "Light Gear", count = 1},
            {name = "Bolt", count = 1},
            {name = "Cinder Block", count = 1}
        },
        level = 1
    },
    ["Level1_VacantRoom"] = {
        name = "Vacant Room (Level 1)",
        items = {
            {name = "Metal Sheet", count = 1},
            {name = "Tire", count = 1},
            {name = "Traffic Cone", count = 1},
            {name = "Pallet", count = 1},
            {name = "Cinder Block", count = 1}
        },
        level = 1
    },
    ["Level1_MedBay"] = {
        name = "Med Bay (Level 1)",
        items = {
            {name = "Bandage", count = 2},
            {name = "Pallet", count = 1},
            {name = "Bolt", count = 1},
            {name = "First Aid Kit", count = 1},
            {name = "Cinder Block", count = 1}
        },
        level = 1
    },
    ["Level1_FoodPantry"] = {
        name = "Food Pantry (Level 1)",
        items = {
            {name = "Jar of Dirt", count = 1},
            {name = "Cooking Pot", count = 1},
            {name = "Beans", count = 1},
            {name = "Pallet", count = 1},
            {name = "Tire", count = 1}
        },
        level = 1
    },
    
    -- Level 2 Rooms
    ["Level2_RecyclingRoom"] = {
        name = "Recycling Room (Level 2)",
        items = {
            {name = "Battery Pack", count = 2},
            {name = "Metal Sheet", count = 1},
            {name = "Light Gear", count = 2},
            {name = "Sawblade", count = 2},
            {name = "Axle", count = 2}
        },
        level = 2
    },
    ["Level2_StorageRoom"] = {
        name = "Storage Room (Level 2)",
        items = {
            {name = "Toolbox", count = 1},
            {name = "Storage Rack", count = 1},
            {name = "Garage Shelf", count = 1},
            {name = "Pallet", count = 3},
            {name = "Cinder Block", count = 1}
        },
        level = 2
    },
    ["Level2_FilterRoom"] = {
        name = "Filter Room (Level 2)",
        items = {
            {name = "Barbed Wire", count = 1},
            {name = "Toolbox", count = 1},
            {name = "Metal Sheet", count = 1},
            {name = "Heavy Gear", count = 1},
            {name = "Bike Tire", count = 2}
        },
        level = 2
    },
    ["Level2_Armory"] = {
        name = "Armory (Level 2)",
        items = {
            {name = "Sawblade", count = 1},
            {name = "Iron Bar", count = 1},
            {name = "Pistol Ammo", count = 1},
            {name = "Metal Sheet", count = 2},
            {name = "Shovel", count = 1}
        },
        level = 2
    },
    
    -- Level 3 Rooms
    ["Level3_BollerRoom"] = {
        name = "Boller Room (Level 3)",
        items = {
            {name = "Fusion Core", count = 1},
            {name = "Steel Panel", count = 3},
            {name = "Gold Bar", count = 1},
            {name = "Coil", count = 1},
            {name = "Iron Bar", count = 3}
        },
        level = 3
    },
    ["Level3_Stairwell"] = {
        name = "Stairwell (Level 3)",
        items = {
            {name = "Steel Panel", count = 1},
            {name = "Light Gear", count = 2},
            {name = "Coil", count = 1},
            {name = "Iron Bar", count = 1},
            {name = "Axle", count = 1}
        },
        level = 3
    },
    ["Level3_BigRoom"] = {
        name = "Big Room (Level 3)",
        items = {
            {name = "Steel Panel", count = 3},
            {name = "Heavy Gear", count = 2},
            {name = "Tire", count = 2},
            {name = "Pallet", count = 3},
            {name = "Cinder Block", count = 3}
        },
        level = 3
    },
    ["Level3_WaterTreatmentRoom"] = {
        name = "Water Treatment Room (Level 3)",
        items = {
            {name = "Vitamins", count = 1},
            {name = "Metal Sheet", count = 1},
            {name = "Water Jug", count = 2},
            {name = "Rusty Pipe", count = 1},
            {name = "Bolt", count = 1}
        },
        level = 3
    },
    
    -- Level 4 Rooms
    ["Level4_DataRoom"] = {
        name = "Data Room (Level 4)",
        items = {
            {name = "Battery Pack", count = 2},
            {name = "Metal Sheet", count = 3},
            {name = "Neon Sign", count = 2},
            {name = "Light Gear", count = 4},
            {name = "Television", count = 1}
        },
        level = 4
    },
    ["Level4_IncineratorRoom"] = {
        name = "Incinerator Room (Level 4)",
        items = {
            {name = "Fusion Core", count = 1},
            {name = "Steel Panel", count = 1},
            {name = "Gold Bar", count = 1},
            {name = "Coil", count = 2},
            {name = "Toolbox", count = 1}
        },
        level = 4
    },
    ["Level4_PitRoom"] = {
        name = "Pit Room (Level 4)",
        items = {
            {name = "Sawblade", count = 1},
            {name = "Iron Bar", count = 3},
            {name = "Coil", count = 2},
            {name = "Shovel", count = 1},
            {name = "Cinder Block", count = 2}
        },
        level = 4
    },
    
    -- Level 5 Rooms
    ["Level5_StatelliteRoom"] = {
        name = "Satellite Room (Level 5)",
        items = {
            {name = "Car Battery", count = 2},
            {name = "Cooking Pot", count = 3},
            {name = "Circuit Board", count = 2},
            {name = "Heavy Gear", count = 5},
            {name = "Silver Bar", count = 3}
        },
        level = 5
    }
}

-- Store selected rooms for stocking
local selectedRoomsForStocking = {
    "Level1_SalesRoom",
    "Level1_VacantRoom",
    "Level1_MedBay",
    "Level1_FoodPantry",
    "Level2_RecyclingRoom",
    "Level2_StorageRoom",
    "Level2_FilterRoom",
    "Level2_Armory",
    "Level3_BollerRoom",
    "Level3_Stairwell",
    "Level3_BigRoom",
    "Level3_WaterTreatmentRoom",
    "Level4_DataRoom",
    "Level4_IncineratorRoom",
    "Level4_PitRoom",
    "Level5_StatelliteRoom"
}

-- Function to find ALL items by name (excluding marked items)
local function findAllUnmarkedItems(itemName)
    local foundItems = {}
    
    local function searchInContainer(container)
        for _, child in ipairs(container:GetDescendants()) do
            if child.Name == itemName and child:IsA("Model") and not isItemMarked(child) then
                table.insert(foundItems, {
                    Model = child,
                    Path = child:GetFullName()
                })
            end
        end
    end
    
    searchInContainer(workspace)
    return foundItems
end

-- Function to teleport item to stocking location with marking
local function teleportItemToStock(item, stockPos)
    if not item or not item:IsA("Model") then
        return false
    end
    
    -- Check if already marked
    if isItemMarked(item) then
        return false, "already_marked"
    end
    
    local success = false
    
    -- Try to drag item
    local dragSuccess, dragResult = pcall(function()
        return RequestDrag:InvokeServer(item)
    end)
    
    if dragSuccess then
        -- Teleport to exact stocking location (slightly above marker)
        local teleportCFrame = CFrame.new(stockPos) + Vector3.new(0, 5, 0) -- Above the marker
        
        -- Teleport the item
        if item:IsA("Model") then
            item:PivotTo(teleportCFrame)
        end
        
        wait(0.05)
        
        -- Release drag
        local releaseSuccess, releaseResult = pcall(function()
            ReleaseDrag:FireServer(item)
        end)
        
        if releaseSuccess then
            -- Mark item as stored
            local itemId = item:GetFullName() .. "_" .. tostring(item:GetDebugId())
            markItemAsStored(itemId)
            
            -- Create invisible marker on the stocked item
            createStockedItemMarker(item)
            
            success = true
        end
    else
        warn("❌ Failed to drag item for stocking: " .. item:GetFullName())
    end
    
    return success
end

-- Main function to stock items for selected rooms (UNLIMITED - all unmarked items)
local function stockAllUnmarkedItems()
    print("🚀 Starting Unlimited Stocking...")
    
    if not stockingLocation then
        print("❌ Please set stocking location first!")
        menu:ShowNotification("❌ Set stocking location first!", 3)
        return 0
    end
    
    local stockPos = stockingLocation
    local totalStocked = 0
    local totalSkipped = 0
    local totalFailed = 0
    
    -- Load marked items
    loadMarkedItems()
    
    print("📋 Collecting ALL items needed for selected rooms...")
    
    -- First, collect ALL item types needed
    local allItemTypes = {}
    for _, roomKey in ipairs(selectedRoomsForStocking) do
        local roomData = advancedStockingRequirements[roomKey]
        if roomData then
            for _, itemReq in ipairs(roomData.items) do
                allItemTypes[itemReq.name] = true
            end
        end
    end
    
    print("🔍 Searching for " .. #allItemTypes .. " different item types...")
    
    -- Process each item type
    for itemName, _ in pairs(allItemTypes) do
        print("   🔍 Looking for ALL " .. itemName .. " items...")
        
        -- Find ALL unmarked items of this type
        local availableItems = findAllUnmarkedItems(itemName)
        
        if #availableItems > 0 then
            print("   ✅ Found " .. #availableItems .. " unmarked " .. itemName .. " items")
            
            local typeStocked = 0
            local typeSkipped = 0
            local typeFailed = 0
            
            -- Teleport ALL found items (not limited by count)
            for i, itemData in ipairs(availableItems) do
                local success, status = teleportItemToStock(itemData.Model, stockPos)
                
                if success then
                    typeStocked += 1
                    totalStocked += 1
                elseif status == "already_marked" then
                    typeSkipped += 1
                    totalSkipped += 1
                else
                    typeFailed += 1
                    totalFailed += 1
                end
                
                -- Small delay to prevent rate limiting
                wait(0.08)
                
                -- Progress update every 10 items
                if i % 10 == 0 then
                    print("      📦 Progress: " .. i .. "/" .. #availableItems .. " " .. itemName .. " items processed")
                end
            end
            
            if typeStocked > 0 then
                print("   📊 Stocked " .. typeStocked .. " " .. itemName .. " items")
            end
            if typeSkipped > 0 then
                print("   ⏭️ Skipped " .. typeSkipped .. " " .. itemName .. " (already marked)")
            end
            if typeFailed > 0 then
                print("   ❌ Failed to stock " .. typeFailed .. " " .. itemName .. " items")
            end
        else
            print("   ❌ No " .. itemName .. " items found or all are already marked")
        end
    end
    
    -- Save marked items
    saveMarkedItems()
    
    print("\n" .. string.rep("=", 50))
    print("🎉 UNLIMITED STOCKING COMPLETE!")
    print(string.rep("=", 50))
    print("📦 Newly Stocked: " .. totalStocked .. " items")
    print("⏭️ Already Stocked: " .. totalSkipped .. " items (skipped)")
    print("❌ Failed: " .. totalFailed .. " items")
    print("📍 All items stored at the blue glowing marker!")
    print("💾 Total Marked Items: " .. #markedItems)
    print(string.rep("=", 50))
    
    return totalStocked
end

-- Function to clear all markers and unmark all items
local function clearAllMarkersAndUnmark()
    print("🧹 Clearing ALL markers and unmarking all items...")
    
    -- Remove location marker
    removeStockingLocationMarker()
    
    -- Remove all stocked item markers
    removeAllStockedItemMarkers()
    
    -- Unmark all items
    unmarkAllItems()
    
    print("✅ All markers cleared and items unmarked!")
    return true
end

-- Function to view current stocking status
local function viewStockingStatus()
    print("\n" .. string.rep("=", 50))
    print("📊 CURRENT STOCKING STATUS")
    print(string.rep("=", 50))
    
    if stockingLocation then
        print("📍 Stocking Location: ✅ SET (Look for blue glowing platform)")
        print("   Position: " .. tostring(stockingLocation))
    else
        print("📍 Stocking Location: ❌ Not set")
    end
    
    print("💾 Marked Items: " .. #markedItems)
    
    -- Count items needed by room
    print("\n🏠 ROOMS SELECTED: " .. #selectedRoomsForStocking)
    
    -- Count total items needed
    local totalItemsNeeded = 0
    local itemTypeCount = {}
    
    for _, roomKey in ipairs(selectedRoomsForStocking) do
        local roomData = advancedStockingRequirements[roomKey]
        if roomData then
            for _, itemReq in ipairs(roomData.items) do
                totalItemsNeeded = totalItemsNeeded + itemReq.count
                itemTypeCount[itemReq.name] = (itemTypeCount[itemReq.name] or 0) + itemReq.count
            end
        end
    end
    
    print("📦 Total Items Needed: " .. totalItemsNeeded)
    print("🔤 Unique Item Types: " .. #itemTypeCount)
    
    print(string.rep("=", 50))
    
    return #markedItems
end

-- Create UI for Advanced Stocking
AdvanceStockingGroup:AddSeparator("📦 ADVANCED STOCKING SYSTEM")

-- Create combo for location setting and stocking
local stockingComboName = "Advanced Stocking"
local stockingCombo = AdvanceStockingGroup:AddCombo(stockingComboName, 
    -- Toggle callback (set location)
    function(isToggled)
        if isToggled then
            -- Set stocking location to player's current position
            stockingLocation = humanoidRootPart.Position + humanoidRootPart.CFrame.LookVector * 10
            createStockingLocationMarker(stockingLocation)
            print("📍 Stocking location set at " .. tostring(stockingLocation))
            print("🔵 Look for the blue glowing platform!")
            menu:ShowNotification("📍 Stocking location set!\n🔵 Look for blue platform!", 3)
        else
            removeStockingLocationMarker()
            print("📍 Stocking location removed")
            menu:ShowNotification("📍 Stocking location removed!", 3)
        end
    end,
    -- Action 1 callback (start UNLIMITED stocking)
    function()
        if not stockingLocation then
            print("❌ Please set stocking location first (toggle ON)")
            menu:ShowNotification("❌ Set stocking location first!", 3)
            return
        end
        
        local stockedCount = stockAllUnmarkedItems()
        
        if stockedCount > 0 then
            menu:ShowNotification("✅ Stocked " .. stockedCount .. " new items!\n📍 At the blue marker", 5)
        else
            menu:ShowNotification("ℹ️ All items already marked or none found!", 5)
        end
    end,
    -- Action 2 callback (clear all markers and unmark all)
    function()
        clearAllMarkersAndUnmark()
        if stockingCombo then
            stockingCombo:SetToggle(false)
        end
        print("🔄 All markers cleared and items unmarked")
        menu:ShowNotification("🧹 All markers cleared and items unmarked!", 3)
    end,
    false -- isPremium
)

-- Store combo reference for later use
local categoryCombos = {}
categoryCombos[stockingComboName] = stockingCombo

-- Room selection multi-dropdown
AdvanceStockingGroup:AddSeparator("🏠 SELECT ROOMS")

local roomOptions = {}
for roomKey, roomData in pairs(advancedStockingRequirements) do
    table.insert(roomOptions, roomData.name)
end

local roomSelection = AdvanceStockingGroup:AddMultiDropdown("Select Rooms to Stock", roomOptions, roomOptions, function(selections)
    -- Map back room names to keys
    selectedRoomsForStocking = {}
    for _, roomName in ipairs(selections) do
        for roomKey, roomData in pairs(advancedStockingRequirements) do
            if roomData.name == roomName then
                table.insert(selectedRoomsForStocking, roomKey)
                break
            end
        end
    end
    print("✅ Selected " .. #selectedRoomsForStocking .. " rooms for stocking")
    menu:ShowNotification("✅ " .. #selectedRoomsForStocking .. " rooms selected!", 3)
end)

-- Management buttons
AdvanceStockingGroup:AddSeparator("⚙️ MANAGEMENT")

-- Unmark All button
AdvanceStockingGroup:AddButton("🚫 Unmark All Items", function()
    unmarkAllItems()
    menu:ShowNotification("🚫 All items unmarked!", 3)
end)

AdvanceStockingGroup:AddButton("📊 View Stocking Status", function()
    viewStockingStatus()
    menu:ShowNotification("📊 Status displayed in console!", 3)
end)

AdvanceStockingGroup:AddButton("📁 Load Marked Items", function()
    loadMarkedItems()
    menu:ShowNotification("📁 Loaded " .. #markedItems .. " marked items!", 3)
end)

AdvanceStockingGroup:AddButton("💾 Save Marked Items", function()
    saveMarkedItems()
    menu:ShowNotification("💾 Saved " .. #markedItems .. " marked items!", 3)
end)

-- Remove all markers button
AdvanceStockingGroup:AddButton("🧹 Remove All Markers", function()
    removeAllStockedItemMarkers()
    removeStockingLocationMarker()
    menu:ShowNotification("🧹 All markers removed!", 3)
end)

-- Status indicators
AdvanceStockingGroup:AddSeparator("📊 STATUS")

local stockingStatusLabel = AdvanceStockingGroup:AddLabel("Status: Ready - Set location first")
local markedCountLabel = AdvanceStockingGroup:AddLabel("Marked Items: 0")
local locationStatusLabel = AdvanceStockingGroup:AddLabel("Location: Not set")
local roomCountLabel = AdvanceStockingGroup:AddLabel("Rooms Selected: 16")

-- Update status labels periodically
spawn(function()
    while true do
        wait(3)
        
        -- Update location status
        if locationStatusLabel and locationStatusLabel.Instance then
            if stockingLocation then
                locationStatusLabel.Instance.Text = "Location: ✅ SET (Look for blue platform)"
                locationStatusLabel.Instance.TextColor3 = Color3.fromRGB(0, 150, 255)
            else
                locationStatusLabel.Instance.Text = "Location: ❌ Not set"
                locationStatusLabel.Instance.TextColor3 = Color3.fromRGB(255, 100, 100)
            end
        end
        
        -- Update stocking status
        if stockingStatusLabel and stockingStatusLabel.Instance then
            stockingStatusLabel.Instance.Text = "Status: " .. (#markedItems > 0 and "Active (" .. #markedItems .. " marked)" or "Ready")
            stockingStatusLabel.Instance.TextColor3 = #markedItems > 0 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255)
        end
        
        -- Update marked count
        if markedCountLabel and markedCountLabel.Instance then
            markedCountLabel.Instance.Text = "Marked Items: " .. #markedItems
        end
        
        -- Update room count
        if roomCountLabel and roomCountLabel.Instance then
            roomCountLabel.Instance.Text = "Rooms Selected: " .. #selectedRoomsForStocking
        end
    end
end)

-- Load marked items on startup
spawn(function()
    wait(2) -- Wait for everything to load
    loadMarkedItems()
    print("📁 Advanced Stocking System Initialized")
    print("📦 Marked Items: " .. #markedItems)
    print("🏠 Rooms Selected: " .. #selectedRoomsForStocking)
    
    if stockingLocation then
        print("📍 Stocking Location: " .. tostring(stockingLocation))
        createStockingLocationMarker(stockingLocation)
        print("🔵 Blue glowing marker created at stocking location")
    else
        print("📍 Stocking Location: Not set (use toggle to set)")
        print("💡 Toggle ON to create a visible blue platform marker!")
    end
end)

print("✅ Advanced Stocking System Loaded!")
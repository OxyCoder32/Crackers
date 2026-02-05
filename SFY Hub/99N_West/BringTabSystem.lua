--[[
d
wadwad
wa
dc2
c2a
dc
3
3
3
r
w
f
 D


d aw
d
wa
 da
d
aw
DC
q
wcd
wqd
cq
d

a
d a
d
awca
ca
d
ca

daw
d 
wa
d
ca 
d
c21
c2
2 c2
d c2d
c2
dc2
dc

c2
d2
]]

local BringTabSystem = {}
 
function BringTabSystem:Init(menu, Tabs)
    -- Store references
    self.menu = menu
    self.Tabs = Tabs or {}
 
    -- Create tabs if not provided
    if not self.Tabs.BringTab then
        self.Tabs.BringTab = menu:CreateTab("Bring Stuff")
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

--=============================BringTab START====================================
local bringstuffSettingsGroup = self.menu:CreateCollapsibleGroup(self.Tabs.BringTab,"BRING STUFF SETTINGS",false,200)
self.menu:MarkAsNew(bringstuffSettingsGroup:GetInstance(),"NEW")
local bringstuffGroup = self.menu:CreateCollapsibleGroup(self.Tabs.BringTab,"BRING STUFF",true,300)
self.menu:MarkAsNew(bringstuffGroup:GetInstance(),"BETA")
-- Bring system configuration (optimized)
local BringConfig = {
    Destination = "Player",
    Speed = "Fast",
    MaxItems = 100,
    Arrangement = "Single",
    BringHeight = 5,
    SpeedSettings = {
        ["Super Fast"] = {delay = 0.0, batchSize = 100},
        ["Fast"] = {delay = 0.4, batchSize = 50},
        ["Slow"] = {delay = 0.1, batchSize = 2}
    },
    ArrangementSettings = {
        ["Single"] = {spacing = 0, randomOffset = false},
        ["Grid"] = {spacing = 3, randomOffset = false},
        ["Circle"] = {spacing = 4, randomOffset = false}
    }
}

-- NEW ITEM CATEGORIES FOR THIS GAME
local ItemCategories = {
    Fuel = {
        "Wood", 
        "Tree seed",
        "Coal",
        "Iron Barrel",
        "Super faces",
        "Oil",
        "Tree trunk",
        "Animal fat"
        },
    Item = {
        "Old Lamp",
        "New Lamp",
        "Large bag",
        "Rabbit foot",
        "Wolf skin",
        "Gem"
        },
    Weapon = {
        "Knift",
        "Riffle Bullet",
        "Sword",
        "Revolver Bullet",
        "ShotGun Bullet",
        "Rifle",
        "Revolver",
        "Good axe"
        },
    Food = {
        "Steak",
        "Meat",
        "Carrot",
        "Soup",
        "Pumpkin",
        "Watermelon",
        "Turkey",
        "TomatoSoup"
        },
    Gear = {
        "Iron barrel",
        "Screw",
        "Steam Machine",
        "Horseshoe",
        "Iron Wheel",
        "Iron trolley",
        "Gold",
        "Iron Rock"
        },
    Meds = {
        "Medical Kit V1",
        "Medical Kit V2"
    },
    Body = {
        "Dead body"
    },
    Armor = {
        "Iron Armor",
        "Leather Armor"
    },
    Event = {
        "Christmas gift"
    }
}

-- Items to exclude from default selection
local ExcludeItems = {
    Fuel = {},
    Item = {},
    Weapon = {},
    Food = {},
    Gear = {},
    Meds = {},
    Body = {},
    Armor = {},
    Event = {}
}

local ItemParts = {
    -- Fuel
    ["Wood"] = "RootPart",["Tree seed"] = "Core",["Coal"] = "RootPart",["Iron Barrel"] = "RootPart",
    ["Super faces"] = "RootPart",["Chair"] = "RootPart",["Oil"] = "RootPart",["Tree trunk"] = "RootPart",["Animal fat"] = "RootPart",
    --Item
    ["Old Lamp"] = "Handle",["New Lamp"] = "Handle",["Large bag"] = "handle",["Rabbit foot"] = "RootPart",["Wolf skin"] = "Union",
    ["Gem"] = "223",["Leahter Armor"] = "çš®ç”²",
    --Weapon
    ["Knift"] = "Handle",["Riffle Bullet"] = "RootPart",["Sword"] = "Handle",
    ["Revolver Bullet"] = "RootPart",["ShotGun Bullet"] = "RootPart",["ShotGun"] = "Handle",["Revolver"] = "Handle",["Rifle"] = "Handle",
    ["Good axe"] = "Handle",
    --Food
    ["Meat"] = "RootPart",["Carrot"] = "RootPart",["Steak"] = "RootPart",["Soup"] = "Handle",["Pumpkin"] = "RootPart",
    ["Watermelon"] = "RootPart",["Turkey"] = "ç”Ÿ",["TomatoSoup"] = "RootPart",
    --Gear
    ["Iron barrel"] = "RootPart",["Screw"] = "RootPart",["Horseshoe"] = "Union",["Steam Machine"] = "RootPart",["Iron Wheel"] = "RootPart",
    ["Iron trolley"] = "RootPart",["Gold"] = "RootPart",["Iron Rock"] = "RootPart",
    --Health Meds
    ["Medical Kit V1"] = "Handle",["Medical Kit V2"] = "Handle",
    --Body 
    ["Dead body"] = "Webbing",
    --Armor
    ["Iron Armor"] = "RootPart",["Leather Armor"] = "RootPart",
    --Event
    ["Christmas gift"] = "RootPart"
 }

-- Bring system variables
local BringSystem = {
    IsActive = false,
    CurrentProcess = nil
}

-- Custom Location System for Each Category
local CustomLocations = {
    Fuel = nil,
    Item = nil,
    Weapon = nil,
    Food = nil,
    Gear = nil,
    Meds = nil,
    Body = nil,
    Armor = nil,
    Event = nil
}

-- Location Markers Storage
local LocationMarkers = {}

-- Store combo references for external access
local CategoryCombos = {}

-- Find the drag remote event (SAME LOGIC AS BRING WOOD)
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
                print("✅ Found drag event: " .. eventName)
                break
            end
        end
    end
end

-- Function to create location marker
local function createLocationMarker(category, position)
    -- Remove existing marker for this category
    if LocationMarkers[category] then
        LocationMarkers[category]:Destroy()
        LocationMarkers[category] = nil
    end
    
    -- Create new marker
    local marker = Instance.new("Part")
    marker.Name = category .. "_LocationMarker"
    marker.Size = Vector3.new(4, 0.2, 4)
    marker.Position = position + Vector3.new(0, -3, 0)
    marker.Anchored = true
    marker.CanCollide = false
    marker.Material = Enum.Material.Neon
    
    -- Set color based on category
    local categoryColors = {
        Fuel = Color3.fromRGB(255, 0, 0),      -- Red
        Item = Color3.fromRGB(255, 255, 0),    -- Yellow
        Weapon = Color3.fromRGB(0, 0, 255),     -- Blue
        Food = Color3.fromRGB(0, 255, 0),       -- Green (suggestion)
        Body = Color3.fromRGB(255, 255, 24),
        Armor = Color3.fromRGB(255, 255, 0)
    }
    
    marker.BrickColor = BrickColor.new(categoryColors[category] or Color3.fromRGB(255, 255, 255))
    marker.Transparency = 0.3
    
    -- Add surface GUI with category name
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "CategoryLabel"
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.Adornee = marker
    billboard.AlwaysOnTop = false
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = category .. " Location"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextStrokeTransparency = 0
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.Parent = billboard
    
    billboard.Parent = marker
    marker.Parent = game:GetService("Workspace")
    
    LocationMarkers[category] = marker
    CustomLocations[category] = position
    
    print("📍 " .. category .. " location set at: " .. tostring(position))
end

-- Function to remove location marker
local function removeLocationMarker(category)
    if LocationMarkers[category] then
        LocationMarkers[category]:Destroy()
        LocationMarkers[category] = nil
    end
    CustomLocations[category] = nil
    print("🗑️ " .. category .. " location removed")
end

-- Function to set current position as custom location
local function setCurrentLocation(category)
    local character = Player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        print("❌ No character found!")
        return false
    end
    
    local position = character.HumanoidRootPart.Position
    createLocationMarker(category, position)
    return true
end

-- Function to teleport to custom location
local function teleportToCustomLocation(category)
    if not CustomLocations[category] then
        print("❌ No " .. category .. " location set!")
        return false
    end
    
    local character = Player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        print("❌ No character found!")
        return false
    end
    
    character.HumanoidRootPart.CFrame = CFrame.new(CustomLocations[category] + Vector3.new(0, 3, 0))
    print("🚀 Teleported to " .. category .. " location")
    return true
end

local function stopAllBringing()
    if BringSystem.IsActive then
        BringSystem.IsActive = false
        BringSystem.CurrentProcess = nil
        print("🛑 All teleportation stopped")
    end
end

-- SAME LOGIC AS BRING WOOD: Get teleport position
local function getTeleportPosition()
    local character = Player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return nil end
    
    local hrp = character.HumanoidRootPart
    return hrp.CFrame + Vector3.new(0, BringConfig.BringHeight, 0)
end

-- SAME LOGIC AS BRING WOOD: Use dragging remote
local function useDraggingRemote(itemObject, state)
    if not DragRemote then
        return false -- No remote available
    end
    
    local success = pcall(function()
        if state then
            -- Drag the item
            DragRemote:FireServer(itemObject)
        else
            -- Undrag the item
            DragRemote:FireServer()
        end
        return true
    end)
    
    return success
end

-- SAME LOGIC AS BRING WOOD: Calculate positions
local function calculateItemPositions(totalItems, basePosition)
    local positions = {}
    local config = BringConfig.ArrangementSettings[BringConfig.Arrangement]
    
    if BringConfig.Arrangement == "Single" then
        -- All items go to same position (SAME AS BRING WOOD)
        for i = 1, math.min(totalItems, BringConfig.MaxItems) do
            table.insert(positions, basePosition.Position)
        end
    elseif BringConfig.Arrangement == "Grid" then
        local itemsPerRow = math.ceil(math.sqrt(math.min(totalItems, BringConfig.MaxItems)))
        for i = 1, math.min(totalItems, BringConfig.MaxItems) do
            local row = math.floor((i - 1) / itemsPerRow)
            local col = (i - 1) % itemsPerRow
            local offset = Vector3.new(
                (col - (itemsPerRow - 1) / 2) * config.spacing,
                0,
                row * config.spacing
            )
            table.insert(positions, basePosition.Position + offset)
        end
    elseif BringConfig.Arrangement == "Circle" then
        for i = 1, math.min(totalItems, BringConfig.MaxItems) do
            local angle = (i / math.min(totalItems, BringConfig.MaxItems)) * math.pi * 2
            local offset = Vector3.new(
                math.cos(angle) * config.spacing,
                0,
                math.sin(angle) * config.spacing
            )
            table.insert(positions, basePosition.Position + offset)
        end
    end
    
    return positions
end

-- IMPROVED: Function to find all items in workspace (not just items folder)
local function findAllItems()
    local foundItems = {}
    local totalScanned = 0
    
    local function scanForItems(parent)
        for _, item in pairs(parent:GetChildren()) do
            if item:IsA("Model") then
                local itemName = item.Name
                local partName = ItemParts[itemName]
                
                -- Check if this is one of our target items
                if partName then
                    local targetPart = item:FindFirstChild(partName)
                    if targetPart and targetPart:IsA("BasePart") then
                        table.insert(foundItems, {
                            Model = item,
                            Part = targetPart,
                            Name = itemName
                        })
                        totalScanned = totalScanned + 1
                    end
                end
            end
            -- Recursive search through all children
            scanForItems(item)
        end
    end
    
    -- Scan entire workspace for items
    scanForItems(game:GetService("Workspace"))
    
    print("🔍 Scanned workspace, found " .. #foundItems .. " target items")
    return foundItems
end

-- SAME LOGIC AS BRING WOOD: Bring selected items
local function bringSelectedItems(selectedItems, customLocation)
    if BringSystem.IsActive then
        print("❌ A bring operation is already in progress")
        return 0
    end
    
    BringSystem.IsActive = true
    BringSystem.CurrentProcess = "selected_items"
    
    -- Find all items in workspace (IMPROVED)
    local allItems = findAllItems()

    -- Filter items based on selection
    local filteredItems = {}
    for _, itemData in ipairs(allItems) do
        if selectedItems[itemData.Name] then
            table.insert(filteredItems, itemData)
        end
    end

    -- Apply max items limit
    local itemsToMove = {}
    for i = 1, math.min(#filteredItems, BringConfig.MaxItems) do
        table.insert(itemsToMove, filteredItems[i])
    end

    local totalToMove = #itemsToMove
    print("🔍 Found " .. #filteredItems .. " selected items, moving " .. totalToMove .. " (Max: " .. BringConfig.MaxItems .. ")")

    local teleportCFrame = customLocation or getTeleportPosition()
    if not teleportCFrame then
        print("❌ Cannot get teleport position!")
        BringSystem.IsActive = false
        return 0
    end

    -- Calculate positions based on arrangement
    local positions = calculateItemPositions(totalToMove, teleportCFrame)
    local speedConfig = BringConfig.SpeedSettings[BringConfig.Speed]
    local moved = 0

    if totalToMove > 0 then
        print("🚀 Starting teleportation of " .. totalToMove .. " items...")
    end

    -- SAME LOGIC AS BRING WOOD: Ultra fast teleport with configurable speed
    for i, itemData in ipairs(itemsToMove) do
        if not BringSystem.IsActive then break end
        
        local targetPos = positions[i] or teleportCFrame.Position
        
        if DragRemote then
            pcall(function()
                -- Drag the item
                DragRemote:FireServer(itemData.Model)
                
                -- Teleport immediately
                itemData.Part.CFrame = CFrame.new(targetPos)
                
                -- Undrag immediately
                DragRemote:FireServer()
                
                moved = moved + 1
                
                -- Show progress for large operations
                if totalToMove > 10 and moved % 10 == 0 then
                    print("📦 Progress: " .. moved .. "/" .. totalToMove .. " items")
                end
            end)
        else
            -- Fallback: direct teleport without remote
            itemData.Part.CFrame = CFrame.new(targetPos)
            moved = moved + 1
        end
        
        -- Apply speed delay if not instant
        if speedConfig.delay > 0 then
            task.wait(speedConfig.delay)
        end
    end
    
    BringSystem.IsActive = false
    BringSystem.CurrentProcess = nil
    
    if moved > 0 then
        local locationType = customLocation and "Custom " or BringConfig.Destination
        print("✅ Successfully teleported " .. moved .. " items to " .. locationType)
    else
        print("❌ No items were teleported - check if items exist in workspace")
    end
    
    return moved
end

-- SAME LOGIC AS BRING WOOD: Fast wood teleport
local function bringAllWoodFast(customLocation)
    if BringSystem.IsActive then
        print("❌ A bring operation is already in progress")
        return 0
    end
    
    BringSystem.IsActive = true
    BringSystem.CurrentProcess = "wood_fast"
    
    -- Find all wood items in workspace (IMPROVED)
    local allItems = findAllItems()
    
    -- Filter for wood items only
    local foundItems = {}
    for _, itemData in ipairs(allItems) do
        if itemData.Name == "Wood" or itemData.Name == "Tree seed" then
            table.insert(foundItems, itemData)
        end
    end

    -- Apply max items limit
    local itemsToMove = {}
    for i = 1, math.min(#foundItems, BringConfig.MaxItems) do
        table.insert(itemsToMove, foundItems[i])
    end

    local totalToMove = #itemsToMove
    print("🪵 Found " .. #foundItems .. " wood items, moving " .. totalToMove)

    local teleportCFrame = customLocation or getTeleportPosition()
    if not teleportCFrame then
        print("❌ Cannot get teleport position!")
        BringSystem.IsActive = false
        return 0
    end

    -- Calculate positions
    local positions = calculateItemPositions(totalToMove, teleportCFrame)
    local moved = 0

    if totalToMove > 0 then
        print("⚡ ULTRA FAST: Teleporting " .. totalToMove .. " wood items...")
    end

    -- SAME LOGIC AS BRING WOOD: SUPER FAST - No delays, process all at once
    for i, itemData in ipairs(itemsToMove) do
        if not BringSystem.IsActive then break end
        
        local targetPosition = positions[i] or teleportCFrame.Position
        
        -- Enable dragging
        local dragEnabled = useDraggingRemote(itemData.Model, true)
        
        -- Move immediately
        if itemData.Part and itemData.Part.Parent then
            itemData.Part.CFrame = CFrame.new(targetPosition)
        end
        
        -- Disable dragging immediately
        if dragEnabled then
            useDraggingRemote(itemData.Model, false)
        end
        
        moved = moved + 1
    end
    
    BringSystem.IsActive = false
    BringSystem.CurrentProcess = nil
    
    if moved > 0 then
        local locationType = customLocation and "Custom " or BringConfig.Destination
        print("✅ ULTRA FAST: Teleported " .. moved .. " wood items to " .. locationType)
    else
        print("❌ No wood items found to teleport")
    end
    
    return moved
end

-- Function to scan and show item count
local function scanItemCount()
    local allItems = findAllItems()
    local itemCounts = {}
    
    for _, itemData in ipairs(allItems) do
        itemCounts[itemData.Name] = (itemCounts[itemData.Name] or 0) + 1
    end
    
    print("🔍 Item Scan Results:")
    for itemName, count in pairs(itemCounts) do
        print("   " .. itemName .. ": " .. count)
    end
    
    return allItems
end

-- Setup Bring Item System with New Combo Function
local function setupBringItemSystem(parentTab)
    -- Initialize selections with excluded items
    local Selections = {}
    local DefaultSelections = {}
    
    for categoryName, items in pairs(ItemCategories) do
        Selections[categoryName] = {}
        DefaultSelections[categoryName] = {}
        
        for _, item in ipairs(items) do
            -- Set to true by default, false if in exclude list
            local isExcluded = table.find(ExcludeItems[categoryName] or {}, item)
            Selections[categoryName][item] = not isExcluded
            DefaultSelections[categoryName][item] = not isExcluded
        end
    end


    bringstuffSettingsGroup:AddDropdown("📍 Teleport Destination", {"Player"}, BringConfig.Destination, function(selected)
        BringConfig.Destination = selected
        print("📌 Item destination set to: " .. selected)
    end)

    bringstuffSettingsGroup:AddDropdown("⚡ Teleport Speed", {"Super Fast", "Fast", "Slow"}, BringConfig.Speed, function(selected)
        BringConfig.Speed = selected
        print("⚡ Teleport speed set to: " .. selected)
    end)

    bringstuffSettingsGroup:AddDropdown("📐 Item Arrangement", {"Single", "Grid", "Circle"}, BringConfig.Arrangement, function(selected)
        BringConfig.Arrangement = selected
        print("📐 Item arrangement set to: " .. selected)
    end)

    bringstuffSettingsGroup:AddSlider("🔢 Max Items to Teleport", 1, 500, BringConfig.MaxItems, function(value)
        BringConfig.MaxItems = value
        print("🔢 Max items set to: " .. value)
    end)

    bringstuffSettingsGroup:AddSlider("📏 Bring Height", 0, 20, BringConfig.BringHeight, function(value)
        BringConfig.BringHeight = value
        print("📏 Bring height set to: " .. value)
    end)

    -- Stop Button
    self.menu:CreateSeparator(parentTab, "🛑 EMERGENCY STOP")
    self.menu:CreateButton(parentTab, "🛑 STOP ALL TELEPORT (P KEY)", stopAllBringing)
    self.menu:CreateLabel(parentTab, "Press P key to stop all operations")

    -- Create category combos with location setting functionality
    for categoryName, items in pairs(ItemCategories) do
        local emoji = categoryName == "Fuel" and "⛽" or 
                     categoryName == "Item" and "🛠️" or 
                     categoryName == "Weapon" and "⚔️" or
                     categoryName == "Food" and "🍕" or
                     categoryName == "Gear" and "🔩" or
                     categoryName == "Meds" and "❤️‍🩹" or
                     categoryName == "Body" and "🧟‍♂️" or
                     categoryName == "Armor" and "👕" or
                     categoryName == "Event" and "🎁"
        
        -- Create the combo for this category
        local combo = bringstuffGroup:AddCombo(
            emoji .. " " .. categoryName,
            function(toggleState)
                -- Toggle callback: Set location when toggled ON, remove when toggled OFF
                if toggleState then
                    print("📍 Setting " .. categoryName .. " location...")
                    local success = setCurrentLocation(categoryName)
                    if not success then
                        -- If failed to set location, turn toggle back off
                        combo:SetToggle(false)
                        print("❌ Failed to set " .. categoryName .. " location")
                    else
                        print("✅ " .. categoryName .. " location set successfully")
                    end
                else
                    -- When toggled OFF, remove the location marker
                    print("🔄 Removing " .. categoryName .. " location...")
                    removeLocationMarker(categoryName)
                    print("🗑️ " .. categoryName .. " location removed (toggle turned off)")
                end
            end,
            function()
                -- Action 1: Bring items to custom location or default
                local customLocation = CustomLocations[categoryName]
                local locationCFrame = nil
                
                if customLocation then
                    locationCFrame = CFrame.new(customLocation + Vector3.new(0, BringConfig.BringHeight, 0))
                    print("🚀 Bringing " .. categoryName .. " items to custom location...")
                else
                    print("🚀 Bringing " .. categoryName .. " items to " .. BringConfig.Destination .. "...")
                end
                
                local count = bringSelectedItems(Selections[categoryName], locationCFrame)
                print("✅ Teleported " .. count .. " " .. categoryName .. " items using " .. BringConfig.Speed .. " speed")
            end,
            function()
                -- Action 2: Reset/Remove location marker and turn off toggle
                print("🔄 Resetting " .. categoryName .. " location...")
                removeLocationMarker(categoryName)
                -- Turn off the toggle
                combo:SetToggle(false)
                print("🗑️ " .. categoryName .. " location reset and toggle turned off")
            end,
            false, -- isPremium
            Enum.KeyCode.F3
            
        )
        
        -- Store combo reference
        CategoryCombos[categoryName] = combo
        
        -- Add item selection dropdown below the combo
        bringstuffGroup:AddMultiDropdown("   ↳ Select " .. categoryName .. " Items", items, DefaultSelections[categoryName], function(selectionsArray)
            for itemName, _ in pairs(Selections[categoryName]) do
                Selections[categoryName][itemName] = false
            end
            for _, itemName in ipairs(selectionsArray) do
                Selections[categoryName][itemName] = true
            end
            print("Updated " .. categoryName .. " selection: " .. table.concat(selectionsArray, ", "))
        end)
    end


    local woodCombo = bringstuffGroup:AddCombo(
        "🪓 Wood & Tree seed Only",
        function(toggleState)
            -- Toggle callback: Set location when toggled ON, remove when toggled OFF
            if toggleState then
                print("📍 Setting wood location...")
                local success = setCurrentLocation("Fuel") -- Use Fuel category for wood
                if not success then
                    woodCombo:SetToggle(false)
                    print("❌ Failed to set wood location")
                else
                    print("✅ Wood location set successfully")
                end
            else
                -- When toggled OFF, remove the location marker
                print("🔄 Removing wood location...")
                removeLocationMarker("Fuel")
                print("🗑️ Wood location removed (toggle turned off)")
            end
        end,
        function()
            -- Action 1: Bring wood to custom location or default
            local customLocation = CustomLocations["Fuel"]
            local locationCFrame = nil
            
            if customLocation then
                locationCFrame = CFrame.new(customLocation + Vector3.new(0, BringConfig.BringHeight, 0))
                print("🚀 Bringing wood to custom location...")
            else
                print("🚀 Bringing wood to " .. BringConfig.Destination .. "...")
            end
            
            local count = bringAllWoodFast(locationCFrame)
            print("🪓 ULTRA FAST: Teleported " .. count .. " wood items")
        end,
        function()
            -- Action 2: Reset/Remove location marker and turn off toggle
            print("🔄 Resetting wood location...")
            removeLocationMarker("Fuel")
            woodCombo:SetToggle(false)
            print("🗑️ Wood location reset and toggle turned off")
        end,
        false,
        Enum.KeyCode.F2
    )

    -- Store wood combo reference
    CategoryCombos["Wood"] = woodCombo


    bringstuffGroup:AddButton("🌍 BRING ALL SELECTED ITEMS", function()
        local allSelections = {}
        for categoryName, categorySelections in pairs(Selections) do
            for itemName, isSelected in pairs(categorySelections) do
                if isSelected then
                    allSelections[itemName] = true
                end
            end
        end
        
        local count = bringSelectedItems(allSelections)
        print("🌍 Teleported " .. count .. " TOTAL items using " .. BringConfig.Speed .. " speed to " .. BringConfig.Destination)
    end)


    bringstuffGroup:AddButton("🗑️ CLEAR ALL LOCATIONS", function()
        for categoryName, combo in pairs(CategoryCombos) do
            removeLocationMarker(categoryName == "Wood" and "Fuel" or categoryName)
            combo:SetToggle(false)
        end
        print("🗑️ All custom locations cleared and toggles reset")
    end)
    
    bringstuffGroup:AddButton("📋 SHOW ACTIVE LOCATIONS", function()
        local activeLocations = {}
        for categoryName in pairs(ItemCategories) do
            if CustomLocations[categoryName] then
                table.insert(activeLocations, categoryName)
            end
        end
        
        if #activeLocations > 0 then
            print("📍 Active Locations: " .. table.concat(activeLocations, ", "))
            
            -- Also update toggle states to reflect actual state
            for categoryName, combo in pairs(CategoryCombos) do
                local actualCategory = categoryName == "Wood" and "Fuel" or categoryName
                if CustomLocations[actualCategory] then
                    combo:SetToggle(true)
                else
                    combo:SetToggle(false)
                end
            end
        else
            print("📍 No active locations set")
            
            -- Ensure all toggles are off
            for categoryName, combo in pairs(CategoryCombos) do
                combo:SetToggle(false)
            end
        end
    end)

    -- Auto-sync toggle states when locations exist on script start
    task.spawn(function()
        task.wait(2) -- Wait a bit for everything to load
        for categoryName, combo in pairs(CategoryCombos) do
            local actualCategory = categoryName == "Wood" and "Fuel" or categoryName
            if CustomLocations[actualCategory] then
                combo:SetToggle(true)
                print("🔄 Auto-synced " .. actualCategory .. " toggle to ON (location exists)")
            else
                combo:SetToggle(false)
            end
        end
    end)
end

-- Initialize Bring System
setupBringItemSystem(self.Tabs.BringTab)

-- Keybind for stop
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.P then
        stopAllBringing()
    end
end)

-- Clean up markers when script stops
game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == Player then
        for categoryName in pairs(LocationMarkers) do
            removeLocationMarker(categoryName)
        end
    end
end)

print("✅ BringTab loaded successfully!")


--Bring stuff end

end
 
-- RETURN the module so main script can use it
return BringTabSystem
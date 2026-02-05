--[[dwa
daw a
daw
dwa
 
adwd
aw
 d
aw
dwa
d
 a
dwa
d
a
d
ac
d

ac
t
3
3
34
t
bv3
t4se
t4
t
cvae
tv
a34tv3
wvwq3
vb53
vb5q3
vb4q53

 3q
5q
54q35 bt

 
4
 
TA4T 
QA3

GR

346T
3
EG
DV 

4
]]

local VisualTabSystem = {}
 
function VisualTabSystem:Init(menu, Tabs)
    -- Store references
    self.menu = menu
    self.Tabs = Tabs or {}
 
    -- Create tabs if not provided
    if not self.Tabs.VisualTab then
        self.Tabs.VisualTab = menu:CreateTab("Visual")
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

-- Chest ESP System
local ChestESP = {
    Enabled = false,
    Connection = nil,
    Chests = {},
    ChestHighlights = {},
    maxdistanceview = 5000,
    
    -- Chest categories with their Chinese names and colors
    ChestCategories = {
        ["2级宝箱"] = {
            Name = "Wooden Chest",
            Color = Color3.fromRGB(139, 69, 19), -- Brown
            PartName = "TouchPart"
        },
        ["3级宝箱"] = {
            Name = "Stone Chest",
            Color = Color3.fromRGB(128, 128, 128), -- Gray
            PartName = "TouchPart"
        },
        ["5级宝箱"] = {
            Name = "Gold Chest",
            Color = Color3.fromRGB(255, 215, 0), -- Gold
            PartName = "TouchPart"
        },
        ["6级宝箱"] = {
            Name = "Gold Silver Chest",
            Color = Color3.fromRGB(192, 192, 192), -- Silver
            PartName = "TouchPart"
        },
        ["小宝石宝箱"] = {
            Name = "Gem Chest",
            Color = Color3.fromRGB(0, 255, 255), -- Cyan
            PartName = "TouchPart"
        }
    },
    
    -- ESP display options
    DisplayOptions = {
        ["Name"] = true,
        ["Distance"] = true,
        ["Line"] = true
    },
    
    -- Chest visibility options (default: all visible)
    VisibleChests = {
        ["2级宝箱"] = true,
        ["3级宝箱"] = true,
        ["5级宝箱"] = true,
        ["6级宝箱"] = true,
        ["小宝石宝箱"] = true
    }
}

-- Function to scan for all chests in the map
local function scanForChests()
    ChestESP.Chests = {}
    
    local mapFolder = Services.Workspace:FindFirstChild("Map")
    if not mapFolder then
        print("❌ Map folder not found!")
        return {}
    end
    
    -- Scan for each chest type
    for chestName, chestInfo in pairs(ChestESP.ChestCategories) do
        if ChestESP.VisibleChests[chestName] then
            local chestModel = mapFolder:FindFirstChild(chestName)
            if chestModel and chestModel:IsA("Model") then
                local touchPart = chestModel:FindFirstChild(chestInfo.PartName)
                if touchPart and touchPart:IsA("BasePart") then
                    table.insert(ChestESP.Chests, {
                        Model = chestModel,
                        Part = touchPart,
                        Name = chestName,
                        DisplayName = chestInfo.Name,
                        Color = chestInfo.Color
                    })
                end
            end
            
            -- Also scan for additional instances
            for _, obj in pairs(mapFolder:GetChildren()) do
                if obj:IsA("Model") and obj.Name == chestName and obj ~= chestModel then
                    local touchPart = obj:FindFirstChild(chestInfo.PartName)
                    if touchPart and touchPart:IsA("BasePart") then
                        table.insert(ChestESP.Chests, {
                            Model = obj,
                            Part = touchPart,
                            Name = chestName,
                            DisplayName = chestInfo.Name,
                            Color = chestInfo.Color
                        })
                    end
                end
            end
        end
    end
    
    print("✅ Found " .. #ChestESP.Chests .. " chests")
    return ChestESP.Chests
end

-- Function to calculate distance from player
local function calculateDistance(chestPosition)
    if not Player.Character then return 0 end
    local hrp = Player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return 0 end
    return math.floor((hrp.Position - chestPosition).Magnitude)
end

-- Function to create ESP for a single chest
local function createChestESP(chestData)
    if not chestData.Model or not chestData.Part then return nil end
    
    -- Create the main highlight
    local highlight = Instance.new("Highlight")
    highlight.Name = "ChestESP_" .. chestData.Name
    highlight.Adornee = chestData.Model
    highlight.FillColor = chestData.Color
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    
    -- Create billboard for text
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ChestInfo"
    billboard.Size = UDim2.new(0, 200, 0, 80)
    billboard.StudsOffset = Vector3.new(0, 5, 0)
    billboard.Adornee = chestData.Part
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = ChestESP.maxdistanceview
    billboard.ResetOnSpawn = false
    
    -- Create text container
    local textContainer = Instance.new("Frame")
    textContainer.Name = "TextContainer"
    textContainer.Size = UDim2.new(1, 0, 1, 0)
    textContainer.BackgroundTransparency = 1
    
    -- Create name label
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = chestData.Color
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Text = chestData.DisplayName
    nameLabel.Visible = ChestESP.DisplayOptions["Name"]
    
    -- Create distance label
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Name = "DistanceLabel"
    distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distanceLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    distanceLabel.TextStrokeTransparency = 0
    distanceLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    distanceLabel.TextSize = 12
    distanceLabel.Font = Enum.Font.Gotham
    distanceLabel.Visible = ChestESP.DisplayOptions["Distance"]
    
    -- Add labels to container
    nameLabel.Parent = textContainer
    distanceLabel.Parent = textContainer
    textContainer.Parent = billboard
    billboard.Parent = highlight
    
    -- Create line to chest (optional)
    local line = nil
    if ChestESP.DisplayOptions["Line"] then
        line = Instance.new("LineHandleAdornment")
        line.Name = "ChestLine_" .. chestData.Name
        line.Color3 = chestData.Color
        line.Transparency = 0.7
        line.Thickness = 2
        line.ZIndex = 10
        line.Length = 0
        line.Visible = true
        line.Parent = game.CoreGui
    end
    
    -- Store ESP components
    local espComponents = {
        Highlight = highlight,
        Billboard = billboard,
        NameLabel = nameLabel,
        DistanceLabel = distanceLabel,
        Line = line,
        ChestData = chestData
    }
    
    -- Add to parent
    highlight.Parent = game.CoreGui
    
    return espComponents
end

-- Function to update ESP display
local function updateESP()
    -- Clear existing ESP
    for chestId, espData in pairs(ChestESP.ChestHighlights) do
        if espData.Highlight then espData.Highlight:Destroy() end
        if espData.Line then espData.Line:Destroy() end
    end
    ChestESP.ChestHighlights = {}
    
    if not ChestESP.Enabled then return end
    
    -- Scan for chests
    local chests = scanForChests()
    
    -- Create ESP for each chest
    for _, chestData in pairs(chests) do
        local espComponents = createChestESP(chestData)
        if espComponents then
            ChestESP.ChestHighlights[chestData.Model] = espComponents
        end
    end
    
    print("✅ ESP updated for " .. #chests .. " chests")
end

-- Function to update ESP positions and distances
local function updateESPInfo()
    if not ChestESP.Enabled or not Player.Character then return end
    
    local hrp = Player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    for chestModel, espData in pairs(ChestESP.ChestHighlights) do
        if espData.ChestData.Part and espData.ChestData.Part.Parent then
            -- Update distance
            if espData.DistanceLabel and ChestESP.DisplayOptions["Distance"] then
                local distance = math.floor((hrp.Position - espData.ChestData.Part.Position).Magnitude)
                espData.DistanceLabel.Text = distance .. " studs"
                espData.DistanceLabel.Visible = ChestESP.DisplayOptions["Distance"]
            end
            
            -- Update name visibility
            if espData.NameLabel then
                espData.NameLabel.Visible = ChestESP.DisplayOptions["Name"]
            end
            
            -- Update line
            if espData.Line then
                espData.Line.Visible = ChestESP.DisplayOptions["Line"]
                if ChestESP.DisplayOptions["Line"] then
                    espData.Line.Adornee = nil
                    espData.Line.Length = (hrp.Position - espData.ChestData.Part.Position).Magnitude
                    espData.Line.CFrame = CFrame.new(hrp.Position, espData.ChestData.Part.Position)
                end
            end
        else
            -- Chest no longer exists, remove ESP
            if espData.Highlight then espData.Highlight:Destroy() end
            if espData.Line then espData.Line:Destroy() end
            ChestESP.ChestHighlights[chestModel] = nil
        end
    end
end

-- Function to start ESP
local function startChestESP()
    if ChestESP.Enabled then return end
    
    ChestESP.Enabled = true
    print("🟢 Chest ESP Started")
    
    -- Initial scan
    updateESP()
    
    -- Start update loop
    ChestESP.Connection = Services.RunService.Heartbeat:Connect(function()
        if not ChestESP.Enabled then
            if ChestESP.Connection then
                ChestESP.Connection:Disconnect()
                ChestESP.Connection = nil
            end
            return
        end
        
        updateESPInfo()
    end)
end

-- Function to stop ESP
local function stopChestESP()
    ChestESP.Enabled = false
    
    if ChestESP.Connection then
        ChestESP.Connection:Disconnect()
        ChestESP.Connection = nil
    end
    
    -- Remove all ESP visuals
    for chestModel, espData in pairs(ChestESP.ChestHighlights) do
        if espData.Highlight then espData.Highlight:Destroy() end
        if espData.Line then espData.Line:Destroy() end
    end
    ChestESP.ChestHighlights = {}
    
    print("🛑 Chest ESP Stopped")
end

-- Function to toggle ESP
local function toggleChestESP(state)
    if state then
        startChestESP()
    else
        stopChestESP()
    end
end

-- Function to refresh ESP
local function refreshChestESP()
    print("🔄 Refreshing Chest ESP...")
    updateESP()
end

-- Create GUI for Chest ESP
local chestESPGroup = self.menu:CreateCollapsibleGroup(self.Tabs.VisualTab, "📦 CHEST ESP SYSTEM", false, 300)
self.menu:MarkAsNew(chestESPGroup:GetInstance(), "NEW")

-- Main Toggle
chestESPGroup:AddToggle("📦 Enable Chest ESP", false, function(state)
    toggleChestESP(state)
end)

-- MultiDropdown for Display Options
chestESPGroup:AddMultiDropdown("👁️ Display Options", {"Name", "Distance", "Line"}, {
    ["Name"] = true,
    ["Distance"] = true,
    ["Line"] = true
}, function(selectedOptions)
    -- Update display options
    for option, _ in pairs(ChestESP.DisplayOptions) do
        ChestESP.DisplayOptions[option] = false
    end
    
    for _, option in ipairs(selectedOptions) do
        ChestESP.DisplayOptions[option] = true
    end
    
    print("👁️ Display options updated: " .. table.concat(selectedOptions, ", "))
    
    -- Refresh ESP if enabled
    if ChestESP.Enabled then
        updateESP()
    end
end)


-- MultiDropdown for Chest Categories
local chestCategoryNames = {}
for chestName, _ in pairs(ChestESP.ChestCategories) do
    table.insert(chestCategoryNames, chestName)
end

chestESPGroup:AddMultiDropdown("🗃️ Chest Categories", chestCategoryNames, ChestESP.VisibleChests, function(selectedChests)
    -- Update visible chests
    for chestName, _ in pairs(ChestESP.VisibleChests) do
        ChestESP.VisibleChests[chestName] = false
    end
    
    for _, chestName in ipairs(selectedChests) do
        ChestESP.VisibleChests[chestName] = true
    end
    
    print("🗃️ Visible chests updated: " .. table.concat(selectedChests, ", "))
    
    -- Refresh ESP if enabled
    if ChestESP.Enabled then
        updateESP()
    end
end)

-- Refresh Button
chestESPGroup:AddButton("🔄 Refresh ESP", function()
    refreshChestESP()
end)

-- Chest Info Display
local chestCountLabel = chestESPGroup:AddLabel("Found Chests: 0")

-- Chest List Display
local chestListLabel = chestESPGroup:AddLabel("Chest Types: Loading...")

-- Function to update chest info display
local function updateChestInfoDisplay()
    local chests = scanForChests()
    chestCountLabel.Text = "Found Chests: " .. #chests
    
    -- Count chests by type
    local chestCounts = {}
    for _, chestData in pairs(chests) do
        chestCounts[chestData.Name] = (chestCounts[chestData.Name] or 0) + 1
    end
    
    -- Create display text
    local displayText = "Chest Types: "
    local first = true
    for chestName, count in pairs(chestCounts) do
        if not first then
            displayText = displayText .. " | "
        end
        displayText = displayText .. chestName .. ": " .. count
        first = false
    end
    
    if first then
        displayText = "Chest Types: None found"
    end
    
    chestListLabel.Text = displayText
end

-- Auto-update chest info periodically
task.spawn(function()
    while true do
        task.wait(5)
        if ChestESP.Enabled then
            updateChestInfoDisplay()
        end
    end
end)

-- Manual update button
chestESPGroup:AddButton("📊 Update Chest Info", function()
    updateChestInfoDisplay()
end)

-- Chest Color Legend
chestESPGroup:AddLabel("🎨 Chest Colors:")
chestESPGroup:AddLabel("🟤 2级宝箱 - Wooden (Brown)")
chestESPGroup:AddLabel("⚪ 3级宝箱 - Stone (Gray)")
chestESPGroup:AddLabel("🟡 5级宝箱 - Gold (Gold)")
chestESPGroup:AddLabel("🔘 6级宝箱 - Gold Silver (Silver)")
chestESPGroup:AddLabel("🔵 小宝石宝箱 - Gem (Cyan)")

-- Initial setup
task.spawn(function()
    task.wait(3)
    
    -- Do initial scan
    local chests = scanForChests()
    
    -- Log found chests
    print("📦 Chest ESP System Loaded!")
    print("📦 Found " .. #chests .. " chests")
    
    if #chests > 0 then
        local chestTypes = {}
        for _, chestData in pairs(chests) do
            if not table.find(chestTypes, chestData.Name) then
                table.insert(chestTypes, chestData.Name)
            end
        end
        print("📦 Chest types: " .. table.concat(chestTypes, ", "))
    end
    
    updateChestInfoDisplay()
end)

-- Clean up when script ends
game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == Player then
        stopChestESP()
    end
end)

print("✅ Chest ESP System Loaded!")


end
 
-- RETURN the module so main script can use it
return VisualTabSystem
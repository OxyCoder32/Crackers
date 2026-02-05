--[[
d
aw
dca
dca
cda

d
acdacwdcwa


cad
ac
dw

a
dc
w
ca

dcwa
dcwa
dc22
c
2

a
c
2da
c
da2
dca2

ca

dca

dca
d
ac
d
ac

dca

dca
c
d
2
a
da

ac
c
dd
d2
d
c
a2c
dc


ad

ac
da
]]

local MainTabSystem = {}
 
function MainTabSystem:Init(menu, Tabs)
    -- Store references
    self.menu = menu
    self.Tabs = Tabs or {}
 
    -- Create tabs if not provided
    if not self.Tabs.MainTab then
        self.Tabs.MainTab = menu:CreateTab("Main")
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

--MainTab Start 

--Auto Reveal map start
--// 🧱 Safe Height (optimized)
local SafeHeight = {Enabled = false, Value = 50, OriginalHeight = 0}

local safeheightGroup = self.menu:CreateCollapsibleGroup(self.Tabs.MainTab,"🌪️ SAFE HEIGHT ",true,150)
self.menu:MarkAsNew(safeheightGroup:GetInstance(),"V2")

safeheightGroup:AddToggle("Safty Height:", false, function(state)
    SafeHeight.Enabled = state
    if Humanoid then
        if state then
            SafeHeight.OriginalHeight = Humanoid.HipHeight
            Humanoid.HipHeight = SafeHeight.Value
        else
            Humanoid.HipHeight = SafeHeight.OriginalHeight
        end
    end
end)

safeheightGroup:AddSlider("Height Settings", 0, 100, SafeHeight.Value, function(value)
    SafeHeight.Value = value
    if SafeHeight.Enabled and Humanoid then
        Humanoid.HipHeight = value
    end
end)

-- Map Reveal System (square spiral from center)
local MapReveal = {
    Active = false, 
    Player = Player,
    CurrentLayer = 0,
    CurrentSide = 1, -- 1: right, 2: down, 3: left, 4: up
    CurrentStep = 0,
    CenterPosition = Vector3.new(-0.01, 13, 0.04) -- Campfire location as center
}
local CameraFreeView = {Enabled = false, OriginalCameraType = nil}

-- Square map boundaries
local mapBounds = {
    left = -1360,
    right = 1360,
    top = -1350,
    bottom = 1351
}
local height = 100

function MapReveal:StartReveal()
    if self.Active then return end
    self.Active = true
    
    local character = self.Player.Character or self.Player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    spawn(function()
        local layer = self.CurrentLayer
        local side = self.CurrentSide
        local step = self.CurrentStep
        local stepSize = 50
        
        while self.Active do
            local sideLength = layer * 2 + 1
            local maxSteps = side == 1 and sideLength or sideLength - 1
            
            -- Calculate position based on current layer, side, and step
            local x, z = self.CenterPosition.X, self.CenterPosition.Z
            local offset = layer * stepSize
            
            if side == 1 then -- Right side
                x = self.CenterPosition.X - offset + (step * stepSize)
                z = self.CenterPosition.Z - offset
            elseif side == 2 then -- Down side
                x = self.CenterPosition.X + offset
                z = self.CenterPosition.Z - offset + (step * stepSize)
            elseif side == 3 then -- Left side
                x = self.CenterPosition.X + offset - (step * stepSize)
                z = self.CenterPosition.Z + offset
            elseif side == 4 then -- Up side
                x = self.CenterPosition.X - offset
                z = self.CenterPosition.Z + offset - (step * stepSize)
            end
            
            -- Check if position is within map bounds
            if x >= mapBounds.left and x <= mapBounds.right and z >= mapBounds.top and z <= mapBounds.bottom then
                local position = Vector3.new(x, self.CenterPosition.Y + height, z)
                rootPart.CFrame = CFrame.new(position)
                task.wait(0.02)
            end
            
            -- Move to next step
            step = step + 1
            
            -- Check if we completed current side
            if step >= maxSteps then
                step = 0
                side = side + 1
                
                -- Check if we completed current layer
                if side > 4 then
                    side = 1
                    layer = layer + 1
                    
                    -- Check if we've covered the entire map
                    local maxOffset = math.max(
                        math.abs(mapBounds.left - self.CenterPosition.X),
                        math.abs(mapBounds.right - self.CenterPosition.X),
                        math.abs(mapBounds.top - self.CenterPosition.Z),
                        math.abs(mapBounds.bottom - self.CenterPosition.Z)
                    )
                    local maxLayers = math.ceil(maxOffset / stepSize)
                    
                    if layer > maxLayers then
                        -- Map fully revealed, return to center
                        rootPart.CFrame = CFrame.new(self.CenterPosition)
                        self:ResetProgress()
                        self.Active = false
                        break
                    end
                end
            end
            
            -- Save progress
            if self.Active then
                self.CurrentLayer = layer
                self.CurrentSide = side
                self.CurrentStep = step
            end
        end
    end)
end

function MapReveal:StopReveal()
    self.Active = false
end

function MapReveal:ResetProgress()
    self.CurrentLayer = 0
    self.CurrentSide = 1
    self.CurrentStep = 0
end

function MapReveal:GetProgressPercentage()
    local totalArea = (mapBounds.right - mapBounds.left) * (mapBounds.bottom - mapBounds.top)
    local maxOffset = math.max(
        math.abs(mapBounds.left - self.CenterPosition.X),
        math.abs(mapBounds.right - self.CenterPosition.X),
        math.abs(mapBounds.top - self.CenterPosition.Z),
        math.abs(mapBounds.bottom - self.CenterPosition.Z)
    )
    local maxLayers = math.ceil(maxOffset / 50)
    
    if self.CurrentLayer >= maxLayers then
        return 100
    end
    
    local currentRadius = self.CurrentLayer * 50
    local revealedArea = math.pi * currentRadius * currentRadius
    return math.min(100, math.floor((revealedArea / totalArea) * 100))
end

-- Initialize
MapReveal:ResetProgress()

local revealMapGroup = self.menu:CreateCollapsibleGroup(self.Tabs.AutoTab,"🗺️ REVEAL FULL MAP 🗺️",true,150)
self.menu:MarkAsNew(revealMapGroup:GetInstance(), "V2")

revealMapGroup:AddButton("START Complete Map Coverage", function()
    if not MapReveal.Active then 
        MapReveal:StartReveal() 
    end
end)

revealMapGroup:AddButton("STOP Coverage", function()
    if MapReveal.Active then 
        MapReveal:StopReveal() 
    end
end)

revealMapGroup:AddToggle("Camera Free View", false, function(state)
    CameraFreeView.Enabled = state
    Camera.CameraType = state and Enum.CameraType.Scriptable or (CameraFreeView.OriginalCameraType or Enum.CameraType.Custom)
end)

revealMapGroup:AddButton("RESET Progress", function()
    MapReveal:StopReveal()
    MapReveal:ResetProgress()
end)

-- Add progress display
revealMapGroup:AddLabel("Progress: 0%")

-- Update progress display periodically
spawn(function()
    while true do
        task.wait(1)
        if revealMapGroup:GetInstance() then
            local progress = MapReveal:GetProgressPercentage()
            -- Update the label with current progress
            -- You might need to adjust this based on your self.menu system's API
        end
    end
end)

--Auto Reveal map end

-- Tree Aura System (Direct Working Logic in Library)
local TreeAura = {
    Enabled = false,
    Range = 10000,
    DamageCooldown = 0.5,
    LastDamageTime = 0,
    Connection = nil,
    Status = "Inactive",
    ScannedTrees = {},
    Character = nil,
    HumanoidRootPart = nil,
    SelectedTrees = {
        ["TreeL"] = true,
        ["TreeXL"] = true
    }
}

-- Get the hit event
local CharacterHitTargetC2S = Services.ReplicatedStorage:WaitForChild("Events"):WaitForChild("Game"):WaitForChild("CharacterHitTargetC2S")

-- Updated scan function with tree type filtering
local function scanForTrees()
    TreeAura.ScannedTrees = {}
    
    local mapFolder = Services.Workspace:FindFirstChild("Map")
    if not mapFolder then 
        TreeAura.Status = "❌ Map folder not found"
        return 
    end
    
    -- Check which tree types are selected
    local scanTreeL = TreeAura.SelectedTrees["TreeL"]
    local scanTreeXL = TreeAura.SelectedTrees["TreeXL"]
    
    -- Scan for TreeL if selected
    if scanTreeL then
        local treeL = mapFolder:FindFirstChild("TreeL")
        if treeL then
            local part = treeL:FindFirstChild("Part") or treeL:FindFirstChildWhichIsA("BasePart")
            if part then
                table.insert(TreeAura.ScannedTrees, {
                    object = treeL,
                    part = part,
                    name = treeL.Name
                })
            end
        end
        
        -- Also scan for other TreeL instances
        for _, obj in pairs(mapFolder:GetChildren()) do
            if obj.Name == "TreeL" and obj ~= mapFolder:FindFirstChild("TreeL") then
                local part = obj:FindFirstChild("Part") or obj:FindFirstChildWhichIsA("BasePart")
                if part then
                    table.insert(TreeAura.ScannedTrees, {
                        object = obj,
                        part = part,
                        name = obj.Name
                    })
                end
            end
        end
    end
    
    -- Scan for TreeXL if selected
    if scanTreeXL then
        local treeXL = mapFolder:FindFirstChild("TreeXL")
        if treeXL then
            local part = treeXL:FindFirstChild("Part") or treeXL:FindFirstChildWhichIsA("BasePart")
            if part then
                table.insert(TreeAura.ScannedTrees, {
                    object = treeXL,
                    part = part,
                    name = treeXL.Name
                })
            end
        end
        
        -- Also scan for other TreeXL instances
        for _, obj in pairs(mapFolder:GetChildren()) do
            if obj.Name == "TreeXL" and obj ~= mapFolder:FindFirstChild("TreeXL") then
                local part = obj:FindFirstChild("Part") or obj:FindFirstChildWhichIsA("BasePart")
                if part then
                    table.insert(TreeAura.ScannedTrees, {
                        object = obj,
                        part = part,
                        name = obj.Name
                    })
                end
            end
        end
    end
    
    -- Also scan for other trees with "Tree" in name (for any additional tree types)
    for _, obj in pairs(mapFolder:GetChildren()) do
        if (obj.Name:find("Tree") or obj.Name:find("tree")) and not TreeAura.ScannedTrees[obj] then
            local isTreeL = obj.Name == "TreeL" and scanTreeL
            local isTreeXL = obj.Name == "TreeXL" and scanTreeXL
            
            if isTreeL or isTreeXL then
                local part = obj:FindFirstChild("Part") or obj:FindFirstChildWhichIsA("BasePart")
                if part then
                    table.insert(TreeAura.ScannedTrees, {
                        object = obj,
                        part = part,
                        name = obj.Name
                    })
                end
            end
        end
    end
    
    TreeAura.Status = "✅ Scanned " .. #TreeAura.ScannedTrees .. " trees"
    return TreeAura.ScannedTrees
end

-- Exact same damage function from working GUI
local function damageTreesInRange()
    if not TreeAura.Enabled or not TreeAura.HumanoidRootPart then return end
    
    local currentTime = tick()
    if currentTime - TreeAura.LastDamageTime < TreeAura.DamageCooldown then
        return
    end
    
    local trees = TreeAura.ScannedTrees
    local damagedAny = false
    
    for _, tree in pairs(trees) do
        if tree.part and tree.part.Parent then
            local distance = (TreeAura.HumanoidRootPart.Position - tree.part.Position).Magnitude
            if distance <= TreeAura.Range then
                local args = {tree.object}
                CharacterHitTargetC2S:FireServer(unpack(args))
                damagedAny = true
                TreeAura.Status = "🪓 Damaging " .. tree.name .. " (" .. math.floor(distance) .. " studs)"
            end
        end
    end
    
    if damagedAny then
        TreeAura.LastDamageTime = currentTime
    else
        TreeAura.Status = "🌳 Active - No trees in range"
    end
end

-- Exact same character setup from working GUI
local function setupCharacter()
    TreeAura.Character = Player.Character or Player.CharacterAdded:Wait()
    TreeAura.HumanoidRootPart = TreeAura.Character:WaitForChild("HumanoidRootPart")
    
    if TreeAura.Enabled then
        scanForTrees()
    end
end

-- Exact same toggle logic from working GUI
local function toggleTreeAura(state)
    if state then
        -- Turn ON
        TreeAura.Status = "Scanning trees..."
        
        if not TreeAura.Character then
            setupCharacter()
        end
        
        scanForTrees()
        
        if #TreeAura.ScannedTrees == 0 then
            TreeAura.Status = "❌ No trees found"
            return
        end
        
        TreeAura.Enabled = true
        TreeAura.Status = "🟢 Tree Aura Started"
        
        -- Start the main loop (same as working GUI)
        TreeAura.Connection = Services.RunService.Heartbeat:Connect(function()
            if not TreeAura.Enabled then
                if TreeAura.Connection then
                    TreeAura.Connection:Disconnect()
                end
                return
            end
            
            if TreeAura.HumanoidRootPart and TreeAura.HumanoidRootPart.Parent then
                pcall(damageTreesInRange)
                
                -- Rescan every 5 seconds
                if tick() % 5 < 0.1 then
                    scanForTrees()
                end
            else
                TreeAura.Enabled = false
                TreeAura.Status = "Character not found"
            end
        end)
        
    else
        -- Turn OFF
        TreeAura.Enabled = false
        if TreeAura.Connection then
            TreeAura.Connection:Disconnect()
        end
        TreeAura.Status = "🛑 Tree Aura Stopped"
    end
end

-- Create GUI for Tree Aura
local treeAuraGroup = self.menu:CreateCollapsibleGroup(self.Tabs.MainTab, "🌳 TREE AURA SYSTEM", false, 240)
self.menu:MarkAsNew(treeAuraGroup:GetInstance(), "NEW")

-- Tree Type Selection MultiDropdown
local availableTreeTypes = {"TreeL", "TreeXL"}
local defaultSelections = {
    ["TreeL"] = true,
    ["TreeXL"] = true
}
treeAuraGroup:AddToggle("🌳 Turn on Tree Aura", false, function(state)
    toggleTreeAura(state)
end)
treeAuraGroup:AddMultiDropdown("🌲 Select Tree Types", availableTreeTypes, defaultSelections, function(selectedTypesArray)
    -- Reset all selections
    for treeType, _ in pairs(TreeAura.SelectedTrees) do
        TreeAura.SelectedTrees[treeType] = false
    end
    
    -- Set selected types
    for _, treeType in ipairs(selectedTypesArray) do
        TreeAura.SelectedTrees[treeType] = true
    end
    
    -- Update selected types display
    local selectedList = {}
    for treeType, isSelected in pairs(TreeAura.SelectedTrees) do
        if isSelected then
            table.insert(selectedList, treeType)
        end
    end
    selectedTypesLabel:SetText("Selected: " .. table.concat(selectedList, ", "))
    
    -- Rescan if aura is active
    if TreeAura.Enabled then
        scanForTrees()
    else
        scanForTrees() -- Always rescan when selection changes
    end
end)

-- Main Toggle


-- Aura Range Slider
treeAuraGroup:AddSlider("🔗 Aura Range", 100, 50000, TreeAura.Range, function(value)
    TreeAura.Range = value
end)

-- Chop Speed Slider
treeAuraGroup:AddSlider("⚡ Chop Speed", 0.1, 2, TreeAura.DamageCooldown, function(value)
    TreeAura.DamageCooldown = value
end)

-- Refresh Trees Button
treeAuraGroup:AddButton("🔄 Refresh Trees", function()
    scanForTrees()
end)

-- Selected Types Display
local selectedTypesLabel = treeAuraGroup:AddLabel("Selected: TreeL, TreeXL")

-- Tree Count Display
local treeCountLabel = treeAuraGroup:AddLabel("Scanned Trees: " .. #TreeAura.ScannedTrees)

-- Status Display
local statusLabel = treeAuraGroup:AddLabel("Status: " .. TreeAura.Status)



-- Update UI when status changes
local originalStatus = TreeAura.Status
setmetatable(TreeAura, {
    __newindex = function(self, key, value)
        rawset(self, key, value)
        if key == "Status" or key == "ScannedTrees" then
        end
    end
})

-- Setup character
Player.CharacterAdded:Connect(setupCharacter)
setupCharacter()

-- Initial scan
task.spawn(function()
    task.wait(2)
    scanForTrees()
end)

print("✅ Tree Aura System Loaded!")
--Aura chop start

-- Get the remote event
local CharacterHitTargetEvent = Services.ReplicatedStorage:WaitForChild("Events"):WaitForChild("Game"):WaitForChild("CharacterHitTargetC2S")

-- Combined Aura Kill System
local AuraKill = {
    Enabled = false,
    Range = 50,
    DamageCooldown = 0.02,
    LastDamageTime = 0,
    Connection = nil,
    Status = "Ready",
    ScannedTargets = {},
    Character = nil,
    HumanoidRootPart = nil,
    
    -- Target configurations
    TargetTypes = {
        "BunnyModel",
        "CowboyMeleeV1", 
        "CowboyMeleeV2",
        "CowboyMeleeV3",
        "CowboyMeleeV4",
        "CowboyGunV1",
        "CowboyGunV2",
        "CowboyGunV3",
        "CowboyGunV4",
        "CowboyHatBlack",
        "CowboyMeleeVC",
        "CowboyGunVC",
		"Snow Lancer",
		"Snow Archer",
        "Stubble Beard",
        "Pine",
        "Gabe",
        "Snowy",
        "Mr.Doge",
        "Bandit",
        "Bandit Jack",
        "Enemy",
        "Target",
		"雪原.小牛",
		"脸",
		"小牛"
    },
    
    -- Whitelist for specific target names
    WhitelistedTargets = {
        "BunnyModel",
        "CowboyMeleeV1",
        "CowboyMeleeV2",
        "CowboyMeleeV3",
        "CowboyMeleeV4",
        "CowboyHatBlack",
        "CowboyGunV1",
        "CowboyGunV2",
        "CowboyGunV3",
        "CowboyGunV4",
        "CowboyMeleeVC",
        "CowboyGunVC",
        "Stubble Beard",
        "Pine",
        "Gabe",
        "Mr.Doge",
        "Sam",
        "Desperadp's Poncho",
        "Jack",
        "FronttierSanchel",
        "Bandit Jack",
        "Wolf",
        "Maya",
        "HumannoidRootPart",
        "Mad Bear",
        "Carlos",
        "TakeDamageModel",
        "Wild Archer",
        "Wild Lancer",
        "White Desperado",
        "Bear",
        "Wild Boar",
        "King of Wild Boars",
        "Snowy",
		"Snow Lancer",
		"Snow Archer",
		"雪原.小牛",
		"脸",
		"小牛"
    }
}

-- Function to scan for ALL possible targets
local function scanForTargets()
    AuraKill.ScannedTargets = {}
    local foundCount = 0
    
    -- Method 1: Direct model search
    for _, targetName in ipairs(AuraKill.TargetTypes) do
        local target = Services.Workspace:FindFirstChild(targetName)
        if target and target:IsA("Model") then
            table.insert(AuraKill.ScannedTargets, target)
            foundCount = foundCount + 1
        end
    end
    
    -- Method 2: Search through descendants for partial matches
    for _, obj in ipairs(Services.Workspace:GetDescendants()) do
        if obj:IsA("Model") then
            for _, targetName in ipairs(AuraKill.WhitelistedTargets) do
                if obj.Name == targetName then
                    table.insert(AuraKill.ScannedTargets, obj)
                    foundCount = foundCount + 1
                    break
                end
            end
        end
    end
    
    -- Method 3: Search in common enemy folders
    local enemyFolders = {"Enemys", "Enemies", "Targets", "NPCs"}
    for _, folderName in ipairs(enemyFolders) do
        local folder = Services.Workspace:FindFirstChild(folderName)
        if folder then
            for _, enemy in ipairs(folder:GetDescendants()) do
                if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") then
                    table.insert(AuraKill.ScannedTargets, enemy)
                    foundCount = foundCount + 1
                end
            end
        end
    end
    
    AuraKill.Status = "✅ Scanned " .. foundCount .. " targets"
    return AuraKill.ScannedTargets
end

-- Check if target is valid and in range
local function IsValidTarget(target)
    if not target then return false end
    
    local character = AuraKill.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return false end
    
    -- Get target position (handle different target structures)
    local targetPos
    if target:IsA("Model") and target.PrimaryPart then
        targetPos = target.PrimaryPart.Position
    elseif target:FindFirstChild("HumanoidRootPart") then
        targetPos = target.HumanoidRootPart.Position
    elseif target:FindFirstChild("Head") then
        targetPos = target.Head.Position
    else
        return false
    end
    
    local playerPos = character.HumanoidRootPart.Position
    local distance = (playerPos - targetPos).Magnitude
    
    return distance <= AuraKill.Range
end

-- Hit the target using the remote event
local function HitTarget(target)
    if not target then return false end
    
    local success, err = pcall(function()
        local args = {target}
        CharacterHitTargetEvent:FireServer(unpack(args))
        return true
    end)
    
    if success then
        return true
    else
        warn("❌ Failed to hit target " .. target.Name .. ": " .. tostring(err))
        return false
    end
end

-- Aura damage loop
local function damageTargetsInRange()
    if not AuraKill.Enabled then return end
    
    local currentTime = tick()
    if currentTime - AuraKill.LastDamageTime < AuraKill.DamageCooldown then
        return
    end
    
    local targets = AuraKill.ScannedTargets
    local damagedAny = false
    local targetsHit = 0
    
    for _, target in pairs(targets) do
        if IsValidTarget(target) then
            if HitTarget(target) then
                damagedAny = true
                targetsHit = targetsHit + 1
            end
        end
    end
    
    if damagedAny then
        AuraKill.LastDamageTime = currentTime
        AuraKill.Status = "⚔️ Hit " .. targetsHit .. " targets"
    else
        AuraKill.Status = "🔍 Active - No targets in range"
    end
end

-- Character setup
local function setupCharacter()
    AuraKill.Character = Player.Character or Player.CharacterAdded:Wait()
    AuraKill.HumanoidRootPart = AuraKill.Character:WaitForChild("HumanoidRootPart")
    
    if AuraKill.Enabled then
        scanForTargets()
    end
end

-- Function to start aura kill
local function startAuraKill()
    if AuraKill.Enabled then return end
    
    AuraKill.Status = "Scanning targets..."
    
    if not AuraKill.Character then
        setupCharacter()
    end
    
    scanForTargets()
    
    if #AuraKill.ScannedTargets == 0 then
        AuraKill.Status = "❌ No targets found"
        return
    end
    
    AuraKill.Enabled = true
    AuraKill.Status = "🟢 Aura Kill Started - Range: " .. AuraKill.Range .. " studs"
    
    -- Start the main loop
    AuraKill.Connection = Services.RunService.Heartbeat:Connect(function()
        if not AuraKill.Enabled then
            if AuraKill.Connection then
                AuraKill.Connection:Disconnect()
            end
            return
        end
        
        if AuraKill.HumanoidRootPart and AuraKill.HumanoidRootPart.Parent then
            pcall(damageTargetsInRange)
            
            -- Rescan every 5 seconds for new targets
            if tick() % 5 < 0.1 then
                scanForTargets()
            end
        else
            AuraKill.Enabled = false
            AuraKill.Status = "❌ Character not found"
        end
    end)
end

-- Function to stop aura kill
local function stopAuraKill()
    AuraKill.Enabled = false
    if AuraKill.Connection then
        AuraKill.Connection:Disconnect()
        AuraKill.Connection = nil
    end
    AuraKill.Status = "🛑 Aura Kill Stopped"
end

-- Function to toggle aura kill
local function toggleAuraKill(state)
    if state then
        startAuraKill()
    else
        stopAuraKill()
    end
end

-- Create GUI for Aura Kill
local auraKillGroup = self.menu:CreateCollapsibleGroup(self.Tabs.MainTab, "💀 ULTIMATE AURA KILL", false, 250)
self.menu:MarkAsNew(auraKillGroup:GetInstance(), "V2")

-- Main Toggle
auraKillGroup:AddToggle("💀 Enable Aura Kill", false, function(state)
    toggleAuraKill(state)
end)

-- Aura Range Slider
auraKillGroup:AddSlider("🔗 Aura Range", 10, 200, AuraKill.Range, function(value)
    AuraKill.Range = value
    if AuraKill.Enabled then
        AuraKill.Status = "Range updated: " .. value .. " studs"
    end
end)

-- Attack Speed Slider
auraKillGroup:AddSlider("⚡ Attack Speed", 0.05, 1, AuraKill.DamageCooldown, function(value)
    AuraKill.DamageCooldown = value
    if AuraKill.Enabled then
        AuraKill.Status = "Speed updated: " .. value .. "s delay"
    end
end)





-- Auto-update status
task.spawn(function()
    while true do
        task.wait(1)
    end
end)

-- Visual ESP for targets
local VisualGroup = self.menu:CreateCollapsibleGroup(self.Tabs.VisualTab, "🎯 TARGET ESP", true, 100)
self.menu:MarkAsNew(VisualGroup:GetInstance(),"NEW")
local ESPEnabled = false
local ESPHighlights = {}

local function UpdateTargetESP()
    -- Clean up old highlights
    for target, highlight in pairs(ESPHighlights) do
        if highlight then
            highlight:Destroy()
        end
    end
    ESPHighlights = {}
    
    if not ESPEnabled then return end
    
    -- Create highlights for all scanned targets
    for _, target in ipairs(AuraKill.ScannedTargets) do
        if target and (target.PrimaryPart or target:FindFirstChild("HumanoidRootPart") or target:FindFirstChild("Head")) then
            local highlight = Instance.new("Highlight")
            highlight.Adornee = target
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            highlight.Name = "SFY_AuraESP_" .. target.Name
            highlight.Parent = game.CoreGui
            ESPHighlights[target] = highlight
        end
    end
end

VisualGroup:AddToggle("Show Target ESP", false, function(state)
    ESPEnabled = state
    UpdateTargetESP()
end)

-- Setup character when player joins
Player.CharacterAdded:Connect(function(character)
    setupCharacter()
end)

-- Auto-stop when player dies
task.spawn(function()
    while true do
        task.wait(3)
        if AuraKill.Enabled then
            local character = Player.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") or 
               (character:FindFirstChild("Humanoid") and character.Humanoid.Health <= 0) then
                stopAuraKill()
            end
        end
    end
end)

-- Auto-refresh ESP when targets update
task.spawn(function()
    while true do
        task.wait(5)
        if ESPEnabled then
            UpdateTargetESP()
        end
    end
end)

-- Initial setup
task.spawn(function()
    task.wait(3)
    setupCharacter()
    local found = scanForTargets()
    
    -- Print initial target scan results
    print("🎯 SFY Aura Kill - Initial Target Scan:")
    if #found > 0 then
        for i, target in ipairs(found) do
            print("   " .. i .. ". " .. target.Name)
        end
    else
        print("   ❌ No targets found automatically")
        print("   💡 Try using 'Refresh Targets' button")
    end
    
end)

-- Manual target test function (for debugging)
local function testSpecificTarget(targetName)
    local target = Services.Workspace:FindFirstChild(targetName)
    if target then
        local args = {target}
        local success, err = pcall(function()
            CharacterHitTargetEvent:FireServer(unpack(args))
            return true
        end)
        
        if success then
            print("✅ Successfully hit: " .. targetName)
        else
            print("❌ Failed to hit " .. targetName .. ": " .. tostring(err))
        end
    else
        print("❌ Target not found: " .. targetName)
    end
end

end
 
-- RETURN the module so main script can use it
return MainTabSystem
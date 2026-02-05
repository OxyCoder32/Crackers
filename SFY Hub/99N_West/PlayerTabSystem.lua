--[[
DAWD
AW
D
AWDCA
DCA
C
DA
CDAWD
CA
D
C
D
dcwa
dca
d
c2
2c2
a
cd
a2
dc

t3
b 
e4
bt
es
b ts
tb e
s
t4e 
st
se 
4
e g
4
es
g 
e
g
 4
a ge4g
e
g
fd
]]


local PlayerTabSystem = {}
 
function PlayerTabSystem:Init(menu, Tabs)
    -- Store references
    self.menu = menu
    self.Tabs = Tabs or {}
 
    -- Create tabs if not provided
    if not self.Tabs.PlayerTab then
        self.Tabs.PlayerTab = menu:CreateTab("Local Player")
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

--Local player start

--PlayerTab Start


-- Add this to your existing script after creating all self.Tabs

-- Create the invisible group in PlayerTab
local invisibleGroup = self.menu:CreateCollapsibleGroup(self.Tabs.PlayerTab, "🎭 INVISIBLE SYSTEM", false, 200)
self.menu:MarkAsNew(invisibleGroup:GetInstance(), "NEW")

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

print("✅ Invisible Hybrid System (No GUI) Ready for SFY self.menu Integration!")

--// 🧍 Player Settings (optimized)
local PlayerSettings = {
    Noclip = false,
    InfiniteJump = false,
    TpWalk = {Enabled = false, Speed = 50, Connection = nil},
    FOV = {Enabled = false, Value = Camera.FieldOfView},
    FullBright = false,
    FullBrightConnection = nil,
    Fly = {Enabled = false, Speed = 16, BodyVelocity = nil, Connection = nil},
    SpeedHack = {Enabled = false, Speed = 90, WSLoop = nil, WSCA = nil}
}

local playerVisualGroup = self.menu:CreateCollapsibleGroup(self.Tabs.PlayerTab,"LOCAL PLAYER VISUAL SETTINGS",false,130)
self.menu:MarkAsNew(playerVisualGroup:GetInstance(),"V2")

local playerSpeedGroup = self.menu:CreateCollapsibleGroup(self.Tabs.PlayerTab,"LOCAL PLAYER SPEED HACK",true,240)
self.menu:MarkAsNew(playerSpeedGroup:GetInstance(),"V2")

local playerCharacterGroup = self.menu:CreateCollapsibleGroup(self.Tabs.PlayerTab,"LOCAL PLAYER CHARACTER MODS",false,130)
self.menu:MarkAsNew(playerCharacterGroup:GetInstance(),"V2")


-- FOV
playerVisualGroup:AddToggle("Player FOV:", false, function(state)
    PlayerSettings.FOV.Enabled = state
    Camera.FieldOfView = state and PlayerSettings.FOV.Value or 70
end)

playerVisualGroup:AddSlider("FOV Value", 50, 120, PlayerSettings.FOV.Value, function(value)
    PlayerSettings.FOV.Value = value
    if PlayerSettings.FOV.Enabled then Camera.FieldOfView = value end
end)


local function applyLoopspeed(speaker, speed)
    local Char = speaker.Character or Services.Workspace:FindFirstChild(speaker.Name)
    local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
    if not Human then return end
    
    local function WalkSpeedChange()
        if Char and Human and Human.Parent then
            Human.WalkSpeed = speed
        end
    end
    
    WalkSpeedChange()
    
    if PlayerSettings.SpeedHack.WSLoop then
        PlayerSettings.SpeedHack.WSLoop:Disconnect()
    end
    PlayerSettings.SpeedHack.WSLoop = Human:GetPropertyChangedSignal("WalkSpeed"):Connect(WalkSpeedChange)
    
    if PlayerSettings.SpeedHack.WSCA then
        PlayerSettings.SpeedHack.WSCA:Disconnect()
    end
    PlayerSettings.SpeedHack.WSCA = speaker.CharacterAdded:Connect(function(nChar)
        repeat task.wait(0.1)
            Human = nChar:FindFirstChildWhichIsA("Humanoid")
        until Human
        Char = nChar
        WalkSpeedChange()
        if PlayerSettings.SpeedHack.WSLoop then
            PlayerSettings.SpeedHack.WSLoop:Disconnect()
        end
        PlayerSettings.SpeedHack.WSLoop = Human:GetPropertyChangedSignal("WalkSpeed"):Connect(WalkSpeedChange)
    end)
end

local function disableLoopspeed()
    if PlayerSettings.SpeedHack.WSLoop then
        PlayerSettings.SpeedHack.WSLoop:Disconnect()
        PlayerSettings.SpeedHack.WSLoop = nil
    end
    if PlayerSettings.SpeedHack.WSCA then
        PlayerSettings.SpeedHack.WSCA:Disconnect()
        PlayerSettings.SpeedHack.WSCA = nil
    end
    PlayerSettings.SpeedHack.Enabled = false
    
    local Char = Player.Character or Services.Workspace:FindFirstChild(Player.Name)
    local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
    if Human then Human.WalkSpeed = 16 end
end

playerSpeedGroup:AddToggle("SPEED HACK", false, function(state)
    PlayerSettings.SpeedHack.Enabled = state
    if state then
        applyLoopspeed(Player, PlayerSettings.SpeedHack.Speed)
    else
        disableLoopspeed()
    end
end)

playerSpeedGroup:AddSlider("Speed:", 16, 500, 90, function(value)
    PlayerSettings.SpeedHack.Speed = value
    if PlayerSettings.SpeedHack.Enabled then
        local Char = Player.Character or Services.Workspace:FindFirstChild(Player.Name)
        local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
        if Human then Human.WalkSpeed = value end
    end
end)


local function toggleFly(state)
    if state then
        PlayerSettings.Fly.Enabled = true
        local character = Player.Character or Player.CharacterAdded:Wait()
        if not character:FindFirstChild("HumanoidRootPart") then
            character:WaitForChild("HumanoidRootPart")
        end
        
        PlayerSettings.Fly.BodyVelocity = Instance.new("BodyVelocity")
        PlayerSettings.Fly.BodyVelocity.Name = "FlyBodyVelocity"
        PlayerSettings.Fly.BodyVelocity.Velocity = Vector3.new(0, 0, 0)
        PlayerSettings.Fly.BodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
        PlayerSettings.Fly.BodyVelocity.Parent = character.HumanoidRootPart
        
        PlayerSettings.Fly.Connection = Services.RunService.Heartbeat:Connect(function()
            if not PlayerSettings.Fly.Enabled or not character or not character:FindFirstChild("HumanoidRootPart") then
                if PlayerSettings.Fly.Connection then
                    PlayerSettings.Fly.Connection:Disconnect()
                end
                return
            end
            
            local root = character.HumanoidRootPart
            local moveDirection = Vector3.new(0, 0, 0)
            
            if Services.UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + Camera.CFrame.LookVector
            end
            if Services.UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - Camera.CFrame.LookVector
            end
            if Services.UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - Camera.CFrame.RightVector
            end
            if Services.UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + Camera.CFrame.RightVector
            end
            if Services.UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveDirection = moveDirection + Vector3.new(0, 1, 0)
            end
            if Services.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveDirection = moveDirection - Vector3.new(0, 1, 0)
            end
            
            if moveDirection.Magnitude > 0 then
                moveDirection = moveDirection.Unit * PlayerSettings.Fly.Speed
            end
            
            if PlayerSettings.Fly.BodyVelocity and PlayerSettings.Fly.BodyVelocity.Parent then
                PlayerSettings.Fly.BodyVelocity.Velocity = moveDirection
            end
        end)
    else
        PlayerSettings.Fly.Enabled = false
        if PlayerSettings.Fly.Connection then
            PlayerSettings.Fly.Connection:Disconnect()
            PlayerSettings.Fly.Connection = nil
        end
        
        if Player and Player.Character then
            local character = Player.Character
            local root = character:FindFirstChild("HumanoidRootPart")
            if root then
                if root:FindFirstChild("FlyBodyVelocity") then
                    root.FlyBodyVelocity:Destroy()
                end
            end
        end
    end
end

playerSpeedGroup:AddToggle("FLY", false, function(state)
    toggleFly(state)
end)

playerSpeedGroup:AddSlider("FLY SPEED", 16, 100, 30, function(value)
    PlayerSettings.Fly.Speed = value
end)

-- TP Walk

playerSpeedGroup:AddToggle("TP Walk Speed:", false, function(state)
    PlayerSettings.TpWalk.Enabled = state
    if state then
        PlayerSettings.TpWalk.Connection = Services.RunService.RenderStepped:Connect(function()
            if PlayerSettings.TpWalk.Enabled and Character and Character:FindFirstChild("HumanoidRootPart") then
                local hrp = Character.HumanoidRootPart
                local humanoid = Character:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.MoveDirection.Magnitude > 0 then
                    hrp.CFrame = hrp.CFrame + humanoid.MoveDirection * (PlayerSettings.TpWalk.Speed / 100)
                end
            end
        end)
    elseif PlayerSettings.TpWalk.Connection then
        PlayerSettings.TpWalk.Connection:Disconnect()
        PlayerSettings.TpWalk.Connection = nil
    end
end)

playerSpeedGroup:AddSlider("TP Walk Speed Value", 50, 500, PlayerSettings.TpWalk.Speed, function(value)
    PlayerSettings.TpWalk.Speed = value
end)

-- Other features
playerCharacterGroup:AddToggle("Infinite Jump", false, function(state) 
    PlayerSettings.InfiniteJump = state 
end)

playerCharacterGroup:AddToggle("Noclip", false, function(state) 
    PlayerSettings.Noclip = state 
end)

local instantOpenChestGroup = self.menu:CreateCollapsibleGroup(self.Tabs.PlayerTab,"USEFULL FEATURES",true,120)
self.menu:MarkAsNew(instantOpenChestGroup:GetInstance(),"NEW")

instantOpenChestGroup:AddToggle("Instant Open Chest",false,function(state)
    if state then
        -- Create a loop to constantly set the value
        while wait(0.1) and state do
            game:GetService("Players").LocalPlayer.Values.openTreasureSpeedBonus.Value = 999999
        end
    end
end)

instantOpenChestGroup:AddToggle("Full Bright", false, function(state) 
    PlayerSettings.FullBright = state
    
    -- Remove existing connection if any
    if PlayerSettings.FullBrightConnection then
        PlayerSettings.FullBrightConnection:Disconnect()
        PlayerSettings.FullBrightConnection = nil
    end
    
    if state then
        -- Create a continuous loop to enforce full bright settings
        PlayerSettings.FullBrightConnection = Services.RunService.Heartbeat:Connect(function()
            if PlayerSettings.FullBright then
                Services.Lighting.Brightness = 2
                Services.Lighting.ClockTime = 12
                Services.Lighting.FogEnd = 1e10
                Services.Lighting.GlobalShadows = false
                Services.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
                Services.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
                
                -- Also set time of day properties
                Services.Lighting.TimeOfDay = "12:00:00"
            end
        end)
    else
        -- Reset to normal
        Services.Lighting.Brightness = 1
        Services.Lighting.ClockTime = 14
        Services.Lighting.FogEnd = 100000
        Services.Lighting.GlobalShadows = true
        Services.Lighting.Ambient = Color3.fromRGB(0, 0, 0)
        Services.Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        Services.Lighting.TimeOfDay = "14:00:00"
    end
end)

-- Noclip and Infinite Jump handlers
Services.RunService.Stepped:Connect(function()
    if PlayerSettings.Noclip and Character then
        for _, v in pairs(Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

Services.UserInputService.JumpRequest:Connect(function()
    if PlayerSettings.InfiniteJump and Humanoid then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

--PlayerTab ENd

end
 
-- RETURN the module so main script can use it
return PlayerTabSystem
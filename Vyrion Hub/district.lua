-- ts file was generated at discord.gg/25ms

local Players = game:GetService('Players')
local Workspace = game:GetService('Workspace')
local RunService = game:GetService('RunService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Lighting = game:GetService('Lighting')
local UserInputService = game:GetService('UserInputService')
local LocalPlayer = Players.LocalPlayer
local WindUI = loadstring(game:HttpGet('https://github.com/Footagesus/WindUI/releases/download/1.6.54/main.lua'))()

pcall(function()
    local TweenService = game:GetService('TweenService')
    local playerGui = LocalPlayer:WaitForChild('PlayerGui')
    local gui = Instance.new('ScreenGui')

    gui.Name = 'VyrionLoader'
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 99999
    gui.Parent = playerGui

    local shade = Instance.new('Frame')

    shade.Size = UDim2.fromScale(1, 1)
    shade.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
    shade.BackgroundTransparency = 1
    shade.Parent = gui

    local panel = Instance.new('Frame')

    panel.AnchorPoint = Vector2.new(0.5, 0.5)
    panel.Position = UDim2.fromScale(0.5, 0.53)
    panel.Size = UDim2.fromOffset(340, 132)
    panel.BackgroundColor3 = Color3.fromRGB(20, 20, 23)
    panel.BackgroundTransparency = 1
    panel.Parent = shade
    Instance.new('UICorner', panel).CornerRadius = UDim.new(0, 12)

    local stroke = Instance.new('UIStroke', panel)

    stroke.Color = Color3.fromRGB(125, 125, 132)
    stroke.Transparency = 1

    local title = Instance.new('TextLabel')

    title.BackgroundTransparency = 1
    title.Position = UDim2.fromOffset(20, 18)
    title.Size = UDim2.new(1, -40, 0, 30)
    title.Font = Enum.Font.GothamBold
    title.Text = 'VYRION HUB'
    title.TextColor3 = Color3.fromRGB(245, 245, 248)
    title.TextSize = 20
    title.TextTransparency = 1
    title.Parent = panel

    local status = Instance.new('TextLabel')

    status.BackgroundTransparency = 1
    status.Position = UDim2.fromOffset(20, 54)
    status.Size = UDim2.new(1, -40, 0, 22)
    status.Font = Enum.Font.Gotham
    status.Text = 'Loading Violence District...'
    status.TextColor3 = Color3.fromRGB(170, 170, 178)
    status.TextSize = 12
    status.TextTransparency = 1
    status.TextXAlignment = Enum.TextXAlignment.Left
    status.Parent = panel

    local barBack = Instance.new('Frame')

    barBack.Position = UDim2.fromOffset(20, 94)
    barBack.Size = UDim2.new(1, -40, 0, 4)
    barBack.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
    barBack.BackgroundTransparency = 1
    barBack.Parent = panel
    Instance.new('UICorner', barBack).CornerRadius = UDim.new(1, 0)

    local bar = Instance.new('Frame')

    bar.Size = UDim2.fromScale(0, 1)
    bar.BackgroundColor3 = Color3.fromRGB(205, 205, 212)
    bar.Parent = barBack
    Instance.new('UICorner', bar).CornerRadius = UDim.new(1, 0)

    TweenService:Create(shade, TweenInfo.new(0.25), {BackgroundTransparency = 0.15}):Play()
    TweenService:Create(panel, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0,
        Position = UDim2.fromScale(0.5, 0.5),
    }):Play()
    TweenService:Create(stroke, TweenInfo.new(0.3), {Transparency = 0.35}):Play()
    TweenService:Create(title, TweenInfo.new(0.25), {TextTransparency = 0}):Play()
    TweenService:Create(status, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    TweenService:Create(barBack, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
    TweenService:Create(bar, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(1, 1),
    }):Play()
    task.wait(1.05)

    status.Text = 'Ready!'

    task.wait(0.2)
    TweenService:Create(shade, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
    task.wait(0.27)
    gui:Destroy()
end)

local function detectMobile()
    local camera = Workspace.CurrentCamera
    local viewport = camera and camera.ViewportSize or Vector2.new(1920, 1080)
    local touch = UserInputService.TouchEnabled
    local noKeyboard = not UserInputService.KeyboardEnabled
    local smallScreen = viewport.X <= 1024 or viewport.Y <= 768
    local motionInput = UserInputService.GyroscopeEnabled or UserInputService.AccelerometerEnabled
    local executor = ''

    pcall(function()
        if identifyexecutor then
            executor = tostring(identifyexecutor()):lower()
        end
    end)

    local mobileExecutor = executor:find('delta', 1, true) or executor:find('arceus', 1, true) or executor:find('fluxus', 1, true) or executor:find('krnl', 1, true)

    return touch and (noKeyboard or smallScreen or motionInput or mobileExecutor ~= nil)
end

local IsMobile = detectMobile()
local Config = {
    ESP = {
        Killer = false,
        Survivor = false,
        Generator = false,
        Gate = false,
        Hook = false,
        Pallet = false,
        Window = false,
        Pumpkin = false,
        ClosestHook = false,
        ShowOnlyClosestHook = false,
        ShowDistance = true,
        MaxDistance = 500,
        MaxObjects = IsMobile and 50 or 100,
    },
    Survivor = {
        AutoGenerator = false,
        GeneratorMode = 'great',
        AutoLeaveGenerator = false,
        LeaveDistance = 15,
        AvoidKiller = false,
        KillerDetectionRadius = 20,
        Aimlock = false,
        AimlockPart = 'HumanoidRootPart',
    },
    Killer = {
        AutoAttack = false,
        AttackRange = 10,
        AttackCooldown = 0.1,
    },
    Teleport = {
        Offset = 3,
        SafeTeleport = true,
    },
    Movement = {
        Speed = false,
        SpeedValue = 16,
        NoClip = false,
        NoFall = false,
    },
    Performance = {
        UpdateRate = 0.5,
        DistanceCulling = true,
        DisableParticles = false,
        LowerGraphics = false,
        DisableShadows = false,
        ReduceRenderDistance = false,
    },
}
local Connections = {}

local function disconnect(name)
    local connection = Connections[name]

    if connection then
        pcall(function()
            connection:Disconnect()
        end)

        Connections[name] = nil
    end
end
local function connect(name, signal, callback)
    disconnect(name)

    Connections[name] = signal:Connect(callback)

    return Connections[name]
end
local function disconnectPrefix(prefix)
    for name in pairs(Connections)do
        if name:sub(1, #prefix) == prefix then
            disconnect(name)
        end
    end
end
local function notify(title, content, duration)
    pcall(function()
        WindUI:Notify({
            Title = title,
            Content = content,
            Duration = duration or 3,
            Icon = 'solar:bell-bold',
        })
    end)
end
local function safeCall(callback, ...)
    local ok, result = pcall(callback, ...)

    return ok, result
end
local function isAlive(instance)
    return typeof(instance) == 'Instance' and instance.Parent ~= nil
end
local function getCharacter()
    return LocalPlayer.Character
end
local function getRoot(player)
    player = player or LocalPlayer

    local character = player.Character

    return character and character:FindFirstChild('HumanoidRootPart')
end
local function getHumanoid(player)
    player = player or LocalPlayer

    local character = player.Character

    return character and character:FindFirstChildOfClass('Humanoid')
end
local function isKiller(player)
    return player and player.Team and player.Team.Name == 'Killer'
end
local function isSurvivor(player)
    return player and player.Team and player.Team.Name == 'Survivors'
end
local function getMap()
    return Workspace:FindFirstChild('Map')
end
local function getRemotes()
    local remotes = ReplicatedStorage:FindFirstChild('Remotes')
    local generator = remotes and remotes:FindFirstChild('Generator')
    local attacks = remotes and remotes:FindFirstChild('Attacks')

    return {
        RepairEvent = generator and generator:FindFirstChild('RepairEvent'),
        SkillCheckResultEvent = generator and generator:FindFirstChild('SkillCheckResultEvent'),
        BasicAttack = attacks and attacks:FindFirstChild('BasicAttack'),
    }
end
local function getFirstBasePart(instance)
    if not instance then
        return nil
    end
    if instance:IsA('BasePart') then
        return instance
    end

    return instance:FindFirstChildWhichIsA('BasePart', true)
end
local function getPosition(instance)
    local part = getFirstBasePart(instance)

    return part and part.Position
end
local function collectModelsByName(root, name)
    local results = {}

    if not root then
        return results
    end

    for _, object in ipairs(root:GetDescendants())do
        if object:IsA('Model') and object.Name == name then
            table.insert(results, object)
        end
    end

    return results
end
local function getGenerators()
    return collectModelsByName(getMap(), 'Generator')
end
local function getGates()
    return collectModelsByName(getMap(), 'Gate')
end
local function getHooks()
    return collectModelsByName(getMap(), 'Hook')
end
local function getNearestPart(models, origin, farthest)
    local chosenPart = nil
    local chosenDistance = farthest and -math.huge or math.huge

    for _, model in ipairs(models)do
        local part = getFirstBasePart(model)

        if part then
            local distance = (part.Position - origin).Magnitude
            local better = farthest and distance > chosenDistance or (not farthest and distance < chosenDistance)

            if better then
                chosenDistance = distance
                chosenPart = part
            end
        end
    end

    return chosenPart, chosenDistance
end
local function getGeneratorsByDistance()
    local root = getRoot()

    if not root then
        return {}
    end

    local result = {}

    for _, generator in ipairs(getGenerators())do
        local part = getFirstBasePart(generator)

        if part then
            table.insert(result, {
                Model = generator,
                Part = part,
                Distance = (part.Position - root.Position).Magnitude,
            })
        end
    end

    table.sort(result, function(a, b)
        return a.Distance < b.Distance
    end)

    return result
end
local function safeTeleport(targetCFrame, offset)
    local character = getCharacter()
    local root = getRoot()

    if not character or not root then
        notify('Teleport', 'Character not found.', 3)

        return false
    end

    local destination = targetCFrame

    if typeof(targetCFrame) == 'Vector3' then
        destination = CFrame.new(targetCFrame)
    end
    if not destination then
        return false
    end

    local finalOffset = offset or Vector3.new(0, Config.Teleport.Offset, 0)
    local savedCollision = {}

    if Config.Teleport.SafeTeleport then
        for _, object in ipairs(character:GetDescendants())do
            if object:IsA('BasePart') then
                savedCollision[object] = object.CanCollide
                object.CanCollide = false
            end
        end
    end

    local success = pcall(function()
        character:PivotTo(destination + finalOffset)
    end)

    if Config.Teleport.SafeTeleport then
        task.delay(0.45, function()
            for part, oldValue in pairs(savedCollision)do
                if part and part.Parent then
                    part.CanCollide = oldValue
                end
            end
        end)
    end

    return success
end
local function leaveNearestGenerator()
    local root = getRoot()

    if not root then
        return false
    end

    local list = getGeneratorsByDistance()
    local nearest = list[1]

    if not nearest or nearest.Distance > Config.Survivor.LeaveDistance then
        notify('Generator', 'You are not close enough to a generator.', 2)

        return false
    end

    local direction = root.Position - nearest.Part.Position

    if direction.Magnitude < 0.1 then
        direction = Vector3.new(0, 0, 1)
    else
        direction = direction.Unit
    end

    local destination = root.Position + direction * (Config.Survivor.LeaveDistance + 15)

    return safeTeleport(CFrame.new(destination, destination + root.CFrame.LookVector), Vector3.new(0, 2, 0))
end

local ESPObjects = {}
local LastESPUpdate = 0

local function removeESP(target)
    local record = ESPObjects[target]

    if record then
        if record.Highlight and record.Highlight.Parent then
            record.Highlight:Destroy()
        end
        if record.DistanceGui and record.DistanceGui.Parent then
            record.DistanceGui:Destroy()
        end

        ESPObjects[target] = nil
    end
    if target and target:FindFirstChild('Vyrion_ESP_Highlight') then
        target.Vyrion_ESP_Highlight:Destroy()
    end
    if target and target:FindFirstChild('Vyrion_ESP_Distance') then
        target.Vyrion_ESP_Distance:Destroy()
    end
end
local function removeAllESP()
    for target in pairs(ESPObjects)do
        removeESP(target)
    end

    table.clear(ESPObjects)
end
local function createDistanceGui(target, part, color)
    if not Config.ESP.ShowDistance or not part then
        return nil
    end

    local gui = Instance.new('BillboardGui')

    gui.Name = 'Vyrion_ESP_Distance'
    gui.Size = UDim2.fromOffset(120, 26)
    gui.StudsOffset = Vector3.new(0, 3, 0)
    gui.AlwaysOnTop = true
    gui.MaxDistance = Config.ESP.MaxDistance
    gui.Adornee = part
    gui.Parent = target

    local label = Instance.new('TextLabel')

    label.BackgroundTransparency = 1
    label.Size = UDim2.fromScale(1, 1)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.TextColor3 = color
    label.TextStrokeTransparency = 0.3
    label.Text = '...'
    label.Parent = gui

    return gui
end
local function createESP(target, color)
    if not isAlive(target) then
        return
    end

    local existing = ESPObjects[target]

    if existing then
        existing.Color = color

        if existing.Highlight then
            existing.Highlight.FillColor = color
            existing.Highlight.OutlineColor = color
        end

        return
    end
    if #ESPObjects >= Config.ESP.MaxObjects then
        return
    end

    local highlight = Instance.new('Highlight')

    highlight.Name = 'Vyrion_ESP_Highlight'
    highlight.Adornee = target
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = target

    local part = getFirstBasePart(target)
    local distanceGui = createDistanceGui(target, part, color)

    ESPObjects[target] = {
        Highlight = highlight,
        DistanceGui = distanceGui,
        Color = color,
    }
end
local function addESP(wanted, target, color)
    if not target or not isAlive(target) then
        return
    end

    local root = getRoot()
    local part = getFirstBasePart(target)

    if Config.Performance.DistanceCulling and root and part then
        if (part.Position - root.Position).Magnitude > Config.ESP.MaxDistance then
            return
        end
    end

    wanted[target] = color
end
local function addPlayerESP(wanted)
    for _, player in ipairs(Players:GetPlayers())do
        if player ~= LocalPlayer and player.Character then
            if isKiller(player) and Config.ESP.Killer then
                addESP(wanted, player.Character, Color3.fromRGB(255, 60, 60))
            elseif isSurvivor(player) and Config.ESP.Survivor then
                addESP(wanted, player.Character, Color3.fromRGB(70, 255, 120))
            end
        end
    end
end
local function getHookParts(hookModel)
    local result = {}
    local inner = hookModel:FindFirstChild('Model')

    if inner then
        for _, object in ipairs(inner:GetDescendants())do
            if object:IsA('MeshPart') or object:IsA('BasePart') then
                table.insert(result, object)
            end
        end
    end
    if #result == 0 then
        local part = getFirstBasePart(hookModel)

        if part then
            table.insert(result, part)
        end
    end

    return result
end
local function addHookESP(wanted)
    local hooks = getHooks()
    local root = getRoot()

    if Config.ESP.ShowOnlyClosestHook and root then
        local bestHook, bestDistance = nil, math.huge

        for _, hook in ipairs(hooks)do
            local part = getFirstBasePart(hook)

            if part then
                local distance = (part.Position - root.Position).Magnitude

                if distance < bestDistance and distance <= Config.ESP.MaxDistance then
                    bestHook = hook
                    bestDistance = distance
                end
            end
        end

        if bestHook then
            for _, part in ipairs(getHookParts(bestHook))do
                addESP(wanted, part, Config.ESP.ClosestHook and Color3.fromRGB(255, 230, 80) or Color3.fromRGB(255, 70, 70))
            end
        end

        return
    end

    for _, hook in ipairs(hooks)do
        local color = Color3.fromRGB(255, 70, 70)

        if Config.ESP.ClosestHook and root then
            local bestHook, bestDistance = nil, math.huge

            for _, candidate in ipairs(hooks)do
                local part = getFirstBasePart(candidate)

                if part then
                    local distance = (part.Position - root.Position).Magnitude

                    if distance < bestDistance then
                        bestDistance = distance
                        bestHook = candidate
                    end
                end
            end

            if hook == bestHook then
                color = Color3.fromRGB(255, 230, 80)
            end
        end

        for _, part in ipairs(getHookParts(hook))do
            addESP(wanted, part, color)
        end
    end
end
local function addObjectESP(wanted)
    local map = getMap()

    if not map then
        return
    end
    if Config.ESP.Generator then
        for _, generator in ipairs(getGenerators())do
            addESP(wanted, generator, Color3.fromRGB(203, 132, 66))
        end
    end
    if Config.ESP.Gate then
        for _, gate in ipairs(getGates())do
            addESP(wanted, gate, Color3.fromRGB(255, 255, 255))
        end
    end
    if Config.ESP.Pallet then
        for _, object in ipairs(map:GetDescendants())do
            if object:IsA('Model') and object.Name == 'Palletwrong' then
                addESP(wanted, object, Color3.fromRGB(255, 240, 80))
            end
        end
    end
    if Config.ESP.Pumpkin then
        local pumpkins = map:FindFirstChild('Pumpkins')

        if pumpkins then
            for _, object in ipairs(pumpkins:GetDescendants())do
                if object:IsA('Model') and object.Name:find('Pumpkin', 1, true) then
                    addESP(wanted, object, Color3.fromRGB(255, 140, 0))
                end
            end
        end
    end
    if Config.ESP.Window then
        for _, object in ipairs(Workspace:GetDescendants())do
            if object:IsA('Model') and object.Name == 'Window' then
                addESP(wanted, object, Color3.fromRGB(173, 216, 230))
            end
        end
    end
    if Config.ESP.Hook then
        addHookESP(wanted)
    end
end
local function anyESPEnabled()
    for key, value in pairs(Config.ESP)do
        if key ~= 'ClosestHook' and key ~= 'ShowOnlyClosestHook' and key ~= 'ShowDistance' and key ~= 'MaxDistance' and key ~= 'MaxObjects' and value == true then
            return true
        end
    end

    return false
end
local function refreshESP()
    local wanted = {}

    if Config.ESP.Killer or Config.ESP.Survivor then
        addPlayerESP(wanted)
    end

    addObjectESP(wanted)

    for target in pairs(ESPObjects)do
        if not wanted[target] or not isAlive(target) then
            removeESP(target)
        end
    end
    for target, color in pairs(wanted)do
        createESP(target, color)
    end

    local root = getRoot()

    for target, record in pairs(ESPObjects)do
        if record.DistanceGui and root then
            local part = getFirstBasePart(target)
            local label = record.DistanceGui:FindFirstChildOfClass('TextLabel')

            if part and label then
                local distance = (part.Position - root.Position).Magnitude

                label.Text = string.format('%.0f studs', distance)
            end
        end
    end
end
local function ensureESPConnection()
    if anyESPEnabled() then
        if not Connections.ESP then
            connect('ESP', RunService.Heartbeat, function()
                local now = os.clock()

                if now - LastESPUpdate < Config.Performance.UpdateRate then
                    return
                end

                LastESPUpdate = now

                refreshESP()
            end)
        end
    else
        disconnect('ESP')
        removeAllESP()
    end
end
local function setESP(key, value)
    Config.ESP[key] = value

    ensureESPConnection()
end

local AutoLeaveThreatActive = false
local CurrentGenerator = nil
local CurrentGeneratorPoint = nil
local LastRepairTick = 0
local LastSkillTick = 0

local function releaseGenerator()
    local remotes = getRemotes()

    if CurrentGeneratorPoint and remotes.RepairEvent then
        safeCall(function()
            remotes.RepairEvent:FireServer(CurrentGeneratorPoint, false)
        end)
    end

    CurrentGenerator = nil
    CurrentGeneratorPoint = nil
end
local function findNearestGenerator(maxDistance)
    local root = getRoot()

    if not root then
        return nil
    end

    local nearest, distance = nil, math.huge

    for _, generator in ipairs(getGenerators())do
        local part = getFirstBasePart(generator)

        if part then
            local currentDistance = (part.Position - root.Position).Magnitude

            if currentDistance <= maxDistance and currentDistance < distance then
                nearest = generator
                distance = currentDistance
            end
        end
    end

    return nearest, distance
end
local function getGeneratorPoint(generator)
    if not generator then
        return nil
    end

    for _, child in ipairs(generator:GetChildren())do
        if child.Name:find('GeneratorPoint', 1, true) then
            return child
        end
    end

    return nil
end
local function updateAutoGenerator()
    if not Config.Survivor.AutoGenerator or AutoLeaveThreatActive then
        releaseGenerator()

        return
    end

    local root = getRoot()

    if not root then
        releaseGenerator()

        return
    end

    local generator = findNearestGenerator(10)
    local point = getGeneratorPoint(generator)
    local remotes = getRemotes()

    if generator ~= CurrentGenerator or point ~= CurrentGeneratorPoint then
        releaseGenerator()
    end
    if not generator or not point or not remotes.RepairEvent then
        return
    end

    CurrentGenerator = generator
    CurrentGeneratorPoint = point

    local now = os.clock()

    if now - LastRepairTick >= 0.18 then
        LastRepairTick = now

        safeCall(function()
            remotes.RepairEvent:FireServer(point, true)
        end)
    end
    if remotes.SkillCheckResultEvent and now - LastSkillTick >= 0.08 then
        LastSkillTick = now

        local result = Config.Survivor.GeneratorMode == 'great' and 'success' or 'neutral'
        local value = Config.Survivor.GeneratorMode == 'great' and 1 or 0

        safeCall(function()
            remotes.SkillCheckResultEvent:FireServer(result, value, generator, point)
        end)
    end
end
local function setAutoGenerator(value)
    Config.Survivor.AutoGenerator = value

    if value then
        if not Connections.AutoGenerator then
            connect('AutoGenerator', RunService.Heartbeat, function()
                updateAutoGenerator()
            end)
        end
    else
        disconnect('AutoGenerator')
        releaseGenerator()
    end
end

local LastVoidTeleport = 0
local WasKillerInRadius = false

local function getKillerRoot()
    for _, player in ipairs(Players:GetPlayers())do
        if isKiller(player) then
            local root = getRoot(player)

            if root then
                return root
            end
        end
    end

    return nil
end
local function findFarthestGenerator(position)
    local chosen, bestDistance = nil, -math.huge

    for _, generator in ipairs(getGenerators())do
        local part = getFirstBasePart(generator)

        if part then
            local distance = (part.Position - position).Magnitude

            if distance > bestDistance then
                bestDistance = distance
                chosen = part
            end
        end
    end

    return chosen
end
local function updateAvoidKiller()
    if not (Config.Survivor.AvoidKiller or Config.Survivor.AutoLeaveGenerator) then
        WasKillerInRadius = false
        AutoLeaveThreatActive = false

        return
    end

    local root = getRoot()
    local killerRoot = getKillerRoot()

    if not root or not killerRoot then
        WasKillerInRadius = false
        AutoLeaveThreatActive = false

        return
    end

    local radius = math.max(0, tonumber(Config.Survivor.KillerDetectionRadius) or 20)
    local inRadius = (killerRoot.Position - root.Position).Magnitude <= radius

    AutoLeaveThreatActive = Config.Survivor.AutoLeaveGenerator and inRadius

    if AutoLeaveThreatActive then
        releaseGenerator()
    end
    if Config.Survivor.AvoidKiller and inRadius and not WasKillerInRadius then
        local now = os.clock()

        if now - LastVoidTeleport >= 1 then
            local farthestPart = findFarthestGenerator(killerRoot.Position)

            if farthestPart then
                LastVoidTeleport = now

                safeTeleport(farthestPart.CFrame)
            end
        end
    end

    WasKillerInRadius = inRadius
end
local function ensureAvoidConnection()
    if Config.Survivor.AvoidKiller or Config.Survivor.AutoLeaveGenerator then
        if not Connections.AvoidKiller then
            connect('AvoidKiller', RunService.Heartbeat, updateAvoidKiller)
        end
    else
        disconnect('AvoidKiller')

        WasKillerInRadius = false
        AutoLeaveThreatActive = false
    end
end
local function getAimTarget()
    for _, player in ipairs(Players:GetPlayers())do
        if player ~= LocalPlayer and isKiller(player) and player.Character then
            local part = player.Character:FindFirstChild(Config.Survivor.AimlockPart)

            part = part or player.Character:FindFirstChild('HumanoidRootPart')

            if part then
                return part
            end
        end
    end

    return nil
end
local function setAimlock(value)
    Config.Survivor.Aimlock = value

    if value then
        if not Connections.Aimlock then
            connect('Aimlock', RunService.RenderStepped, function()
                if not Config.Survivor.Aimlock then
                    return
                end

                local camera = Workspace.CurrentCamera
                local target = getAimTarget()

                if not camera or not target then
                    return
                end

                local current = camera.CFrame

                camera.CFrame = CFrame.new(current.Position, target.Position)
            end)
        end
    else
        disconnect('Aimlock')
    end
end

local LastAttackTick = 0

local function findNearestSurvivor(maxDistance)
    local root = getRoot()

    if not root then
        return nil
    end

    local nearest, distance = nil, math.huge

    for _, player in ipairs(Players:GetPlayers())do
        if player ~= LocalPlayer and isSurvivor(player) then
            local targetRoot = getRoot(player)

            if targetRoot then
                local currentDistance = (targetRoot.Position - root.Position).Magnitude

                if currentDistance <= maxDistance and currentDistance < distance then
                    nearest = player
                    distance = currentDistance
                end
            end
        end
    end

    return nearest
end
local function updateAutoAttack()
    if not Config.Killer.AutoAttack or not isKiller(LocalPlayer) then
        return
    end

    local now = os.clock()

    if now - LastAttackTick < Config.Killer.AttackCooldown then
        return
    end

    local target = findNearestSurvivor(Config.Killer.AttackRange)

    if not target then
        return
    end

    local remotes = getRemotes()

    if remotes.BasicAttack then
        LastAttackTick = now

        safeCall(function()
            remotes.BasicAttack:FireServer(false)
        end)
    end
end
local function setAutoAttack(value)
    Config.Killer.AutoAttack = value

    if value then
        if not isKiller(LocalPlayer) then
            notify('Killer', 'Auto Attack solo funciona mientras tu equipo sea Killer.', 3)
        end
        if not Connections.AutoAttack then
            connect('AutoAttack', RunService.Heartbeat, updateAutoAttack)
        end
    else
        disconnect('AutoAttack')
    end
end

local OriginalWalkSpeed = nil

local function applySpeed()
    local humanoid = getHumanoid()

    if not humanoid then
        return
    end
    if Config.Movement.Speed then
        if OriginalWalkSpeed == nil then
            OriginalWalkSpeed = humanoid.WalkSpeed
        end

        humanoid.WalkSpeed = Config.Movement.SpeedValue
    end
end
local function setSpeed(value)
    Config.Movement.Speed = value

    if value then
        applySpeed()

        if not Connections.Speed then
            connect('Speed', RunService.Heartbeat, applySpeed)
        end
    else
        disconnect('Speed')

        local humanoid = getHumanoid()

        if humanoid then
            humanoid.WalkSpeed = OriginalWalkSpeed or 16
        end

        OriginalWalkSpeed = nil
    end
end

local NoClipSavedCollision = {}

local function saveCurrentCollisionState(character)
    table.clear(NoClipSavedCollision)

    for _, object in ipairs(character:GetDescendants())do
        if object:IsA('BasePart') then
            NoClipSavedCollision[object] = object.CanCollide
        end
    end
end
local function restoreCollisionState()
    for object, original in pairs(NoClipSavedCollision)do
        if object and object.Parent then
            object.CanCollide = original
        end
    end

    table.clear(NoClipSavedCollision)
end
local function setNoClip(value)
    Config.Movement.NoClip = value

    if value then
        local character = getCharacter()

        if character then
            saveCurrentCollisionState(character)
        end
        if not Connections.NoClip then
            connect('NoClip', RunService.Stepped, function()
                local currentCharacter = getCharacter()

                if not currentCharacter then
                    return
                end

                for _, object in ipairs(currentCharacter:GetDescendants())do
                    if object:IsA('BasePart') then
                        object.CanCollide = false
                    end
                end
            end)
        end
    else
        disconnect('NoClip')
        restoreCollisionState()

        local character = getCharacter()

        if character then
            for _, object in ipairs(character:GetDescendants())do
                if object:IsA('BasePart') and object.CanCollide == false then
                    object.CanCollide = true
                end
            end
        end
    end
end

local FallConnection = nil
local FallHumanoid = nil
local FallHealth = nil

local function stopNoFall()
    if FallConnection then
        pcall(function()
            FallConnection:Disconnect()
        end)

        FallConnection = nil
    end

    FallHumanoid = nil
    FallHealth = nil
end
local function attachNoFall(character)
    stopNoFall()

    if not Config.Movement.NoFall then
        return
    end

    local humanoid = character:FindFirstChildOfClass('Humanoid') or character:WaitForChild('Humanoid', 5)

    if not humanoid then
        return
    end

    FallHumanoid = humanoid
    FallHealth = humanoid.Health
    FallConnection = humanoid.HealthChanged:Connect(function(currentHealth)
        if not Config.Movement.NoFall or humanoid ~= FallHumanoid then
            return
        end

        local state = humanoid:GetState()

        if currentHealth < FallHealth and (state == Enum.HumanoidStateType.Freefall or state == Enum.HumanoidStateType.Landed) then
            humanoid.Health = math.max(FallHealth, 1)
        else
            FallHealth = currentHealth
        end
    end)
end
local function setNoFall(value)
    Config.Movement.NoFall = value

    if value then
        local character = getCharacter()

        if character then
            task.defer(function()
                if character.Parent then
                    attachNoFall(character)
                end
            end)
        end
    else
        stopNoFall()
    end
end

connect('CharacterAdded', LocalPlayer.CharacterAdded, function(character)
    task.spawn(function()
        local humanoid = character:WaitForChild('Humanoid', 5)

        if humanoid and Config.Movement.Speed then
            OriginalWalkSpeed = humanoid.WalkSpeed
            humanoid.WalkSpeed = Config.Movement.SpeedValue
        end
        if Config.Movement.NoFall then
            attachNoFall(character)
        end
    end)
end)

local FullbrightSaved = nil
local FogSaved = nil
local ParticleSaved = {}
local QualitySaved = nil
local StreamingSaved = nil

local function setFullbright(value)
    if value then
        if not FullbrightSaved then
            FullbrightSaved = {
                Brightness = Lighting.Brightness,
                ClockTime = Lighting.ClockTime,
                Ambient = Lighting.Ambient,
                GlobalShadows = Lighting.GlobalShadows,
                Effects = {},
            }

            for _, effect in ipairs(Lighting:GetChildren())do
                if effect:IsA('BlurEffect') or effect:IsA('ColorCorrectionEffect') or effect:IsA('SunRaysEffect') then
                    FullbrightSaved.Effects[effect] = effect.Enabled
                    effect.Enabled = false
                end
            end
        end

        Lighting.Brightness = 10
        Lighting.ClockTime = 14
        Lighting.Ambient = Color3.fromRGB(178, 178, 178)
        Lighting.GlobalShadows = false
    else
        if not FullbrightSaved then
            return
        end

        Lighting.Brightness = FullbrightSaved.Brightness
        Lighting.ClockTime = FullbrightSaved.ClockTime
        Lighting.Ambient = FullbrightSaved.Ambient
        Lighting.GlobalShadows = Config.Performance.DisableShadows and false or FullbrightSaved.GlobalShadows

        for effect, enabled in pairs(FullbrightSaved.Effects)do
            if effect and effect.Parent then
                effect.Enabled = enabled
            end
        end

        FullbrightSaved = nil
    end
end
local function setNoFog(value)
    if value then
        if not FogSaved then
            FogSaved = {
                FogEnd = Lighting.FogEnd,
                FogStart = Lighting.FogStart,
                FogColor = Lighting.FogColor,
            }
        end

        Lighting.FogEnd = 100000
        Lighting.FogStart = 100000
    else
        if FogSaved then
            Lighting.FogEnd = FogSaved.FogEnd
            Lighting.FogStart = FogSaved.FogStart
            Lighting.FogColor = FogSaved.FogColor
            FogSaved = nil
        end
    end
end
local function applyParticles()
    local enabled = Config.Performance.DisableParticles

    if enabled then
        for _, object in ipairs(Workspace:GetDescendants())do
            if object:IsA('ParticleEmitter') or object:IsA('Trail') or object:IsA('Beam') then
                if ParticleSaved[object] == nil then
                    ParticleSaved[object] = object.Enabled
                end

                object.Enabled = false
            end
        end
    else
        for object, original in pairs(ParticleSaved)do
            if object and object.Parent then
                object.Enabled = original
            end

            ParticleSaved[object] = nil
        end
    end
end
local function applyQuality()
    if Config.Performance.LowerGraphics then
        if QualitySaved == nil then
            safeCall(function()
                QualitySaved = settings().Rendering.QualityLevel
            end)
        end

        safeCall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        end)
    elseif QualitySaved ~= nil then
        safeCall(function()
            settings().Rendering.QualityLevel = QualitySaved
        end)

        QualitySaved = nil
    end
end
local function applyShadows()
    if Config.Performance.DisableShadows then
        Lighting.GlobalShadows = false
    end
end
local function applyStreaming()
    if Config.Performance.ReduceRenderDistance then
        if not StreamingSaved then
            StreamingSaved = {
                Enabled = Workspace.StreamingEnabled,
                MinRadius = Workspace.StreamingMinRadius,
                TargetRadius = Workspace.StreamingTargetRadius,
            }
        end

        safeCall(function()
            Workspace.StreamingEnabled = true
        end)
        safeCall(function()
            Workspace.StreamingMinRadius = 32
        end)
        safeCall(function()
            Workspace.StreamingTargetRadius = 64
        end)
    elseif StreamingSaved then
        safeCall(function()
            Workspace.StreamingEnabled = StreamingSaved.Enabled
        end)
        safeCall(function()
            Workspace.StreamingMinRadius = StreamingSaved.MinRadius
        end)
        safeCall(function()
            Workspace.StreamingTargetRadius = StreamingSaved.TargetRadius
        end)

        StreamingSaved = nil
    end
end
local function applyPerformance()
    applyParticles()
    applyQuality()
    applyShadows()
    applyStreaming()
end
local function resetPerformance()
    Config.Performance.DisableParticles = false
    Config.Performance.LowerGraphics = false
    Config.Performance.DisableShadows = false
    Config.Performance.ReduceRenderDistance = false

    applyPerformance()
end

WindUI:AddTheme({
    Name = 'Vyrion Blue',
    Dialog = Color3.fromHex('#081A30'),
    Outline = Color3.fromHex('#38BDF8'),
    Text = Color3.fromHex('#F1F9FF'),
    Placeholder = Color3.fromHex('#93C5FD'),
    Background = WindUI:Gradient({
        ['0'] = {
            Color = Color3.fromHex('#0B2A55'),
            Transparency = 0.42,
        },
        ['50'] = {
            Color = Color3.fromHex('#102A4C'),
            Transparency = 0.42,
        },
        ['100'] = {
            Color = Color3.fromHex('#071426'),
            Transparency = 0.42,
        },
    }, {Rotation = 135}),
    Button = WindUI:Gradient({
        ['0'] = {
            Color = Color3.fromHex('#38BDF8'),
            Transparency = 0.06,
        },
        ['50'] = {
            Color = Color3.fromHex('#3B82F6'),
            Transparency = 0.06,
        },
        ['100'] = {
            Color = Color3.fromHex('#1D4ED8'),
            Transparency = 0.06,
        },
    }, {Rotation = 90}),
    Icon = WindUI:Gradient({
        ['0'] = {
            Color = Color3.fromHex('#67E8F9'),
            Transparency = 0,
        },
        ['25'] = {
            Color = Color3.fromHex('#38BDF8'),
            Transparency = 0,
        },
        ['50'] = {
            Color = Color3.fromHex('#2563EB'),
            Transparency = 0,
        },
        ['75'] = {
            Color = Color3.fromHex('#3B82F6'),
            Transparency = 0,
        },
        ['100'] = {
            Color = Color3.fromHex('#1D4ED8'),
            Transparency = 0,
        },
    }, {Rotation = 135}),
})

local Window = WindUI:CreateWindow({
    Title = 'Vyrion Hub | Violence District',
    Author = 'By Themomix',
    Size = UDim2.fromOffset(640, 380),
    Transparent = true,
    Resizable = true,
    Theme = 'Vyrion Blue',
    SideBarWidth = 210,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    Background = WindUI:Gradient({
        ['0'] = {
            Color = Color3.fromHex('#0B2A55'),
            Transparency = 0.42,
        },
        ['40'] = {
            Color = Color3.fromHex('#102A4C'),
            Transparency = 0.42,
        },
        ['70'] = {
            Color = Color3.fromHex('#05204A'),
            Transparency = 0.42,
        },
        ['100'] = {
            Color = Color3.fromHex('#071426'),
            Transparency = 0.42,
        },
    }, {Rotation = 135}),
    BackgroundImageTransparency = 0.42,
    Icon = 'rbxassetid://90450210081651',
    IconThemed = false,
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            notify('Vyrion', 'Welcome, ' .. LocalPlayer.Name .. '!', 3)
        end,
    },
    Topbar = {
        Height = 44,
        ButtonsType = 'Mac',
    },
})

pcall(function()
    Window:EditOpenButton({
        Title = 'VYRION HUB',
        Icon = 'rbxassetid://90450210081651',
        IconThemed = false,
        CornerRadius = UDim.new(0, 14),
        StrokeThickness = 2,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(56, 189, 248)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(59, 130, 246)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(29, 78, 216)),
        }),
        OnlyMobile = false,
        Enabled = true,
        Draggable = true,
    })
end)

local InfoTab = Window:Tab({
    Title = 'Info',
    Icon = 'info',
})
local ESPTab = Window:Tab({
    Title = 'ESP',
    Icon = 'eye',
})
local SurviveTab = Window:Tab({
    Title = 'Survive',
    Icon = 'user-check',
})
local KillerTab = Window:Tab({
    Title = 'Killer',
    Icon = 'skull',
})
local PlayerTab = Window:Tab({
    Title = 'Player',
    Icon = 'user',
})
local TeleportTab = Window:Tab({
    Title = 'Teleport',
    Icon = 'send',
})
local SettingsTab = Window:Tab({
    Title = 'Settings',
    Icon = 'settings',
})
local DISCORD_INVITE = 'https://discord.gg/NK2cJqzEs'
local DISCORD_CODE = 'NK2cJqzEs'

pcall(function()
    Window:Dialog({
        Icon = 'message-circle',
        Title = 'Vyrion Community',
        Content = 'Join the official VyrionStudios Discord server for updates and support.',
        Buttons = {
            {
                Title = 'Sure!',
                Callback = function()
                    pcall(function()
                        if setclipboard then
                            setclipboard(DISCORD_INVITE)
                        end
                    end)
                    notify('Discord', 'Invite copied to clipboard.', 3)
                end,
            },
            {
                Title = 'Close',
                Callback = function() end,
            },
        },
    })
end)

local DiscordStatusParagraph
local DiscordServerParagraph

local function refreshDiscord(silent)
    if not silent then
        notify('Discord', 'Refreshing Discord information...', 2)
    end

    local ok, data = pcall(function()
        local response

        if syn and syn.request then
            response = syn.request({
                Url = 'https://discord.com/api/v10/invites/' .. DISCORD_CODE .. '?with_counts=true',
                Method = 'GET',
            })
        elseif request then
            response = request({
                Url = 'https://discord.com/api/v10/invites/' .. DISCORD_CODE .. '?with_counts=true',
                Method = 'GET',
            })
        else
            local body = game:GetService('HttpService'):GetAsync('https://discord.com/api/v10/invites/' .. DISCORD_CODE .. '?with_counts=true')

            response = {
                Body = body,
                StatusCode = 200,
            }
        end

        assert(response and (response.StatusCode == 200 or response.Success), 'Discord API request failed')

        return game:GetService('HttpService'):JSONDecode(response.Body)
    end)

    if ok and data and data.guild then
        local guild = data.guild
        local total = tostring(data.approximate_member_count or 'Unavailable')
        local online = tostring(data.approximate_presence_count or 'Unavailable')
        local iconUrl = guild.icon and ('https://cdn.discordapp.com/icons/' .. guild.id .. '/' .. guild.icon .. '.png?size=256') or nil

        if DiscordServerParagraph then
            pcall(function()
                DiscordServerParagraph:SetDesc('\u{2022} Members: ' .. total .. '\n\u{2022} Active now: ' .. online)

                if iconUrl and DiscordServerParagraph.SetImage then
                    DiscordServerParagraph:SetImage(iconUrl)
                end
            end)
        end
        if DiscordStatusParagraph then
            pcall(function()
                DiscordStatusParagraph:SetDesc('\u{2022} Members: ' .. total .. '\n\u{2022} Active now: ' .. online)
            end)
        end
        if not silent then
            notify('Discord', 'Server information updated.', 3)
        end

        return true
    end
    if DiscordStatusParagraph then
        pcall(function()
            DiscordStatusParagraph:SetDesc('\u{2022} Members: Unavailable\n\u{2022} Active now: Unavailable')
        end)
    end
    if not silent then
        notify('Discord', 'Could not retrieve server information.', 3)
    end

    return false
end

InfoTab:Section({
    Title = 'VyrionStudios',
    Icon = 'shield',
})
InfoTab:Paragraph({
    Title = 'Vyrion | Violence District',
    Desc = 'Clean Rewrite V1\n\nHub reorganizado y optimizado para Violence District.\nESP, Survivor, Killer, Player, Teleport y Performance.',
    Image = 'rbxassetid://90450210081651',
    ImageSize = 32,
})
InfoTab:Divider()
InfoTab:Section({
    Title = 'User',
    Icon = 'user',
})
InfoTab:Paragraph({
    Title = 'Current Player',
    Desc = 'Username: ' .. LocalPlayer.Name .. '\nDisplay Name: ' .. LocalPlayer.DisplayName .. '\nMobile: ' .. tostring(IsMobile),
})
InfoTab:Divider()
InfoTab:Section({
    Title = 'Discord',
    Icon = 'message-circle',
})

DiscordServerParagraph = InfoTab:Paragraph({
    Title = 'VyrionStudios',
    Desc = '\u{2022} Members: Loading...\n\u{2022} Active now: Loading...',
    Image = 'rbxassetid://90450210081651',
    ImageSize = 52,
})

InfoTab:Button({
    Title = 'Copy Discord Invite',
    Desc = 'Copy the Vyrion Studios Discord invitation.',
    Callback = function()
        pcall(function()
            if setclipboard then
                setclipboard(DISCORD_INVITE)
                notify('Discord', 'Invite copied to clipboard.', 3)
            else
                notify('Discord', DISCORD_INVITE, 5)
            end
        end)
    end,
})
InfoTab:Button({
    Title = 'Open Discord',
    Desc = 'Open the Vyrion Studios Discord invitation.',
    Callback = function()
        pcall(function()
            if syn and syn.request then
                syn.request({
                    Url = DISCORD_INVITE,
                    Method = 'GET',
                })
            elseif request then
                request({
                    Url = DISCORD_INVITE,
                    Method = 'GET',
                })
            end
        end)
        notify('Discord', 'Invite: ' .. DISCORD_INVITE, 5)
    end,
})
InfoTab:Divider()
InfoTab:Section({
    Title = 'Discord Status',
    Icon = 'activity',
})

DiscordStatusParagraph = InfoTab:Paragraph({
    Title = 'Live Server Status',
    Desc = '\u{2022} Members: Loading...\n\u{2022} Active now: Loading...',
})

InfoTab:Button({
    Title = 'Refresh',
    Desc = 'Refresh Discord server information.',
    Callback = function()
        refreshDiscord(false)
    end,
})
task.spawn(function()
    refreshDiscord(true)
end)
ESPTab:Section({
    Title = 'Players',
    Icon = 'users',
})
ESPTab:Toggle({
    Title = 'Killer ESP',
    Desc = 'See the killer through the walls',
    Value = false,
    Callback = function(value)
        setESP('Killer', value)
    end,
})
ESPTab:Toggle({
    Title = 'Survivor ESP',
    Desc = 'It allows you to see the survivors through the walls',
    Value = false,
    Callback = function(value)
        setESP('Survivor', value)
    end,
})
ESPTab:Divider()
ESPTab:Section({
    Title = 'Objects',
    Icon = 'scan',
})
ESPTab:Toggle({
    Title = 'Generator ESP',
    Desc = 'Highlight the generators',
    Value = false,
    Callback = function(value)
        setESP('Generator', value)
    end,
})
ESPTab:Toggle({
    Title = 'Gate ESP',
    Desc = 'Highlight the escape door',
    Value = false,
    Callback = function(value)
        setESP('Gate', value)
    end,
})
ESPTab:Toggle({
    Title = 'Hook ESP',
    Desc = 'Hook Highlights',
    Value = false,
    Callback = function(value)
        setESP('Hook', value)
    end,
})
ESPTab:Toggle({
    Title = 'Pallet ESP',
    Desc = 'Highlight Pallets',
    Value = false,
    Callback = function(value)
        setESP('Pallet', value)
    end,
})
ESPTab:Toggle({
    Title = 'Window ESP',
    Desc = 'Highlight the windows',
    Value = false,
    Callback = function(value)
        setESP('Window', value)
    end,
})
ESPTab:Toggle({
    Title = 'Pumpkin ESP',
    Desc = 'Pumpkin Highlights',
    Value = false,
    Callback = function(value)
        setESP('Pumpkin', value)
    end,
})
ESPTab:Toggle({
    Title = 'Only Closest Hook',
    Desc = 'Highlight only the nearest hook',
    Value = false,
    Callback = function(value)
        Config.ESP.ShowOnlyClosestHook = value

        ensureESPConnection()
    end,
})
ESPTab:Toggle({
    Title = 'Mark Closest Hook',
    Desc = 'Mark the nearest hook with a different color',
    Value = false,
    Callback = function(value)
        Config.ESP.ClosestHook = value

        ensureESPConnection()
    end,
})
ESPTab:Toggle({
    Title = 'Show Distance',
    Desc = 'Displays the distance over each ESP',
    Value = true,
    Callback = function(value)
        Config.ESP.ShowDistance = value

        ensureESPConnection()
    end,
})
ESPTab:Slider({
    Title = 'ESP Max Distance',
    Desc = 'Maximum ESP distance',
    Step = 25,
    Value = {
        Min = 50,
        Max = 1000,
        Default = 500,
    },
    Callback = function(value)
        Config.ESP.MaxDistance = value

        ensureESPConnection()
    end,
})
ESPTab:Slider({
    Title = 'ESP Max Objects',
    Desc = 'Limit to avoid lag',
    Step = 5,
    Value = {
        Min = 20,
        Max = 200,
        Default = Config.ESP.MaxObjects,
    },
    Callback = function(value)
        Config.ESP.MaxObjects = value

        ensureESPConnection()
    end,
})
SurviveTab:Section({
    Title = 'Auto Generator',
    Icon = 'zap',
})
SurviveTab:Toggle({
    Title = 'Auto Complete Generators',
    Desc = 'Auto Repair Generators',
    Value = false,
    Callback = setAutoGenerator,
})
SurviveTab:Dropdown({
    Title = 'Generator Mode',
    Desc = 'Great send success; Normal env\u{ed}a neutral.',
    Values = {
        'Great (Fast)',
        'Normal (Slow)',
    },
    Value = 'Great (Fast)',
    Multi = false,
    Callback = function(value)
        Config.Survivor.GeneratorMode = value == 'Great (Fast)' and 'great' or 'normal'
    end,
})
SurviveTab:Divider()
SurviveTab:Section({
    Title = 'Killer Avoid',
    Icon = 'shield-alert',
})
SurviveTab:Toggle({
    Title = 'Auto Avoid Killer',
    Desc = 'If the Killer enters the radius, he escapes to the furthest generator',
    Value = false,
    Callback = function(value)
        Config.Survivor.AvoidKiller = value

        ensureAvoidConnection()
    end,
})
SurviveTab:Toggle({
    Title = 'Auto Leave Generator',
    Desc = "If the Killer approaches while you're near a generator, it will automatically attempt to exit repair mode",
    Value = false,
    Callback = function(value)
        Config.Survivor.AutoLeaveGenerator = value

        ensureAvoidConnection()
    end,
})
SurviveTab:Slider({
    Title = 'Killer Detection Radius',
    Desc = "Studs' Radio To escape the Killer if he approaches",
    Step = 1,
    Value = {
        Min = 10,
        Max = 80,
        Default = 20,
    },
    Callback = function(value)
        Config.Survivor.KillerDetectionRadius = value
    end,
})
SurviveTab:Slider({
    Title = 'Leave Distance',
    Desc = 'Distance used to consider that you are above a generator',
    Step = 1,
    Value = {
        Min = 5,
        Max = 50,
        Default = 15,
    },
    Callback = function(value)
        Config.Survivor.LeaveDistance = value
    end,
})
SurviveTab:Button({
    Title = 'Leave Current Generator',
    Desc = 'Exit Current Generator',
    Callback = function()
        leaveNearestGenerator()
    end,
})
SurviveTab:Paragraph({
    Title = 'Atajo',
    Desc = 'Press Q to exit the nearest generator',
})
SurviveTab:Divider()
SurviveTab:Section({
    Title = 'Aimlock',
    Icon = 'crosshair',
})
SurviveTab:Dropdown({
    Title = 'Aimlock Target Part',
    Desc = 'Part of the Killer to aim with Aimlock',
    Values = {
        'HumanoidRootPart',
        'Head',
        'UpperTorso',
        'RightArm',
        'LeftArm',
    },
    Value = 'HumanoidRootPart',
    Multi = false,
    Callback = function(value)
        Config.Survivor.AimlockPart = value
    end,
})
SurviveTab:Toggle({
    Title = 'Aimlock Killer',
    Desc = 'Point the camera towards the killer',
    Value = false,
    Callback = setAimlock,
})
KillerTab:Section({
    Title = 'Killer Powers',
    Icon = 'skull',
})
KillerTab:Toggle({
    Title = 'Auto Attack Nearby Survivors',
    Desc = 'Find the nearest Survivor within range and attack with M1',
    Value = false,
    Callback = setAutoAttack,
})
KillerTab:Slider({
    Title = 'Attack Range',
    Desc = 'Maximum attack range: If a Survivor gets within your range, you will attack them',
    Step = 1,
    Value = {
        Min = 5,
        Max = 20,
        Default = 10,
    },
    Callback = function(value)
        Config.Killer.AttackRange = value
    end,
})
KillerTab:Slider({
    Title = 'Attack Cooldown',
    Desc = "Attack speed m1, I don't recommend lowering it too much",
    Step = 0.01,
    Value = {
        Min = 0.05,
        Max = 0.5,
        Default = 0.1,
    },
    Callback = function(value)
        Config.Killer.AttackCooldown = value
    end,
})
PlayerTab:Section({
    Title = 'Movement',
    Icon = 'move',
})
PlayerTab:Toggle({
    Title = 'Speed Boost',
    Desc = 'speed of movement',
    Value = false,
    Callback = setSpeed,
})
PlayerTab:Slider({
    Title = 'Speed Value',
    Desc = 'Configure how fast you want to run',
    Step = 1,
    Value = {
        Min = 16,
        Max = 500,
        Default = 16,
    },
    Callback = function(value)
        Config.Movement.SpeedValue = value

        if Config.Movement.Speed then
            applySpeed()
        end
    end,
})
PlayerTab:Divider()
PlayerTab:Toggle({
    Title = 'NoClip',
    Desc = 'It makes you feel like you can walk through walls',
    Value = false,
    Callback = setNoClip,
})
PlayerTab:Toggle({
    Title = 'No Fall Damage',
    Desc = 'Maintains life against losses detected during Freefall/Landed. SOMETIMES FAILS',
    Value = false,
    Callback = setNoFall,
})
TeleportTab:Section({
    Title = 'Generators',
    Icon = 'map-pin',
})
TeleportTab:Button({
    Title = 'Teleport to Closest Generator',
    Desc = 'It teleports you to the nearest Generator',
    Callback = function()
        local list = getGeneratorsByDistance()

        if not list[1] then
            notify('Teleport', 'No generators were found.', 3)

            return
        end
        if safeTeleport(list[1].Part.CFrame) then
            notify('Teleport', string.format('Closest generator: %.0f studs', list[1].Distance), 2)
        end
    end,
})
TeleportTab:Button({
    Title = 'Teleport to Farthest Generator',
    Desc = 'It teleports you to the furthest generator.',
    Callback = function()
        local list = getGeneratorsByDistance()
        local farthest = list[#list]

        if not farthest then
            notify('Teleport', 'No se encontraron generators.', 3)

            return
        end
        if safeTeleport(farthest.Part.CFrame) then
            notify('Teleport', string.format('Farthest generator: %.0f studs', farthest.Distance), 2)
        end
    end,
})
TeleportTab:Divider()
TeleportTab:Section({
    Title = 'Players / Gates',
    Icon = 'send',
})

local SelectedPlayer = nil

local function getPlayerNames()
    local names = {}

    for _, player in ipairs(Players:GetPlayers())do
        if player ~= LocalPlayer then
            table.insert(names, player.Name)
        end
    end

    table.sort(names)

    return names
end

local PlayerDropdown = TeleportTab:Dropdown({
    Title = 'Select Player',
    Desc = 'Select a player to teleport to them',
    Values = getPlayerNames(),
    Value = nil,
    Multi = false,
    Callback = function(value)
        SelectedPlayer = value
    end,
})

local function refreshPlayerDropdown()
    pcall(function()
        PlayerDropdown:Refresh(getPlayerNames())
    end)
end

connect('PlayerAdded', Players.PlayerAdded, function()
    task.defer(refreshPlayerDropdown)
end)
connect('PlayerRemoving', Players.PlayerRemoving, function(player)
    if SelectedPlayer == player.Name then
        SelectedPlayer = nil
    end

    task.defer(refreshPlayerDropdown)
end)
TeleportTab:Button({
    Title = 'TP to Selected Player',
    Desc = 'Teleports you to the selected player',
    Callback = function()
        local target = SelectedPlayer and Players:FindFirstChild(SelectedPlayer)
        local targetRoot = target and getRoot(target)

        if not targetRoot then
            notify('Teleport', 'Player Dead or Not Found.', 3)

            return
        end

        safeTeleport(targetRoot.CFrame)
    end,
})
TeleportTab:Button({
    Title = 'TP to Nearest Gate',
    Desc = 'It teleports you to the nearest escape door',
    Callback = function()
        local root = getRoot()
        local map = getMap()

        if not root or not map then
            notify('Teleport', 'Not found.', 3)

            return
        end

        local part, distance = getNearestPart(getGates(), root.Position, false)

        if not part then
            notify('Teleport', 'No escape routes were found.', 3)

            return
        end
        if safeTeleport(part.CFrame) then
            notify('Teleport', string.format('Gate: %.0f studs', distance), 2)
        end
    end,
})
SettingsTab:Section({
    Title = 'Visual',
    Icon = 'sun',
})
SettingsTab:Toggle({
    Title = 'Fullbright',
    Desc = 'Increases lighting and preserves the previous state of the effects',
    Value = false,
    Callback = setFullbright,
})
SettingsTab:Toggle({
    Title = 'No Fog',
    Desc = 'Removes fog and restores original values by disabling',
    Value = false,
    Callback = setNoFog,
})
SettingsTab:Divider()
SettingsTab:Section({
    Title = 'Performance',
    Icon = 'gauge',
})
SettingsTab:Slider({
    Title = 'ESP Update Rate',
    Desc = 'The lower the ESP, the more frequent the ESP refresh',
    Step = 0.05,
    Value = {
        Min = 0.1,
        Max = 2,
        Default = 0.5,
    },
    Callback = function(value)
        Config.Performance.UpdateRate = value
    end,
})
SettingsTab:Toggle({
    Title = 'Distance Culling',
    Desc = 'Do not create ESP outside of the maximum distance',
    Value = true,
    Callback = function(value)
        Config.Performance.DistanceCulling = value

        ensureESPConnection()
    end,
})
SettingsTab:Toggle({
    Title = 'Disable Particles & Effects',
    Desc = 'Turn off ParticleEmitter, Trail, and Beam and remember their state',
    Value = false,
    Callback = function(value)
        Config.Performance.DisableParticles = value

        applyPerformance()
    end,
})
SettingsTab:Toggle({
    Title = 'Lower Graphics Quality',
    Desc = 'Try using the lowest quality option available to the customer',
    Value = false,
    Callback = function(value)
        Config.Performance.LowerGraphics = value

        applyPerformance()
    end,
})
SettingsTab:Toggle({
    Title = 'Disable Shadows',
    Desc = 'Disable GlobalShadows without touching Fog',
    Value = false,
    Callback = function(value)
        Config.Performance.DisableShadows = value

        if value then
            applyShadows()
        else
            if not FullbrightSaved then
            end
        end
    end,
})
SettingsTab:Toggle({
    Title = 'Reduce Render Distance',
    Desc = 'Adjust StreamingMinRadius/TargetRadius with restoration',
    Value = false,
    Callback = function(value)
        Config.Performance.ReduceRenderDistance = value

        applyPerformance()
    end,
})
SettingsTab:Button({
    Title = 'Apply All Performance',
    Desc = 'Activate all available optimizations',
    Callback = function()
        Config.Performance.DisableParticles = true
        Config.Performance.LowerGraphics = true
        Config.Performance.DisableShadows = true
        Config.Performance.ReduceRenderDistance = true

        applyPerformance()
        notify('Performance', 'Applied optimization', 3)
    end,
})
SettingsTab:Button({
    Title = 'Reset Performance',
    Desc = 'Restore the changes that Vyrion saved',
    Callback = function()
        resetPerformance()
        notify('Performance', 'Configuration restored', 2)
    end,
})
SettingsTab:Button({
    Title = 'Clear All ESP',
    Desc = 'Immediately clear all highlights and labels created by Vyrion',
    Callback = function()
        removeAllESP()
        ensureESPConnection()
    end,
})
connect('Input', UserInputService.InputBegan, function(input, gameProcessed)
    if gameProcessed then
        return
    end
    if input.KeyCode == Enum.KeyCode.Q then
        leaveNearestGenerator()
    end
end)
refreshPlayerDropdown()
notify('VyrionStudios', 'Violence District cargado correctamente.', 4)

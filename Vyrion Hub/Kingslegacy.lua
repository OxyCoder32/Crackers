-- ts file was generated at discord.gg/25ms

local Hub = {}
local Started = false

function Hub.Start()
    if Started then
        warn('[Vyrion Hub] Already started.')

        return
    end

    print('[Vyrion Hub] Starting main features...')

    local WindUI

    do
        local ok, result = pcall(function()
            return loadstring(game:HttpGet('https://github.com/Footagesus/WindUI/releases/download/1.6.54/main.lua'))()
        end)

        if not ok or not result then
            warn('[Vyrion Hub] Failed to load WindUI:', result)

            return
        end

        WindUI = result
    end

    pcall(function()
        WindUI:AddTheme({
            Name = 'Vyrion Red Blue',
            Dialog = Color3.fromHex('#160B25'),
            Outline = Color3.fromHex('#A832FF'),
            Text = Color3.fromHex('#F8F3FF'),
            Placeholder = Color3.fromHex('#B88CDE'),
            Background = WindUI:Gradient({
                ['0'] = {
                    Color = Color3.fromHex('#35156E'),
                    Transparency = 0.42,
                },
                ['50'] = {
                    Color = Color3.fromHex('#26164F'),
                    Transparency = 0.42,
                },
                ['100'] = {
                    Color = Color3.fromHex('#100B28'),
                    Transparency = 0.42,
                },
            }, {Rotation = 135}),
            Button = WindUI:Gradient({
                ['0'] = {
                    Color = Color3.fromHex('#FF5F72'),
                    Transparency = 0.06,
                },
                ['50'] = {
                    Color = Color3.fromHex('#4D63FF'),
                    Transparency = 0.06,
                },
                ['100'] = {
                    Color = Color3.fromHex('#2630B8'),
                    Transparency = 0.06,
                },
            }, {Rotation = 90}),
            Icon = WindUI:Gradient({
                ['0'] = {
                    Color = Color3.fromHex('#FF8A9A'),
                    Transparency = 0,
                },
                ['25'] = {
                    Color = Color3.fromHex('#FF5A72'),
                    Transparency = 0,
                },
                ['50'] = {
                    Color = Color3.fromHex('#7A4CFF'),
                    Transparency = 0,
                },
                ['75'] = {
                    Color = Color3.fromHex('#4D63FF'),
                    Transparency = 0,
                },
                ['100'] = {
                    Color = Color3.fromHex('#2630B8'),
                    Transparency = 0,
                },
            }, {Rotation = 135}),
        })
    end)

    local Window = WindUI:CreateWindow({
        Title = 'VYRION HUB | AIMBOT',
        Author = 'Thermomix',
        Icon = 'skull',
        Folder = 'VyrionStudios',
        Size = UDim2.fromOffset(640, 420),
        Transparent = true,
        Resizable = true,
        Theme = 'Vyrion Red Blue',
        SideBarWidth = 210,
        HideSearchBar = false,
        ScrollBarEnabled = true,
        Background = WindUI:Gradient({
            ['0'] = {
                Color = Color3.fromHex('#35156E'),
                Transparency = 0.42,
            },
            ['40'] = {
                Color = Color3.fromHex('#26164F'),
                Transparency = 0.42,
            },
            ['70'] = {
                Color = Color3.fromHex('#05204A'),
                Transparency = 0.42,
            },
            ['100'] = {
                Color = Color3.fromHex('#100B28'),
                Transparency = 0.42,
            },
        }, {Rotation = 135}),
        BackgroundImageTransparency = 0.42,
        User = {
            Enabled = true,
            Anonymous = false,
            Callback = function()
                WindUI:Notify({
                    Title = 'Vyrion Hub',
                    Content = 'Aimbot module \u{2022} Vyrion Hub',
                    Duration = 4,
                    Icon = 'user',
                })
            end,
        },
    })

    if not Window then
        warn('[Vyrion Hub] WindUI window failed to create.')

        return
    end

    pcall(function()
        Window:Tag({
            Title = 'AIMBOT 1.7',
            Color = WindUI:Gradient({
                ['0'] = {
                    Color = Color3.fromHex('#FF5268'),
                    Transparency = 0,
                },
                ['50'] = {
                    Color = Color3.fromHex('#7A4CFF'),
                    Transparency = 0,
                },
                ['100'] = {
                    Color = Color3.fromHex('#263B9A'),
                    Transparency = 0,
                },
            }, {Rotation = 90}),
            Radius = 13,
        })
    end)
    pcall(function()
        Window:Tag({
            Title = 'Free',
            Color = WindUI:Gradient({
                ['0'] = {
                    Color = Color3.fromHex('#FF5F72'),
                    Transparency = 0,
                },
                ['100'] = {
                    Color = Color3.fromHex('#4D63FF'),
                    Transparency = 0,
                },
            }, {Rotation = 45}),
            Radius = 13,
        })
    end)
    pcall(function()
        Window:EditOpenButton({
            Title = 'Vyrion Hub | Aimbot',
            Icon = 'rbxassetid://90450210081651',
            CornerRadius = UDim.new(0, 16),
            StrokeThickness = 2,
            Color = ColorSequence.new(Color3.fromHex('#FF5268'), Color3.fromHex('#2630B8')),
            OnlyMobile = false,
            Enabled = true,
            Draggable = true,
        })
    end)

    local function Notify(content, duration)
        pcall(function()
            WindUI:Notify({
                Title = 'Vyrion Hub | Aimbot',
                Content = tostring(content),
                Duration = duration or 3,
            })
        end)
    end

    local Players = game:GetService('Players')
    local RunService = game:GetService('RunService')
    local UserInputService = game:GetService('UserInputService')
    local player = Players.LocalPlayer
    local mouse = player:GetMouse()
    local camera = workspace.CurrentCamera
    local selectedPlayer = ''
    local targetInCircle = false
    local cachedRadiusSq = 5625

    _G.Settings = {
        aimbot = false,
        aimbotPriority = false,
        aimbotnear = false,
        aimbotd = 200,
        flashStepAim = false,
        aimPrediction = 0,
        circle = false,
        circlez = 0,
        aimNPC = false,
        aimNPCDistance = 200,
        camlock = false,
        camlockPriority = false,
        camlockTarget = '',
        camlockIntensity = 5,
        teleportPlayer = false,
        speedEnabled = false,
        speedMode = 'CFrame',
        speedValue = 50,
        espPlayers = false,
        infJump = false,
        antiLag = false,
    }
    _G.CurrentTarget = nil
    _G.pos_skill = nil
    _G.SkillAimTarget = nil

    local function GetSetting(name)
        return _G.Settings[name]
    end

    local kenHakiVisualCount = 0
    local kenHakiLoad = false

    local function IsCharacterModel(instance)
        if not instance then
            return false
        end

        local model = instance:FindFirstAncestorOfClass('Model')

        if not model then
            return false
        end

        return model:FindFirstChildOfClass('Humanoid') ~= nil
    end
    local function IsKenHakiVisual(instance)
        if not instance then
            return false
        end
        if instance.Name == 'PlayerESP' then
            return false
        end
        if not (instance:IsA('BillboardGui') or instance:IsA('Highlight') or instance:IsA('SelectionBox')) then
            return false
        end
        if not IsCharacterModel(instance) then
            return false
        end

        local name = string.lower(instance.Name)

        if string.find(name, 'ken') or string.find(name, 'haki') or string.find(name, 'observation') or string.find(name, 'level') or string.find(name, 'mark') or string.find(name, 'name') then
            return true
        end
        if instance:IsA('BillboardGui') or instance:IsA('Highlight') then
            return true
        end

        return false
    end
    local function UpdateKenHakiLoad()
        kenHakiLoad = kenHakiVisualCount >= 3
    end
    local function RegisterKenHakiVisual(instance)
        if IsKenHakiVisual(instance) then
            kenHakiVisualCount += 1

            UpdateKenHakiLoad()
        end
    end
    local function UnregisterKenHakiVisual(instance)
        if IsKenHakiVisual(instance) then
            kenHakiVisualCount = math.max(0, kenHakiVisualCount - 1)

            UpdateKenHakiLoad()
        end
    end

    task.spawn(function()
        local count = 0

        for _, instance in ipairs(workspace:GetDescendants())do
            if IsKenHakiVisual(instance) then
                count += 1
            end
        end

        kenHakiVisualCount = count

        UpdateKenHakiLoad()
    end)
    workspace.DescendantAdded:Connect(function(instance)
        RegisterKenHakiVisual(instance)
    end)
    workspace.DescendantRemoving:Connect(function(instance)
        UnregisterKenHakiVisual(instance)
    end)

    local playerList = {}

    for _, p in ipairs(Players:GetPlayers())do
        if p ~= player then
            playerList[p] = true
        end
    end

    Players.PlayerAdded:Connect(function(p)
        if p ~= player then
            playerList[p] = true
        end
    end)
    Players.PlayerRemoving:Connect(function(p)
        playerList[p] = nil
    end)

    local npcCache = {}

    local function IsAllowedNPCContainer(container)
        if not container then
            return false
        end

        local monster = workspace:FindFirstChild('Monster')

        return container == (monster and monster:FindFirstChild('Mon')) or container == (monster and monster:FindFirstChild('Boss')) or container == workspace:FindFirstChild('MOB')
    end
    local function IsValidNPC(model)
        if not model or not model:IsA('Model') then
            return false
        end
        if model == player.Character then
            return false
        end
        if not IsAllowedNPCContainer(model.Parent) then
            return false
        end

        local humanoid = model:FindFirstChildOfClass('Humanoid')
        local hrp = model:FindFirstChild('HumanoidRootPart')

        return humanoid ~= nil and humanoid.Health > 0 and hrp ~= nil
    end
    local function AddNPCToCache(model)
        if not IsValidNPC(model) then
            return
        end
        if npcCache[model] then
            return
        end

        npcCache[model] = {
            Character = model,
            Humanoid = model:FindFirstChildOfClass('Humanoid'),
            HRP = model:FindFirstChild('HumanoidRootPart'),
            Head = model:FindFirstChild('Head'),
        }
    end
    local function RemoveNPCFromCache(model)
        npcCache[model] = nil
    end
    local function ScanNPCContainer(container)
        if not container then
            return
        end

        for _, object in ipairs(container:GetChildren())do
            if object:IsA('Model') then
                AddNPCToCache(object)
            end
        end
    end
    local function ConnectNPCContainer(container)
        if not container then
            return
        end

        ScanNPCContainer(container)
        container.ChildAdded:Connect(function(object)
            if object:IsA('Model') then
                task.defer(function()
                    if object.Parent == container then
                        AddNPCToCache(object)
                    end
                end)
            end
        end)
        container.ChildRemoved:Connect(function(object)
            if object:IsA('Model') then
                RemoveNPCFromCache(object)
            end
        end)
    end

    task.spawn(function()
        local monster = workspace:FindFirstChild('Monster')

        ConnectNPCContainer(monster and monster:FindFirstChild('Mon'))
        ConnectNPCContainer(monster and monster:FindFirstChild('Boss'))
        ConnectNPCContainer(workspace:FindFirstChild('MOB'))
    end)
    workspace.ChildAdded:Connect(function(object)
        if object.Name == 'MOB' then
            ConnectNPCContainer(object)
        elseif object.Name == 'Monster' then
            task.defer(function()
                if object.Parent == workspace then
                    ConnectNPCContainer(object:FindFirstChild('Mon'))
                    ConnectNPCContainer(object:FindFirstChild('Boss'))
                end
            end)
        end
    end)
    workspace.DescendantAdded:Connect(function(object)
        if not object:IsA('Folder') then
            return
        end
        if object.Name ~= 'Mon' and object.Name ~= 'Boss' then
            return
        end

        local monster = workspace:FindFirstChild('Monster')

        if monster and object.Parent == monster then
            ConnectNPCContainer(object)
        end
    end)

    local gui = Instance.new('ScreenGui')

    gui.Name = 'NexusWareAimCircle'
    gui.ResetOnSpawn = false
    gui.Parent = game.CoreGui

    local circle = Instance.new('Frame')

    circle.Size = UDim2.new(0, 150, 0, 150)
    circle.AnchorPoint = Vector2.new(0.5, 0.5)
    circle.BackgroundTransparency = 1
    circle.Visible = false
    circle.Parent = gui

    local uiCorner = Instance.new('UICorner')

    uiCorner.CornerRadius = UDim.new(1, 0)
    uiCorner.Parent = circle

    local uiStroke = Instance.new('UIStroke')

    uiStroke.Thickness = 3
    uiStroke.Color = Color3.fromRGB(255, 0, 0)
    uiStroke.Parent = circle

    local circleConnection = nil

    local function UpdateCircleConnection(enabled)
        if enabled then
            if not circleConnection then
                circle.Visible = true
                circleConnection = RunService.RenderStepped:Connect(function()
                    circle.Position = UDim2.fromOffset(mouse.X, mouse.Y)

                    if targetInCircle then
                        uiStroke.Color = Color3.fromRGB(0, 255, 0)
                    else
                        uiStroke.Color = Color3.fromRGB(255, 0, 0)
                    end
                end)
            end
        else
            if circleConnection then
                circleConnection:Disconnect()

                circleConnection = nil
            end

            circle.Visible = false
        end
    end

    local AIM_CIRCLE_BASE_SIZE = 150

    local function UpdateAimCircleSize(value)
        local diameter = AIM_CIRCLE_BASE_SIZE + value

        circle.Size = UDim2.fromOffset(diameter, diameter)

        local radius = diameter / 2

        cachedRadiusSq = radius * radius
    end
    local function GetCharacterData(targetPlayer)
        if not targetPlayer then
            return nil
        end

        local character = targetPlayer.Character

        if not character then
            return nil
        end

        local humanoid = character:FindFirstChildOfClass('Humanoid')
        local hrp = character:FindFirstChild('HumanoidRootPart')
        local head = character:FindFirstChild('Head')

        if not humanoid or humanoid.Health <= 0 then
            return nil
        end
        if not hrp then
            return nil
        end

        return {
            Player = targetPlayer,
            Character = character,
            Humanoid = humanoid,
            HRP = hrp,
            Head = head,
        }
    end
    local function GetPriorityTarget()
        if not GetSetting('aimbotPriority') then
            return nil
        end
        if selectedPlayer == '' or selectedPlayer == 'No Data' then
            return nil
        end

        local targetPlayer = Players:FindFirstChild(selectedPlayer)

        return GetCharacterData(targetPlayer)
    end
    local function GetSelectedTarget()
        if not GetSetting('aimbot') then
            return nil
        end
        if selectedPlayer == '' or selectedPlayer == 'No Data' then
            return nil
        end

        local targetPlayer = Players:FindFirstChild(selectedPlayer)

        return GetCharacterData(targetPlayer)
    end
    local function GetNearestTarget()
        if not GetSetting('aimbotnear') then
            return nil
        end

        local myCharacter = player.Character
        local myHRP = myCharacter and myCharacter:FindFirstChild('HumanoidRootPart')

        if not myHRP then
            return nil
        end

        local maxDistance = tonumber(GetSetting('aimbotd')) or 200

        if maxDistance <= 0 then
            return nil
        end

        local maxDistanceSq = maxDistance * maxDistance
        local closest = nil
        local closestDistanceSq = math.huge

        for targetPlayer in pairs(playerList)do
            if targetPlayer ~= player then
                local data = GetCharacterData(targetPlayer)

                if data and data.HRP then
                    local stats = targetPlayer:FindFirstChild('PlayerStats')
                    local pvp = stats and stats:FindFirstChild('PVP')
                    local allyGUI = data.Head and data.Head:FindFirstChild('AllyGUI')

                    if pvp and pvp.Value and not allyGUI then
                        local offset = data.HRP.Position - myHRP.Position
                        local distanceSq = offset:Dot(offset)

                        if distanceSq <= maxDistanceSq and distanceSq < closestDistanceSq then
                            closestDistanceSq = distanceSq
                            closest = data
                        end
                    end
                end
            end
        end

        return closest
    end
    local function GetCircleTarget()
        if not GetSetting('circle') then
            return nil
        end

        local mousePosition = Vector2.new(mouse.X, mouse.Y)
        local closest = nil
        local closestDistanceSq = cachedRadiusSq

        for targetPlayer in pairs(playerList)do
            local data = GetCharacterData(targetPlayer)

            if data and data.HRP then
                local screenPosition, onScreen = camera:WorldToViewportPoint(data.HRP.Position)

                if onScreen then
                    local dx = mousePosition.X - screenPosition.X
                    local dy = mousePosition.Y - screenPosition.Y
                    local distanceSq = dx * dx + dy * dy

                    if distanceSq <= closestDistanceSq then
                        closestDistanceSq = distanceSq
                        closest = data
                    end
                end
            end
        end

        return closest
    end
    local function GetNPCTarget()
        if not GetSetting('aimNPC') then
            return nil
        end

        local myCharacter = player.Character
        local myHRP = myCharacter and myCharacter:FindFirstChild('HumanoidRootPart')

        if not myHRP then
            return nil
        end

        local maxDistance = tonumber(GetSetting('aimNPCDistance')) or 200

        if maxDistance <= 0 then
            return nil
        end

        local maxDistanceSq = maxDistance * maxDistance
        local closest = nil
        local closestDistanceSq = math.huge

        for npc, data in pairs(npcCache)do
            if not npc.Parent or not IsAllowedNPCContainer(npc.Parent) then
                npcCache[npc] = nil
            elseif data.Humanoid and data.Humanoid.Health > 0 and data.HRP and data.HRP.Parent then
                local allyGUI = data.Head and data.Head:FindFirstChild('AllyGUI')

                if not allyGUI then
                    local offset = data.HRP.Position - myHRP.Position
                    local distanceSq = offset:Dot(offset)

                    if distanceSq <= maxDistanceSq and distanceSq < closestDistanceSq then
                        closestDistanceSq = distanceSq
                        closest = data
                    end
                end
            end
        end

        return closest
    end

    local cachedNPCTarget = nil
    local lastNPCTargetUpdate = 0

    local function GetCachedNPCTarget()
        if not GetSetting('aimNPC') then
            cachedNPCTarget = nil

            return nil
        end

        local now = os.clock()
        local interval = kenHakiLoad and 0.3 or 0.2

        if now - lastNPCTargetUpdate >= interval then
            lastNPCTargetUpdate = now
            cachedNPCTarget = GetNPCTarget()
        end

        return cachedNPCTarget
    end
    local function ResolveAimTarget()
        local target = GetPriorityTarget()

        if target then
            return target, 'Priority'
        end
        if GetSetting('aimbotnear') then
            target = GetNearestTarget()

            if target then
                return target, 'Nearest'
            end
        end

        target = GetSelectedTarget()

        if target then
            return target, 'Selected'
        end

        target = GetCircleTarget()

        if target then
            return target, 'Circle'
        end

        target = GetCachedNPCTarget()

        if target then
            return target, 'NPC'
        end

        return nil, nil
    end

    local aimPlayerSignature = ''

    local function GetAimPlayerNames()
        local names = {}

        for p in pairs(playerList)do
            if p ~= player then
                table.insert(names, p.Name)
            end
        end

        table.sort(names, function(a, b)
            return a:lower() < b:lower()
        end)

        if #names == 0 then
            table.insert(names, 'No Data')
        end

        return names
    end
    local function GetAimPlayerSignature()
        return table.concat(GetAimPlayerNames(), '|')
    end

    local camlockPlayerSignature = ''

    local function GetCamLockPlayers()
        local players = {}

        for _, targetPlayer in ipairs(Players:GetPlayers())do
            if targetPlayer ~= player then
                table.insert(players, targetPlayer)
            end
        end

        table.sort(players, function(a, b)
            return a.Name:lower() < b.Name:lower()
        end)

        return players
    end
    local function GetCamLockPlayerNames()
        local names = {}

        for _, targetPlayer in ipairs(GetCamLockPlayers())do
            table.insert(names, targetPlayer.Name)
        end

        if #names == 0 then
            table.insert(names, 'No Players')
        end

        return names
    end
    local function GetCamLockSignature()
        return table.concat(GetCamLockPlayerNames(), '|')
    end
    local function FindClosestCamLockPlayer()
        local myCharacter = player.Character
        local myHRP = myCharacter and myCharacter:FindFirstChild('HumanoidRootPart')

        if not myHRP then
            return nil
        end

        local closestCharacter = nil
        local closestDistanceSq = math.huge

        for _, targetPlayer in ipairs(GetCamLockPlayers())do
            local character = targetPlayer.Character

            if character then
                local hrp = character:FindFirstChild('HumanoidRootPart')
                local humanoid = character:FindFirstChildOfClass('Humanoid')

                if hrp and humanoid and humanoid.Health > 0 then
                    local head = character:FindFirstChild('Head')
                    local allyGUI = head and head:FindFirstChild('AllyGUI')

                    if not allyGUI then
                        local offset = myHRP.Position - hrp.Position
                        local distanceSq = offset:Dot(offset)

                        if distanceSq < closestDistanceSq then
                            closestDistanceSq = distanceSq
                            closestCharacter = character
                        end
                    end
                end
            end
        end

        return closestCharacter
    end
    local function FindPriorityCamLockPlayer()
        local targetName = _G.Settings.camlockTarget

        if not targetName or targetName == '' or targetName == 'No Players' then
            return nil
        end

        local targetPlayer = Players:FindFirstChild(targetName)

        if not targetPlayer or targetPlayer == player then
            return nil
        end

        local character = targetPlayer.Character

        if not character then
            return nil
        end

        local hrp = character:FindFirstChild('HumanoidRootPart')
        local humanoid = character:FindFirstChildOfClass('Humanoid')

        if not hrp or not humanoid or humanoid.Health <= 0 then
            return nil
        end

        local head = character:FindFirstChild('Head')
        local allyGUI = head and head:FindFirstChild('AllyGUI')

        if allyGUI then
            return nil
        end

        return character
    end
    local function UpdateCamLockTarget()
        if not _G.Settings.camlock then
            _G.CurrentTarget = nil

            return
        end
        if _G.Settings.camlockPriority then
            _G.CurrentTarget = FindPriorityCamLockPlayer()

            return
        end

        _G.CurrentTarget = FindClosestCamLockPlayer()
    end

    local InfoTab = Window:Tab({
        Title = 'Info',
        Icon = 'house',
        Opened = true,
    })

    InfoTab:Section({
        Title = '\u{2014} Welcome to Vyrion Hub \u{2014}',
        Icon = 'sparkles',
        Opened = false,
        Desc = 'Aimbot module \u{2022} WindUI edition',
    })
    InfoTab:Paragraph({
        Title = 'About Vyrion Hub',
        Desc = '\u{2192} Vyrion Hub | Aimbot 1.7\n\u{2192} WindUI interface styled after Vyrion Hub Final.\n\u{2192} Original combat, player, NPC and performance logic preserved.\n\u{2192} Runtime configuration remains stored in _G.Settings.',
    })
    InfoTab:Divider()

    local DiscordInvite = 'M3paay9U7'
    local DiscordInviteURL = 'https://discord.gg/' .. DiscordInvite
    local DiscordAPIURL = 'https://discord.com/api/v10/invites/' .. DiscordInvite .. '?with_counts=true&with_expiration=true'
    local DiscordInfo = {
        memberCount = '...',
        onlineCount = '...',
        paragraph = nil,
    }

    local function DiscordRequest(options)
        local ok, result = pcall(function()
            if syn and syn.request then
                return syn.request(options)
            end
            if request and type(request) == 'function' then
                return request(options)
            end
            if http and http.request then
                return http.request(options)
            end

            local HttpService = game:GetService('HttpService')

            return {
                Body = HttpService:GetAsync(options.Url),
                StatusCode = 200,
                Success = true,
            }
        end)

        if ok then
            return result
        end

        return {
            Body = '{}',
            StatusCode = 0,
            Success = false,
        }
    end
    local function GetDiscordInfo()
        local HttpService = game:GetService('HttpService')
        local ok, data = pcall(function()
            local response = DiscordRequest({
                Url = DiscordAPIURL,
                Method = 'GET',
                Headers = {
                    ['User-Agent'] = 'RobloxBot/1.0',
                    Accept = 'application/json',
                },
            })

            if not response or (response.StatusCode and response.StatusCode ~= 200) then
                error('Discord request failed')
            end

            return HttpService:JSONDecode(response.Body)
        end)

        if ok and data and data.guild then
            DiscordInfo.memberCount = tostring(data.approximate_member_count or 'Unavailable')
            DiscordInfo.onlineCount = tostring(data.approximate_presence_count or 'Unavailable')

            local iconURL = nil

            if data.guild.id and data.guild.icon then
                iconURL = 'https://cdn.discordapp.com/icons/' .. tostring(data.guild.id) .. '/' .. tostring(data.guild.icon) .. '.png?size=1024'
            end

            return iconURL
        end

        DiscordInfo.memberCount = 'Unavailable'
        DiscordInfo.onlineCount = 'Unavailable'

        return nil
    end
    local function DiscordCountsText()
        return '\u{2022} Members: ' .. DiscordInfo.memberCount .. '\n\u{2022} Online: ' .. DiscordInfo.onlineCount
    end

    local DiscordIcon = GetDiscordInfo()

    DiscordInfo.paragraph = InfoTab:Paragraph({
        Title = 'VyrionStudios',
        Desc = DiscordCountsText(),
        Image = DiscordIcon,
        ImageSize = 52,
    })

    InfoTab:Button({
        Title = 'Discord',
        Icon = 'message-circle',
        Description = 'Join the official VyrionStudios Discord community',
        Callback = function()
            pcall(function()
                setclipboard(DiscordInviteURL)
            end)
            Notify('Discord invite copied to clipboard!')
        end,
    })
    InfoTab:Divider()
    InfoTab:Section({
        Title = 'Information',
        Icon = 'info',
        Opened = false,
        Desc = '',
    })
    InfoTab:Paragraph({
        Title = 'About Vyrion Hub',
        Desc = '\u{2192} Vyrion Hub | Aimbot module.\n\u{2192} WindUI interface styled after Vyrion Hub Final.\n\u{2192} Original gameplay logic and runtime configuration preserved.',
    })
    InfoTab:Divider()
    InfoTab:Section({
        Title = 'Features',
        Icon = 'list',
        Opened = false,
        Desc = '',
    })
    InfoTab:Paragraph({
        Title = "What's Included",
        Desc = '\u{2192} Aim Skill Player\n\u{2192} CamLock\n\u{2192} Player Teleport\n\u{2192} Player ESP\n\u{2192} Speed + Infinite Jump\n\u{2192} Aim NPC\n\u{2192} Anti Lag\n\u{2192} Server Live / event reporting\n\u{2192} Original webhook / fruit-stock routines remain active.',
    })
    InfoTab:Divider()
    InfoTab:Section({
        Title = 'Refresh',
        Icon = 'refresh-cw',
        Opened = false,
        Desc = '',
    })
    InfoTab:Button({
        Title = 'Refresh Server Info',
        Description = 'Re-fetch live Discord member and online counts',
        Callback = function()
            local iconURL = GetDiscordInfo()

            pcall(function()
                DiscordInfo.paragraph:SetDesc(DiscordCountsText())

                if iconURL then
                    DiscordInfo.paragraph = InfoTab:Paragraph({
                        Title = 'VyrionStudios',
                        Desc = DiscordCountsText(),
                        Image = iconURL,
                        ImageSize = 52,
                    })
                end
            end)
            Notify('Discord info updated!')
        end,
    })
    InfoTab:Divider()
    InfoTab:Section({
        Title = 'Runtime Configuration',
        Icon = 'settings',
        Opened = false,
        Desc = 'Original _G.Settings table preserved.',
    })

    local SettingsInfo = InfoTab:Paragraph({
        Title = 'Current Status',
        Desc = 'Aimbot: false\nCamLock: false\nPlayer ESP: false\nAim NPC: false\nAnti Lag: false',
    })

    local function RefreshSettingsInfo()
        pcall(function()
            SettingsInfo:SetDesc('Aimbot: ' .. tostring(_G.Settings.aimbot) .. '\nCamLock: ' .. tostring(_G.Settings.camlock) .. '\nPlayer ESP: ' .. tostring(_G.Settings.espPlayers) .. '\nAim NPC: ' .. tostring(_G.Settings.aimNPC) .. '\nAnti Lag: ' .. tostring(_G.Settings.antiLag))
        end)
    end

    InfoTab:Button({
        Title = 'Refresh Settings Info',
        Icon = 'refresh-cw',
        Description = 'Refresh the runtime status shown above.',
        Callback = function()
            RefreshSettingsInfo()
            Notify('Runtime settings information refreshed.')
        end,
    })
    InfoTab:Divider()
    InfoTab:Section({
        Title = 'UI',
        Icon = 'palette',
        Opened = false,
        Desc = 'Vyrion Red Blue theme \u{2022} WindUI 1.6.54',
    })
    InfoTab:Paragraph({
        Title = 'Interface',
        Desc = '640\u{d7}420 resizable window\nPurple / blue Vyrion gradient\nFloating Vyrion button\nWindUI sidebar and search',
    })

    local Tab = Window:Tab({
        Title = 'Combat',
        Icon = 'swords',
        Opened = false,
    })

    Tab:Section({
        Title = 'Aim Skill Player',
        Icon = 'crosshair',
        Opened = false,
        Desc = '',
    })

    local PlayerDropdown = Tab:Dropdown({
        Title = 'Select Player',
        Values = GetAimPlayerNames(),
        Value = 'No Data',
        Callback = function(Value)
            if Value == 'No Data' then
                selectedPlayer = ''
            else
                selectedPlayer = tostring(Value)
            end
        end,
    })

    Tab:Toggle({
        Title = 'Flash Step Aim (ButtonR3)',
        Default = false,
        Callback = function(Value)
            _G.Settings.flashStepAim = Value
        end,
    })
    Tab:Toggle({
        Title = 'Aim Selected Player',
        Default = false,
        Callback = function(Value)
            _G.Settings.aimbot = Value
        end,
    })

    local function RefreshAimPlayers(force)
        local newSignature = GetAimPlayerSignature()

        if not force and newSignature == aimPlayerSignature then
            return
        end

        aimPlayerSignature = newSignature

        local previousPlayer = selectedPlayer

        pcall(function()
            PlayerDropdown:SetValues(GetAimPlayerNames())
        end)

        if previousPlayer ~= '' and previousPlayer ~= 'No Data' and Players:FindFirstChild(previousPlayer) then
            selectedPlayer = previousPlayer
        else
            selectedPlayer = ''
        end
    end

    Tab:Button({
        Title = 'Refresh Players',
        Icon = 'refresh-cw',
        Callback = function()
            RefreshAimPlayers(true)
        end,
    })
    Tab:Toggle({
        Title = 'Aim Skill Nearest',
        Default = false,
        Callback = function(Value)
            _G.Settings.aimbotnear = Value
        end,
    })
    Tab:Toggle({
        Title = 'Priority Player Aim Skill',
        Default = false,
        Callback = function(Value)
            _G.Settings.aimbotPriority = Value
        end,
    })
    Tab:Slider({
        Title = 'Aim Distance',
        Value = {
            Min = 200,
            Max = 1000,
            Default = 200,
        },
        Step = 1,
        Callback = function(Value)
            _G.Settings.aimbotd = Value
        end,
    })
    Tab:Slider({
        Title = 'Aim Prediction',
        Value = {
            Min = 0,
            Max = 0.5,
            Default = 0,
        },
        Step = 0.01,
        Callback = function(Value)
            local value = tonumber(Value) or 0

            if value < 0.01 then
                value = 0
            end

            _G.Settings.aimPrediction = value
        end,
    })
    Tab:Toggle({
        Title = 'Turn On Aim Circle',
        Default = false,
        Callback = function(Value)
            _G.Settings.circle = Value

            UpdateCircleConnection(Value)
        end,
    })
    Tab:Slider({
        Title = 'Aim Circle Size',
        Value = {
            Min = 0,
            Max = 400,
            Default = 0,
        },
        Step = 1,
        Callback = function(Value)
            _G.Settings.circlez = Value

            UpdateAimCircleSize(Value)
        end,
    })
    Tab:Section({
        Title = 'CamLock',
        Icon = 'lock',
        Opened = false,
        Desc = '',
    })

    local CamLockPlayerDropdown = Tab:Dropdown({
        Title = 'CamLock Player',
        Values = GetCamLockPlayerNames(),
        Value = 'No Players',
        Callback = function(Value)
            if Value == 'No Players' then
                _G.Settings.camlockTarget = ''
            else
                _G.Settings.camlockTarget = tostring(Value)
            end
            if _G.Settings.camlockPriority then
                UpdateCamLockTarget()
            end
        end,
    })

    local function RefreshCamLockPlayers(force)
        local newSignature = GetCamLockSignature()

        if not force and newSignature == camlockPlayerSignature then
            return
        end

        camlockPlayerSignature = newSignature

        local previousTarget = _G.Settings.camlockTarget

        pcall(function()
            CamLockPlayerDropdown:SetValues(GetCamLockPlayerNames())
        end)

        if previousTarget ~= '' and previousTarget ~= 'No Players' and Players:FindFirstChild(previousTarget) then
            _G.Settings.camlockTarget = previousTarget
        else
            _G.Settings.camlockTarget = ''

            if _G.Settings.camlockPriority then
                _G.CurrentTarget = nil
            end
        end

        UpdateCamLockTarget()
    end

    Tab:Button({
        Title = 'Refresh CamLock Players',
        Icon = 'refresh-cw',
        Callback = function()
            RefreshCamLockPlayers(true)
        end,
    })
    Tab:Toggle({
        Title = 'Priority Player Lock',
        Default = false,
        Callback = function(Value)
            _G.Settings.camlockPriority = Value

            UpdateCamLockTarget()
        end,
    })
    Tab:Toggle({
        Title = 'CamLock',
        Default = false,
        Callback = function(Value)
            _G.Settings.camlock = Value

            if not Value then
                _G.CurrentTarget = nil
            else
                UpdateCamLockTarget()
            end
        end,
    })
    Tab:Slider({
        Title = 'Monitoring Intensity',
        Value = {
            Min = 1,
            Max = 20,
            Default = 5,
        },
        Step = 1,
        Callback = function(Value)
            _G.Settings.camlockIntensity = Value
        end,
    })

    local PlayerTab = Window:Tab({
        Title = 'Player',
        Icon = 'user',
        Opened = false,
    })

    _G.Settings.autoRunLowHealth = _G.Settings.autoRunLowHealth or false
    _G.Settings.autoRunLowHealthPercent = _G.Settings.autoRunLowHealthPercent or 50
    _G.Settings.autoActivateV3 = _G.Settings.autoActivateV3 or false
    _G.Settings.autoActivateV3Percent = _G.Settings.autoActivateV3Percent or 30

    local LowHealthRunPosition = CFrame.new(-5994, 20118, 5461)
    local lowHealthReturnCFrame = nil
    local lowHealthRunActive = false
    local lowHealthV3Triggered = false

    local function GetLowHealthPercent()
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass('Humanoid')

        if not humanoid or humanoid.MaxHealth <= 0 then
            return nil
        end

        return (humanoid.Health / humanoid.MaxHealth) * 100
    end
    local function ReturnFromLowHealthRun()
        if not lowHealthRunActive then
            return
        end

        local character = player.Character
        local root = character and character:FindFirstChild('HumanoidRootPart')

        if root and lowHealthReturnCFrame then
            root.CFrame = lowHealthReturnCFrame
        end

        lowHealthReturnCFrame = nil
        lowHealthRunActive = false
    end

    PlayerTab:Section({
        Title = 'Run Low Health',
        Icon = 'heart-pulse',
        Opened = false,
        Desc = 'Escape and return automatically according to health.',
    })
    PlayerTab:Toggle({
        Title = 'Auto Run Low Health',
        Default = false,
        Callback = function(Value)
            _G.Settings.autoRunLowHealth = Value

            if not Value then
                ReturnFromLowHealthRun()
            end
        end,
    })
    PlayerTab:Slider({
        Title = 'Run Health %',
        Value = {
            Min = 20,
            Max = 100,
            Default = 50,
        },
        Step = 1,
        Callback = function(Value)
            _G.Settings.autoRunLowHealthPercent = tonumber(Value) or 50
        end,
    })
    PlayerTab:Section({
        Title = 'Activate V3 with low health',
        Icon = 'shield',
        Opened = false,
        Desc = 'Activates V3 once when health reaches the selected threshold.',
    })
    PlayerTab:Toggle({
        Title = 'Auto Activate V3',
        Default = false,
        Callback = function(Value)
            _G.Settings.autoActivateV3 = Value

            if not Value then
                lowHealthV3Triggered = false
            end
        end,
    })
    PlayerTab:Slider({
        Title = 'V3 Health %',
        Value = {
            Min = 10,
            Max = 100,
            Default = 30,
        },
        Step = 1,
        Callback = function(Value)
            _G.Settings.autoActivateV3Percent = tonumber(Value) or 30
        end,
    })
    task.spawn(function()
        while task.wait(0.1) do
            pcall(function()
                local hp = GetLowHealthPercent()

                if not hp then
                    return
                end
                if _G.Settings.autoRunLowHealth then
                    local threshold = tonumber(_G.Settings.autoRunLowHealthPercent) or 50
                    local character = player.Character
                    local root = character and character:FindFirstChild('HumanoidRootPart')

                    if not lowHealthRunActive and hp <= threshold and root then
                        lowHealthReturnCFrame = root.CFrame
                        lowHealthRunActive = true
                        root.CFrame = LowHealthRunPosition
                    elseif lowHealthRunActive and hp > threshold then
                        ReturnFromLowHealthRun()
                    elseif lowHealthRunActive and root then
                        root.CFrame = LowHealthRunPosition
                    end
                elseif lowHealthRunActive then
                    ReturnFromLowHealthRun()
                end
                if _G.Settings.autoActivateV3 then
                    local threshold = tonumber(_G.Settings.autoActivateV3Percent) or 30

                    if hp > threshold then
                        lowHealthV3Triggered = false
                    elseif hp <= threshold and not lowHealthV3Triggered then
                        lowHealthV3Triggered = true

                        task.spawn(function()
                            pcall(function()
                                local chest = game:GetService('ReplicatedStorage'):FindFirstChild('Chest')
                                local remotes = chest and chest:FindFirstChild('Remotes')
                                local functions = remotes and remotes:FindFirstChild('Functions')
                                local skillAction = functions and functions:FindFirstChild('SkillAction')

                                if skillAction and skillAction:IsA('RemoteFunction') then
                                    skillAction:InvokeServer('RC')
                                end
                            end)
                        end)
                    end
                else
                    lowHealthV3Triggered = false
                end
            end)
        end
    end)
    PlayerTab:Section({
        Title = 'Teleport Player',
        Icon = 'rocket',
        Opened = false,
        Desc = '',
    })

    local teleportSelectedPlayer = ''
    local teleportPlayerSignature = ''

    local function GetTeleportPlayerNames()
        local names = {}

        for p in pairs(playerList)do
            if p ~= player then
                table.insert(names, p.Name)
            end
        end

        table.sort(names, function(a, b)
            return a:lower() < b:lower()
        end)

        if #names == 0 then
            table.insert(names, 'No Data')
        end

        return names
    end
    local function GetTeleportPlayerSignature()
        return table.concat(GetTeleportPlayerNames(), '|')
    end

    local TeleportPlayerDropdown = PlayerTab:Dropdown({
        Title = 'Teleport Player Select',
        Values = GetTeleportPlayerNames(),
        Value = 'No Data',
        Callback = function(Value)
            if Value == 'No Data' then
                teleportSelectedPlayer = ''
            else
                teleportSelectedPlayer = tostring(Value)
            end
        end,
    })

    local function RefreshTeleportPlayers(force)
        local newSignature = GetTeleportPlayerSignature()

        if not force and newSignature == teleportPlayerSignature then
            return
        end

        teleportPlayerSignature = newSignature

        local previousPlayer = teleportSelectedPlayer
        local names = GetTeleportPlayerNames()

        pcall(function()
            TeleportPlayerDropdown:SetValues(names)
        end)

        if previousPlayer ~= '' and previousPlayer ~= 'No Data' and Players:FindFirstChild(previousPlayer) then
            teleportSelectedPlayer = previousPlayer
        else
            teleportSelectedPlayer = ''
        end
    end

    PlayerTab:Button({
        Title = 'Refresh Teleport Players',
        Icon = 'refresh-cw',
        Callback = function()
            RefreshTeleportPlayers(true)
        end,
    })
    PlayerTab:Toggle({
        Title = 'Teleport Player Select',
        Default = false,
        Callback = function(Value)
            _G.Settings.teleportPlayer = Value
        end,
    })
    PlayerTab:Section({
        Title = 'ESP Player',
        Icon = 'eye',
        Opened = false,
        Desc = '',
    })

    local function removeESP(targetPlayer)
        if not targetPlayer then
            return
        end

        local character = targetPlayer.Character

        if not character then
            return
        end

        local head = character:FindFirstChild('Head')

        if not head then
            return
        end

        local esp = head:FindFirstChild('PlayerESP')

        if esp then
            esp:Destroy()
        end
    end
    local function createESP(targetPlayer)
        if targetPlayer == player then
            return
        end

        local character = targetPlayer.Character

        if not character then
            return
        end

        local head = character:FindFirstChild('Head')

        if not head then
            return
        end
        if head:FindFirstChild('PlayerESP') then
            return
        end

        local billboard = Instance.new('BillboardGui')

        billboard.Name = 'PlayerESP'
        billboard.Parent = head
        billboard.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        billboard.AlwaysOnTop = true
        billboard.LightInfluence = 1
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 2.5, 0)

        local label = Instance.new('TextLabel')

        label.Name = 'TextLabel'
        label.Parent = billboard
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(0, 200, 0, 50)
        label.Font = Enum.Font.GothamBold
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextSize = 14
        label.TextStrokeTransparency = 0
        label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        label.TextWrapped = true
        label.TextXAlignment = Enum.TextXAlignment.Center
        label.TextYAlignment = Enum.TextYAlignment.Center
    end
    local function updateESP(targetPlayer)
        if not _G.Settings.espPlayers then
            return
        end
        if targetPlayer == player then
            return
        end

        local character = targetPlayer.Character

        if not character then
            return
        end

        local head = character:FindFirstChild('Head')
        local hrp = character:FindFirstChild('HumanoidRootPart')

        if not head or not hrp then
            return
        end

        local myCharacter = player.Character
        local myHRP = myCharacter and myCharacter:FindFirstChild('HumanoidRootPart')

        if not myHRP then
            return
        end
        if not head:FindFirstChild('PlayerESP') then
            createESP(targetPlayer)
        end

        local billboard = head:FindFirstChild('PlayerESP')

        if not billboard then
            return
        end

        local label = billboard:FindFirstChild('TextLabel')

        if not label then
            return
        end

        local distance = math.floor((myHRP.Position - head.Position).Magnitude)
        local level = '?'
        local stats = targetPlayer:FindFirstChild('PlayerStats')

        if stats then
            local lvl = stats:FindFirstChild('lvl')

            if lvl then
                level = tostring(lvl.Value)
            end
        end

        local pvpText = 'PVP : Off'
        local pvpEnabled = false

        if stats then
            local pvp = stats:FindFirstChild('PVP')

            if pvp then
                pvpEnabled = pvp.Value

                if pvp.Value then
                    pvpText = 'PVP : On'
                end
            end
        end

        label.Text = targetPlayer.Name .. ' | Level : ' .. level .. ' | ' .. pvpText .. '\n\n' .. distance .. ' M'

        if pvpEnabled then
            label.TextColor3 = Color3.fromRGB(255, 80, 80)
        else
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
    local function enableESP()
        for _, targetPlayer in ipairs(Players:GetPlayers())do
            if targetPlayer ~= player then
                createESP(targetPlayer)
            end
        end
    end
    local function disableESP()
        for _, targetPlayer in ipairs(Players:GetPlayers())do
            if targetPlayer ~= player then
                removeESP(targetPlayer)
            end
        end
    end

    PlayerTab:Toggle({
        Title = 'Esp Player',
        Default = false,
        Callback = function(Value)
            _G.Settings.espPlayers = Value

            if Value then
                enableESP()
            else
                disableESP()
            end
        end,
    })
    PlayerTab:Section({
        Title = 'Speed',
        Icon = 'zap',
        Opened = false,
        Desc = '',
    })
    PlayerTab:Toggle({
        Title = 'Speed',
        Default = false,
        Callback = function(Value)
            _G.Settings.speedEnabled = Value

            if not Value then
                local character = player.Character
                local humanoid = character and character:FindFirstChildOfClass('Humanoid')

                if humanoid then
                    humanoid.WalkSpeed = 16
                end
            end
        end,
    })
    PlayerTab:Dropdown({
        Title = 'Speed Type',
        Values = {
            'CFrame',
            'WalkSpeed',
        },
        Value = 'CFrame',
        Callback = function(Value)
            _G.Settings.speedMode = Value

            if Value == 'CFrame' then
                local character = player.Character
                local humanoid = character and character:FindFirstChildOfClass('Humanoid')

                if humanoid then
                    humanoid.WalkSpeed = 16
                end
            end
        end,
    })
    PlayerTab:Dropdown({
        Title = 'Speed Value',
        Values = {
            '25',
            '50',
            '75',
            '100',
            '150',
            '200',
        },
        Value = '50',
        Callback = function(Value)
            _G.Settings.speedValue = tonumber(Value) or 50
        end,
    })
    PlayerTab:Section({
        Title = 'Infinite Jump',
        Icon = 'move-up',
        Opened = false,
        Desc = '',
    })
    PlayerTab:Toggle({
        Title = 'Infinite Jump',
        Default = false,
        Callback = function(Value)
            _G.Settings.infJump = Value
        end,
    })

    local NPCTab = Window:Tab({
        Title = 'Aim NPC',
        Icon = 'crosshair',
        Opened = false,
    })

    NPCTab:Section({
        Title = 'Nearest NPC Aim',
        Icon = 'crosshair',
        Opened = false,
        Desc = 'Aim only at the closest valid NPC from the configured NPC folders.',
    })
    NPCTab:Toggle({
        Title = 'AimNearestNpc',
        Default = false,
        Callback = function(Value)
            _G.Settings.aimNPC = Value
        end,
    })
    NPCTab:Slider({
        Title = 'NPC Aim Distance',
        Value = {
            Min = 50,
            Max = 1000,
            Default = 200,
        },
        Step = 1,
        Callback = function(Value)
            _G.Settings.aimNPCDistance = Value
        end,
    })

    local AntiLagTab = Window:Tab({
        Title = 'Anti Lag',
        Icon = 'zap',
        Opened = false,
    })

    AntiLagTab:Section({
        Title = 'Visual Performance',
        Icon = 'zap',
        Opened = false,
        Desc = '',
    })

    local antiLagCache = {}
    local removedTreeChildren = {}
    local antiLagConnection = nil

    local function SaveAndSet(instance, property, value)
        if not antiLagCache[instance] then
            antiLagCache[instance] = {}
        end
        if antiLagCache[instance][property] == nil then
            local success, original = pcall(function()
                return instance[property]
            end)

            if success then
                antiLagCache[instance][property] = original
            end
        end

        pcall(function()
            instance[property] = value
        end)
    end
    local function IsProtectedKenHakiObject(instance)
        if not instance then
            return true
        end
        if instance:IsA('BillboardGui') or instance:IsA('TextLabel') or instance:IsA('TextButton') or instance:IsA('Highlight') or instance:IsA('SelectionBox') then
            if IsCharacterModel(instance) then
                return true
            end
        end

        return false
    end
    local function OptimizeVisual(instance)
        if IsProtectedKenHakiObject(instance) then
            return
        end
        if instance:IsA('ParticleEmitter') then
            SaveAndSet(instance, 'Rate', math.min(instance.Rate, 3))
            SaveAndSet(instance, 'Lifetime', NumberRange.new(0.05, 0.15))
            SaveAndSet(instance, 'LightEmission', 0)
            SaveAndSet(instance, 'LightInfluence', 1)
        elseif instance:IsA('Trail') then
            SaveAndSet(instance, 'Lifetime', math.min(instance.Lifetime, 0.05))
        elseif instance:IsA('Beam') then
            SaveAndSet(instance, 'Segments', 1)
        elseif instance:IsA('PointLight') or instance:IsA('SpotLight') or instance:IsA('SurfaceLight') then
            SaveAndSet(instance, 'Brightness', 0.5)
            SaveAndSet(instance, 'Range', math.min(instance.Range, 8))
        elseif instance:IsA('Smoke') or instance:IsA('Fire') then
            SaveAndSet(instance, 'Enabled', false)
        end
    end
    local function RemoveTreeChildren(tree)
        if not tree or not tree.Parent then
            return
        end
        if tree.Name ~= 'Tree' then
            return
        end

        for _, child in ipairs(tree:GetChildren())do
            if child.Parent == tree then
                table.insert(removedTreeChildren, {
                    Object = child,
                    Parent = tree,
                })

                child.Parent = nil
            end
        end
    end
    local function FindAndRemoveTrees()
        for _, object in ipairs(workspace:GetDescendants())do
            if (object:IsA('Folder') or object:IsA('Model')) and object.Name == 'Tree' then
                RemoveTreeChildren(object)
            end
        end
    end
    local function RestoreTrees()
        for i = #removedTreeChildren, 1, -1 do
            local data = removedTreeChildren[i]

            if data.Object and data.Parent and data.Parent.Parent then
                pcall(function()
                    data.Object.Parent = data.Parent
                end)
            end

            table.remove(removedTreeChildren, i)
        end
    end
    local function EnableAntiLag()
        for _, instance in ipairs(workspace:GetDescendants())do
            OptimizeVisual(instance)
        end

        FindAndRemoveTrees()
    end
    local function RestoreAntiLag()
        for instance, properties in pairs(antiLagCache)do
            if instance and instance.Parent then
                for property, originalValue in pairs(properties)do
                    pcall(function()
                        instance[property] = originalValue
                    end)
                end
            end
        end

        table.clear(antiLagCache)
        RestoreTrees()
    end
    local function CheckNewAntiLagObject(instance)
        if not _G.Settings.antiLag then
            return
        end
        if IsProtectedKenHakiObject(instance) then
            return
        end
        if instance.Name == 'Tree' and (instance:IsA('Folder') or instance:IsA('Model')) then
            task.defer(function()
                if instance.Parent then
                    RemoveTreeChildren(instance)
                end
            end)

            return
        end
        if instance:IsA('ParticleEmitter') or instance:IsA('Trail') or instance:IsA('Beam') or instance:IsA('PointLight') or instance:IsA('SpotLight') or instance:IsA('SurfaceLight') or instance:IsA('Smoke') or instance:IsA('Fire') then
            OptimizeVisual(instance)
        end
    end
    local function StartAntiLagMonitor()
        if antiLagConnection then
            antiLagConnection:Disconnect()
        end

        antiLagConnection = workspace.DescendantAdded:Connect(CheckNewAntiLagObject)
    end
    local function StopAntiLagMonitor()
        if antiLagConnection then
            antiLagConnection:Disconnect()

            antiLagConnection = nil
        end
    end

    AntiLagTab:Toggle({
        Title = 'Anti Lag',
        Default = false,
        Callback = function(Value)
            _G.Settings.antiLag = Value

            if Value then
                EnableAntiLag()
                StartAntiLagMonitor()
            else
                StopAntiLagMonitor()
                RestoreAntiLag()
            end
        end,
    })

    camlockPlayerSignature = GetCamLockSignature()

    task.spawn(function()
        while true do
            local intensity = math.clamp(tonumber(GetSetting('camlockIntensity')) or 5, 1, 20)
            local interval

            if intensity <= 1 then
                interval = 0.01
            else
                interval = 0.14 - ((intensity - 1) * 0.003)
                interval = math.max(interval, 0.08)

                if kenHakiLoad then
                    interval = math.max(interval, 0.12)
                end
            end

            task.wait(interval)

            if not GetSetting('camlock') then
                _G.CurrentTarget = nil

                continue
            end

            UpdateCamLockTarget()
        end
    end)
    task.spawn(function()
        local success, ClassicCamera = pcall(function()
            local PlayerScripts = player:WaitForChild('PlayerScripts')
            local PlayerModule = PlayerScripts:WaitForChild('PlayerModule')
            local CameraModule = PlayerModule:WaitForChild('CameraModule')
            local ClassicCameraModule = CameraModule:WaitForChild('ClassicCamera')

            return require(ClassicCameraModule)
        end)

        if not success or type(ClassicCamera) ~= 'table' or type(ClassicCamera.Update) ~= 'function' then
            return
        end
        if ClassicCamera.__VyrionCamLock then
            return
        end

        ClassicCamera.__VyrionCamLock = true

        local OriginalUpdate = ClassicCamera.Update

        ClassicCamera.Update = function(self, dt, ...)
            if _G.Settings.camlock then
                self.lastUserPanCamera = tick()
            end

            local cf, focus = OriginalUpdate(self, dt, ...)

            if not _G.Settings.camlock then
                return cf, focus
            end

            local target = _G.CurrentTarget

            if not target then
                return cf, focus
            end

            local hrp = target:FindFirstChild('HumanoidRootPart')
            local humanoid = target:FindFirstChildOfClass('Humanoid')

            if not hrp or not humanoid or humanoid.Health <= 0 then
                return cf, focus
            end

            local head = target:FindFirstChild('Head')
            local targetPosition

            if head then
                targetPosition = head.Position
            else
                targetPosition = hrp.Position + Vector3.new(0, 1.8, 0)
            end

            local velocity = hrp.AssemblyLinearVelocity

            if velocity.Magnitude > 5 then
                targetPosition = targetPosition + velocity * 0.08
            end

            cf = CFrame.lookAt(cf.Position, targetPosition)

            return cf, focus
        end
    end)
    task.spawn(function()
        while task.wait(0.05) do
            if not GetSetting('teleportPlayer') then
                continue
            end
            if teleportSelectedPlayer == '' or teleportSelectedPlayer == 'No Data' then
                continue
            end

            local targetPlayer = Players:FindFirstChild(teleportSelectedPlayer)

            if not targetPlayer then
                continue
            end

            local targetCharacter = targetPlayer.Character
            local myCharacter = player.Character

            if not targetCharacter or not myCharacter then
                continue
            end

            local targetHRP = targetCharacter:FindFirstChild('HumanoidRootPart')
            local myHRP = myCharacter:FindFirstChild('HumanoidRootPart')
            local humanoid = myCharacter:FindFirstChildOfClass('Humanoid')

            if not targetHRP or not myHRP or not humanoid or humanoid.Health <= 0 then
                continue
            end

            local targetPosition = targetHRP.Position + Vector3.new(0, 6, 0)
            local currentLook = myHRP.CFrame.LookVector
            local horizontalLook = Vector3.new(currentLook.X, 0, currentLook.Z)

            if horizontalLook.Magnitude < 0.01 then
                horizontalLook = Vector3.new(0, 0, -1)
            else
                horizontalLook = horizontalLook.Unit
            end

            myHRP.CFrame = CFrame.lookAt(targetPosition, targetPosition + horizontalLook)
            myHRP.AssemblyLinearVelocity = Vector3.zero
            myHRP.AssemblyAngularVelocity = Vector3.zero
        end
    end)
    RunService.RenderStepped:Connect(function(deltaTime)
        if not GetSetting('speedEnabled') then
            return
        end

        local character = player.Character

        if not character then
            return
        end

        local humanoid = character:FindFirstChildOfClass('Humanoid')
        local hrp = character:FindFirstChild('HumanoidRootPart')

        if not humanoid or not hrp then
            return
        end

        local speed = _G.Settings.speedValue

        if _G.Settings.speedMode == 'CFrame' then
            local moveDirection = humanoid.MoveDirection

            if moveDirection.Magnitude > 0 then
                hrp.CFrame = hrp.CFrame + (moveDirection.Unit * speed * deltaTime)
            end

            humanoid.WalkSpeed = 16
        elseif _G.Settings.speedMode == 'WalkSpeed' then
            humanoid.WalkSpeed = speed
        end
    end)
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild('Humanoid', 5)

        if humanoid then
            if _G.Settings.speedEnabled and _G.Settings.speedMode == 'WalkSpeed' then
                humanoid.WalkSpeed = _G.Settings.speedValue
            else
                humanoid.WalkSpeed = 16
            end
        end
    end)
    task.spawn(function()
        while true do
            local interval = kenHakiLoad and 0.5 or 0.3

            task.wait(interval)

            if not _G.Settings.espPlayers then
                continue
            end

            for _, targetPlayer in ipairs(Players:GetPlayers())do
                if targetPlayer ~= player then
                    updateESP(targetPlayer)
                end
            end
        end
    end)

    local function setupPlayerESP(targetPlayer)
        if targetPlayer == player then
            return
        end

        targetPlayer.CharacterAdded:Connect(function(character)
            local head = character:WaitForChild('Head', 5)

            if head and _G.Settings.espPlayers then
                task.wait(0.2)
                createESP(targetPlayer)
            end
        end)
    end

    for _, targetPlayer in ipairs(Players:GetPlayers())do
        setupPlayerESP(targetPlayer)
    end

    Players.PlayerAdded:Connect(function(targetPlayer)
        task.wait(0.15)
        RefreshCamLockPlayers(true)
        RefreshAimPlayers(true)
        RefreshTeleportPlayers(true)
        setupPlayerESP(targetPlayer)
    end)
    Players.PlayerRemoving:Connect(function(targetPlayer)
        if _G.Settings.camlockTarget == targetPlayer.Name then
            _G.Settings.camlockTarget = ''
            _G.CurrentTarget = nil
        end
        if teleportSelectedPlayer == targetPlayer.Name then
            teleportSelectedPlayer = ''
            _G.Settings.teleportPlayer = false
        end

        task.wait(0.05)
        RefreshCamLockPlayers(true)
        RefreshAimPlayers(true)
        RefreshTeleportPlayers(true)
        removeESP(targetPlayer)
    end)
    UserInputService.JumpRequest:Connect(function()
        if not _G.Settings.infJump then
            return
        end

        local char = player.Character

        if char then
            local humanoid = char:FindFirstChildOfClass('Humanoid')

            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end)

    local cachedAimTarget = nil
    local cachedAimTargetType = nil
    local AIM_TARGET_UPDATE_INTERVAL = 0.15
    local AIM_PREDICTION_UPDATE_INTERVAL = 0.05
    local lastAimTargetUpdate = 0

    local function IsAimTargetValid(target)
        if not target then
            return false
        end

        local humanoid = target.Humanoid
        local hrp = target.HRP

        if not humanoid or humanoid.Health <= 0 then
            return false
        end
        if not hrp or not hrp.Parent then
            return false
        end
        if target.Player and target.Player ~= player and not target.Player.Parent then
            return false
        end

        return true
    end
    local function UpdateCachedAimTarget()
        local now = os.clock()
        local interval

        if GetSetting('aimbotnear') then
            interval = 0.05
        else
            interval = kenHakiLoad and 0.2 or AIM_TARGET_UPDATE_INTERVAL
        end
        if now - lastAimTargetUpdate < interval then
            return
        end

        lastAimTargetUpdate = now

        local target, targetType = ResolveAimTarget()

        cachedAimTarget = target
        cachedAimTargetType = targetType
        _G.SkillAimTarget = target
    end
    local function UpdateAimPrediction()
        local target = cachedAimTarget

        if not target then
            _G.pos_skill = nil

            return
        end
        if not IsAimTargetValid(target) then
            cachedAimTarget = nil
            cachedAimTargetType = nil
            _G.SkillAimTarget = nil
            _G.pos_skill = nil

            return
        end

        local aimPart = target.Head or target.HRP

        if not aimPart or not aimPart.Parent then
            _G.pos_skill = nil

            return
        end

        local prediction = tonumber(GetSetting('aimPrediction')) or 0

        if prediction <= 0 then
            _G.pos_skill = aimPart.CFrame

            return
        end

        local hrp = target.HRP

        if not hrp then
            _G.pos_skill = aimPart.CFrame

            return
        end

        local velocity = hrp.AssemblyLinearVelocity
        local predictedPosition = aimPart.Position + (velocity * prediction)

        _G.pos_skill = CFrame.new(predictedPosition)
    end

    task.spawn(function()
        while true do
            task.wait(AIM_TARGET_UPDATE_INTERVAL)

            if not (GetSetting('aimbotPriority') or GetSetting('aimbot') or GetSetting('aimbotnear') or GetSetting('circle') or GetSetting('aimNPC')) then
                cachedAimTarget = nil
                cachedAimTargetType = nil
                _G.SkillAimTarget = nil
                _G.pos_skill = nil
                targetInCircle = false

                continue
            end

            UpdateCachedAimTarget()

            targetInCircle = (cachedAimTargetType == 'Circle')
        end
    end)
    task.spawn(function()
        while true do
            task.wait(AIM_PREDICTION_UPDATE_INTERVAL)

            if not cachedAimTarget then
                _G.pos_skill = nil

                continue
            end

            UpdateAimPrediction()
        end
    end)
    task.spawn(function()
        pcall(function()
            local mt = getrawmetatable(game)
            local oldNamecall = mt.__namecall

            setreadonly(mt, false)

            mt.__namecall = newcclosure(function(self, ...)
                local args = {...}
                local method = getnamecallmethod()

                if method == 'InvokeServer' and tostring(self) == 'SkillAction' then
                    if (GetSetting('aimbotPriority') or GetSetting('aimbotnear') or GetSetting('circle') or GetSetting('aimNPC') or GetSetting('aimbot')) then
                        if typeof(args[2]) == 'table' and _G.pos_skill then
                            args[2].MouseHit = _G.pos_skill
                        end
                    end

                    return oldNamecall(self, unpack(args))
                end
                if method == 'FireServer' and tostring(self) == 'ButtonR3' then
                    if GetSetting('flashStepAim') then
                        local target = _G.SkillAimTarget

                        if target then
                            local targetHRP = target.HRP or (target.Character and target.Character:FindFirstChild('HumanoidRootPart'))
                            local myCharacter = player.Character
                            local myHRP = myCharacter and myCharacter:FindFirstChild('HumanoidRootPart')

                            if targetHRP and myHRP then
                                local teleportPosition = targetHRP.Position + (targetHRP.CFrame.LookVector * 6)
                                local newCFrame = CFrame.lookAt(teleportPosition, targetHRP.Position)

                                myHRP.CFrame = newCFrame
                                myHRP.AssemblyLinearVelocity = Vector3.zero
                                myHRP.AssemblyAngularVelocity = Vector3.zero

                                if typeof(args[1]) == 'table' then
                                    args[1][1] = newCFrame
                                    args[1][2] = newCFrame
                                end
                            end
                        end
                    end

                    return oldNamecall(self, unpack(args))
                end

                return oldNamecall(self, unpack(args))
            end)

            setreadonly(mt, true)
        end)
    end)

    local HttpService = game:GetService('HttpService')
    local ServerLiveAPI = 'https://vyrion-server-live.ai.studio/api'
    local ServerLiveAPIKey = 'API_VYRION_HUB_544_OMG'
    local ServerLiveRequest = http_request or request or syn_request
    local ServerLiveLastPost = 0
    local ServerLiveHadEvents = false
    local ServerLivePreviousEvents = {}

    local function ServerLiveRequestJSON(method, url, body)
        if not ServerLiveRequest then
            return nil
        end

        local ok, response = pcall(function()
            local options = {
                Url = url,
                Method = method,
                Headers = {
                    ['Content-Type'] = 'application/json',
                    ['x-api-key'] = ServerLiveAPIKey,
                },
            }

            if body ~= nil then
                options.Body = HttpService:JSONEncode(body)
            end

            return ServerLiveRequest(options)
        end)

        if ok then
            return response
        end

        warn('[Vyrion Server Live] HTTP error:', response)

        return nil
    end
    local function ServerLiveAddEvent(events, category, eventName)
        if type(category) ~= 'string' or category == '' then
            return
        end

        eventName = tostring(eventName or category)

        if eventName == '' then
            eventName = category
        end

        events[category] = events[category] or {}

        for _, existing in ipairs(events[category])do
            if existing == eventName then
                return
            end
        end

        table.insert(events[category], eventName)
    end
    local function ServerLiveCollectEvents()
        local events = {}
        local monster = workspace:FindFirstChild('Monster')
        local boss = monster and monster:FindFirstChild('Boss')
        local serpent = boss and boss:FindFirstChild('Serpent')
        local whirlpool = workspace:FindFirstChild('SerpentWhirlpool')

        if serpent then
            local humanoid = serpent:FindFirstChildOfClass('Humanoid')

            if not humanoid or humanoid.Health > 0 then
                ServerLiveAddEvent(events, 'Serpent', serpent.Name)
            end
        end
        if whirlpool then
            ServerLiveAddEvent(events, 'Serpent', whirlpool.Name)
        end
        if game.PlaceId == 15759515082 then
            local seaMonster = workspace:FindFirstChild('SeaMonster')

            if seaMonster then
                for _, instance in ipairs(seaMonster:GetChildren())do
                    if string.find(instance.Name, 'Galleon') then
                        ServerLiveAddEvent(events, 'Serpent', instance.Name)
                    elseif not instance:FindFirstChild('done') then
                        ServerLiveAddEvent(events, 'Set-Sail', instance.Name)
                    end
                end
            end

            local islandFolder = workspace:FindFirstChild('Island')

            if islandFolder then
                for _, instance in ipairs(islandFolder:GetChildren())do
                    if string.find(instance.Name, 'Human') or string.find(instance.Name, 'Gale') or string.find(instance.Name, 'SeaKing') or string.find(instance.Name, 'Angel') or string.find(instance.Name, 'Animal') or string.find(instance.Name, 'Fish') or string.find(instance.Name, 'Demon') then
                        ServerLiveAddEvent(events, 'Island-Race', instance.Name)
                    end
                end
            end

            local bossFolder = workspace:FindFirstChild('Monster')
            local bossContainer = bossFolder and bossFolder:FindFirstChild('Boss')

            if bossContainer and bossContainer:FindFirstChild('FuryTentacle') then
                ServerLiveAddEvent(events, 'Boss-KL', 'Kraken')
            end
        elseif game.PlaceId == 6381829480 then
            local islandFolder = workspace:FindFirstChild('Island')

            if islandFolder then
                for _, instance in ipairs(islandFolder:GetChildren())do
                    if string.find(instance.Name, 'Sea King') or string.find(instance.Name, 'Legacy Island') then
                        if instance:FindFirstChild('HydraStand') then
                            ServerLiveAddEvent(events, 'Hydra', 'Hydra')
                        end
                        if instance:FindFirstChild('ChestSpawner') then
                            ServerLiveAddEvent(events, 'Seaking', 'Seaking')
                        end
                    end
                end
            end

            local ghostMonster = workspace:FindFirstChild('GhostMonster')
            local ghostShip = ghostMonster and ghostMonster:FindFirstChild('Ghost Ship')

            if ghostShip then
                local humanoid = ghostShip:FindFirstChild('Humanoid')
                local hrp = ghostShip:FindFirstChild('HumanoidRootPart')

                if humanoid and humanoid.Health > 0 and hrp then
                    ServerLiveAddEvent(events, 'Ghost-Ship', ghostShip.Name)
                end
            end
        end

        return events
    end
    local function ServerLiveEventsToArray(events)
        local list = {}
        local order = {
            'Serpent',
            'Seaking',
            'Hydra',
            'Ghost-Ship',
            'Set-Sail',
            'Boss-KL',
            'Island-Race',
        }

        for _, category in ipairs(order)do
            local names = events[category]

            if names then
                table.insert(list, category)

                for _, eventName in ipairs(names)do
                    table.insert(list, eventName)
                end
            end
        end

        return list
    end
    local function ServerLiveEventSignature(events)
        local list = ServerLiveEventsToArray(events)

        table.sort(list)

        return table.concat(list, '|')
    end
    local function ServerLivePost(events)
        local bosses = ServerLiveEventsToArray(events)

        if #bosses == 0 then
            return false
        end

        local response = ServerLiveRequestJSON('POST', ServerLiveAPI .. '/servers', {
            placeId = game.PlaceId,
            jobId = game.JobId,
            players = #Players:GetPlayers(),
            maxPlayers = Players.MaxPlayers,
            bosses = bosses,
            timestamp = os.time(),
        })

        if response then
            ServerLiveLastPost = os.clock()
            ServerLiveHadEvents = true
            ServerLivePreviousEvents = events
            ServerLivePreviousSignature = ServerLiveEventSignature(events)

            return true
        end

        return false
    end
    local function ServerLiveDeleteCurrentServer()
        if not ServerLiveHadEvents then
            return
        end

        local encodedJobId = HttpService:UrlEncode(game.JobId)
        local response = ServerLiveRequestJSON('DELETE', ServerLiveAPI .. '/servers/' .. encodedJobId)

        if response then
            ServerLiveHadEvents = false
            ServerLivePreviousEvents = {}
            ServerLivePreviousSignature = ''
            ServerLiveLastPost = 0
        end
    end

    task.spawn(function()
        task.wait(1)

        while true do
            task.wait(2)
            pcall(function()
                local events = ServerLiveCollectEvents()
                local eventList = ServerLiveEventsToArray(events)
                local hasEvents = #eventList > 0

                if hasEvents then
                    local signature = ServerLiveEventSignature(events)
                    local changed = signature ~= (ServerLivePreviousSignature or '')

                    if not ServerLiveHadEvents or changed or os.clock() - ServerLiveLastPost >= 7 then
                        ServerLivePost(events)
                    end
                elseif ServerLiveHadEvents then
                    ServerLiveDeleteCurrentServer()
                end
            end)
        end
    end)

    local webhookRequest = http_request or request or syn_request
    local webhookPlayerCount = #Players:GetPlayers()
    local webhookJobId = game.JobId

    local function EncodeJobId(jobId)
        if type(encode) == 'function' then
            local ok, result = pcall(encode, jobId)

            if ok and result ~= nil then
                return tostring(result)
            end
        end

        return tostring(jobId)
    end

    webhookJobId = EncodeJobId(webhookJobId)
    _G.webhook = _G.webhook or {
        sk = 'https://discord.com/api/webhooks/1543895675463270500/bnBXbMMj2hG7giwTYWoYTflmOw_3Em8uefKsE2cqRdj6OzTntNiZuFxL-kdho61L8ayF',
        hd = 'https://discord.com/api/webhooks/1543895675463270500/bnBXbMMj2hG7giwTYWoYTflmOw_3Em8uefKsE2cqRdj6OzTntNiZuFxL-kdho61L8ayF',
        gs = 'https://discord.com/api/webhooks/1543895675463270500/bnBXbMMj2hG7giwTYWoYTflmOw_3Em8uefKsE2cqRdj6OzTntNiZuFxL-kdho61L8ayF',
        ks = 'https://discord.com/api/webhooks/1543900973934583838/ZYQTGeMek4o50durs-pvmlgk1mgYAXQEmbeC2p0w2F_UxEu42r_8Cb_JgDKXCdHMeJoB',
        race = 'https://discord.com/api/webhooks/1528584992236507270/Gz6hudZHFug7PNhaLT9ravflw0iq_5M-kGvdvIxWJLwVpmV5nzPbtlVVRmII2lT8mptt',
        ss = 'https://discord.com/api/webhooks/1528678889507786813/8GFx21DEWQ6GZCb0d0cL9MBSd4j-Bwlm_SDrQF8GTyW70PYbZZTUfXjHEqqvVJddv_Cs',
    }

    local function MarkWebhookDone(instance)
        if instance and not instance:FindFirstChild('done') then
            local marker = Instance.new('Folder')

            marker.Name = 'done'
            marker.Parent = instance
        end
    end
    local function WebhookPayload(title)
        return {
            embeds = {
                {
                    title = '```' .. tostring(title) .. '```',
                    color = 7498202,
                    fields = {
                        {
                            name = 'Player Count',
                            value = '```' .. tostring(webhookPlayerCount) .. '/12```',
                            inline = true,
                        },
                        {
                            name = 'Code Pc',
                            value = '```' .. tostring(webhookJobId) .. '```',
                            inline = true,
                        },
                        {
                            name = 'Code Mobile',
                            value = tostring(webhookJobId),
                            inline = true,
                        },
                    },
                },
            },
        }
    end
    local function GetServerLiveCategory(title)
        local t = string.lower(tostring(title or ''))

        if string.find(t, 'hydra') then
            return 'Hydra'
        elseif string.find(t, 'seaking') or string.find(t, 'sea king') then
            return 'Seaking'
        elseif string.find(t, 'ghost') then
            return 'Ghost-Ship'
        elseif string.find(t, 'kraken') or string.find(t, 'furytentacle') then
            return 'Boss-KL'
        elseif string.find(t, 'galleon') or string.find(t, 'serpent') or string.find(t, 'whirlpool') then
            return 'Serpent'
        elseif string.find(t, 'human') or string.find(t, 'gale') or string.find(t, 'angel') or string.find(t, 'animal') or string.find(t, 'fish') or string.find(t, 'demon') or string.find(t, 'race') then
            return 'Island-Race'
        else
            return 'Set-Sail'
        end
    end
    local function PostServerLiveEvent(title)
        local category = GetServerLiveCategory(title)
        local events = ServerLiveCollectEvents()

        ServerLiveAddEvent(events, category, title)

        return ServerLivePost(events)
    end
    local function PostWebhook(url, title)
        if not webhookRequest or not url then
            return
        end

        pcall(function()
            webhookRequest({
                Url = url,
                Method = 'POST',
                Headers = {
                    ['Content-Type'] = 'application/json',
                },
                Body = HttpService:JSONEncode(WebhookPayload(title)),
            })
        end)
        pcall(function()
            PostServerLiveEvent(title)
        end)
    end

    if game.PlaceId ~= 6381829480 then
        if game.PlaceId == 15759515082 then
            task.spawn(function()
                while task.wait(1) do
                    pcall(function()
                        local seaMonster = workspace:FindFirstChild('SeaMonster')

                        if not seaMonster then
                            return
                        end

                        for _, instance in ipairs(seaMonster:GetChildren())do
                            if string.find(instance.Name, 'Galleon') and not instance:FindFirstChild('done') then
                                MarkWebhookDone(instance)
                                PostWebhook(_G.webhook.ks, instance.Name)
                            end
                        end
                    end)
                end
            end)
            task.spawn(function()
                while task.wait(1) do
                    pcall(function()
                        local islandFolder = workspace:FindFirstChild('Island')

                        if not islandFolder then
                            return
                        end

                        for _, instance in ipairs(islandFolder:GetChildren())do
                            if (string.find(instance.Name, 'Human') or string.find(instance.Name, 'Gale') or string.find(instance.Name, 'SeaKing') or string.find(instance.Name, 'Angel') or string.find(instance.Name, 'Animal') or string.find(instance.Name, 'Fish') or string.find(instance.Name, 'Demon')) and not instance:FindFirstChild('done') then
                                MarkWebhookDone(instance)
                                PostWebhook(_G.webhook.race, instance.Name)
                            end
                        end
                    end)
                end
            end)
            task.spawn(function()
                while task.wait(1) do
                    pcall(function()
                        local seaMonster = workspace:FindFirstChild('SeaMonster')

                        if not seaMonster then
                            return
                        end

                        for _, instance in ipairs(seaMonster:GetChildren())do
                            if not string.find(instance.Name, 'Galleon') and not instance:FindFirstChild('done') then
                                MarkWebhookDone(instance)
                                PostWebhook(_G.webhook.ss, instance.Name)
                            end
                        end
                    end)
                end
            end)
            task.spawn(function()
                while task.wait(1) do
                    pcall(function()
                        local monster = workspace:FindFirstChild('Monster')
                        local boss = monster and monster:FindFirstChild('Boss')

                        if boss and boss:FindFirstChild('FuryTentacle') then
                            if not boss:FindFirstChild('done') then
                                MarkWebhookDone(boss)
                                PostWebhook(_G.webhook.ss, 'Kraken')
                            end
                        elseif boss and boss:FindFirstChild('done') then
                            boss:FindFirstChild('done'):Destroy()
                        end
                    end)
                end
            end)
        end
    else
        task.spawn(function()
            while task.wait(1) do
                pcall(function()
                    local islandFolder = workspace:FindFirstChild('Island')

                    if not islandFolder then
                        return
                    end

                    for _, instance in ipairs(islandFolder:GetChildren())do
                        if string.find(instance.Name, 'Sea King') or string.find(instance.Name, 'Legacy Island') then
                            if instance:FindFirstChild('HydraStand') and not instance:FindFirstChild('done') then
                                MarkWebhookDone(instance)
                                PostWebhook(_G.webhook.hd, 'Hydra')
                            end
                            if instance:FindFirstChild('ChestSpawner') and not instance:FindFirstChild('done') then
                                MarkWebhookDone(instance)
                                PostWebhook(_G.webhook.sk, 'Seaking')
                            end
                        end
                    end
                end)
            end
        end)
        task.spawn(function()
            while task.wait(1) do
                pcall(function()
                    local ghostMonster = workspace:FindFirstChild('GhostMonster')
                    local ghostShip = ghostMonster and ghostMonster:FindFirstChild('Ghost Ship')

                    if ghostShip and ghostShip:FindFirstChild('Humanoid') and ghostShip.Humanoid.Health > 0 and ghostShip:FindFirstChild('HumanoidRootPart') and not ghostShip:FindFirstChild('done') then
                        MarkWebhookDone(ghostShip)
                        PostWebhook(_G.webhook.gs, 'Ghost Ship')
                    end
                end)
            end
        end)
    end

    local function DumpStockValue(value, depth)
        local output = ''
        local indent = string.rep('  ', depth or 0)

        if typeof(value) == 'table' then
            for key, child in pairs(value)do
                if typeof(child) ~= 'table' then
                    if output ~= '' then
                        output = output .. '\n' .. indent .. tostring(key)
                    else
                        output = indent .. tostring(key)
                    end
                else
                    DumpStockValue(child, (depth or 0) + 1)
                end
            end
        end

        return output
    end
    local function PostFruitStock()
        pcall(function()
            local shopFunction = game:GetService('ReplicatedStorage'):FindFirstChild('Chest') and game:GetService('ReplicatedStorage').Chest:FindFirstChild('Remotes') and game:GetService('ReplicatedStorage').Chest.Remotes:FindFirstChild('Functions') and game:GetService('ReplicatedStorage').Chest.Remotes.Functions:FindFirstChild('GetDFShop')

            if not shopFunction then
                return
            end

            local stockData = shopFunction:InvokeServer()
            local data = DumpStockValue(stockData, 0)

            if not webhookRequest then
                return
            end

            webhookRequest({
                Url = 'https://discord.com/api/webhooks/1528582315662381348/S6W42RlGxPbp-QIdiyWUOuDJIHOu4ma87a9HXzj7dy1h8CCWw_tv6jNnp-lKF-a0N7hU',
                Method = 'POST',
                Headers = {
                    ['Content-Type'] = 'application/json',
                },
                Body = HttpService:JSONEncode({
                    embeds = {
                        {
                            title = '```Notification```',
                            color = 7498202,
                            fields = {
                                {
                                    name = 'Stock Fruit',
                                    value = '```' .. data .. '```',
                                    inline = true,
                                },
                            },
                        },
                    },
                }),
            })
        end)
    end

    task.spawn(function()
        PostFruitStock()

        while task.wait(54E2) do
            PostFruitStock()
        end
    end)

    Started = true

    print('[Vyrion Hub] Main features initialized.')
end

if not Started then
    local ok, err = xpcall(function()
        Hub.Start()
    end, function(errorObject)
        if debug and debug.traceback then
            return debug.traceback(tostring(errorObject), 2)
        end

        return tostring(errorObject)
    end)

    if not ok then
        warn('[Vyrion Hub] Startup failed:')
        warn(tostring(err))
    end
end

return Hub

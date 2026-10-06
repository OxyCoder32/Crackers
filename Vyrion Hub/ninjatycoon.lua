-- ts file was generated at discord.gg/25ms

local WindUI
local okWind, windResult = pcall(function()
    return loadstring(game:HttpGet('https://github.com/Footagesus/WindUI/releases/download/1.6.54/main.lua'))()
end)

if not okWind or not windResult then
    warn('[Vyrion Hub] Failed to load WindUI:', windResult)

    return
end

WindUI = windResult

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
    Title = 'VYRION HUB | TYCOON',
    Author = 'By Thermomix',
    Icon = 'database',
    Folder = 'VyrionTycoon',
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
            pcall(function()
                WindUI:Notify({
                    Title = 'Vyrion Hub | Tycoon',
                    Content = 'Ninja Tycoon module \u{2022} Vyrion Hub',
                    Duration = 4,
                    Icon = 'database',
                })
            end)
        end,
    },
})

if not Window then
    warn('[Vyrion Hub] WindUI window failed to create.')

    return
end

pcall(function()
    Window:Tag({
        Title = 'UPD 2.3',
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
    Window:EditOpenButton({
        Title = 'VYRION | TYCOON',
        Icon = 'rbxassetid://90450210081651',
        CornerRadius = UDim.new(0, 14),
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
            Title = 'Vyrion Hub | Ninja Tycoon',
            Content = tostring(content),
            Duration = duration or 3,
        })
    end)
end

local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local TweenService = game:GetService('TweenService')
local VirtualInputManager = game:GetService('VirtualInputManager')
local Lighting = game:GetService('Lighting')
local HttpService = game:GetService('HttpService')
local UserInputService = game:GetService('UserInputService')
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild('PlayerGui')

getgenv().UseOneByOne = false

local FloatingButtonGui = Instance.new('ScreenGui')

FloatingButtonGui.Name = 'NexusFloatingButtonGui'
FloatingButtonGui.ResetOnSpawn = false
FloatingButtonGui.Enabled = false
FloatingButtonGui.Parent = PlayerGui

local FastSpamButton = Instance.new('ImageButton', FloatingButtonGui)

FastSpamButton.Name = 'FastSpamButton'
FastSpamButton.Size = UDim2.fromOffset(170, 45)
FastSpamButton.Position = UDim2.new(0.5, -85, 0, 15)
FastSpamButton.Image = 'rbxthumb://type=Asset&id=nillw=150&h=150'
FastSpamButton.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
FastSpamButton.ScaleType = Enum.ScaleType.Crop

local ButtonStroke = Instance.new('UIStroke', FastSpamButton)

ButtonStroke.Color = Color3.fromRGB(0, 255, 255)
ButtonStroke.Thickness = 2
ButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local ButtonCorner = Instance.new('UICorner', FastSpamButton)

ButtonCorner.CornerRadius = UDim.new(0, 4)

local ButtonText = Instance.new('TextLabel', FastSpamButton)

ButtonText.Size = UDim2.fromScale(1, 1)
ButtonText.BackgroundTransparency = 1
ButtonText.Text = '\u{26a1} SPAM ALL SKILLS \u{26a1}'
ButtonText.TextColor3 = Color3.fromRGB(255, 230, 0)
ButtonText.Font = Enum.Font.Arcade
ButtonText.TextSize = 14
ButtonText.TextStrokeTransparency = 0.5
ButtonText.TextStrokeColor3 = Color3.fromRGB(255, 0, 100)

FastSpamButton.MouseButton1Click:Connect(function()
    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass('Humanoid')
    local backpack = LocalPlayer:FindFirstChild('Backpack')

    if not character or not humanoid then
        return
    end

    local allTools = {}

    for _, item in ipairs(character:GetChildren())do
        if item:IsA('Tool') then
            table.insert(allTools, item)
        end
    end

    if backpack then
        for _, item in ipairs(backpack:GetChildren())do
            if item:IsA('Tool') then
                table.insert(allTools, item)
            end
        end
    end

    local function executeTool(tool)
        if tool.Parent == backpack then
            pcall(function()
                humanoid:EquipTool(tool)
            end)
        end

        for _, remote in ipairs(tool:GetDescendants())do
            if remote:IsA('RemoteEvent') then
                pcall(function()
                    remote:FireServer()
                end)
            elseif remote:IsA('RemoteFunction') then
                pcall(function()
                    remote:InvokeServer()
                end)
            end
        end

        pcall(function()
            tool:Activate()
        end)
    end

    if getgenv().UseOneByOne then
        task.spawn(function()
            for _, tool in ipairs(allTools)do
                executeTool(tool)
                task.wait(0.1)
            end
        end)
    else
        for _, tool in ipairs(allTools)do
            task.spawn(function()
                executeTool(tool)
            end)
        end
    end
end)

local Tabs = {
    Info = Window:Tab({
        Title = 'Info',
        Icon = 'info',
        Opened = true,
    }),
    Main = Window:Tab({
        Title = 'MAIN',
        Icon = 'Scroll',
        Opened = false,
    }),
    GetItems = Window:Tab({
        Title = 'MISSIONS',
        Icon = 'box',
        Opened = false,
    }),
    Tycoon = Window:Tab({
        Title = 'TYCOON',
        Icon = 'bird',
        Opened = false,
    }),
    Combat = Window:Tab({
        Title = 'COMBAT',
        Icon = 'swords',
        Opened = false,
    }),
    Player = Window:Tab({
        Title = 'PLAYER',
        Icon = 'user',
        Opened = false,
    }),
    FarmBoss = Window:Tab({
        Title = 'BOSS',
        Icon = 'skull',
        Opened = false,
    }),
    Settings = Window:Tab({
        Title = 'Settings',
        Icon = 'settings',
        Opened = false,
    }),
    Visuals = Window:Tab({
        Title = 'VISUALS',
        Icon = 'eye',
        Opened = false,
    }),
}

Tabs.Info:Section({
    Title = '\u{2014} Welcome to Vyrion Hub \u{2014}',
    Icon = 'sparkles',
    Opened = false,
    Desc = 'Tycoon module \u{2022} edition',
})
Tabs.Info:Paragraph({
    Title = 'About Vyrion Hub',
    Desc = 'Welcome to the new Vyrion UI! Remember that Vyrion Hub works on multiple devices \u{1f3ae}  ',
})
Tabs.Info:Divider()

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

        if data.guild.id and data.guild.icon then
            return 'https://cdn.discordapp.com/icons/' .. tostring(data.guild.id) .. '/' .. tostring(data.guild.icon) .. '.png?size=1024'
        end
    end

    DiscordInfo.memberCount = 'Unavailable'
    DiscordInfo.onlineCount = 'Unavailable'

    return nil
end
local function DiscordCountsText()
    return '\u{2022} Members: ' .. DiscordInfo.memberCount .. '\n\u{2022} Online: ' .. DiscordInfo.onlineCount
end

local DiscordIcon = GetDiscordInfo()

DiscordInfo.paragraph = Tabs.Info:Paragraph({
    Title = 'VyrionStudios',
    Desc = DiscordCountsText(),
    Image = DiscordIcon,
    ImageSize = 52,
})

Tabs.Info:Button({
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
Tabs.Info:Divider()
Tabs.Info:Section({
    Title = 'Information',
    Icon = 'info',
    Opened = false,
    Desc = '',
})
Tabs.Info:Paragraph({
    Title = 'About Vyrion Hub',
    Desc = 'King Legacy | 99 Nights | Doors | mm2 | Ninja Tycoon | Violencie District etc...',
})
Tabs.Info:Divider()
Tabs.Info:Section({
    Title = 'Features',
    Icon = 'list',
    Opened = false,
    Desc = '',
})
Tabs.Info:Paragraph({
    Title = "What's Included",
    Desc = 'Farm Ryo | Get Items | Tycoon | Combat | Player | Farm Boss | Settings | Visuals',
})
Tabs.Info:Divider()
Tabs.Info:Section({
    Title = 'Refresh',
    Icon = 'refresh-cw',
    Opened = false,
    Desc = '',
})
Tabs.Info:Button({
    Title = 'Refresh Server Info',
    Description = 'Re-fetch live Discord member and online counts',
    Callback = function()
        local iconURL = GetDiscordInfo()

        pcall(function()
            if DiscordInfo.paragraph and DiscordInfo.paragraph.SetDesc then
                DiscordInfo.paragraph:SetDesc(DiscordCountsText())
            end
            if iconURL then
                DiscordInfo.paragraph = Tabs.Info:Paragraph({
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
Tabs.Info:Divider()
Tabs.Info:Section({
    Title = 'Runtime Configuration',
    Icon = 'settings',
    Opened = false,
    Desc = 'Vyrion Hub runtime configuration.',
})

local SettingsInfo = Tabs.Info:Paragraph({
    Title = 'ADS',
    Desc = 'Tired of the key system? Forget about it! With Premium Ultimate \u{1f31f} No more keys! No more waiting for the launch! Buy Ultimate at https://vyrion-hub.ai.studio',
})

local function RefreshSettingsInfo()
    pcall(function()
        SettingsInfo:SetDesc('Auto Farm Boss: ' .. tostring(getgenv().AutoFarmBoss) .. '\nKill Aura: ' .. tostring(getgenv().KillAura) .. '\nAuto Sayu Quiz: ' .. tostring(getgenv().AutoSayuQuiz) .. '\nAuto Pain Mission: ' .. tostring(getgenv().AutoPainMission) .. '\nAuto Akatsuki: ' .. tostring(getgenv().AutoFarmAkatsuki))
    end)
end

Tabs.Info:Button({
    Title = 'Refresh Settings Info',
    Icon = 'refresh-cw',
    Description = 'Refresh the runtime status shown above.',
    Callback = function()
        RefreshSettingsInfo()
        Notify('Runtime settings information refreshed.')
    end,
})
Tabs.Info:Divider()
Tabs.Info:Section({
    Title = 'News',
    Icon = 'palette',
    Opened = false,
    Desc = 'Vyrion Red Blue theme \u{2022} WindUI 1.6.54',
})
Tabs.Info:Paragraph({
    Title = 'Bad news',
    Desc = 'At some point the script will stop being free and will have locked options :(',
})

getgenv().HitboxSize = 0
getgenv().FarmNoclip = false
getgenv().RunLowHP = false
getgenv().ToggleSpeedEnabled = false
getgenv().ToggleJumpEnabled = false
getgenv().SpeedValue = 16
getgenv().JumpValue = 50
getgenv().OnlyUse7Sword = false
getgenv().AuraRange = 50
getgenv().PassShields = false

local SelectedBoss = 'All'
local SelectedRoomBoss = 'Madara'
local SelectedMissionDifficulty = 'Normal'
local SelectedAkatsukiDifficulty = 'Normal'
local camLockConnection = nil
local lastWeaponSwap = 0
local currentWeaponIndex = 1

task.spawn(function()
    while task.wait(15) do
        gcinfo()
    end
end)

local function SafeFirePrompt(prompt)
    if not prompt or not prompt:IsA('ProximityPrompt') then
        return
    end

    task.spawn(function()
        local originalMaxDist = prompt.MaxActivationDistance
        local originalRequiresLineOfSight = prompt.RequiresLineOfSight

        prompt.RequiresLineOfSight = false
        prompt.MaxActivationDistance = math.huge

        if fireproximityprompt then
            fireproximityprompt(prompt)
        end

        pcall(function()
            prompt:InputBegan(Enum.UserInputType.Keyboard)
            task.wait(prompt.HoldDuration + 0.1)
            prompt:InputEnded(Enum.UserInputType.Keyboard)
        end)
        task.wait(0.1)

        if prompt and prompt.Parent then
            prompt.MaxActivationDistance = originalMaxDist
            prompt.RequiresLineOfSight = originalRequiresLineOfSight
        end
    end)
end
local function AutoEquipAndAttack()
    local backpack = LocalPlayer:FindFirstChild('Backpack')
    local character = LocalPlayer.Character

    if not character or not character:FindFirstChild('Humanoid') then
        return
    end

    local isRoomBossFarming = getgenv().AutoFarmRoomBoss or getgenv().AutoKillClown

    if isRoomBossFarming then
        local currentTool = character:FindFirstChildOfClass('Tool')

        if currentTool and string.find(string.lower(currentTool.Name), 'dash') then
            character.Humanoid:UnequipTools()
        end
    end
    if (getgenv().AutoFarmBoss or getgenv().AutoPainMission or getgenv().AutoFarmRoomBoss or getgenv().AutoFarmAkatsuki or getgenv().AutoKillClown) and backpack then
        local now = tick()

        if now - lastWeaponSwap >= 0.15 then
            lastWeaponSwap = now

            local validTools = {}

            for _, item in ipairs(backpack:GetChildren())do
                if item:IsA('Tool') then
                    local isDash = string.find(string.lower(item.Name), 'dash')

                    if not (isRoomBossFarming and isDash) then
                        table.insert(validTools, item)
                    end
                end
            end

            if #validTools > 0 then
                if currentWeaponIndex > #validTools then
                    currentWeaponIndex = 1
                end

                local weaponToEquip = validTools[currentWeaponIndex]

                if weaponToEquip then
                    character.Humanoid:EquipTool(weaponToEquip)
                end

                currentWeaponIndex = currentWeaponIndex + 1
            end
        end
    end

    local toolEquipped = character:FindFirstChildOfClass('Tool')
    local skillUsed = false

    if backpack and not toolEquipped then
        for _, item in ipairs(backpack:GetChildren())do
            if item:IsA('Tool') then
                local nameLower = string.lower(item.Name)
                local isDash = string.find(nameLower, 'dash')

                if not (isRoomBossFarming and isDash) then
                    if not string.find(nameLower, 'combat') and not string.find(nameLower, 'sword') and not string.find(nameLower, 'punch') then
                        character.Humanoid:EquipTool(item)

                        toolEquipped = item
                        skillUsed = true

                        break
                    end
                end
            end
        end
    end
    if getgenv().OnlyUse7Sword and not skillUsed and not toolEquipped then
        if backpack then
            for _, item in ipairs(backpack:GetChildren())do
                if item:IsA('Tool') then
                    local nameLower = string.lower(item.Name)
                    local isDash = string.find(nameLower, 'dash')

                    if not (isRoomBossFarming and isDash) then
                        if string.find(nameLower, 'combat') or string.find(nameLower, 'sword') or string.find(nameLower, 'm1') or string.find(nameLower, 'punch') or string.find(nameLower, 'katana') then
                            character.Humanoid:EquipTool(item)

                            toolEquipped = item

                            break
                        end
                    end
                end
            end
        end
    end
    if toolEquipped then
        local camera = workspace.CurrentCamera

        if camera then
            local center = camera.ViewportSize / 2

            pcall(function() end)
        end

        toolEquipped:Activate()
    end
end

RunService.Stepped:Connect(function()
    if getgenv().FarmNoclip and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetChildren())do
            if part:IsA('BasePart') and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

local ShieldKeywords = {
    'shield',
    'gate',
    'barrier',
    'forcefield',
    'wall',
    'pared',
    'door',
    'puerta',
}

task.spawn(function()
    while task.wait(5) do
        if getgenv().PassShields then
            local kit = workspace:FindFirstChild("Zednov's Tycoon Kit")
            local tycoons = kit and kit:FindFirstChild('Tycoons')

            if tycoons then
                for _, tycoon in ipairs(tycoons:GetChildren())do
                    for _, obj in ipairs(tycoon:GetDescendants())do
                        if obj:IsA('BasePart') then
                            local nameLower = string.lower(obj.Name)

                            for i = 1, #ShieldKeywords do
                                if string.find(nameLower, ShieldKeywords[i]) then
                                    pcall(function()
                                        obj:Destroy()
                                    end)

                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

local function GetMyTycoon()
    local zednovKit = workspace:FindFirstChild("Zednov's Tycoon Kit")
    local tycoonsFolder = zednovKit and zednovKit:FindFirstChild('Tycoons')

    if tycoonsFolder then
        for _, tycoon in ipairs(tycoonsFolder:GetChildren())do
            local ownerValue = tycoon:FindFirstChild('Owner')

            if ownerValue and (ownerValue.Value == LocalPlayer or tostring(ownerValue.Value) == LocalPlayer.Name) then
                return tycoon
            end
        end
    end

    return nil
end
local function IsBlacklisted(obj)
    if not obj then
        return true
    end

    local fullName = string.lower(obj:GetFullName())

    return (string.find(fullName, 'daron') or string.find(fullName, 'bossrooms') or string.find(fullName, 'traveling') or string.find(fullName, 'travelninja'))
end
local function TeleportWithTravelNinja(targetCFrame, targetIdentifier)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild('HumanoidRootPart')

    if not hrp then
        return
    end

    for _, obj in ipairs(ReplicatedStorage:GetDescendants())do
        if obj:IsA('RemoteEvent') and string.find(string.lower(obj.Name), 'travelninja') then
            pcall(function()
                obj:FireServer(targetIdentifier or 'Teleport')
            end)

            break
        end
    end

    task.wait(0.3)

    if (hrp.Position - targetCFrame.Position).Magnitude > 50 then
        hrp.CFrame = targetCFrame
    end
end
local function FireNearbyPrompts(hrp)
    for _, prompt in ipairs(workspace:GetDescendants())do
        if prompt:IsA('ProximityPrompt') and prompt.Parent and prompt.Parent:IsA('BasePart') then
            if (prompt.Parent.Position - hrp.Position).Magnitude <= 25 then
                SafeFirePrompt(prompt)
            end
        end
    end
end
local function GetValidNPCs()
    local npcs = {}
    local bossRooms = workspace:FindFirstChild('BossRooms')

    if bossRooms then
        for _, room in ipairs(bossRooms:GetChildren())do
            if room:IsA('Model') and room:FindFirstChild('Humanoid') and room.Humanoid.Health > 0 then
                table.insert(npcs, room)
            end
        end
    end

    local pathsFolder = workspace:FindFirstChild('PathsOfPainFolder')
    local enemyHolder = pathsFolder and pathsFolder:FindFirstChild('enemyHolder')

    if enemyHolder then
        for _, npc in ipairs(enemyHolder:GetChildren())do
            if npc:IsA('Model') and npc:FindFirstChild('Humanoid') and npc.Humanoid.Health > 0 then
                table.insert(npcs, npc)
            end
        end
    end

    for _, obj in ipairs(workspace:GetChildren())do
        if obj:IsA('Model') and obj:FindFirstChild('Humanoid') and obj.Humanoid.Health > 0 and not Players:GetPlayerFromCharacter(obj) then
            local lowerName = string.lower(obj.Name)

            if not string.find(lowerName, 'daron') and not string.find(lowerName, 'travel') then
                table.insert(npcs, obj)
            end
        end
    end

    return npcs
end

local PainNPCNames_Lower = {
    'pain of naraka',
    'pain of preta',
    'pain of animal',
    'pain of deva',
    'pain of human',
    'pain of asura',
}

local function GetClosestPainNPC()
    local pathsFolder = workspace:FindFirstChild('PathsOfPainFolder')
    local enemyHolder = pathsFolder and pathsFolder:FindFirstChild('enemyHolder')

    if not enemyHolder then
        return nil
    end

    local bestTarget = nil
    local shortestDist = math.huge
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild('HumanoidRootPart')

    if hrp then
        local potentialTargets = {}

        for _, npc in ipairs(enemyHolder:GetChildren())do
            if npc:IsA('Model') then
                local lowerName = string.lower(npc.Name)

                for i = 1, #PainNPCNames_Lower do
                    if string.find(lowerName, PainNPCNames_Lower[i]) then
                        table.insert(potentialTargets, npc)

                        break
                    end
                end
            end
        end
        for _, npc in ipairs(potentialTargets)do
            local npc_hrp = npc:FindFirstChild('HumanoidRootPart')
            local hum = npc:FindFirstChild('Humanoid')

            if npc_hrp and hum and hum.Health > 0 then
                local dist = (npc_hrp.Position - hrp.Position).Magnitude

                if dist < shortestDist then
                    shortestDist = dist
                    bestTarget = npc
                end
            end
        end
    end

    return bestTarget
end

Tabs.Main:Section({
    Title = 'BOSS FARM \u{1f479}',
    Icon = 'skull',
    Opened = true,
})
Tabs.Main:Dropdown({
    Title = 'Select Boss',
    Values = {
        'All',
        'Jigan',
        'Gimshiki',
        'Tenth Beast',
        'Nisshiki Otsutsushi',
        'Monashiki (Awakened)',
        'Monashiki',
    },
    Value = 'All',
    Callback = function(Value)
        SelectedBoss = Value
    end,
})
Tabs.Main:Toggle({
    Title = 'Auto Raid Boss',
    Default = false,
    Callback = function(state)
        getgenv().AutoFarmBoss = state

        if state then
            getgenv().HitboxSize = 60
            getgenv().HitboxNPC = true

            task.spawn(function()
                while getgenv().AutoFarmBoss do
                    local character = LocalPlayer.Character
                    local hrp = character and character:FindFirstChild('HumanoidRootPart')

                    if hrp then
                        local targetBoss = nil

                        if SelectedBoss == 'All' then
                            for _, bossName in ipairs({
                                'Jigan',
                                'Gimshiki',
                                'Tenth Beast',
                                'Nisshiki Otsutsushi',
                                'Monashiki (Awakened)',
                                'Monashiki',
                            })do
                                local b = workspace:FindFirstChild(bossName)

                                if b and b:FindFirstChild('HumanoidRootPart') and b:FindFirstChild('Humanoid') and b.Humanoid.Health > 0 then
                                    targetBoss = b

                                    break
                                end
                            end
                        else
                            local b = workspace:FindFirstChild(SelectedBoss)

                            if b and b:FindFirstChild('HumanoidRootPart') and b:FindFirstChild('Humanoid') and b.Humanoid.Health > 0 then
                                targetBoss = b
                            end
                        end
                        if targetBoss and targetBoss:FindFirstChild('HumanoidRootPart') then
                            getgenv().FarmNoclip = true

                            local hum = character:FindFirstChild('Humanoid')
                            local isLowHP = getgenv().RunLowHP and hum and hum.Health <= (hum.MaxHealth * 0.5)

                            if isLowHP then
                                local radius = 25
                                local flightSpeed = 800
                                local heightOffset = 100
                                local angle = tick() * (flightSpeed / radius)
                                local bossPos = targetBoss.HumanoidRootPart.Position
                                local circlePos = bossPos + Vector3.new(math.cos(angle) * radius, heightOffset, math.sin(angle) * radius)

                                hrp.CFrame = CFrame.lookAt(circlePos, bossPos)
                                hrp.Velocity = Vector3.new(0, 0, 0)
                            else
                                local targetCFrame = targetBoss.HumanoidRootPart.CFrame * CFrame.new(0, 4, 3)
                                local bossDist = (hrp.Position - targetCFrame.Position).Magnitude

                                if bossDist > 150 then
                                    TeleportWithTravelNinja(targetCFrame, targetBoss.Name)
                                    task.wait(3)
                                elseif bossDist > 15 then
                                    TweenService:Create(hrp, TweenInfo.new(bossDist / 40, Enum.EasingStyle.Linear), {CFrame = targetCFrame}):Play()
                                    task.wait(0.1)
                                else
                                    hrp.CFrame = targetCFrame
                                end
                            end

                            AutoEquipAndAttack()
                            task.wait(0.01)
                        else
                            task.wait(0.5)
                        end
                    else
                        task.wait(0.5)
                    end
                end
            end)
        else
            getgenv().FarmNoclip = false
        end
    end,
})

local scrollCache = {}

local function updateScrollCache()
    table.clear(scrollCache)

    for _, obj in ipairs(workspace:GetChildren())do
        if obj:IsA('BasePart') or obj:IsA('Model') then
            local prompt = obj:FindFirstChildWhichIsA('ProximityPrompt') or obj:FindFirstChildOfClass('ProximityPrompt', true)

            if prompt and string.find(string.lower(obj.Name), 'scroll') then
                table.insert(scrollCache, prompt)
            end
        end
    end
end

Tabs.Main:Section({
    Title = 'SCROLLS \u{1f4dc}',
    Icon = 'scroll',
    Opened = false,
})
Tabs.Main:Toggle({
    Title = 'Auto Collect Scrolls',
    Default = false,
    Callback = function(state)
        getgenv().AutoCollectScrolls = state

        if state then
            task.spawn(function()
                local cacheTimer = 0

                while getgenv().AutoCollectScrolls do
                    local character = LocalPlayer.Character
                    local hrp = character and character:FindFirstChild('HumanoidRootPart')

                    if hrp then
                        if os.clock() - cacheTimer > 3 or #scrollCache == 0 then
                            updateScrollCache()

                            cacheTimer = os.clock()
                        end

                        for i = #scrollCache, 1, -1 do
                            local prompt = scrollCache[i]

                            if prompt and prompt.Parent and prompt.Parent:IsA('BasePart') then
                                hrp.CFrame = prompt.Parent.CFrame

                                task.wait(0.1)

                                if SafeFirePrompt then
                                    SafeFirePrompt(prompt)
                                else
                                    fireproximityprompt(prompt)
                                end

                                task.wait(0.2)
                                table.remove(scrollCache, i)

                                break
                            else
                                table.remove(scrollCache, i)
                            end
                        end
                    end

                    task.wait(0.2)
                end
            end)
        end
    end,
})
Tabs.Main:Section({
    Title = 'SAYU QUIZ \u{1f4dc}',
    Icon = 'book-open',
    Opened = false,
})
Tabs.Main:Toggle({
    Title = 'Auto Sayu Quiz (Lag Fixed)',
    Default = false,
    Callback = function(state)
        getgenv().AutoSayuQuiz = state

        if state then
            task.spawn(function()
                while getgenv().AutoSayuQuiz do
                    local character = LocalPlayer.Character
                    local hrp = character and character:FindFirstChild('HumanoidRootPart')

                    if hrp then
                        local quizFolder = workspace:FindFirstChild('TimedEvent_Quiz')
                        local foundCorrectAnswer = false

                        if quizFolder then
                            for _, question in ipairs(quizFolder:GetChildren())do
                                for _, answer in ipairs(question:GetChildren())do
                                    local head = answer:FindFirstChild('Head')

                                    if head and head:FindFirstChild('Sayu_Correct') then
                                        hrp.CFrame = head.CFrame * CFrame.new(0, 0.5, 3.5)

                                        AutoEquipAndAttack()

                                        foundCorrectAnswer = true

                                        break
                                    end
                                end

                                if foundCorrectAnswer then
                                    break
                                end
                            end
                        end
                        if not foundCorrectAnswer then
                            for _, obj in ipairs(workspace:GetChildren())do
                                if string.find(string.lower(obj.Name), 'scroll') and obj:IsA('BasePart') then
                                    local prompt = obj:FindFirstChildOfClass('ProximityPrompt')

                                    if prompt then
                                        hrp.CFrame = obj.CFrame

                                        task.wait(0.2)
                                        SafeFirePrompt(prompt)
                                        task.wait(0.2)
                                    end
                                end
                            end
                        end
                    end

                    task.wait(0.25)
                end
            end)
        end
    end,
})
Tabs.GetItems:Section({
    Title = 'MISSIONS & ITEMS \u{1f4dc}',
    Icon = 'scroll',
    Opened = true,
})
Tabs.GetItems:Section({
    Title = 'LOW HEALTH \u{1fa78}',
    Icon = 'heart-pulse',
    Opened = false,
})
Tabs.GetItems:Toggle({
    Title = 'Run Low HP (Fly 100 Studs x20)',
    Default = false,
    Callback = function(state)
        getgenv().RunLowHP = state
    end,
})
Tabs.GetItems:Dropdown({
    Title = 'Select Difficulty',
    Values = {
        'Normal',
        'Hard',
    },
    Value = 'Normal',
    Callback = function(Value)
        SelectedMissionDifficulty = Value
    end,
})
Tabs.GetItems:Section({
    Title = 'PAIN MISSION \u{1f441}\u{fe0f}',
    Icon = 'eye',
    Opened = false,
})
Tabs.GetItems:Toggle({
    Title = 'Auto Pain Missions (Full Auto + Lock)',
    Default = false,
    Callback = function(state)
        getgenv().AutoPainMission = state

        if state then
            LocalPlayer.CameraMinZoomDistance = 0.5
            LocalPlayer.CameraMaxZoomDistance = 0.5
            LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson

            task.spawn(function()
                local radius = 25
                local flightSpeed = 800
                local heightOffset = 100

                while getgenv().AutoPainMission do
                    local character = LocalPlayer.Character
                    local hrp = character and character:FindFirstChild('HumanoidRootPart')

                    if hrp then
                        for _, part in ipairs(character:GetChildren())do
                            if part:IsA('BasePart') then
                                part.CanCollide = false
                            end
                        end

                        local targetNPC = GetClosestPainNPC()

                        if targetNPC and targetNPC:FindFirstChild('HumanoidRootPart') then
                            local hum = character:FindFirstChild('Humanoid')
                            local isLowHP = getgenv().RunLowHP and hum and hum.Health <= (hum.MaxHealth * 0.5)

                            if isLowHP then
                                local angle = tick() * (flightSpeed / radius)
                                local npcPos = targetNPC.HumanoidRootPart.Position
                                local circlePos = npcPos + Vector3.new(math.cos(angle) * radius, heightOffset, math.sin(angle) * radius)

                                hrp.CFrame = CFrame.lookAt(circlePos, npcPos)
                                hrp.Velocity = Vector3.new(0, 0, 0)
                            else
                                hrp.CFrame = targetNPC.HumanoidRootPart.CFrame * CFrame.new(0, 6, 3)
                                hrp.Velocity = Vector3.new(0, 0, 0)
                            end

                            AutoEquipAndAttack()
                        else
                            hrp.CFrame = CFrame.new(4041.41, 4291.67, 3035.66)

                            task.wait(0.1)
                            FireNearbyPrompts(hrp)

                            local timeWaited = 0

                            while timeWaited < 2 do
                                if GetClosestPainNPC() then
                                    break
                                end

                                task.wait(0.01)

                                timeWaited = timeWaited + 0.01
                            end

                            if not getgenv().AutoPainMission then
                                break
                            end
                            if not GetClosestPainNPC() then
                                if SelectedMissionDifficulty == 'Normal' then
                                    hrp.CFrame = CFrame.new(4038.8, 4291.7, 3058.99)
                                elseif SelectedMissionDifficulty == 'Hard' then
                                    hrp.CFrame = CFrame.new(4022.96, 4291.24, 3034.26)
                                end

                                task.wait(0.1)
                                FireNearbyPrompts(hrp)

                                timeWaited = 0

                                while timeWaited < 1.5 do
                                    if GetClosestPainNPC() then
                                        break
                                    end

                                    task.wait(0.01)

                                    timeWaited = timeWaited + 0.01
                                end
                            end
                        end
                    end

                    task.wait(0.01)
                end
            end)

            if not camLockConnection then
                camLockConnection = RunService.RenderStepped:Connect(function()
                    local character = LocalPlayer.Character

                    if character and character:FindFirstChild('HumanoidRootPart') then
                        local playerHRP = character.HumanoidRootPart
                        local closestTarget = GetClosestPainNPC()

                        if closestTarget and closestTarget:FindFirstChild('HumanoidRootPart') then
                            local targetHRP = closestTarget.HumanoidRootPart
                            local camera = workspace.CurrentCamera

                            camera.CFrame = CFrame.new(camera.CFrame.Position, targetHRP.Position)

                            local lookVector = (targetHRP.Position - playerHRP.Position).Unit

                            playerHRP.CFrame = CFrame.new(playerHRP.Position, playerHRP.Position + Vector3.new(lookVector.X, 0, lookVector.Z))
                        end
                    end
                end)
            end
        else
            if camLockConnection then
                camLockConnection:Disconnect()

                camLockConnection = nil
            end

            LocalPlayer.CameraMode = Enum.CameraMode.Classic
            LocalPlayer.CameraMinZoomDistance = 0.5
            LocalPlayer.CameraMaxZoomDistance = 400
        end
    end,
})
Tabs.GetItems:Section({
    Title = 'AKATSUKI \u{1f300}',
    Icon = 'flame',
    Opened = false,
})
Tabs.GetItems:Dropdown({
    Title = 'Select Akatsuki Difficulty',
    Values = {
        'Normal',
        'Hard',
    },
    Value = 'Normal',
    Callback = function(Value)
        SelectedAkatsukiDifficulty = Value
    end,
})

local akatsukiCamLockConn = nil

Tabs.GetItems:Toggle({
    Title = 'Auto Farm Akatsuki Missions',
    Default = false,
    Callback = function(state)
        getgenv().AutoFarmAkatsuki = state

        if state then
            LocalPlayer.CameraMinZoomDistance = 0.5
            LocalPlayer.CameraMaxZoomDistance = 0.5
            LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson

            task.spawn(function()
                while getgenv().AutoFarmAkatsuki do
                    local character = LocalPlayer.Character
                    local hrp = character and character:FindFirstChild('HumanoidRootPart')

                    if hrp then
                        local akatsukiFolder = workspace:FindFirstChild('AkatsukeShowdownFolder')
                        local memberHolder = akatsukiFolder and akatsukiFolder:FindFirstChild('AkatMemberHolder')

                        getgenv().CurrentAkatsukiTarget = nil

                        if memberHolder then
                            for _, npc in ipairs(memberHolder:GetChildren())do
                                if npc:IsA('Model') and npc:FindFirstChild('Humanoid') and npc.Humanoid.Health > 0 and npc:FindFirstChild('HumanoidRootPart') then
                                    getgenv().CurrentAkatsukiTarget = npc

                                    break
                                end
                            end
                        end

                        local targetNPC = getgenv().CurrentAkatsukiTarget

                        if targetNPC then
                            for _, part in ipairs(character:GetChildren())do
                                if part:IsA('BasePart') then
                                    part.CanCollide = false
                                end
                            end

                            local hum = character:FindFirstChild('Humanoid')
                            local isLowHP = getgenv().RunLowHP and hum and hum.Health <= (hum.MaxHealth * 0.5)

                            if isLowHP then
                                local radius = 25
                                local flightSpeed = 800
                                local heightOffset = 100
                                local angle = tick() * (flightSpeed / radius)
                                local npcPos = targetNPC.HumanoidRootPart.Position
                                local circlePos = npcPos + Vector3.new(math.cos(angle) * radius, heightOffset, math.sin(angle) * radius)

                                hrp.CFrame = CFrame.lookAt(circlePos, npcPos)
                                hrp.Velocity = Vector3.new(0, 0, 0)
                            else
                                hrp.CFrame = targetNPC.HumanoidRootPart.CFrame * CFrame.new(0, 6, 3)
                                hrp.Velocity = Vector3.new(0, 0, 0)
                            end

                            AutoEquipAndAttack()
                            task.wait(0.01)
                        else
                            hrp.CFrame = CFrame.new(4017.77, 4290.3, 10.84)

                            task.wait(0.2)
                            FireNearbyPrompts(hrp)
                            task.wait(0.5)

                            if SelectedAkatsukiDifficulty == 'Hard' then
                                hrp.CFrame = CFrame.new(4001.95, 4289.66, -1.24)
                            elseif SelectedAkatsukiDifficulty == 'Normal' then
                                hrp.CFrame = CFrame.new(3999.86, 4289.66, 26.01)
                            end

                            task.wait(0.2)
                            FireNearbyPrompts(hrp)
                            task.wait(1)
                        end
                    else
                        task.wait(0.5)
                    end
                end
            end)

            if not akatsukiCamLockConn then
                akatsukiCamLockConn = RunService.RenderStepped:Connect(function()
                    local character = LocalPlayer.Character
                    local targetNPC = getgenv().CurrentAkatsukiTarget

                    if character and character:FindFirstChild('HumanoidRootPart') and targetNPC and targetNPC:FindFirstChild('HumanoidRootPart') then
                        local playerHRP = character.HumanoidRootPart
                        local targetHRP = targetNPC.HumanoidRootPart
                        local camera = workspace.CurrentCamera

                        camera.CFrame = CFrame.new(camera.CFrame.Position, targetHRP.Position)

                        local lookVector = (targetHRP.Position - playerHRP.Position).Unit

                        playerHRP.CFrame = CFrame.new(playerHRP.Position, playerHRP.Position + Vector3.new(lookVector.X, 0, lookVector.Z))
                    end
                end)
            end
        else
            if akatsukiCamLockConn then
                akatsukiCamLockConn:Disconnect()

                akatsukiCamLockConn = nil
            end

            getgenv().CurrentAkatsukiTarget = nil
            LocalPlayer.CameraMode = Enum.CameraMode.Classic
            LocalPlayer.CameraMinZoomDistance = 0.5
            LocalPlayer.CameraMaxZoomDistance = 400
        end
    end,
})
Tabs.Tycoon:Section({
    Title = 'TYCOON FARM \u{1f3ed}',
    Icon = 'database',
    Opened = true,
})
Tabs.Tycoon:Toggle({
    Title = 'Auto Collect Money',
    Default = false,
    Callback = function(state)
        getgenv().AutoCollect = state

        task.spawn(function()
            while getgenv().AutoCollect do
                local myTycoon = GetMyTycoon()

                if myTycoon and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart') then
                    local giver = myTycoon:FindFirstChild('Essentials') and myTycoon.Essentials:FindFirstChild('Giver')

                    if giver and not IsBlacklisted(giver) then
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, giver, 0)
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, giver, 1)
                    end
                end

                task.wait(0.5)
            end
        end)
    end,
})
Tabs.Tycoon:Section({
    Title = 'PURCHASE & STEAL \u{1f3ea}',
    Icon = 'shopping-cart',
    Opened = false,
})
Tabs.Tycoon:Toggle({
    Title = 'Auto Buy',
    Default = false,
    Callback = function(state)
        getgenv().AutoBuy = state

        task.spawn(function()
            while getgenv().AutoBuy do
                local myTycoon = GetMyTycoon()

                if myTycoon and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart') then
                    local buttons = myTycoon:FindFirstChild('Buttons')

                    if buttons then
                        for _, button in ipairs(buttons:GetChildren())do
                            if not IsBlacklisted(button) and button:FindFirstChild('Head') then
                                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, button.Head, 0)
                                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, button.Head, 1)
                            end
                        end
                    end
                end

                task.wait(0.3)
            end
        end)
    end,
})
Tabs.Tycoon:Toggle({
    Title = 'Steal Tycoons',
    Default = false,
    Callback = function(state)
        getgenv().AutoSteal = state

        task.spawn(function()
            while getgenv().AutoSteal do
                local zednovKit = workspace:FindFirstChild("Zednov's Tycoon Kit")

                if zednovKit and zednovKit:FindFirstChild('Tycoons') then
                    local myTycoon = GetMyTycoon()

                    for _, tycoon in ipairs(zednovKit.Tycoons:GetChildren())do
                        if tycoon ~= myTycoon then
                            local giver = tycoon:FindFirstChild('Essentials') and tycoon.Essentials:FindFirstChild('Giver')

                            if giver and not IsBlacklisted(giver) and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart') then
                                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, giver, 0)
                                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, giver, 1)
                            end
                        end
                    end
                end

                task.wait(1.5)
            end
        end)
    end,
})
Tabs.Tycoon:Section({
    Title = 'DROPPER \u{2699}\u{fe0f}',
    Icon = 'mouse-pointer-click',
    Opened = false,
})
Tabs.Tycoon:Toggle({
    Title = 'Auto Click Dropper',
    Default = false,
    Callback = function(state)
        getgenv().AutoClicker = state

        task.spawn(function()
            while getgenv().AutoClicker do
                local myTycoon = GetMyTycoon()

                if myTycoon then
                    for _, obj in ipairs(myTycoon:GetDescendants())do
                        if obj:IsA('ProximityPrompt') and not IsBlacklisted(obj) then
                            SafeFirePrompt(obj)
                        end
                    end
                end

                task.wait(0.05)
            end
        end)
    end,
})
Tabs.Combat:Section({
    Title = 'COMBAT \u{2694}\u{fe0f}',
    Icon = 'swords',
    Opened = true,
})
Tabs.Combat:Toggle({
    Title = 'Only use 7 sword',
    Default = false,
    Callback = function(state)
        getgenv().OnlyUse7Sword = state
    end,
})
Tabs.Combat:Toggle({
    Title = 'God Mode',
    Default = false,
    Callback = function(state)
        getgenv().AutoHeal = state

        task.spawn(function()
            while getgenv().AutoHeal do
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild('HumanoidRootPart')
                local hum = char and char:FindFirstChildOfClass('Humanoid')

                if char and hum and hrp and hum.Health > 0 and hum.Health < hum.MaxHealth then
                    local zednovKit = workspace:FindFirstChild("Zednov's Tycoon Kit")

                    if zednovKit and zednovKit:FindFirstChild('Tycoons') then
                        local healed = false

                        for _, tycoon in ipairs(zednovKit.Tycoons:GetChildren())do
                            for _, obj in ipairs(tycoon:GetDescendants())do
                                if obj:IsA('BasePart') and string.find(string.lower(obj.Name), 'heal') then
                                    firetouchinterest(hrp, obj, 0)
                                    firetouchinterest(hrp, obj, 1)

                                    healed = true

                                    break
                                end
                            end

                            if healed then
                                break
                            end
                        end
                    end
                end

                task.wait(0.25)
            end
        end)
    end,
})
Tabs.Combat:Section({
    Title = 'RANGE & EQUIP \u{1f3af}',
    Icon = 'target',
    Opened = false,
})
Tabs.Combat:Toggle({
    Title = 'Auto Equip',
    Default = false,
    Callback = function(state)
        getgenv().AutoEquip = state

        task.spawn(function()
            local currentToolIndex = 1

            while getgenv().AutoEquip do
                local backpack = LocalPlayer:FindFirstChild('Backpack')

                if backpack then
                    local tools = {}

                    for _, item in ipairs(backpack:GetChildren())do
                        if item:IsA('Tool') then
                            table.insert(tools, item)
                        end
                    end

                    if #tools > 0 then
                        if currentToolIndex > #tools then
                            currentToolIndex = 1
                        end

                        local nextTool = tools[currentToolIndex]

                        if nextTool and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('Humanoid') then
                            LocalPlayer.Character.Humanoid:EquipTool(nextTool)

                            currentToolIndex = currentToolIndex + 1
                        end
                    end
                end

                task.wait(1.2)
            end
        end)
    end,
})

getgenv().KillAura = false
getgenv().KillAuraPlayers = false
getgenv().KillAuraDamage = 1000
getgenv().InfiniteShield = false

Tabs.Player:Section({
    Title = 'PLAYER \u{26a1}',
    Icon = 'user',
    Opened = true,
})
Tabs.Player:Section({
    Title = 'KILL AURA \u{1f52a}',
    Icon = 'swords',
    Opened = true,
})
Tabs.Player:Toggle({
    Title = 'Attack Hitbox (NPC)',
    Default = false,
    Callback = function(state)
        getgenv().KillAura = state
    end,
})
Tabs.Player:Toggle({
    Title = 'Attack Hitbox (Players)',
    Default = false,
    Callback = function(state)
        getgenv().KillAuraPlayers = state
    end,
})
Tabs.Player:Toggle({
    Title = 'Show Aura Range',
    Default = false,
    Callback = function(state)
        getgenv().ShowAuraCircle = state
    end,
})
Tabs.Player:Slider({
    Title = 'Aura Range',
    Value = {
        Min = 10,
        Max = 1000,
        Default = 50,
    },
    Step = 5,
    Callback = function(Value)
        getgenv().AuraRange = Value
    end,
})
Tabs.Player:Toggle({
    Title = 'Insta Kill Aura',
    Default = false,
    Callback = function(state)
        getgenv().KillAuraEnabled = state
    end,
})

local auraCircle = Instance.new('Part')

auraCircle.Name = 'VyrionAuraCircle'
auraCircle.Shape = Enum.PartType.Cylinder
auraCircle.Material = Enum.Material.Neon
auraCircle.Color = Color3.fromRGB(255, 50, 50)
auraCircle.Transparency = 0.6
auraCircle.Anchored = true
auraCircle.CanCollide = false
auraCircle.CanTouch = false
auraCircle.CanQuery = false
auraCircle.CastShadow = false

RunService.RenderStepped:Connect(function()
    if getgenv().ShowAuraCircle and (getgenv().KillAura or getgenv().KillAuraPlayers or getgenv().KillAuraEnabled) then
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild('HumanoidRootPart')

        if hrp then
            auraCircle.Parent = workspace

            local r = tonumber(getgenv().AuraRange) or 50

            auraCircle.Size = Vector3.new(0.2, r * 2, r * 2)
            auraCircle.CFrame = CFrame.new(hrp.Position - Vector3.new(0, hrp.Size.Y / 2 + 0.9, 0)) * CFrame.Angles(0, 0, math.rad(90))
        else
            auraCircle.Parent = nil
        end
    else
        auraCircle.Parent = nil
    end
end)
Tabs.Player:Section({
    Title = 'MOVEMENT \u{1f3c3}',
    Icon = 'move',
    Opened = false,
})
Tabs.Player:Toggle({
    Title = 'Enable Speed Modifier',
    Default = false,
    Callback = function(state)
        getgenv().ToggleSpeedEnabled = state
    end,
})
Tabs.Player:Slider({
    Title = 'WalkSpeed',
    Value = {
        Min = 16,
        Max = 120,
        Default = 16,
    },
    Step = 1,
    Callback = function(Value)
        getgenv().SpeedValue = Value
    end,
})
Tabs.Player:Toggle({
    Title = 'Enable Jump Modifier',
    Default = false,
    Callback = function(state)
        getgenv().ToggleJumpEnabled = state
    end,
})
Tabs.Player:Slider({
    Title = 'JumpPower',
    Value = {
        Min = 50,
        Max = 200,
        Default = 50,
    },
    Step = 1,
    Callback = function(Value)
        getgenv().JumpValue = Value
    end,
})
Tabs.Player:Section({
    Title = 'CAMERA \u{1f4f7}',
    Icon = 'camera',
    Opened = false,
})
Tabs.Player:Toggle({
    Title = 'Force First Person',
    Default = false,
    Callback = function(state)
        if state then
            LocalPlayer.CameraMinZoomDistance = 0.5
            LocalPlayer.CameraMaxZoomDistance = 0.5
            LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
        else
            LocalPlayer.CameraMode = Enum.CameraMode.Classic
            LocalPlayer.CameraMinZoomDistance = 0.5
            LocalPlayer.CameraMaxZoomDistance = 400
        end
    end,
})

local ContextActionService = game:GetService('ContextActionService')
local Debris = game:GetService('Debris')

Tabs.Player:Toggle({
    Title = 'No Dash Cooldown (Fixed)',
    Default = false,
    Callback = function(state)
        getgenv().NoDashCooldown = state

        local characterConnection

        local function setupDash(character)
            if not character then
                return
            end

            local originalDashScript = character:WaitForChild('Dash', 3)

            if getgenv().NoDashCooldown then
                if originalDashScript and originalDashScript:IsA('LocalScript') then
                    originalDashScript.Disabled = true
                end

                local function customDash(_, inputState)
                    if inputState == Enum.UserInputState.Begin then
                        local currentCharacter = LocalPlayer.Character
                        local hrp = currentCharacter and currentCharacter:FindFirstChild('HumanoidRootPart')
                        local hum = currentCharacter and currentCharacter:FindFirstChildOfClass('Humanoid')

                        if hrp and hum and hum.Health > 0 then
                            local anim = Instance.new('Animation')

                            anim.AnimationId = 'rbxassetid://12003682032'

                            local track = hum:LoadAnimation(anim)

                            track:Play()

                            hrp.Velocity = hrp.CFrame.lookVector * 200

                            local sound = Instance.new('Sound', hrp)

                            sound.SoundId = 'rbxassetid://4689460614'
                            sound.Volume = 1
                            sound.PlayOnRemove = true

                            sound:Destroy()
                            pcall(function()
                                local moduleAssets = ReplicatedStorage:FindFirstChild('ModuleAssets')

                                if moduleAssets then
                                    local sprintParticle = moduleAssets:FindFirstChild('SprintParticle')

                                    if sprintParticle then
                                        local clone = sprintParticle:Clone()

                                        clone.Parent = hrp
                                        clone.Enabled = true

                                        Debris:AddItem(clone, 1)
                                        task.delay(0.1, function()
                                            clone.Enabled = false
                                        end)
                                    end

                                    local dashLines = moduleAssets:FindFirstChild('DashLines')

                                    if dashLines then
                                        local clone = dashLines:Clone()

                                        clone.Parent = hrp
                                        clone.Enabled = true

                                        Debris:AddItem(clone, 2)
                                        task.delay(0.5, function()
                                            clone.Enabled = false
                                        end)
                                    end
                                end
                            end)
                        end
                    end
                end

                ContextActionService:BindAction('Dashing', customDash, true, Enum.KeyCode.E, Enum.KeyCode.ButtonY)
                ContextActionService:SetPosition('Dashing', UDim2.new(0.4, 0, 0.1, 0))
            end
        end

        if state then
            setupDash(LocalPlayer.Character)

            characterConnection = LocalPlayer.CharacterAdded:Connect(function(newCharacter)
                setupDash(newCharacter)
            end)
        else
            if characterConnection then
                characterConnection:Disconnect()
            end

            ContextActionService:UnbindAction('Dashing')

            local character = LocalPlayer.Character
            local originalDashScript = character and character:FindFirstChild('Dash')

            if originalDashScript and originalDashScript:IsA('LocalScript') then
                originalDashScript.Disabled = true

                task.wait(0.05)

                originalDashScript.Disabled = false
            end
        end
    end,
})
task.spawn(function()
    while task.wait(0.4) do
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('Humanoid') then
            if getgenv().ToggleSpeedEnabled then
                LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().SpeedValue
            else
                LocalPlayer.Character.Humanoid.WalkSpeed = 16
            end
            if getgenv().ToggleJumpEnabled then
                LocalPlayer.Character.Humanoid.UseJumpPower = true
                LocalPlayer.Character.Humanoid.JumpPower = getgenv().JumpValue
            else
                LocalPlayer.Character.Humanoid.JumpPower = 50
            end
        end
    end
end)

local function getClosestPlayerTarget(character)
    local myHRP = character:FindFirstChild('HumanoidRootPart')

    if not myHRP then
        return nil
    end

    local closestRoot = nil
    local closestDistance = math.huge

    for _, p in ipairs(Players:GetPlayers())do
        if p ~= LocalPlayer and p.Character then
            local humanoid = p.Character:FindFirstChildOfClass('Humanoid')
            local root = p.Character:FindFirstChild('HumanoidRootPart')

            if humanoid and humanoid.Health > 0 and root then
                local distance = (root.Position - myHRP.Position).Magnitude

                if distance < closestDistance then
                    closestDistance = distance
                    closestRoot = root
                end
            end
        end
    end

    return closestRoot
end

local Players = game:GetService('Players')

getgenv().UniversalSpamEnabled = false

local function getPrecisePlayerTarget(myCharacter)
    local myHRP = myCharacter:FindFirstChild('HumanoidRootPart')

    if not myHRP then
        return nil, nil
    end

    local closestHRP = nil
    local closestDistance = math.huge

    for _, p in ipairs(Players:GetPlayers())do
        if p ~= LocalPlayer and p.Character then
            local enemyHum = p.Character:FindFirstChildOfClass('Humanoid')
            local enemyHRP = p.Character:FindFirstChild('HumanoidRootPart')

            if enemyHum and enemyHum.Health > 0 and enemyHRP then
                local distance = (enemyHRP.Position - myHRP.Position).Magnitude

                if distance < closestDistance then
                    closestDistance = distance
                    closestHRP = enemyHRP
                end
            end
        end
    end

    return closestHRP
end

Tabs.Player:Section({
    Title = 'SKILL SPAMMER \u{26a1}',
    Icon = 'zap',
    Opened = false,
})
Tabs.Player:Toggle({
    Title = 'Universal Skill Spammer (No Cooldown)',
    Default = false,
    Callback = function(state)
        getgenv().UniversalSpamEnabled = state

        if state then
            task.spawn(function()
                while getgenv().UniversalSpamEnabled do
                    local character = LocalPlayer.Character

                    if character then
                        local tool = character:FindFirstChildOfClass('Tool')

                        if tool then
                            local vulnerableRemotes = {
                                'RemoteEvent',
                                'Atk',
                            }

                            for i = 1, #vulnerableRemotes do
                                local remote = tool:FindFirstChild(vulnerableRemotes[i])

                                if remote and remote:IsA('RemoteEvent') then
                                    if tool.Name == 'Phoenix Volley' then
                                        local targetHRP = getPrecisePlayerTarget(character)

                                        if targetHRP then
                                            local predictedPosition = targetHRP.Position + (targetHRP.Velocity * 0.15)

                                            pcall(function()
                                                remote:FireServer(predictedPosition)
                                            end)
                                        end
                                    else
                                        pcall(function()
                                            remote:FireServer()
                                        end)
                                    end
                                end
                            end
                        end
                    end

                    task.wait(0.1)
                end
            end)
        end
    end,
})
task.spawn(function()
    while task.wait(0.045) do
        pcall(function()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild('HumanoidRootPart')
            local hum = char and char:FindFirstChildOfClass('Humanoid')

            if not char or not hrp or not hum or hum.Health <= 0 then
                return
            end

            local range = tonumber(getgenv().AuraRange) or 50

            if getgenv().KillAura then
                local tool = char:FindFirstChildOfClass('Tool')
                local handle = tool and (tool:FindFirstChild('Handle') or tool:FindFirstChildWhichIsA('BasePart'))

                if handle then
                    for _, obj in ipairs(workspace:GetDescendants())do
                        if obj:IsA('Model') then
                            local npcHum = obj:FindFirstChildOfClass('Humanoid')
                            local npcRoot = obj:FindFirstChild('HumanoidRootPart')

                            if npcHum and npcRoot and npcHum.Health > 0 and not Players:GetPlayerFromCharacter(obj) then
                                if (npcRoot.Position - hrp.Position).Magnitude <= range then
                                    firetouchinterest(handle, npcRoot, 0)
                                    firetouchinterest(handle, npcRoot, 1)
                                end
                            end
                        end
                    end
                end
            end
            if getgenv().KillAuraPlayers then
                local tool = char:FindFirstChildOfClass('Tool')
                local handle = tool and (tool:FindFirstChild('Handle') or tool:FindFirstChildWhichIsA('BasePart'))

                if handle then
                    for _, player in ipairs(Players:GetPlayers())do
                        if player ~= LocalPlayer and player.Character then
                            local targetHum = player.Character:FindFirstChildOfClass('Humanoid')
                            local targetRoot = player.Character:FindFirstChild('HumanoidRootPart')

                            if targetHum and targetRoot and targetHum.Health > 0 then
                                if (targetRoot.Position - hrp.Position).Magnitude <= range then
                                    firetouchinterest(handle, targetRoot, 0)
                                    firetouchinterest(handle, targetRoot, 1)
                                end
                            end
                        end
                    end
                end
            end
            if getgenv().KillAuraEnabled then
                local damage = tonumber(getgenv().KillAuraDamage) or 9999

                for _, obj in ipairs(workspace:GetDescendants())do
                    if obj:IsA('Model') and obj:FindFirstChildOfClass('Humanoid') then
                        local playerCheck = Players:GetPlayerFromCharacter(obj)

                        if not playerCheck then
                            local targetHum = obj:FindFirstChildOfClass('Humanoid')
                            local targetRoot = obj:FindFirstChild('HumanoidRootPart')

                            if targetHum and targetRoot and targetHum.Health > 0 then
                                if (targetRoot.Position - hrp.Position).Magnitude <= range then
                                    targetHum.Health = math.max(0, targetHum.Health - damage)
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)
Tabs.FarmBoss:Section({
    Title = 'ROOM BOSS \u{1f479}',
    Icon = 'skull',
    Opened = true,
})
Tabs.FarmBoss:Dropdown({
    Title = 'Select Room Boss',
    Values = {
        'Madara',
        'kaguya',
    },
    Default = 'Madara',
    Callback = function(Value)
        getgenv().SelectedRoomBoss = Value
    end,
})
Tabs.FarmBoss:Toggle({
    Title = 'Auto Farm Room Bosses',
    Default = false,
    Callback = function(state)
        getgenv().AutoFarmRoomBoss = state

        if state then
            getgenv().HitboxSize = 60
            getgenv().HitboxNPC = true

            task.spawn(function()
                while getgenv().AutoFarmRoomBoss do
                    local character = LocalPlayer.Character
                    local hrp = character and character:FindFirstChild('HumanoidRootPart')
                    local bossRooms = workspace:FindFirstChild('BossRooms')

                    if hrp and bossRooms then
                        for _, part in ipairs(character:GetChildren())do
                            if part:IsA('BasePart') then
                                part.CanCollide = false
                            end
                        end

                        local targetName = getgenv().SelectedRoomBoss
                        local targetRoomBoss = nil
                        local summonCFrame = nil
                        local bossInstanceName = ''

                        if targetName == 'Madara' then
                            summonCFrame = CFrame.new(772.64, 2417.2, 1570.03)
                            bossInstanceName = 'Nadara'
                        elseif targetName == 'kaguya' then
                            summonCFrame = CFrame.new(-1575.56, 2364.19, -2341.43)
                            bossInstanceName = 'Kaguyai'
                        end

                        local b = bossRooms:FindFirstChild(bossInstanceName)

                        if b and b:FindFirstChild('HumanoidRootPart') and b:FindFirstChild('Humanoid') and b.Humanoid.Health > 0 then
                            targetRoomBoss = b
                        end
                        if not targetRoomBoss then
                            hrp.CFrame = summonCFrame
                            hrp.Velocity = Vector3.new(0, 0, 0)

                            task.wait(0.5)

                            local holdTime = 0

                            while holdTime < 3 and getgenv().AutoFarmRoomBoss do
                                pcall(function()
                                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
                                end)
                                task.wait(0.1)

                                holdTime = holdTime + 0.1
                            end

                            pcall(function()
                                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
                            end)

                            local timeWaited = 0

                            while timeWaited < 2 do
                                local checkBoss = bossRooms:FindFirstChild(bossInstanceName)

                                if checkBoss and checkBoss:FindFirstChild('Humanoid') and checkBoss.Humanoid.Health > 0 then
                                    break
                                end

                                task.wait(0.01)

                                timeWaited = timeWaited + 0.01
                            end
                        else
                            getgenv().FarmNoclip = true

                            local hum = character:FindFirstChild('Humanoid')
                            local isLowHP = getgenv().RunLowHP and hum and hum.Health <= (hum.MaxHealth * 0.5)

                            if isLowHP then
                                local radius = 25
                                local flightSpeed = 800
                                local heightOffset = 100
                                local angle = tick() * (flightSpeed / radius)
                                local bossPos = targetRoomBoss.HumanoidRootPart.Position
                                local circlePos = bossPos + Vector3.new(math.cos(angle) * radius, heightOffset, math.sin(angle) * radius)

                                hrp.CFrame = CFrame.lookAt(circlePos, bossPos)
                                hrp.Velocity = Vector3.new(0, 0, 0)
                            else
                                hrp.CFrame = targetRoomBoss.HumanoidRootPart.CFrame * CFrame.new(0, 6, 3)
                                hrp.Velocity = Vector3.new(0, 0, 0)
                            end

                            AutoEquipAndAttack()
                        end
                    end

                    task.wait(0.01)
                end
            end)
        else
            getgenv().FarmNoclip = false
        end
    end,
})

local TweenService = game:GetService('TweenService')
local VirtualInputManager = game:GetService('VirtualInputManager')
local StarterGui = game:GetService('StarterGui')
local RunService = game:GetService('RunService')
local Players = game:GetService('Players')
local LocalPlayer = Players.LocalPlayer
local spawnCFrame = CFrame.new(-4362.35, 2430.53, -1331.84)
local statue = workspace:FindFirstChild('kamuiDimension') and workspace.kamuiDimension:FindFirstChild('ClownjasonSTATUE')

local function notify(title, text)
    StarterGui:SetCore('SendNotification', {
        Title = title,
        Text = text,
        Duration = 3,
    })
end
local function setCamera(mode, distance)
    LocalPlayer.CameraMode = mode

    if distance then
        LocalPlayer.CameraMaxZoomDistance = distance
        LocalPlayer.CameraMinZoomDistance = distance
    else
        LocalPlayer.CameraMaxZoomDistance = 128
        LocalPlayer.CameraMinZoomDistance = 0.5
    end
end
local function collectScrolls()
    local drops = workspace
    local collected = false

    if drops then
        for _, item in pairs(drops:GetChildren())do
            if item.Name:lower():find('scroll') and item:FindFirstChild('HumanoidRootPart') then
                local char = LocalPlayer.Character

                if char and char:FindFirstChild('HumanoidRootPart') then
                    local dist = (char.HumanoidRootPart.Position - item.HumanoidRootPart.Position).Magnitude

                    if dist <= 20 then
                        char.HumanoidRootPart.CFrame = item.HumanoidRootPart.CFrame

                        firetouchinterest(char.HumanoidRootPart, item.HumanoidRootPart, 0)
                        firetouchinterest(char.HumanoidRootPart, item.HumanoidRootPart, 1)

                        collected = true

                        task.wait(0.2)
                    end
                end
            end
        end
    end

    return collected
end

Tabs.FarmBoss:Toggle({
    Title = 'Auto Kill Clownjason (Full Auto)',
    Default = false,
    Callback = function(state)
        getgenv().AutoKillClown = state

        if state then
            notify('AutoFarm', 'Activado. Waiting 6 seconds...')
            task.spawn(function()
                local waitStartTime = tick()
                local isHoldingF = false
                local shouldLockCamera = false
                local lastBossHealth = 100
                local camConnection

                camConnection = RunService.RenderStepped:Connect(function()
                    if shouldLockCamera and statue and statue:FindFirstChild('HumanoidRootPart') then
                        local camera = workspace.CurrentCamera

                        if camera then
                            camera.CFrame = CFrame.new(camera.CFrame.Position, statue.HumanoidRootPart.Position)
                        end
                    end
                end)

                while getgenv().AutoKillClown do
                    task.wait(0.1)

                    local char = LocalPlayer.Character
                    local hrp = char and char:FindFirstChild('HumanoidRootPart')
                    local clownBoss = workspace:FindFirstChild('BossRooms') and workspace.BossRooms:FindFirstChild('Clownjason')

                    if hrp then
                        if clownBoss and clownBoss:FindFirstChild('Humanoid') and clownBoss.Humanoid.Health > 0 then
                            getgenv().FarmNoclip = true
                            waitStartTime = nil
                            isHoldingF = false
                            shouldLockCamera = false

                            setCamera(Enum.CameraMode.Classic, 19)

                            lastBossHealth = clownBoss.Humanoid.Health

                            pcall(function()
                                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
                            end)

                            local bossHRP = clownBoss.HumanoidRootPart

                            hrp.CFrame = bossHRP.CFrame * CFrame.new(0, 3, 4)
                            hrp.Velocity = Vector3.zero

                            if type(AutoEquipAndAttack) == 'function' then
                                AutoEquipAndAttack()
                            end

                            local tool = char:FindFirstChildOfClass('Tool')

                            if tool then
                                local remote = tool:FindFirstChild('RemoteEvent') or tool:FindFirstChild('AttackRem')

                                if remote then
                                    local tName = tool.Name

                                    if tName == 'Phoenix Volley' or tName == 'Rasanshuriken' or tName == 'Chitari Spear' then
                                        remote:FireServer(bossHRP.Position)
                                    elseif tName == 'Particle Vaporize' then
                                        local unknowing = tool:FindFirstChild('Unknowing')

                                        if unknowing then
                                            local oldCF = hrp.CFrame

                                            hrp.CFrame = CFrame.lookAt(hrp.Position, Vector3.new(bossHRP.Position.X, hrp.Position.Y, bossHRP.Position.Z))

                                            task.wait(0.03)
                                            unknowing:FireServer()

                                            hrp.CFrame = oldCF
                                        end
                                    else
                                        remote:FireServer(bossHRP.Position)
                                    end
                                end
                            end
                        elseif lastBossHealth ~= nil and (not clownBoss or clownBoss.Humanoid.Health <= 0) then
                            notify('Boss Defeated', 'Waiting 10 seconds for respawn...')

                            lastBossHealth = nil
                            shouldLockCamera = false

                            setCamera(Enum.CameraMode.Classic)
                            task.wait(10)

                            waitStartTime = tick()
                        elseif collectScrolls() then
                            getgenv().FarmNoclip = false
                            waitStartTime = nil
                            isHoldingF = false
                            shouldLockCamera = false

                            setCamera(Enum.CameraMode.Classic)
                        else
                            getgenv().FarmNoclip = false

                            if not waitStartTime then
                                waitStartTime = tick()

                                notify('Waiting', 'Waiting 6 seconds to start...')
                            end
                            if (tick() - waitStartTime) >= 6 then
                                shouldLockCamera = true

                                setCamera(Enum.CameraMode.LockFirstPerson)

                                local dist = (hrp.Position - spawnCFrame.Position).Magnitude

                                if dist > 3 then
                                    TweenService:Create(hrp, TweenInfo.new(0.2), {CFrame = spawnCFrame}):Play()
                                end
                                if not isHoldingF then
                                    isHoldingF = true

                                    task.spawn(function()
                                        pcall(function()
                                            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
                                        end)
                                        task.wait(3)
                                        pcall(function()
                                            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
                                        end)
                                        task.wait(0.5)

                                        isHoldingF = false
                                    end)
                                end
                            else
                                shouldLockCamera = false

                                setCamera(Enum.CameraMode.Classic)
                            end
                        end
                    end
                end

                if camConnection then
                    camConnection:Disconnect()
                end

                shouldLockCamera = false

                setCamera(Enum.CameraMode.Classic)
                pcall(function()
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
                end)
            end)
        else
            getgenv().FarmNoclip = false

            setCamera(Enum.CameraMode.Classic)
            pcall(function()
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
            end)
        end
    end,
})
Tabs.Visuals:Button({
    Title = 'Remove Barriers (Lasers)',
    Callback = function()
        local zednovKit = workspace:FindFirstChild("Zednov's Tycoon Kit")
        local tycoons = zednovKit and zednovKit:FindFirstChild('Tycoons')

        if tycoons then
            local count = 0

            for _, tycoon in ipairs(tycoons:GetChildren())do
                for _, obj in ipairs(tycoon:GetDescendants())do
                    if string.find(string.lower(obj.Name), 'laser') then
                        pcall(function()
                            obj:Destroy()

                            count = count + 1
                        end)
                    end
                end
            end

            local StarterGui = game:GetService('StarterGui')

            pcall(function()
                StarterGui:SetCore('SendNotification', {
                    Title = 'Nexus Hub',
                    Text = 'The barriers were removed\u{2705}' .. tostring(count) .. ' barreras l\u{e1}ser.',
                    Duration = 3,
                })
            end)
        end
    end,
})

local ESPEnabled = false
local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local LocalPlayer = Players.LocalPlayer
local teamChangeConnections = {}
local charAddedConnections = {}
local renderConnections = {}

local function removeESP(player)
    local char = player.Character

    if char then
        local highlight = char:FindFirstChild('ESP_Highlight')

        if highlight then
            highlight:Destroy()
        end

        local head = char:FindFirstChild('Head')

        if head then
            local billboard = head:FindFirstChild('ESP_Info')

            if billboard then
                billboard:Destroy()
            end
        end
    end
end
local function updateESPColors(player, character)
    if not character then
        return
    end

    local newColor = player.TeamColor.Color
    local highlight = character:FindFirstChild('ESP_Highlight')

    if highlight then
        highlight.FillColor = newColor
    end

    local head = character:FindFirstChild('Head')

    if head then
        local billboard = head:FindFirstChild('ESP_Info')

        if billboard then
            local label = billboard:FindFirstChildWhichIsA('TextLabel')

            if label then
                label.TextColor3 = newColor
            end
        end
    end
end
local function applyESP(player, character)
    if not ESPEnabled or not character or player == LocalPlayer then
        return
    end

    removeESP(player)

    local highlight = Instance.new('Highlight')

    highlight.Name = 'ESP_Highlight'
    highlight.Parent = character
    highlight.FillColor = player.TeamColor.Color
    highlight.OutlineColor = Color3.new(1, 1, 1)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

    local head = character:FindFirstChild('Head')

    if head then
        local billboard = Instance.new('BillboardGui')

        billboard.Name = 'ESP_Info'
        billboard.Size = UDim2.new(0, 200, 0, 70)
        billboard.StudsOffset = Vector3.new(0, 4, 0)
        billboard.AlwaysOnTop = true
        billboard.LightInfluence = 0
        billboard.Parent = head

        local infoLabel = Instance.new('TextLabel')

        infoLabel.Size = UDim2.new(1, 0, 1, 0)
        infoLabel.BackgroundTransparency = 1
        infoLabel.TextColor3 = player.TeamColor.Color
        infoLabel.TextStrokeTransparency = 0
        infoLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
        infoLabel.Font = Enum.Font.GothamBold
        infoLabel.TextSize = 15
        infoLabel.Text = string.format('%s\n[HP: 100]', player.Name)
        infoLabel.Parent = billboard

        local humanoid = character:FindFirstChild('Humanoid')

        if humanoid then
            if renderConnections[player] then
                renderConnections[player]:Disconnect()
            end

            renderConnections[player] = RunService.RenderStepped:Connect(function()
                if not ESPEnabled or not (character and character.Parent and humanoid.Health > 0) then
                    if renderConnections[player] then
                        renderConnections[player]:Disconnect()

                        renderConnections[player] = nil
                    end

                    return
                end

                infoLabel.Text = string.format('%s\n[HP: %.0f]', player.Name, humanoid.Health)
            end)
        end
    end

    updateESPColors(player, character)
end
local function setupPlayerESP(player)
    if player == LocalPlayer then
        return
    end
    if player.Character then
        applyESP(player, player.Character)
    end
    if charAddedConnections[player] then
        charAddedConnections[player]:Disconnect()
    end

    charAddedConnections[player] = player.CharacterAdded:Connect(function(char)
        if ESPEnabled then
            applyESP(player, char)
        end
    end)

    if not teamChangeConnections[player] then
        teamChangeConnections[player] = player:GetPropertyChangedSignal('TeamColor'):Connect(function()
            if ESPEnabled and player.Character then
                updateESPColors(player, player.Character)
            end
        end)
    end
end

Players.PlayerAdded:Connect(function(p)
    if ESPEnabled then
        setupPlayerESP(p)
    end
end)
Players.PlayerRemoving:Connect(function(player)
    removeESP(player)

    if teamChangeConnections[player] then
        teamChangeConnections[player]:Disconnect()

        teamChangeConnections[player] = nil
    end
    if charAddedConnections[player] then
        charAddedConnections[player]:Disconnect()

        charAddedConnections[player] = nil
    end
    if renderConnections[player] then
        renderConnections[player]:Disconnect()

        renderConnections[player] = nil
    end
end)
Tabs.Visuals:Section({
    Title = 'ESP PLAYERS \u{1f441}\u{fe0f}',
    Icon = 'eye',
    Opened = true,
})
Tabs.Visuals:Toggle({
    Title = 'ESP Players',
    Default = false,
    Callback = function(state)
        ESPEnabled = state

        if ESPEnabled then
            for _, p in ipairs(Players:GetPlayers())do
                setupPlayerESP(p)
            end
        else
            for _, p in ipairs(Players:GetPlayers())do
                removeESP(p)

                if renderConnections[p] then
                    renderConnections[p]:Disconnect()

                    renderConnections[p] = nil
                end
            end
        end
    end,
})
Tabs.Settings:Section({
    Title = 'INVENTORY & UI \u{2699}\u{fe0f}',
    Icon = 'settings',
    Opened = true,
})
Tabs.Settings:Toggle({
    Title = 'Show Extended Inventory',
    Default = false,
    Callback = function(state)
        local gui = LocalPlayer:WaitForChild('PlayerGui'):FindFirstChild('NexusCustomInventory')

        if gui then
            gui.Enabled = state
        end
    end,
})
Tabs.Settings:Toggle({
    Title = 'Enable Edit Mode (Top Panel)',
    Default = false,
    Callback = function(state)
        local gui = LocalPlayer:WaitForChild('PlayerGui'):FindFirstChild('NexusCustomInventory')

        if gui then
            local editPanel = gui:FindFirstChild('EditPanel')

            if editPanel then
                editPanel.Visible = state

                if state then
                    getgenv().RefreshEditPanel()
                end
            end
        end
    end,
})

local PlayerGui = LocalPlayer:WaitForChild('PlayerGui')
local oldGui = PlayerGui:FindFirstChild('NexusCustomInventory')

if oldGui then
    oldGui:Destroy()
end

local CustomInventoryGui = Instance.new('ScreenGui')

CustomInventoryGui.Name = 'NexusCustomInventory'
CustomInventoryGui.ResetOnSpawn = false
CustomInventoryGui.Enabled = false
CustomInventoryGui.IgnoreGuiInset = true
CustomInventoryGui.Parent = PlayerGui

local DraggingTool = nil
local DragGhost = nil
local ActiveInput = nil
local SlotBindings = {}
local AllTargetSlots = {}
local EditPanel = Instance.new('Frame', CustomInventoryGui)

EditPanel.Name = 'EditPanel'
EditPanel.Size = UDim2.new(0, 500, 0, 150)
EditPanel.Position = UDim2.new(0.5, -250, 0.05, 0)
EditPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
EditPanel.BackgroundTransparency = 0.1
EditPanel.Visible = false
Instance.new('UICorner', EditPanel).CornerRadius = UDim.new(0, 10)

local ScrollingEdit = Instance.new('ScrollingFrame', EditPanel)

ScrollingEdit.Size = UDim2.new(1, -20, 1, -20)
ScrollingEdit.Position = UDim2.new(0, 10, 0, 10)
ScrollingEdit.BackgroundTransparency = 1
ScrollingEdit.ScrollBarThickness = 5

local EditLayout = Instance.new('UIGridLayout', ScrollingEdit)

EditLayout.CellSize = UDim2.new(0, 60, 0, 60)
EditLayout.CellPadding = UDim2.new(0, 8, 0, 8)
EditLayout.SortOrder = Enum.SortOrder.Name

local GridContainer = Instance.new('Frame', CustomInventoryGui)

GridContainer.Name = 'GridContainer'
GridContainer.Size = UDim2.new(0, 500, 0, 220)
GridContainer.Position = UDim2.new(0.5, -250, 0.45, 0)
GridContainer.BackgroundTransparency = 1

local GridLayout = Instance.new('UIGridLayout', GridContainer)

GridLayout.CellSize = UDim2.new(0, 60, 0, 60)
GridLayout.CellPadding = UDim2.new(0, 8, 0, 8)
GridLayout.SortOrder = Enum.SortOrder.LayoutOrder

for i = 1, 21 do
    local Slot = Instance.new('TextButton', GridContainer)

    Slot.Name = 'GridSlot_' .. i
    Slot.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    Slot.BackgroundTransparency = 0.6
    Slot.Text = ''
    Instance.new('UICorner', Slot).CornerRadius = UDim.new(0, 8)

    local ToolLabel = Instance.new('TextLabel', Slot)

    ToolLabel.Size = UDim2.new(1, -4, 1, -4)
    ToolLabel.Position = UDim2.new(0, 2, 0, 2)
    ToolLabel.BackgroundTransparency = 1
    ToolLabel.Text = ''
    ToolLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToolLabel.Font = Enum.Font.GothamBold
    ToolLabel.TextSize = 10
    ToolLabel.TextWrapped = true

    table.insert(AllTargetSlots, Slot)
end

getgenv().RefreshEditPanel = function()
    for _, child in ipairs(ScrollingEdit:GetChildren())do
        if child:IsA('TextButton') then
            child:Destroy()
        end
    end

    local char = LocalPlayer.Character
    local backpack = LocalPlayer:FindFirstChild('Backpack')
    local tools = {}

    if backpack then
        for _, t in ipairs(backpack:GetChildren())do
            if t:IsA('Tool') then
                table.insert(tools, t)
            end
        end
    end
    if char then
        for _, t in ipairs(char:GetChildren())do
            if t:IsA('Tool') then
                table.insert(tools, t)
            end
        end
    end

    for _, tool in ipairs(tools)do
        local btn = Instance.new('TextButton', ScrollingEdit)

        btn.Size = UDim2.new(0, 60, 0, 60)
        btn.Text = tool.Name
        btn.TextWrapped = true
        btn.TextSize = 10
        btn.Font = Enum.Font.GothamBold
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Instance.new('UICorner', btn).CornerRadius = UDim.new(0, 6)

        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                DraggingTool = tool
                ActiveInput = input

                if DragGhost then
                    DragGhost:Destroy()
                end

                DragGhost = Instance.new('TextLabel', CustomInventoryGui)
                DragGhost.Size = UDim2.new(0, 60, 0, 60)
                DragGhost.Text = tool.Name
                DragGhost.TextWrapped = true
                DragGhost.TextSize = 10
                DragGhost.Font = Enum.Font.GothamBold
                DragGhost.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
                DragGhost.BackgroundTransparency = 0.3
                DragGhost.TextColor3 = Color3.fromRGB(255, 255, 255)
                Instance.new('UICorner', DragGhost).CornerRadius = UDim.new(0, 8)
                DragGhost.ZIndex = 100
                DragGhost.Position = UDim2.new(0, input.Position.X - 30, 0, input.Position.Y - 30)
            end
        end)
    end

    ScrollingEdit.CanvasSize = UDim2.new(0, 0, 0, math.ceil(#tools / 8) * 70)
end

UserInputService.InputChanged:Connect(function(input)
    if input == ActiveInput and DragGhost then
        DragGhost.Position = UDim2.new(0, input.Position.X - 30, 0, input.Position.Y - 30)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input == ActiveInput and DraggingTool then
        local dropX, dropY = input.Position.X, input.Position.Y

        for _, slot in ipairs(AllTargetSlots)do
            local pos = slot.AbsolutePosition
            local size = slot.AbsoluteSize

            if dropX >= pos.X and dropX <= pos.X + size.X and dropY >= pos.Y and dropY <= pos.Y + size.Y then
                SlotBindings[slot] = DraggingTool

                local label = slot:FindFirstChildOfClass('TextLabel')

                if label then
                    label.Text = DraggingTool.Name
                end

                slot.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                slot.BackgroundTransparency = 0.2

                if slot:FindFirstChild('EquipStroke') then
                    slot.EquipStroke:Destroy()
                end

                local stroke = Instance.new('UIStroke', slot)

                stroke.Name = 'EquipStroke'
                stroke.Color = Color3.fromRGB(255, 140, 0)
                stroke.Thickness = 2

                break
            end
        end

        if DragGhost then
            DragGhost:Destroy()

            DragGhost = nil
        end

        DraggingTool = nil
        ActiveInput = nil
    end
end)

for _, slot in ipairs(AllTargetSlots)do
    slot.Activated:Connect(function()
        if EditPanel.Visible and DraggingTool then
            return
        end

        local targetTool = SlotBindings[slot]

        if targetTool and targetTool.Parent then
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass('Humanoid')

            if hum then
                hum:EquipTool(targetTool)
            end
        end
    end)
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end
    if input.KeyCode.Value >= Enum.KeyCode.One.Value and input.KeyCode.Value <= Enum.KeyCode.Seven.Value then
        local slotIndex = input.KeyCode.Value - Enum.KeyCode.One.Value + 1
        local targetSlot = AllTargetSlots[slotIndex]
        local targetTool = targetSlot and SlotBindings[targetSlot]

        if targetTool and targetTool.Parent then
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass('Humanoid')

            if hum then
                hum:EquipTool(targetTool)
            end
        end
    end
end)
Tabs.Settings:Toggle({
    Title = 'Enable Floating Spam Button',
    Default = false,
    Callback = function(state)
        FloatingButtonGui.Enabled = state
    end,
})
Tabs.Settings:Toggle({
    Title = 'Use Skills Slow',
    Default = false,
    Callback = function(state)
        getgenv().UseOneByOne = state
    end,
})

local WebhookURL = 'https://discord.com/api/webhooks/1529939073324679238/XwTMaLNU9oCKcUR1yT2NGo-oq-tU0R_Sg60hlwz2VAErK54oLTzI1k8OH579mG8YFx8t'
local notifiedBosses = {}

local function SendBossWebhook(bossName)
    if WebhookURL == '' then
        return
    end

    local Players = game:GetService('Players')
    local currentPlayerCount = #Players:GetPlayers()
    local data = {
        content = '```Raid Boss```',
        embeds = {
            {
                title = '\u{26a0}\u{fe0f} A Boss has spawned!',
                color = tonumber(0xff0000),
                fields = {
                    {
                        name = 'Boss Name',
                        value = '```' .. bossName .. '```',
                        inline = false,
                    },
                    {
                        name = 'Server JobId',
                        value = '```' .. game.JobId .. '```',
                        inline = false,
                    },
                    {
                        name = '\u{1f465} Players',
                        value = '```' .. currentPlayerCount .. '/12```',
                        inline = false,
                    },
                    {
                        name = 'Join Script',
                        value = "```lua\ngame:GetService('TeleportService'):TeleportToPlaceInstance(" .. game.PlaceId .. ", '" .. game.JobId .. "', game:GetService('Players').LocalPlayer)\n```",
                        inline = false,
                    },
                },
            },
        },
    }
    local jsonData = HttpService:JSONEncode(data)
    local requestFunc = request or http_request or (syn and syn.request) or (fluxus and fluxus.request)

    if requestFunc then
        pcall(function()
            requestFunc({
                Url = WebhookURL,
                Method = 'POST',
                Headers = {
                    ['Content-Type'] = 'application/json',
                },
                Body = jsonData,
            })
        end)
    else
        warn('[Nexus Hub] Your executor does not support HTTP requests for Webhooks.')
    end
end

Window:SelectTab(1)
Tabs.Visuals:Toggle({
    Title = 'ESP Players',
    Default = false,
    Callback = function(state)
        ESPEnabled = state

        if ESPEnabled then
            for _, p in ipairs(Players:GetPlayers())do
                setupPlayerESP(p)
            end
        else
            for _, p in ipairs(Players:GetPlayers())do
                removeESP(p)

                if renderConnections[p] then
                    renderConnections[p]:Disconnect()

                    renderConnections[p] = nil
                end
            end
        end
    end,
})
Tabs.Settings:Toggle({
    Title = 'Show Extended Inventory',
    Default = false,
    Callback = function(state)
        local gui = LocalPlayer:WaitForChild('PlayerGui'):FindFirstChild('NexusCustomInventory')

        if gui then
            gui.Enabled = state
        end
    end,
})
Tabs.Settings:Toggle({
    Title = 'Enable Edit Mode (Top Panel)',
    Default = false,
    Callback = function(state)
        local gui = LocalPlayer:WaitForChild('PlayerGui'):FindFirstChild('NexusCustomInventory')

        if gui then
            local editPanel = gui:FindFirstChild('EditPanel')

            if editPanel then
                editPanel.Visible = state

                if state then
                    getgenv().RefreshEditPanel()
                end
            end
        end
    end,
})

local PlayerGui = LocalPlayer:WaitForChild('PlayerGui')
local oldGui = PlayerGui:FindFirstChild('NexusCustomInventory')

if oldGui then
    oldGui:Destroy()
end

local CustomInventoryGui = Instance.new('ScreenGui')

CustomInventoryGui.Name = 'NexusCustomInventory'
CustomInventoryGui.ResetOnSpawn = false
CustomInventoryGui.Enabled = false
CustomInventoryGui.IgnoreGuiInset = true
CustomInventoryGui.Parent = PlayerGui

local DraggingTool = nil
local DragGhost = nil
local ActiveInput = nil
local SlotBindings = {}
local AllTargetSlots = {}
local EditPanel = Instance.new('Frame', CustomInventoryGui)

EditPanel.Name = 'EditPanel'
EditPanel.Size = UDim2.new(0, 500, 0, 150)
EditPanel.Position = UDim2.new(0.5, -250, 0.05, 0)
EditPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
EditPanel.BackgroundTransparency = 0.1
EditPanel.Visible = false
Instance.new('UICorner', EditPanel).CornerRadius = UDim.new(0, 10)

local ScrollingEdit = Instance.new('ScrollingFrame', EditPanel)

ScrollingEdit.Size = UDim2.new(1, -20, 1, -20)
ScrollingEdit.Position = UDim2.new(0, 10, 0, 10)
ScrollingEdit.BackgroundTransparency = 1
ScrollingEdit.ScrollBarThickness = 5

local EditLayout = Instance.new('UIGridLayout', ScrollingEdit)

EditLayout.CellSize = UDim2.new(0, 60, 0, 60)
EditLayout.CellPadding = UDim2.new(0, 8, 0, 8)
EditLayout.SortOrder = Enum.SortOrder.Name

local GridContainer = Instance.new('Frame', CustomInventoryGui)

GridContainer.Name = 'GridContainer'
GridContainer.Size = UDim2.new(0, 500, 0, 220)
GridContainer.Position = UDim2.new(0.5, -250, 0.45, 0)
GridContainer.BackgroundTransparency = 1

local GridLayout = Instance.new('UIGridLayout', GridContainer)

GridLayout.CellSize = UDim2.new(0, 60, 0, 60)
GridLayout.CellPadding = UDim2.new(0, 8, 0, 8)
GridLayout.SortOrder = Enum.SortOrder.LayoutOrder

for i = 1, 21 do
    local Slot = Instance.new('TextButton', GridContainer)

    Slot.Name = 'GridSlot_' .. i
    Slot.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    Slot.BackgroundTransparency = 0.6
    Slot.Text = ''
    Instance.new('UICorner', Slot).CornerRadius = UDim.new(0, 8)

    local ToolLabel = Instance.new('TextLabel', Slot)

    ToolLabel.Size = UDim2.new(1, -4, 1, -4)
    ToolLabel.Position = UDim2.new(0, 2, 0, 2)
    ToolLabel.BackgroundTransparency = 1
    ToolLabel.Text = ''
    ToolLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToolLabel.Font = Enum.Font.GothamBold
    ToolLabel.TextSize = 10
    ToolLabel.TextWrapped = true

    table.insert(AllTargetSlots, Slot)
end

getgenv().RefreshEditPanel = function()
    for _, child in ipairs(ScrollingEdit:GetChildren())do
        if child:IsA('TextButton') then
            child:Destroy()
        end
    end

    local char = LocalPlayer.Character
    local backpack = LocalPlayer:FindFirstChild('Backpack')
    local tools = {}

    if backpack then
        for _, t in ipairs(backpack:GetChildren())do
            if t:IsA('Tool') then
                table.insert(tools, t)
            end
        end
    end
    if char then
        for _, t in ipairs(char:GetChildren())do
            if t:IsA('Tool') then
                table.insert(tools, t)
            end
        end
    end

    for _, tool in ipairs(tools)do
        local btn = Instance.new('TextButton', ScrollingEdit)

        btn.Size = UDim2.new(0, 60, 0, 60)
        btn.Text = tool.Name
        btn.TextWrapped = true
        btn.TextSize = 10
        btn.Font = Enum.Font.GothamBold
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Instance.new('UICorner', btn).CornerRadius = UDim.new(0, 6)

        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                DraggingTool = tool
                ActiveInput = input

                if DragGhost then
                    DragGhost:Destroy()
                end

                DragGhost = Instance.new('TextLabel', CustomInventoryGui)
                DragGhost.Size = UDim2.new(0, 60, 0, 60)
                DragGhost.Text = tool.Name
                DragGhost.TextWrapped = true
                DragGhost.TextSize = 10
                DragGhost.Font = Enum.Font.GothamBold
                DragGhost.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
                DragGhost.BackgroundTransparency = 0.3
                DragGhost.TextColor3 = Color3.fromRGB(255, 255, 255)
                Instance.new('UICorner', DragGhost).CornerRadius = UDim.new(0, 8)
                DragGhost.ZIndex = 100
                DragGhost.Position = UDim2.new(0, input.Position.X - 30, 0, input.Position.Y - 30)
            end
        end)
    end

    ScrollingEdit.CanvasSize = UDim2.new(0, 0, 0, math.ceil(#tools / 8) * 70)
end

UserInputService.InputChanged:Connect(function(input)
    if input == ActiveInput and DragGhost then
        DragGhost.Position = UDim2.new(0, input.Position.X - 30, 0, input.Position.Y - 30)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input == ActiveInput and DraggingTool then
        local dropX, dropY = input.Position.X, input.Position.Y

        for _, slot in ipairs(AllTargetSlots)do
            local pos = slot.AbsolutePosition
            local size = slot.AbsoluteSize

            if dropX >= pos.X and dropX <= pos.X + size.X and dropY >= pos.Y and dropY <= pos.Y + size.Y then
                SlotBindings[slot] = DraggingTool

                local label = slot:FindFirstChildOfClass('TextLabel')

                if label then
                    label.Text = DraggingTool.Name
                end

                slot.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                slot.BackgroundTransparency = 0.2

                if slot:FindFirstChild('EquipStroke') then
                    slot.EquipStroke:Destroy()
                end

                local stroke = Instance.new('UIStroke', slot)

                stroke.Name = 'EquipStroke'
                stroke.Color = Color3.fromRGB(255, 140, 0)
                stroke.Thickness = 2

                break
            end
        end

        if DragGhost then
            DragGhost:Destroy()

            DragGhost = nil
        end

        DraggingTool = nil
        ActiveInput = nil
    end
end)

for _, slot in ipairs(AllTargetSlots)do
    slot.Activated:Connect(function()
        if EditPanel.Visible and DraggingTool then
            return
        end

        local targetTool = SlotBindings[slot]

        if targetTool and targetTool.Parent then
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass('Humanoid')

            if hum then
                hum:EquipTool(targetTool)
            end
        end
    end)
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end
    if input.KeyCode.Value >= Enum.KeyCode.One.Value and input.KeyCode.Value <= Enum.KeyCode.Seven.Value then
        local slotIndex = input.KeyCode.Value - Enum.KeyCode.One.Value + 1
        local targetSlot = AllTargetSlots[slotIndex]
        local targetTool = targetSlot and SlotBindings[targetSlot]

        if targetTool and targetTool.Parent then
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass('Humanoid')

            if hum then
                hum:EquipTool(targetTool)
            end
        end
    end
end)
Tabs.Settings:Toggle({
    Title = 'Enable Floating Spam Button',
    Default = false,
    Callback = function(state)
        FloatingButtonGui.Enabled = state
    end,
})
Tabs.Settings:Toggle({
    Title = 'Use Skills Slow',
    Default = false,
    Callback = function(state)
        getgenv().UseOneByOne = state
    end,
})

local WebhookURL = 'https://discord.com/api/webhooks/1529939073324679238/XwTMaLNU9oCKcUR1yT2NGo-oq-tU0R_Sg60hlwz2VAErK54oLTzI1k8OH579mG8YFx8t'
local notifiedBosses = {}

local function SendBossWebhook(bossName)
    if WebhookURL == '' then
        return
    end

    local Players = game:GetService('Players')
    local currentPlayerCount = #Players:GetPlayers()
    local data = {
        content = '```Raid Boss```',
        embeds = {
            {
                title = '\u{26a0}\u{fe0f} A Boss has spawned!',
                color = tonumber(0xff0000),
                fields = {
                    {
                        name = 'Boss Name',
                        value = '```' .. bossName .. '```',
                        inline = false,
                    },
                    {
                        name = 'Server JobId',
                        value = '```' .. game.JobId .. '```',
                        inline = false,
                    },
                    {
                        name = '\u{1f465} Players',
                        value = '```' .. currentPlayerCount .. '/12```',
                        inline = false,
                    },
                    {
                        name = 'Join Script',
                        value = "```lua\ngame:GetService('TeleportService'):TeleportToPlaceInstance(" .. game.PlaceId .. ", '" .. game.JobId .. "', game:GetService('Players').LocalPlayer)\n```",
                        inline = false,
                    },
                },
            },
        },
    }
    local jsonData = HttpService:JSONEncode(data)
    local requestFunc = request or http_request or (syn and syn.request) or (fluxus and fluxus.request)

    if requestFunc then
        pcall(function()
            requestFunc({
                Url = WebhookURL,
                Method = 'POST',
                Headers = {
                    ['Content-Type'] = 'application/json',
                },
                Body = jsonData,
            })
        end)
    else
        warn('[Nexus Hub] Your executor does not support HTTP requests for Webhooks.')
    end
end

Window:SelectTab(1)

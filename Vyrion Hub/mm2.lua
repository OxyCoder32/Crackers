-- ts file was generated at discord.gg/25ms

local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local UserInputService = game:GetService('UserInputService')
local Lighting = game:GetService('Lighting')
local TeleportService = game:GetService('TeleportService')
local HttpService = game:GetService('HttpService')
local RS = game:GetService('ReplicatedStorage')
local TweenService = game:GetService('TweenService')
local VirtualUser = game:FindService('VirtualUser')
local GuiService = game:GetService('GuiService')
local CollectionService = game:GetService('CollectionService')
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local rndSeed = Random.new(tick() * 1e6 % 2147483647)

local function rnd(len)
    local pool = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    local out = {}

    for i = 1, (len or rndSeed:NextInteger(9, 15))do
        out[i] = pool:sub(rndSeed:NextInteger(1, #pool), rndSeed:NextInteger(1, #pool))
    end

    return table.concat(out)
end
local function protect(inst)
    pcall(function()
        if typeof(syn) == 'table' and syn.protect_gui then
            syn.protect_gui(inst)
        elseif typeof(protectgui) == 'function' then
            protectgui(inst)
        end
    end)
end

local mountTarget

do
    local function try(f)
        local ok, v = pcall(f)

        if ok and typeof(v) == 'Instance' then
            return v
        end
    end

    mountTarget = (typeof(gethui) == 'function' and try(gethui)) or try(function()
        local c = game:GetService('CoreGui')
        local probe = Instance.new('Folder')

        probe.Parent = c

        probe:Destroy()

        return c
    end) or try(function()
        return LocalPlayer:FindFirstChildOfClass('PlayerGui')
    end) or LocalPlayer:WaitForChild('PlayerGui', 10)
end

local GENV = (typeof(getgenv) == 'function') and getgenv() or nil

pcall(function()
    if GENV and GENV.DAE_Unload then
        GENV.DAE_Unload()
    end
end)
pcall(function()
    if GENV and type(GENV.DAE_GUIS) == 'table' then
        for _, g in ipairs(GENV.DAE_GUIS)do
            pcall(function()
                g:Destroy()
            end)
        end
    end
end)

for _, g in ipairs(mountTarget:GetChildren())do
    if g.Name == 'Obsidian' or g.Name == 'DAE_ESP' or g.Name == 'DAE_MINI' then
        pcall(function()
            g:Destroy()
        end)
    end
end

local TRACKED = {}

if GENV then
    GENV.DAE_GUIS = TRACKED
end

local function trackGui(inst)
    table.insert(TRACKED, inst)
    protect(inst)

    return inst
end

local WindUI = loadstring(game:HttpGet('https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua'))()
local VYRION_ICON = 'rbxassetid://90450210081651'
local DISCORD_INVITE = 'https://discord.gg/zg4hzhAaW'
local Options = {}
local aimKeyHeld = false
local Window
local unloadHandler
local Library = {Unloaded = false}

function Library:Notify(data)
    local title = data and data.Title or 'Vyrion Hub'
    local content = data and (data.Content or data.Description) or ''
    local duration = data and (data.Duration or data.Time) or 3

    pcall(function()
        WindUI:Notify({
            Title = title,
            Content = content,
            Duration = duration,
        })
    end)
end
function Library:Unload()
    if Library.Unloaded then
        return
    end

    Library.Unloaded = true

    if unloadHandler then
        pcall(unloadHandler)
    end

    pcall(function()
        if Window then
            Window:Destroy()
        end
    end)
end

local function create(class, props, children)
    local o = Instance.new(class)

    for k, v in pairs(props or {})do
        o[k] = v
    end
    for _, c in ipairs(children or {})do
        c.Parent = o
    end

    return o
end
local function hideWindow()
    pcall(function()
        if Library.ScreenGui then
            Library.ScreenGui.Name = rnd()

            trackGui(Library.ScreenGui)
        end
    end)
end

local flags = {
    knifeWalls = false,
    instantKnife = false,
    killAll = false,
    aimbot = false,
    aimbotTarget = 'Head',
    silentAim = false,
    aimFov = 120,
    showFov = false,
    gunWalls = false,
    triggerBot = false,
    autoGun = false,
    gunEsp = false,
    gunEspDist = false,
    espBox = false,
    espChams = false,
    espFill = false,
    espNames = false,
    espRoleTags = false,
    espSkeleton = false,
    killFeed = false,
    coinEsp = false,
    fullbright = false,
    performanceMode = false,
    murdererNotify = false,
    autoFlingMurderer = false,
    autoFlingSheriff = false,
    antiFling = false,
    antiAfk = false,
    miniSquare = true,
    showBindNote = false,
    spawnedItems = {},
}
local COLLECT_SPEED = 16
local aimFov = 120
local flinging = false
local Mono = {
    tpAt = -10,
    TP_GRACE = 2.5,
    MAX_LEAD = 14,
    MAX_VLEAD = 1.5,
    VEL_SAMPLE = 0.06,
    VEL_SMOOTH = 0.55,
    MIN_DAMP = 0.35,
    velHist = setmetatable({}, {
        __mode = 'k',
    }),
    FLING_POWER = 99999,
    FLING_SECONDS = 2.5,
    FLING_STEP = 3,
    COIN_MAX_DIST = 250,
    lastVel = setmetatable({}, {
        __mode = 'k',
    }),
    tagOwners = {},
    guiN = 0,
    guiT = 0,
}

function Mono.teleporting()
    return os.clock() - Mono.tpAt < Mono.TP_GRACE
end
function Mono.markTeleport()
    Mono.tpAt = os.clock()
end

local instantFiredAt = -10
local unstick
local MiniBtnRef
local conns = {}

local function bind(sig, fn)
    local c = sig:Connect(fn)

    table.insert(conns, c)

    return c
end
local function notify(msg, t)
    Library:Notify({
        Title = 'Vyrion Hub | MM2',
        Description = msg,
        Time = t or 3,
    })
end
local function mousePos()
    local m = UserInputService:GetMouseLocation()
    local ins = GuiService:GetGuiInset()

    return Vector2.new(m.X - ins.X, m.Y - ins.Y)
end

local MM2_PLACE = 142823291
local MM2_UNIVERSE = 66654135
local CONFIG_FOLDER = 'DaesMM2'
local hopFallbackPlace

local function fetchServers(placeId, maxPages)
    local out, cursor = {}, nil

    for _ = 1, (maxPages or 4)do
        local url = 'https://games.roblox.com/v1/games/' .. placeId .. '/servers/Public?sortOrder=Desc&limit=100'

        if cursor then
            url = url .. '&cursor=' .. HttpService:UrlEncode(cursor)
        end

        local ok, res = pcall(function()
            return game:HttpGet(url)
        end)

        if not ok then
            break
        end

        local ok2, d = pcall(function()
            return HttpService:JSONDecode(res)
        end)

        if not (ok2 and d and d.data) then
            break
        end

        for _, sv in ipairs(d.data)do
            out[#out + 1] = sv
        end

        cursor = d.nextPageCursor

        if not cursor then
            break
        end
    end

    return out
end
local function hopServers(placeId, excludeJob, fallbackTeleport)
    task.spawn(function()
        local all = fetchServers(placeId, 4)
        local room, any = {}, {}

        for _, sv in ipairs(all)do
            if sv.id and sv.id ~= excludeJob then
                any[#any + 1] = sv

                if (sv.playing or 0) < (sv.maxPlayers or 0) then
                    room[#room + 1] = sv
                end
            end
        end

        local pick

        if #room > 0 then
            table.sort(room, function(a, b)
                return (a.playing or 0) > (b.playing or 0)
            end)

            pick = room[math.random(1, math.min(#room, 5))]
        elseif #any > 0 then
            pick = any[math.random(1, #any)]
        end
        if pick then
            hopFallbackPlace = placeId

            local ok = pcall(function()
                TeleportService:TeleportToPlaceInstance(placeId, pick.id, LocalPlayer)
            end)

            if ok then
                return
            end
        end

        hopFallbackPlace = nil

        notify('Letting Roblox pick a server...')
        pcall(function()
            TeleportService:Teleport(placeId, LocalPlayer)
        end)
    end)
end
local function rejoin()
    notify('Rejoining...')
    pcall(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end)
end
local function serverHop()
    notify('Finding a server...')
    hopServers(game.PlaceId, game.JobId, true)
end
local function joinMM2()
    notify('Joining Murder Mystery 2...')
    hopServers(MM2_PLACE, nil, true)
end
local function applySavedTheme() end

if game.GameId ~= MM2_UNIVERSE then
    local WrongWindow = WindUI:CreateWindow({
        Title = 'Vyrion Hub | MM2',
        Author = 'VyrionStudios',
        Folder = CONFIG_FOLDER,
        Icon = VYRION_ICON,
        IconThemed = false,
        Theme = 'Vyrion Silver',
        OpenButton = {
            Title = 'Open Vyrion Hub',
            Icon = VYRION_ICON,
            IconThemed = false,
            Enabled = true,
            Draggable = true,
            Scale = 0.55,
            Color = ColorSequence.new(Color3.fromRGB(185, 185, 185), Color3.fromRGB(95, 95, 95)),
        },
    })

    pcall(function()
        WrongWindow:Dialog({
            Title = 'Unsupported Game',
            Content = "Dae's MM2 only supports Murder Mystery 2.",
            Buttons = {
                {
                    Title = 'Close',
                    Variant = 'Secondary',
                    Callback = function()
                        WrongWindow:Destroy()
                    end,
                },
                {
                    Title = 'Join MM2',
                    Variant = 'Primary',
                    Callback = function()
                        joinMM2()
                    end,
                },
            },
        })
    end)
    pcall(function()
        if GENV then
            GENV.DAE_Unload = function()
                pcall(function()
                    WrongWindow:Destroy()
                end)
            end
        end
    end)

    return
end

local EspGui = trackGui(create('ScreenGui', {
    Name = rnd(),
    ResetOnSpawn = false,
    IgnoreGuiInset = false,
    DisplayOrder = 998,
    Parent = mountTarget,
}))

do
    local lineMT = {}

    local function apply(t)
        local f = rawget(t, '_f')

        if not (f and f.Parent) then
            return
        end

        local a, b = rawget(t, '_From'), rawget(t, '_To')

        if not (a and b) then
            return
        end

        local d = b - a

        f.Position = UDim2.fromOffset((a.X + b.X) * 0.5, (a.Y + b.Y) * 0.5)
        f.Size = UDim2.fromOffset(math.max(d.Magnitude, 1), math.max(rawget(t, '_Thickness') or 1, 1))
        f.Rotation = math.deg(math.atan2(d.Y, d.X))
    end
    local function remove(t)
        local f = rawget(t, '_f')

        if f then
            pcall(function()
                f:Destroy()
            end)
        end
    end

    lineMT.__index = function(t, k)
        if k == 'Remove' then
            return remove
        end

        return rawget(t, '_' .. k)
    end
    lineMT.__newindex = function(t, k, v)
        rawset(t, '_' .. k, v)

        local f = rawget(t, '_f')

        if not (f and f.Parent) then
            return
        end
        if k == 'Visible' then
            f.Visible = (v == true)
        elseif k == 'Color' then
            f.BackgroundColor3 = v
        elseif k == 'Transparency' then
            f.BackgroundTransparency = 1 - (tonumber(v) or 1)
        elseif k == 'From' or k == 'To' or k == 'Thickness' then
            apply(t)
        end
    end
    Mono.hasDrawing = (typeof(Drawing) == 'table') and (pcall(function()
        local probe = Drawing.new('Line')

        probe:Remove()
    end))

    function Mono.newLine(thickness)
        if Mono.hasDrawing then
            local l = Drawing.new('Line')

            l.Thickness = thickness
            l.Transparency = 1
            l.Visible = false

            return l
        end

        local t = setmetatable({}, lineMT)

        rawset(t, '_f', create('Frame', {
            Name = rnd(),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.new(1, 1, 1),
            Visible = false,
            ZIndex = 3,
            Parent = EspGui,
        }))
        rawset(t, '_Thickness', thickness)
        rawset(t, '_Visible', false)

        return t
    end
end

local CRC

pcall(function()
    CRC = require(RS:WaitForChild('Modules'):WaitForChild('CurrentRoundClient'))
end)

local function roundData(plr)
    return CRC and CRC.PlayerData and CRC.PlayerData[plr.Name]
end
local function getHRP(ch)
    return ch and ch:FindFirstChild('HumanoidRootPart')
end
local function charHasWeapon(ch, kind)
    for _, t in ipairs(ch:GetChildren())do
        if t:IsA('Tool') then
            if kind == 'Gun' and (t.Name == 'Gun' or t:FindFirstChild('Shoot')) then
                return true
            end
            if kind == 'Knife' and (t.Name == 'Knife' or t:FindFirstChild('Events')) then
                return true
            end
        end
    end

    return false
end

function Mono.refreshTags()
    for _, tag in ipairs({
        'Weapon_Gun',
        'Weapon_Knife',
    })do
        local m = Mono.tagOwners[tag]

        if m then
            table.clear(m)
        else
            m = {}
            Mono.tagOwners[tag] = m
        end

        for _, t in ipairs(CollectionService:GetTagged(tag))do
            local par = t.Parent

            if par then
                m[par] = true
            end
        end
    end
end

Mono.refreshTags()

local function playerHasTagged(plr, tag)
    local m = Mono.tagOwners[tag]

    if not m then
        return false
    end

    local ch = plr.Character

    if ch and m[ch] then
        return true
    end

    local bp = plr:FindFirstChildOfClass('Backpack')

    if bp and m[bp] then
        return true
    end

    return false
end
local function computeRole(plr)
    local d = roundData(plr)
    local r = d and d.Role

    if r == 'Murderer' then
        return 'Murderer'
    end
    if r == 'Sheriff' or r == 'Hero' then
        return r
    end

    local ch = plr.Character

    if playerHasTagged(plr, 'Weapon_Gun') or (ch and charHasWeapon(ch, 'Gun')) then
        return 'Hero'
    end
    if playerHasTagged(plr, 'Weapon_Knife') or (ch and charHasWeapon(ch, 'Knife')) then
        return 'Murderer'
    end

    return r or 'Innocent'
end
local function computeAlive(plr)
    local d = roundData(plr)

    if d and d.Dead == true then
        return false
    end

    local ch = plr.Character
    local hum = ch and ch:FindFirstChildOfClass('Humanoid')

    return ch and hum and hum.Health > 0 and getHRP(ch)
end

local CACHE_TTL = 0.05
local roleCache, aliveCache, cacheStamp = {}, {}, 0

local function sweepCaches()
    local now = os.clock()

    if now - cacheStamp > CACHE_TTL then
        table.clear(roleCache)
        table.clear(aliveCache)

        cacheStamp = now

        Mono.refreshTags()
    end
end
local function roleOf(plr)
    sweepCaches()

    local v = roleCache[plr]

    if v == nil then
        v = computeRole(plr)
        roleCache[plr] = v
    end

    return v
end
local function alive(plr)
    sweepCaches()

    local v = aliveCache[plr]

    if v == nil then
        v = computeAlive(plr) or false
        aliveCache[plr] = v
    end

    return v
end
local function myRole()
    return roleOf(LocalPlayer)
end
local function isGunRole(role)
    return role == 'Sheriff' or role == 'Hero'
end
local function isEnemyOf(myrole, role)
    if myrole == 'Murderer' then
        return true
    end
    if isGunRole(myrole) then
        return role == 'Murderer'
    end

    return false
end
local function findMurderer()
    for _, p in ipairs(Players:GetPlayers())do
        if roleOf(p) == 'Murderer' then
            return p
        end
    end
end
local function findWeapon(n)
    local ch = LocalPlayer.Character
    local bp = LocalPlayer:FindFirstChildOfClass('Backpack')

    return (ch and ch:FindFirstChild(n)) or (bp and bp:FindFirstChild(n))
end
local function equip(tool)
    local ch = LocalPlayer.Character
    local hum = ch and ch:FindFirstChildOfClass('Humanoid')

    if tool and hum and tool.Parent ~= ch then
        pcall(function()
            hum:EquipTool(tool)
        end)
    end
end

local Stats = game:GetService('Stats')

local function netPing()
    local ok, v = pcall(function()
        return Stats.Network.ServerStatsItem['Data Ping']:GetValue() / 1000
    end)

    if ok and type(v) == 'number' and v > 0 and v < 1 then
        return v
    end

    return 0.12
end

local PREDICT_MIN_SPEED = 1

local function aimPos(plr, noPredict)
    local ch = plr and plr.Character
    local hrp = ch and getHRP(ch)

    if not hrp then
        return
    end

    local base = hrp.Position

    if noPredict then
        return base
    end

    local now = os.clock()
    local s = Mono.velHist[plr]

    if not s or s.ch ~= ch then
        s = {
            ch = ch,
            p = base,
            t = now,
            v = hrp.AssemblyLinearVelocity,
            dir = nil,
        }
        Mono.velHist[plr] = s
    end

    local dt = now - s.t

    if dt >= Mono.VEL_SAMPLE then
        s.v = s.v:Lerp((base - s.p) / dt, Mono.VEL_SMOOTH)
        s.p, s.t = base, now
    end

    local vel = s.v
    local flat = Vector3.new(vel.X, 0, vel.Z)

    if flat.Magnitude < PREDICT_MIN_SPEED then
        return base
    end

    local t = netPing()
    local lead = flat * t
    local dir = flat.Unit

    if s.dir then
        lead = lead * math.clamp((s.dir:Dot(dir) + 1) * 0.5, Mono.MIN_DAMP, 1)
    end

    s.dir = dir

    local hum = ch:FindFirstChildOfClass('Humanoid')

    if hum and hum.FloorMaterial == Enum.Material.Air then
        local dy = hrp.AssemblyLinearVelocity.Y * t * 0.5

        lead = lead + Vector3.new(0, math.clamp(dy, -Mono.MAX_VLEAD, Mono.MAX_VLEAD), 0)
    end
    if lead.Magnitude > Mono.MAX_LEAD then
        lead = lead.Unit * Mono.MAX_LEAD
    end

    return base + lead
end

function Mono.aimPointFor(p)
    local ch = p and p.Character
    local hrp = ch and getHRP(ch)

    if not hrp then
        return
    end

    local part = ch:FindFirstChild('UpperTorso') or ch:FindFirstChild('Torso') or hrp
    local pred = aimPos(p)

    return pred and (pred + (part.Position - hrp.Position)) or part.Position
end

local KNIFE_PARTS = {
    'HumanoidRootPart',
    'UpperTorso',
    'LowerTorso',
    'Torso',
    'Head',
}

local function knifeKill(ev, targetChar)
    if not (ev and targetChar) then
        return
    end

    local ht = ev:FindFirstChild('HandleTouched')
    local ks = ev:FindFirstChild('KnifeStabbed')

    if not ht then
        return
    end

    for _, pn in ipairs(KNIFE_PARTS)do
        local part = targetChar:FindFirstChild(pn)

        if part then
            ht:FireServer(part)
        end
    end

    if ks then
        ks:FireServer()
    end
end
local function shootGunAt(pos, throughWalls)
    if not pos then
        return
    end

    local gun = findWeapon('Gun')

    if not gun then
        return
    end

    equip(gun)

    local shoot = gun:FindFirstChild('Shoot')

    if not shoot then
        return
    end

    local myhrp = getHRP(LocalPlayer.Character)

    if not myhrp then
        return
    end

    local origin

    if throughWalls then
        local dir = (pos - myhrp.Position)

        dir = dir.Magnitude > 0.1 and dir.Unit or myhrp.CFrame.LookVector
        origin = CFrame.new(pos - dir * 2, pos)
    else
        local att = myhrp:FindFirstChild('GunRaycastAttachment')

        origin = (att and att.WorldCFrame) or CFrame.new(myhrp.Position, pos)
    end

    shoot:FireServer(origin, CFrame.new(pos))
end
local function aimAt(target, role, throughWalls)
    if role == 'Murderer' then
        local knife = findWeapon('Knife')

        if not knife then
            return 0
        end

        equip(knife)
        knifeKill(knife:FindFirstChild('Events'), target.Character)

        return 0.1
    elseif isGunRole(role) then
        shootGunAt(Mono.aimPointFor(target), throughWalls == true)

        return 0.15
    end

    return 0
end

local losParams = RaycastParams.new()

losParams.FilterType = Enum.RaycastFilterType.Exclude

local function hasLineOfSight(ch)
    local myCh = LocalPlayer.Character
    local myHrp = getHRP(myCh)
    local tHrp = getHRP(ch)

    if not (myHrp and tHrp) then
        return false
    end

    losParams.FilterDescendantsInstances = {myCh, ch}

    local dir = tHrp.Position - myHrp.Position

    if dir.Magnitude < 0.1 then
        return true
    end

    return workspace:Raycast(myHrp.Position, dir, losParams) == nil
end
local function enemies()
    local role = myRole()
    local list = {}

    if isGunRole(role) then
        local m = findMurderer()

        if m and alive(m) then
            table.insert(list, m)
        end
    else
        for _, p in ipairs(Players:GetPlayers())do
            if p ~= LocalPlayer and alive(p) then
                table.insert(list, p)
            end
        end
    end

    return list, role
end
local function nearest(list)
    local hrp = getHRP(LocalPlayer.Character)

    if not hrp then
        return
    end

    local best, bd

    for _, p in ipairs(list)do
        local h = getHRP(p.Character)

        if h then
            local d = (h.Position - hrp.Position).Magnitude

            if not bd or d < bd then
                bd, best = d, p
            end
        end
    end

    return best
end
local function fovTarget()
    local mr = myRole()

    if not (mr == 'Murderer' or isGunRole(mr)) then
        return nil
    end

    local center = mousePos()
    local best, bd

    for _, p in ipairs(Players:GetPlayers())do
        if p ~= LocalPlayer and alive(p) and isEnemyOf(mr, roleOf(p)) then
            local hrp = getHRP(p.Character)

            if hrp then
                local v, on = Camera:WorldToViewportPoint(hrp.Position)

                if on and v.Z > 0 then
                    local d = (Vector2.new(v.X, v.Y) - center).Magnitude

                    if d <= aimFov and (not bd or d < bd) then
                        bd, best = d, p
                    end
                end
            end
        end
    end

    return best
end

task.spawn(function()
    while not Library.Unloaded do
        local okLoop, errLoop = pcall(function()
            if flags.killAll then
                local list, role = enemies()

                if role == 'Murderer' then
                    local knife = findWeapon('Knife')
                    local ev = knife and knife:FindFirstChild('Events')

                    if ev then
                        equip(knife)

                        for _, tgt in ipairs(list)do
                            if not flags.killAll then
                                break
                            end

                            knifeKill(ev, tgt.Character)
                        end
                    end

                    task.wait(0.05)
                elseif isGunRole(role) then
                    local tgt = nearest(list)

                    if tgt and flags.killAll then
                        shootGunAt(Mono.aimPointFor(tgt), flags.gunWalls == true)
                    end

                    task.wait(0.06)
                else
                    task.wait(0.1)
                end
            else
                task.wait(0.08)
            end
        end)

        if not okLoop then
            warn('[DAE] kill all: ' .. tostring(errLoop))
            task.wait(0.25)
        end
    end
end)
task.spawn(function()
    local last = 0

    while not Library.Unloaded do
        if flags.triggerBot then
            local role = myRole()

            if isGunRole(role) then
                local t = fovTarget()
                local walls = flags.gunWalls

                if t and os.clock() - last > 0.15 and (walls or hasLineOfSight(t.Character)) then
                    last = os.clock()

                    aimAt(t, role, walls)
                end
            end
        end

        task.wait(0.03)
    end
end)

local FovCircle = create('Frame', {
    Name = rnd(),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(240, 240),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Visible = false,
    Parent = EspGui,
}, {
    create('UICorner', {
        CornerRadius = UDim.new(1, 0),
    }),
    create('UIStroke', {
        Color = Color3.fromRGB(255, 255, 255),
        Thickness = 1.5,
        Transparency = 0.25,
    }),
})

bind(RunService.RenderStepped, function()
    if flags.showFov and (flags.aimbot or flags.silentAim or flags.triggerBot) then
        FovCircle.Visible = true
        FovCircle.Size = UDim2.fromOffset(aimFov * 2, aimFov * 2)

        local mp = mousePos()

        FovCircle.Position = UDim2.fromOffset(mp.X, mp.Y)
    else
        FovCircle.Visible = false
    end
    if flags.aimbot and Options.AimKey and Options.AimKey:GetState() then
        local t = fovTarget()

        if t then
            local th = t.Character:FindFirstChild('Head') or getHRP(t.Character)

            if th then
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, th.Position), 0.45)
            end
        end
    end
end)

local silentAimPos

local function crosshairEnemyPos(radius)
    local mr = myRole()

    if not (mr == 'Murderer' or isGunRole(mr)) then
        return nil
    end

    local center = mousePos()
    local best, bd

    for _, p in ipairs(Players:GetPlayers())do
        if p ~= LocalPlayer and alive(p) and isEnemyOf(mr, roleOf(p)) then
            local ch = p.Character
            local hrp = getHRP(ch)

            if hrp then
                local sp = Camera:WorldToViewportPoint(hrp.Position)

                if sp.Z > 0 then
                    local d = (Vector2.new(sp.X, sp.Y) - center).Magnitude

                    if d <= radius and (not bd or d < bd) then
                        bd = d
                        best = Mono.aimPointFor(p)
                    end
                end
            end
        end
    end

    return best
end
local function crosshairAnyPlayerPos(radius)
    local center = mousePos()
    local best, bd

    for _, p in ipairs(Players:GetPlayers())do
        if p ~= LocalPlayer and alive(p) then
            local ch = p.Character
            local hrp = getHRP(ch)

            if hrp then
                local sp = Camera:WorldToViewportPoint(hrp.Position)

                if sp.Z > 0 then
                    local d = (Vector2.new(sp.X, sp.Y) - center).Magnitude

                    if d <= radius and (not bd or d < bd) then
                        bd = d
                        best = Mono.aimPointFor(p)
                    end
                end
            end
        end
    end

    return best
end
local function computeSilentTarget()
    local mr = myRole()

    if mr == 'Murderer' then
        return crosshairAnyPlayerPos(aimFov)
    end
    if isGunRole(mr) then
        return crosshairEnemyPos(aimFov)
    end

    return nil
end
local function aimRay()
    local m = UserInputService:GetMouseLocation()
    local x, y = m.X, m.Y
    local ml = LocalPlayer.PlayerScripts and LocalPlayer.PlayerScripts:FindFirstChild('MouseLock')

    if ml and ml:GetAttribute('Enabled') == true and UserInputService.PreferredInput ~= Enum.PreferredInput.Gamepad then
        local vs = Camera.ViewportSize

        x, y = vs.X / 2, vs.Y / 2
    end

    return Camera:ViewportPointToRay(x, y)
end
local function wallAimPos()
    local ray = aimRay()
    local origin, dir = ray.Origin, ray.Direction.Unit
    local far = origin + dir * 300
    local chars = {}

    for _, p in ipairs(Players:GetPlayers())do
        if p ~= LocalPlayer and alive(p) and p.Character then
            chars[#chars + 1] = p.Character
        end
    end

    if #chars == 0 then
        return nil, far
    end

    local params = RaycastParams.new()

    params.FilterType = Enum.RaycastFilterType.Include
    params.FilterDescendantsInstances = chars

    local hit = workspace:Raycast(origin, dir * 300, params)

    return (hit and hit.Position or nil), far
end

local wallSnapPos, wallFarPos, myHrpPos

bind(RunService.Heartbeat, function()
    silentAimPos = flags.silentAim and computeSilentTarget() or nil

    if flags.knifeWalls or flags.gunWalls then
        wallSnapPos, wallFarPos = wallAimPos()
    else
        wallSnapPos, wallFarPos = nil, nil
    end

    local h = getHRP(LocalPlayer.Character)

    myHrpPos = h and h.Position or nil
end)

Mono.hookOk = pcall(function()
    if typeof(hookmetamethod) ~= 'function' or typeof(newcclosure) ~= 'function' or typeof(checkcaller) ~= 'function' or typeof(getnamecallmethod) ~= 'function' then
        error('executor has no __namecall hooking')
    end

    local oldNamecall

    oldNamecall = hookmetamethod(game, '__namecall', newcclosure(function(self, ...)
        if not checkcaller() and getnamecallmethod() == 'FireServer' then
            local nm = self.Name

            if nm == 'Shoot' or nm == 'KnifeThrown' then
                local walls = (nm == 'Shoot' and flags.gunWalls) or (nm == 'KnifeThrown' and flags.knifeWalls)

                if nm == 'KnifeThrown' and flags.instantKnife and os.clock() - instantFiredAt < 0.6 then
                    return
                end

                local silent = flags.silentAim and silentAimPos
                local wallTarget

                if walls then
                    if nm == 'Shoot' then
                        wallTarget = wallSnapPos
                    else
                        wallTarget = wallSnapPos or wallFarPos
                    end
                end

                local retarget = (silent and silentAimPos) or wallTarget or nil

                if retarget then
                    local n = select('#', ...)

                    if n >= 2 then
                        local a = {...}

                        if typeof(a[2]) == 'CFrame' then
                            if retarget then
                                a[2] = CFrame.new(retarget)
                            end
                            if walls and retarget and myHrpPos and typeof(a[1]) == 'CFrame' then
                                local tp = a[2].Position
                                local d = tp - myHrpPos

                                d = (d.Magnitude > 0.1) and d.Unit or Vector3.new(0, 0, -1)
                                a[1] = CFrame.new(tp - d * 2, tp)
                            end

                            return oldNamecall(self, table.unpack(a, 1, n))
                        end
                    end
                end
            end
        end

        return oldNamecall(self, ...)
    end))
end)

if not Mono.hookOk then
    Mono.softAimAt = -10

    bind(UserInputService.InputBegan, function(input, gpe)
        if gpe or not flags.silentAim then
            return
        end
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
            return
        end
        if os.clock() - Mono.softAimAt < 0.35 then
            return
        end

        local mr = myRole()

        if not isGunRole(mr) then
            return
        end

        local pos = silentAimPos or computeSilentTarget()

        if not pos then
            return
        end

        Mono.softAimAt = os.clock()

        shootGunAt(pos, flags.gunWalls == true)
    end)
end

local WeaponService

pcall(function()
    WeaponService = require(RS:WaitForChild('ClientServices'):WaitForChild('WeaponService'))
end)

local function gameAimCFrame()
    if WeaponService then
        local ok, cf = pcall(function()
            return WeaponService:GetMouseTargetCFrame()
        end)

        if ok and typeof(cf) == 'CFrame' then
            return cf
        end
    end

    local ray = aimRay()

    return CFrame.new(ray.Origin + ray.Direction.Unit * 300)
end
local function throwKnifeNow(ignoreCooldown)
    local ch = LocalPlayer.Character

    if not ch then
        return false
    end

    local knife = ch:FindFirstChild('Knife')

    if not knife then
        local bp = LocalPlayer:FindFirstChild('Backpack')
        local stowed = bp and bp:FindFirstChild('Knife')

        if stowed then
            local hum = ch:FindFirstChildOfClass('Humanoid')

            if hum then
                pcall(function()
                    hum:EquipTool(stowed)
                end)
            end

            knife = ch:FindFirstChild('Knife') or stowed
        end
    end
    if not knife then
        return false
    end

    local ev = knife:FindFirstChild('Events')
    local thrown = ev and ev:FindFirstChild('KnifeThrown')

    if not thrown then
        return false
    end
    if knife:GetAttribute('Disabled') == true then
        return false
    end
    if not ignoreCooldown then
        local cd = 1.05 * (tonumber(knife:GetAttribute('ThrowSpeed')) or 1)

        if os.clock() - instantFiredAt < cd then
            return false
        end
    end

    local target = silentAimPos

    if not target then
        if flags.knifeWalls then
            local snap, far = wallAimPos()

            target = snap or far
        else
            target = gameAimCFrame().Position
        end
    end
    if not target then
        return false
    end

    local hrp = getHRP(ch)

    if not hrp then
        return false
    end

    local d = target - hrp.Position

    d = (d.Magnitude > 0.1) and d.Unit or Vector3.new(0, 0, -1)
    instantFiredAt = os.clock()

    thrown:FireServer(CFrame.new(target - d * 2, target), CFrame.new(target))

    return true
end

bind(UserInputService.InputBegan, function(input, gpe)
    if gpe then
        return
    end
    if input.UserInputType ~= Enum.UserInputType.MouseButton2 then
        return
    end
    if flags.instantKnife then
        throwKnifeNow(false)
    end
end)
task.spawn(function()
    local ok, act = pcall(function()
        local ic = LocalPlayer:WaitForChild('PlayerGui', 10):WaitForChild('InputContext', 10)

        return ic:WaitForChild('GameplayContext', 10):WaitForChild('Throw', 10)
    end)

    if ok and act then
        pcall(function()
            bind(act.Pressed, function()
                if flags.instantKnife then
                    throwKnifeNow(false)
                end
            end)
        end)
    end
end)

local function flingPlayer(p, keepPos)
    if flinging then
        return false
    end

    local myCh = LocalPlayer.Character
    local myHrp = getHRP(myCh)
    local hum = myCh and myCh:FindFirstChildOfClass('Humanoid')
    local tHrp = p and p.Character and getHRP(p.Character)

    if not (myHrp and hum and tHrp) then
        return false
    end

    flinging = true

    local back = keepPos or myHrp.CFrame
    local restore = {}

    for _, pp in ipairs(myCh:GetDescendants())do
        if pp:IsA('BasePart') then
            restore[pp] = {
                pp.CustomPhysicalProperties,
                pp.Massless,
                pp.CanCollide,
            }
            pp.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5)
            pp.Massless = true
            pp.CanCollide = false
            pp.AssemblyLinearVelocity = Vector3.zero
        end
    end

    local bav = Instance.new('BodyAngularVelocity')

    bav.Name = rnd()
    bav.AngularVelocity = Vector3.new(0, Mono.FLING_POWER, 0)
    bav.MaxTorque = Vector3.new(0, math.huge, 0)
    bav.P = math.huge
    bav.Parent = myHrp

    local t0 = os.clock()
    local spinning, phaseAt = true, os.clock()

    while os.clock() - t0 < Mono.FLING_SECONDS do
        if Mono.teleporting() then
            break
        end

        local h = getHRP(LocalPlayer.Character)
        local t = p.Character and getHRP(p.Character)

        if not (h and t and bav.Parent) then
            break
        end

        local now = os.clock()

        if spinning and now - phaseAt >= 0.2 then
            bav.AngularVelocity = Vector3.zero
            spinning = false
            phaseAt = now
        elseif (not spinning) and now - phaseAt >= 0.1 then
            bav.AngularVelocity = Vector3.new(0, Mono.FLING_POWER, 0)
            spinning = true
            phaseAt = now
        end

        local aim = t.Position + t.AssemblyLinearVelocity * netPing()
        local off = aim - h.Position
        local dist = off.Magnitude

        if dist > 0.05 then
            h.CFrame = CFrame.new(h.Position + off.Unit * math.min(dist, Mono.FLING_STEP))
        end

        RunService.Stepped:Wait()
    end

    if bav and bav.Parent then
        bav:Destroy()
    end

    for pp, v in pairs(restore)do
        if pp and pp.Parent then
            pp.CustomPhysicalProperties = v[1]
            pp.Massless = v[2]
            pp.CanCollide = v[3]
            pp.AssemblyLinearVelocity = Vector3.zero
            pp.AssemblyAngularVelocity = Vector3.zero
        end
    end

    local home = CFrame.new(back.Position + Vector3.new(0, 4, 0))

    for _ = 1, 6 do
        local ch2 = LocalPlayer.Character

        if not ch2 then
            break
        end

        for _, pp in ipairs(getCharParts(ch2))do
            if pp.Parent then
                pp.AssemblyLinearVelocity = Vector3.zero
                pp.AssemblyAngularVelocity = Vector3.zero
            end
        end

        RunService.Heartbeat:Wait()
    end

    local h2 = getHRP(LocalPlayer.Character)

    if h2 then
        h2.CFrame = home
        h2.AssemblyLinearVelocity = Vector3.zero
        h2.AssemblyAngularVelocity = Vector3.zero
    end

    local watch = os.clock()

    while os.clock() - watch < 2.5 do
        RunService.Heartbeat:Wait()

        if Mono.teleporting() then
            break
        end

        local h3 = getHRP(LocalPlayer.Character)

        if not h3 then
            break
        end

        local lv = h3.AssemblyLinearVelocity

        if lv.Magnitude > 140 or h3.AssemblyAngularVelocity.Magnitude > 40 or (h3.Position - home.Position).Magnitude > 25 then
            h3.AssemblyLinearVelocity = Vector3.zero
            h3.AssemblyAngularVelocity = Vector3.zero
            h3.CFrame = home
        end
    end

    flinging = false

    return true
end
local function flingAll()
    local myHrp = getHRP(LocalPlayer.Character)

    if not myHrp then
        notify('You have no character')

        return
    end

    local home = myHrp.CFrame

    task.spawn(function()
        local n = 0

        for _, p in ipairs(Players:GetPlayers())do
            if p ~= LocalPlayer and p.Character and getHRP(p.Character) and alive(p) then
                if flingPlayer(p, home) then
                    n = n + 1
                end

                task.wait(0.1)
            end
        end

        local h = getHRP(LocalPlayer.Character)

        if h then
            h.CFrame = home
            h.AssemblyLinearVelocity = Vector3.zero
        end

        notify('Flung ' .. n .. ' player' .. (n == 1 and '' or 's'))
    end)
end

task.spawn(function()
    while not Library.Unloaded do
        if (flags.autoFlingMurderer or flags.autoFlingSheriff) and alive(LocalPlayer) and not flinging and not Mono.teleporting() then
            local want

            for _, p in ipairs(Players:GetPlayers())do
                if p ~= LocalPlayer and alive(p) and p.Character and getHRP(p.Character) then
                    local r = roleOf(p)

                    if (flags.autoFlingMurderer and r == 'Murderer') or (flags.autoFlingSheriff and isGunRole(r)) then
                        want = p

                        break
                    end
                end
            end

            if want then
                flingPlayer(want)
            end
        end

        task.wait(0.5)
    end
end)

local function resolvePlayer(v)
    if typeof(v) == 'Instance' and v:IsA('Player') then
        return v
    end
    if type(v) == 'table' then
        for k, on in pairs(v)do
            local cand = (on == true) and k or on

            if typeof(cand) == 'Instance' and cand:IsA('Player') then
                return cand
            end
            if type(cand) == 'string' then
                local p = resolvePlayer(cand)

                if p then
                    return p
                end
            end
        end

        return nil
    end
    if type(v) == 'string' and #v > 0 then
        local p = Players:FindFirstChild(v)

        if p and p:IsA('Player') then
            return p
        end

        local lv = v:lower()

        for _, q in ipairs(Players:GetPlayers())do
            if q.Name:lower() == lv or (q.DisplayName or ''):lower() == lv then
                return q
            end
        end
    end

    return nil
end

local coinContainerRef

local function getCoinContainer()
    if coinContainerRef and coinContainerRef.Parent then
        return coinContainerRef
    end

    coinContainerRef = workspace:FindFirstChild('CoinContainer', true)

    return coinContainerRef
end
local function coinTaken(d)
    local c = d:GetAttribute('Collected')

    return c == true or c == 'true'
end
local function freshCoins()
    local out = {}
    local c = getCoinContainer()

    if c then
        for _, d in ipairs(c:GetChildren())do
            if d:IsA('BasePart') and (d:GetAttribute('CoinID') ~= nil or d.Name == 'Coin_Server') and not coinTaken(d) then
                out[#out + 1] = d
            end
        end
    end

    return out
end

local coinCache = {}

task.spawn(function()
    while not Library.Unloaded do
        coinCache = freshCoins()

        task.wait(0.2)
    end
end)

local coinEspStore = {}

task.spawn(function()
    while not Library.Unloaded do
        if flags.coinEsp then
            local seen = {}

            for _, coin in ipairs(coinCache)do
                seen[coin] = true

                if not coinEspStore[coin] then
                    local vis = coin:FindFirstChild('CoinVisual')
                    local ad = (vis and vis:FindFirstChild('MainCoin')) or vis or coin

                    coinEspStore[coin] = create('Highlight', {
                        Name = rnd(),
                        Adornee = ad,
                        FillColor = Color3.fromRGB(255, 205, 55),
                        FillTransparency = 0.25,
                        OutlineColor = Color3.fromRGB(255, 235, 150),
                        OutlineTransparency = 0,
                        DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
                        Parent = EspGui,
                    })
                end
            end
            for coin, hl in pairs(coinEspStore)do
                if not seen[coin] or not coin.Parent then
                    hl:Destroy()

                    coinEspStore[coin] = nil
                end
            end
        elseif next(coinEspStore) then
            for coin, hl in pairs(coinEspStore)do
                hl:Destroy()

                coinEspStore[coin] = nil
            end
        end

        task.wait(0.15)
    end
end)

local PlayerESP = {}
local ROLE_COLORS = {
    Murderer = Color3.fromRGB(255, 55, 55),
    Sheriff = Color3.fromRGB(65, 145, 255),
    Innocent = Color3.fromRGB(65, 220, 95),
}

local function destroyPlayerESP(plr)
    local data = PlayerESP[plr]

    if not data then
        return
    end
    if data.gui then
        pcall(function()
            data.gui:Destroy()
        end)
    end

    PlayerESP[plr] = nil
end
local function getESPData(plr)
    local data = PlayerESP[plr]

    if data and data.gui and data.gui.Parent then
        return data
    end

    local gui = Instance.new('BillboardGui')

    gui.Name = rnd()
    gui.Size = UDim2.fromOffset(100, 48)
    gui.StudsOffsetWorldSpace = Vector3.new(0, 0, 0)
    gui.AlwaysOnTop = true
    gui.LightInfluence = 0
    gui.MaxDistance = 5000
    gui.Enabled = false
    gui.Parent = EspGui

    local box = Instance.new('Frame')

    box.Name = rnd()
    box.AnchorPoint = Vector2.new(0.5, 0.5)
    box.Position = UDim2.fromScale(0.5, 0.5)
    box.Size = UDim2.fromOffset(18, 18)
    box.BackgroundTransparency = 1
    box.BorderSizePixel = 1
    box.Parent = gui

    local stroke = Instance.new('UIStroke')

    stroke.Thickness = 1.5
    stroke.Transparency = 0
    stroke.Parent = box

    local label = Instance.new('TextLabel')

    label.Name = rnd()
    label.AnchorPoint = Vector2.new(0.5, 1)
    label.Position = UDim2.fromScale(0.5, 0.5)
    label.Size = UDim2.fromOffset(100, 16)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 11
    label.TextStrokeTransparency = 0.35
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.Parent = gui
    data = {
        gui = gui,
        box = box,
        stroke = stroke,
        label = label,
    }
    PlayerESP[plr] = data

    return data
end
local function roleESPInfo(plr)
    local role = roleOf(plr)

    if role == 'Murderer' then
        return 'murderer', ROLE_COLORS.Murderer
    elseif role == 'Sheriff' then
        return 'sheriff', ROLE_COLORS.Sheriff
    end

    return 'innocent', ROLE_COLORS.Innocent
end
local function updatePlayerESP(plr)
    if plr == LocalPlayer then
        destroyPlayerESP(plr)

        return
    end

    local enabled = flags.espBox or flags.espRoleTags

    if not enabled then
        local data = PlayerESP[plr]

        if data then
            data.gui.Enabled = false
        end

        return
    end

    local ch = plr.Character
    local hrp = getHRP(ch)
    local data = getESPData(plr)

    if not hrp or not hrp.Parent or not alive(plr) then
        data.gui.Enabled = false

        return
    end

    data.gui.Adornee = hrp
    data.gui.Enabled = true

    local roleText, color = roleESPInfo(plr)

    data.box.Visible = flags.espBox
    data.stroke.Color = color
    data.label.Visible = flags.espRoleTags
    data.label.Text = roleText
    data.label.TextColor3 = color
end
local function updateAllPlayerESP()
    for _, plr in ipairs(Players:GetPlayers())do
        updatePlayerESP(plr)
    end
    for plr in pairs(PlayerESP)do
        if not plr.Parent then
            destroyPlayerESP(plr)
        end
    end
end

bind(Players.PlayerAdded, function(plr)
    plr.CharacterAdded:Connect(function()
        task.wait(0.15)
        updatePlayerESP(plr)
    end)
end)
bind(Players.PlayerRemoving, function(plr)
    destroyPlayerESP(plr)
end)

for _, plr in ipairs(Players:GetPlayers())do
    if plr ~= LocalPlayer then
        plr.CharacterAdded:Connect(function()
            task.wait(0.15)
            updatePlayerESP(plr)
        end)
    end
end

task.spawn(function()
    while not Library.Unloaded do
        updateAllPlayerESP()
        task.wait(0.08)
    end
end)

local GameplayR = RS:WaitForChild('Remotes'):WaitForChild('Gameplay')

for _, rn in ipairs({
    'TeleportToPart',
    'RoundStart',
    'RoundEndFade',
    'LoadingMap',
    'GameOver',
    'VictoryScreen',
})do
    local r = GameplayR:FindFirstChild(rn)

    if r and r:IsA('RemoteEvent') then
        bind(r.OnClientEvent, Mono.markTeleport)
    end
end

bind(LocalPlayer.CharacterAdded, Mono.markTeleport)

local function findDroppedGun()
    for _, p in ipairs(CollectionService:GetTagged('GunDrop'))do
        if p:IsA('BasePart') and p:IsDescendantOf(workspace) then
            return p
        end
    end
    for _, d in ipairs(workspace:GetChildren())do
        if d:IsA('BasePart') and d.Name == 'GunDrop' then
            return d
        end
        if d:IsA('Model') then
            local g = d:FindFirstChild('GunDrop')

            if g and g:IsA('BasePart') then
                return g
            end
        end
    end
end

local droppedGun
local gunEspHL, gunEspBB

task.spawn(function()
    while not Library.Unloaded do
        local h = flags.gunEsp and droppedGun or nil

        if h and h.Parent then
            if not gunEspHL then
                gunEspHL = create('Highlight', {
                    Name = rnd(),
                    FillColor = Color3.fromRGB(90, 150, 255),
                    FillTransparency = 0.35,
                    OutlineColor = Color3.fromRGB(170, 210, 255),
                    OutlineTransparency = 0,
                    DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
                    Parent = EspGui,
                })
            end
            if not gunEspBB then
                gunEspBB = create('BillboardGui', {
                    Name = rnd(),
                    Size = UDim2.fromOffset(160, 18),
                    AlwaysOnTop = true,
                    StudsOffsetWorldSpace = Vector3.new(0, 2, 0),
                    Parent = EspGui,
                }, {
                    create('TextLabel', {
                        BackgroundTransparency = 1,
                        Size = UDim2.fromScale(1, 1),
                        Font = Enum.Font.GothamBold,
                        TextSize = 12,
                        TextColor3 = Color3.fromRGB(140, 190, 255),
                        TextStrokeTransparency = 0.4,
                        Text = 'GUN',
                    }),
                })
            end

            gunEspHL.Adornee = h
            gunEspHL.Enabled = true
            gunEspBB.Adornee = h
            gunEspBB.Enabled = flags.gunEspDist

            if flags.gunEspDist then
                local hrp = getHRP(LocalPlayer.Character)
                local dist = hrp and math.floor((h.Position - hrp.Position).Magnitude) or 0
                local lbl = gunEspBB:FindFirstChildOfClass('TextLabel')

                if lbl then
                    lbl.Text = 'DROPPED GUN  \u{b7}  ' .. dist .. 'm'
                end
            end
        else
            if gunEspHL then
                gunEspHL.Enabled = false
            end
            if gunEspBB then
                gunEspBB.Enabled = false
            end
        end

        task.wait(0.1)
    end
end)

local grabbing = false

local function touchGun(h)
    local hrp = getHRP(LocalPlayer.Character)

    if not (hrp and h and h.Parent) then
        return false
    end
    if typeof(firetouchinterest) == 'function' then
        pcall(function()
            for _ = 1, 4 do
                firetouchinterest(hrp, h, 0)
                firetouchinterest(hrp, h, 1)
            end
        end)
    end

    return findWeapon('Gun') ~= nil
end

function Mono.canAct()
    if Mono.teleporting() then
        return false
    end

    local ch = LocalPlayer.Character

    if not ch or not ch.Parent then
        return false
    end

    local hum = ch:FindFirstChildOfClass('Humanoid')

    if not (hum and hum.Health > 0) then
        return false
    end
    if not getHRP(ch) then
        return false
    end
    if LocalPlayer:GetAttribute('Alive') == false then
        return false
    end

    local d = roundData(LocalPlayer)

    if d and d.Dead == true then
        return false
    end

    return true
end

local function grabGunOnce(target)
    if grabbing then
        return false
    end

    local h = target or droppedGun or findDroppedGun()
    local hrp = getHRP(LocalPlayer.Character)

    if not (h and h.Parent and hrp and Mono.canAct()) then
        return false
    end

    grabbing = true

    if touchGun(h) then
        notify('Grabbed the Sheriff gun')

        grabbing = false

        return true
    end

    local back = hrp.CFrame

    for _ = 1, 10 do
        local myhrp = getHRP(LocalPlayer.Character)

        if not (myhrp and h.Parent) then
            break
        end
        if not Mono.canAct() then
            break
        end

        myhrp.CFrame = CFrame.new(h.Position)
        myhrp.AssemblyLinearVelocity = Vector3.zero

        if touchGun(h) then
            break
        end

        RunService.Heartbeat:Wait()
    end

    local myhrp = getHRP(LocalPlayer.Character)

    if myhrp then
        myhrp.CFrame = back
        myhrp.AssemblyLinearVelocity = Vector3.zero
    end

    local got = findWeapon('Gun') ~= nil

    if got then
        notify('Grabbed the Sheriff gun')
    end

    grabbing = false

    return got
end
local function onGunAppeared(inst)
    if not (inst and inst:IsA('BasePart') and inst:IsDescendantOf(workspace)) then
        return
    end

    droppedGun = inst

    if flags.autoGun and not grabbing and myRole() ~= 'Murderer' and not findWeapon('Gun') and Mono.canAct() then
        task.spawn(grabGunOnce, inst)
    end
end

pcall(function()
    bind(CollectionService:GetInstanceAddedSignal('GunDrop'), onGunAppeared)
    bind(CollectionService:GetInstanceRemovedSignal('GunDrop'), function(i)
        if droppedGun == i then
            droppedGun = nil
        end
    end)
end)
bind(workspace.DescendantAdded, function(d)
    if d.Name == 'GunDrop' then
        task.defer(onGunAppeared, d)
    end
end)
task.spawn(function()
    while not Library.Unloaded do
        if flags.gunEsp or flags.autoGun then
            local g = findDroppedGun()

            droppedGun = g

            if g and flags.autoGun and not grabbing and myRole() ~= 'Murderer' and not findWeapon('Gun') and Mono.canAct() then
                grabGunOnce(g)
            end
        elseif droppedGun then
            droppedGun = nil
        end

        task.wait(0.1)
    end
end)

local fbStore

local function setFullbright(on)
    if on then
        fbStore = fbStore or {
            Lighting.Brightness,
            Lighting.ClockTime,
            Lighting.GlobalShadows,
            Lighting.Ambient,
        }
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.fromRGB(140, 140, 140)
    elseif fbStore then
        Lighting.Brightness, Lighting.ClockTime, Lighting.GlobalShadows, Lighting.Ambient = fbStore[1], fbStore[2], fbStore[3], fbStore[4]
        fbStore = nil
    end
end

local fpsStore, fpsConn

local function fxKill(e, store)
    if store[e] ~= nil then
        return
    end
    if e:IsA('PostEffect') then
        if e.Enabled then
            e.Enabled = false
            store[e] = {
                'en',
            }
        end
    elseif e:IsA('ParticleEmitter') or e:IsA('Trail') or e:IsA('Smoke') or e:IsA('Fire') or e:IsA('Sparkles') or e:IsA('Beam') then
        if e.Enabled then
            e.Enabled = false
            store[e] = {
                'en',
            }
        end
    elseif e:IsA('Decal') or e:IsA('Texture') then
        store[e] = {
            'tr',
            e.Transparency,
        }
        e.Transparency = 1
    elseif e:IsA('SurfaceAppearance') then
        store[e] = {
            'par',
            e.Parent,
        }
        e.Parent = nil
    end
end
local function setPerformanceMode(on)
    if on then
        fpsStore = {
            changed = {},
            shadows = Lighting.GlobalShadows,
        }
        Lighting.GlobalShadows = false

        local terrain = workspace:FindFirstChildOfClass('Terrain')

        if terrain then
            fpsStore.water = {
                terrain.WaterWaveSize,
                terrain.WaterWaveSpeed,
                terrain.WaterReflectance,
            }
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
        end

        fpsConn = workspace.DescendantAdded:Connect(function(e)
            if flags.performanceMode and fpsStore then
                task.defer(fxKill, e, fpsStore.changed)
            end
        end)

        task.spawn(function()
            local s = fpsStore.changed
            local n = 0

            for _, e in ipairs(Lighting:GetDescendants())do
                fxKill(e, s)
            end
            for _, e in ipairs(workspace:GetDescendants())do
                if not (flags.performanceMode and fpsStore) then
                    return
                end

                fxKill(e, s)

                n += 1

                if n % 900 == 0 then
                    RunService.Heartbeat:Wait()
                end
            end
        end)
    elseif fpsStore then
        local s = fpsStore.changed

        Lighting.GlobalShadows = fpsStore.shadows

        local terrain = workspace:FindFirstChildOfClass('Terrain')

        if terrain and fpsStore.water then
            terrain.WaterWaveSize, terrain.WaterWaveSpeed, terrain.WaterReflectance = fpsStore.water[1], fpsStore.water[2], fpsStore.water[3]
        end
        if fpsConn then
            fpsConn:Disconnect()

            fpsConn = nil
        end

        fpsStore = nil

        task.spawn(function()
            local n = 0

            for e, info in pairs(s)do
                pcall(function()
                    if info[1] == 'en' then
                        e.Enabled = true
                    elseif info[1] == 'tr' then
                        e.Transparency = info[2]
                    elseif info[1] == 'par' then
                        e.Parent = info[2]
                    end
                end)

                n += 1

                if n % 900 == 0 then
                    RunService.Heartbeat:Wait()
                end
            end
        end)
    end
end

unstick = function(ch)
    if not ch then
        return
    end

    local hrp = getHRP(ch)

    if not hrp then
        return
    end

    task.spawn(function()
        local params = RaycastParams.new()

        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = {ch}

        local from = hrp.Position + Vector3.new(0, 6, 0)
        local hit = workspace:Raycast(from, Vector3.new(0, -200, 0), params)

        if hit then
            hrp.CFrame = CFrame.new(hit.Position + Vector3.new(0, 3.5, 0))
        else
            hrp.CFrame = hrp.CFrame + Vector3.new(0, 4, 0)
        end

        hrp.AssemblyLinearVelocity = Vector3.zero

        RunService.Heartbeat:Wait()

        for _, p in ipairs(getCharParts(ch))do
            if p.Parent and p.Name ~= 'HumanoidRootPart' then
                p.CanCollide = true
            end
        end
    end)
end

local function tpTo(pos)
    local hrp = getHRP(LocalPlayer.Character)

    if not hrp then
        return
    end

    hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
end

local MURD_ALERT_RANGE = 50
local murdNotif = nil
local murdLastShown = nil

local function closeMurdNotif()
    if murdNotif then
        pcall(function()
            murdNotif:Destroy()
        end)

        murdNotif = nil
        murdLastShown = nil
    end
end

bind(RunService.Heartbeat, function()
    if not flags.murdererNotify then
        closeMurdNotif()

        return
    end

    local hrp = getHRP(LocalPlayer.Character)
    local m = findMurderer()
    local mh = (m and m ~= LocalPlayer and alive(m)) and getHRP(m.Character) or nil

    if not (hrp and mh) then
        closeMurdNotif()

        return
    end

    local d = math.floor((mh.Position - hrp.Position).Magnitude)

    if d > MURD_ALERT_RANGE then
        closeMurdNotif()

        return
    end
    if not murdNotif then
        local ok, res = pcall(function()
            return Library:Notify({
                Title = 'Murderer Nearby',
                Description = m.Name .. '   ' .. d .. 'm',
                Persist = true,
            })
        end)

        murdNotif = ok and res or nil
        murdLastShown = d
    elseif d ~= murdLastShown then
        murdLastShown = d

        pcall(function()
            murdNotif:ChangeDescription(m.Name .. '   ' .. d .. 'm')
        end)
    end
end)

local GiveWeaponR = GameplayR:FindFirstChild('GiveWeapon')

if GiveWeaponR then
    bind(GiveWeaponR.OnClientEvent, function(w)
        if w == 'Knife' or w == 'Gun' then
            notify('You are the ' .. (w == 'Knife' and 'MURDERER' or 'SHERIFF') .. '!', 3)
        end
    end)
end

do
    local function feedNotify(name, killType, role)
        local tag = role and (' [' .. (role == 'Murderer' and 'M' or isGunRole(role) and 'S' or 'I') .. ']') or ''

        Library:Notify({
            Title = 'Kill Feed',
            Description = tostring(name) .. tag .. '  \u{b7}  ' .. tostring(killType or 'Eliminated'),
            Time = 4,
        })
    end

    local recentKillEvent = {}
    local KillEventR = GameplayR:FindFirstChild('KillEvent')

    if KillEventR then
        bind(KillEventR.OnClientEvent, function(victim, _, _, killType)
            if not victim then
                return
            end

            local nm = tostring(victim)

            recentKillEvent[nm] = os.clock()

            if flags.killFeed then
                feedNotify(nm, killType)
            end
        end)
    end

    local lastDead = {}

    local function scanDeaths()
        if not (CRC and CRC.PlayerData) then
            return
        end

        for name, d in pairs(CRC.PlayerData)do
            local dead = (d.Dead == true)
            local was = lastDead[name]

            if was == false and dead then
                local seen = recentKillEvent[name]

                if flags.killFeed and not (seen and os.clock() - seen < 2) then
                    feedNotify(name, nil, d.Role)
                end
            end

            lastDead[name] = dead
        end
    end

    local PlayerDataChangedR = GameplayR:FindFirstChild('PlayerDataChanged')

    if PlayerDataChangedR then
        bind(PlayerDataChangedR.OnClientEvent, function()
            task.defer(scanDeaths)
        end)
    end

    local RoundStartR = GameplayR:FindFirstChild('RoundStart')

    if RoundStartR then
        bind(RoundStartR.OnClientEvent, function()
            lastDead = {}
            recentKillEvent = {}
            coinBagFull = false

            task.defer(scanDeaths)
        end)
    end

    task.spawn(function()
        while not Library.Unloaded do
            scanDeaths()
            task.wait(0.2)
        end
    end)
end

bind(TeleportService.TeleportInitFailed, function(_, _, _, _)
    local p = hopFallbackPlace

    if not p then
        return
    end

    hopFallbackPlace = nil

    notify('That server was full, letting Roblox pick one')
    pcall(function()
        TeleportService:Teleport(p, LocalPlayer)
    end)
end)

if VirtualUser then
    bind(LocalPlayer.Idled, function()
        if flags.antiAfk then
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    end)
end

do
    local MAX_LINEAR = 190
    local MAX_ANGULAR = 22
    local otherParts = {}
    local nParts = 0

    local function addPart(d)
        if d:IsA('BasePart') then
            nParts = nParts + 1
            otherParts[nParts] = d

            if d.CanCollide then
                d.CanCollide = false
            end
        end
    end
    local function hookChar(ch)
        if not ch then
            return
        end

        for _, d in ipairs(ch:GetDescendants())do
            addPart(d)
        end

        ch.DescendantAdded:Connect(function(d)
            if flags.antiFling then
                task.defer(addPart, d)
            end
        end)
    end
    local function rebuildOthers()
        table.clear(otherParts)

        nParts = 0

        for _, p in ipairs(Players:GetPlayers())do
            if p ~= LocalPlayer and p.Character then
                for _, d in ipairs(p.Character:GetDescendants())do
                    addPart(d)
                end
            end
        end
    end
    local function watch(p)
        if p == LocalPlayer then
            return
        end

        hookChar(p.Character)
        p.CharacterAdded:Connect(function(ch)
            task.defer(function()
                hookChar(ch)
                rebuildOthers()
            end)
        end)
    end

    for _, p in ipairs(Players:GetPlayers())do
        watch(p)
    end

    bind(Players.PlayerAdded, function(p)
        watch(p)
        task.defer(rebuildOthers)
    end)
    bind(Players.PlayerRemoving, function()
        task.defer(rebuildOthers)
    end)
    task.spawn(function()
        while not Library.Unloaded do
            if flags.antiFling then
                rebuildOthers()
            end

            task.wait(3)
        end
    end)

    local function selfBusy()
        return flinging
    end

    local lastSweep = 0
    local SWEEP_INTERVAL = 0

    local function guard()
        if not flags.antiFling or selfBusy() then
            return
        end
        if Mono.teleporting() then
            return
        end

        local now = os.clock()

        if now - lastSweep >= SWEEP_INTERVAL then
            lastSweep = now

            for i = 1, nParts do
                local d = otherParts[i]

                if d and d.Parent and d.CanCollide then
                    d.CanCollide = false
                end
            end
        end

        local hrp = getHRP(LocalPlayer.Character)

        if not hrp then
            return
        end

        local lv = hrp.AssemblyLinearVelocity

        if lv.Magnitude > MAX_LINEAR then
            hrp.AssemblyLinearVelocity = lv.Unit * MAX_LINEAR
        end

        for _, p in ipairs(getCharParts(LocalPlayer.Character))do
            if p.Parent and p:IsA('BasePart') and p.AssemblyAngularVelocity.Magnitude > MAX_ANGULAR then
                p.AssemblyAngularVelocity = Vector3.zero
            end
        end

        local av = hrp.AssemblyAngularVelocity

        if av.Magnitude > MAX_ANGULAR then
            hrp.AssemblyAngularVelocity = Vector3.zero
        end
    end

    bind(RunService.Stepped, guard)
    bind(RunService.Heartbeat, guard)

    local function isMover(d)
        return d:IsA('BodyVelocity') or d:IsA('BodyAngularVelocity') or d:IsA('BodyThrust') or d:IsA('BodyForce') or d:IsA('LinearVelocity') or d:IsA('AngularVelocity')
    end
    local function watchSelf(ch)
        if not ch then
            return
        end

        ch.DescendantAdded:Connect(function(d)
            if not flags.antiFling then
                return
            end
            if not isMover(d) then
                return
            end

            task.defer(function()
                if d.Parent and not selfBusy() then
                    pcall(function()
                        d:Destroy()
                    end)
                end
            end)
        end)
    end

    watchSelf(LocalPlayer.Character)
    bind(LocalPlayer.CharacterAdded, watchSelf)
end

local SILVER_THEME = 'Vyrion Silver'

pcall(function()
    WindUI:AddTheme({
        Name = SILVER_THEME,
        Accent = Color3.fromRGB(0, 0, 0),
        Background = Color3.fromRGB(18, 18, 20),
        Outline = Color3.fromRGB(105, 105, 110),
        Text = Color3.fromRGB(245, 245, 245),
        Placeholder = Color3.fromRGB(155, 155, 160),
        Button = Color3.fromRGB(72, 72, 76),
        Icon = Color3.fromRGB(205, 205, 210),
    })
end)
pcall(function()
    WindUI:SetTheme(SILVER_THEME)
end)

Window = WindUI:CreateWindow({
    Title = 'Vyrion Hub | MM2',
    Author = 'VyrionStudios',
    Folder = CONFIG_FOLDER,
    Icon = VYRION_ICON,
    IconThemed = false,
    Theme = SILVER_THEME,
    NewElements = true,
    HideSearchBar = false,
    OpenButton = {
        Title = 'Open Vyrion Hub',
        Icon = VYRION_ICON,
        IconThemed = false,
        CornerRadius = UDim.new(1, 0),
        StrokeThickness = 2,
        Enabled = true,
        Draggable = true,
        OnlyMobile = false,
        Scale = 0.55,
        Color = ColorSequence.new(Color3.fromRGB(205, 205, 205), Color3.fromRGB(105, 105, 110)),
    },
    Topbar = {
        Height = 44,
        ButtonsType = 'Mac',
    },
})

pcall(function()
    Window:EditOpenButton({
        Title = 'Vyrion Hub',
        Icon = VYRION_ICON,
        CornerRadius = UDim.new(0, 14),
        StrokeThickness = 2,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(72, 72, 76)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 150, 155)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 220, 225)),
        }),
        OnlyMobile = false,
        Enabled = true,
        Draggable = true,
    })
end)

Library.Unloaded = false

pcall(function()
    Window:Tag({
        Title = 'VYRION',
        Icon = VYRION_ICON,
        Color = Color3.fromRGB(70, 70, 74),
        Border = true,
    })
end)

local function section(tab, title)
    return tab:Section({
        Title = title,
        Box = true,
        BoxBorder = true,
        Opened = true,
    })
end
local function addToggle(parent, title, desc, callback, default)
    return parent:Toggle({
        Title = title,
        Desc = desc,
        Value = default == true,
        Flag = 'VYRION_' .. title:gsub('%W', '_'),
        Callback = callback,
    })
end

local Tabs = {
    News = Window:Tab({
        Title = 'News',
        Icon = 'newspaper',
    }),
    Visuals = Window:Tab({
        Title = 'Visuals',
        Icon = 'eye',
    }),
    Murder = Window:Tab({
        Title = 'Murder',
        Icon = 'knife',
    }),
    Sheriff = Window:Tab({
        Title = 'Sheriff',
        Icon = 'crosshair',
    }),
    Misc = Window:Tab({
        Title = 'Misc',
        Icon = 'zap',
    }),
    Server = Window:Tab({
        Title = 'Server',
        Icon = 'server',
    }),
    Settings = Window:Tab({
        Title = 'Settings',
        Icon = 'settings',
    }),
    Info = Window:Tab({
        Title = 'Info',
        Icon = 'info',
    }),
}

do
    local g = section(Tabs.News, 'Welcome')

    g:Paragraph({
        Title = 'Vyrion Hub | MM2',
        Desc = 'Welcome, ' .. LocalPlayer.Name .. '\nVersion: 2.0\nHotfixes: None\nBug Fixes: None\nChanges: Initial release\nNew Features: Vyrion Hub interface',
        Image = VYRION_ICON,
        ImageSize = 24,
    })
end
do
    local g = section(Tabs.Visuals, 'Player ESP')

    addToggle(g, 'Nametag ESP', 'Name, distance and round coins above each player.', function(v)
        flags.espNames = v
    end)
    addToggle(g, 'Box ESP', "Marks each player's HumanoidRootPart with a role-colored square.", function(v)
        flags.espBox = v
    end)
    addToggle(g, 'Chams', 'Coloured through-wall outline on each player.', function(v)
        flags.espChams = v
    end)
    addToggle(g, 'Chams Fill', 'Fills the chams body instead of outlining it. Needs Chams on.', function(v)
        flags.espFill = v
    end)
    addToggle(g, 'Role Tags', 'Shows a small innocent, murderer or sheriff label above the player.', function(v)
        flags.espRoleTags = v
    end)
    addToggle(g, 'Skeleton ESP', 'Draws bone lines over each player.', function(v)
        flags.espSkeleton = v
    end)

    local g2 = section(Tabs.Visuals, 'World & Render')

    addToggle(g2, 'Coin ESP', 'Highlights every uncollected coin on the map.', function(v)
        flags.coinEsp = v
    end)
    addToggle(g2, 'Dropped Gun ESP', 'Highlights the sheriff gun once it is lying on the ground.', function(v)
        flags.gunEsp = v
    end)
    addToggle(g2, 'Gun ESP Distance', 'Adds a distance label to the dropped gun highlight.', function(v)
        flags.gunEspDist = v
    end)
    addToggle(g2, 'Kill Feed', 'Notifies you of every elimination, in any role including innocent.', function(v)
        flags.killFeed = v
    end)
    addToggle(g2, 'Fullbright', 'Removes darkness so nowhere on the map is unlit.', function(v)
        flags.fullbright = v

        setFullbright(v)
    end)
    addToggle(g2, 'Performance Mode', 'Strips particles, shadows, decals and post effects. Reversed on unload.', function(v)
        flags.performanceMode = v

        setPerformanceMode(v)
    end)
    addToggle(g2, 'Murderer Notify', 'A notification that sticks around updating their distance while the murderer is within 50 studs.', function(v)
        flags.murdererNotify = v
    end)
end
do
    local g = section(Tabs.Murder, 'Murder Tools')

    addToggle(g, 'Knife Through Walls', 'Your thrown knives ignore geometry. Aim at a player or anywhere on the map. Does not throw for you.', function(v)
        flags.knifeWalls = v
    end)
    addToggle(g, 'Instant Knife Throw', 'Skips the wind up and the flight time, so the knife lands the instant you press throw. Walls still block it unless Knife Through Walls is on.', function(v)
        flags.instantKnife = v
    end)
    addToggle(g, 'Kill All', 'Kills every alive player instantly. Only works if you are the murderer.', function(v)
        if v and myRole() ~= 'Murderer' then
            notify('Wait until you are the murderer', 3)
        end

        flags.killAll = v
    end)
end
do
    local g = section(Tabs.Sheriff, 'Sheriff Tools')
    local aimToggle = addToggle(g, 'Aimbot', 'Hold the keybind to snap your camera to the murderer. Head or Body targeting.', function(v)
        if v and not isGunRole(myRole()) then
            notify('Wait until you are the Sheriff or Hero', 3)
        end

        flags.aimbot = v
    end)
    local aimKey = g:Keybind({
        Title = 'Aimbot Key',
        Desc = 'Hold this key while Aimbot is enabled.',
        Value = 'MouseRight',
        Callback = function() end,
    })

    Options.AimKey = {
        Value = 'MouseRight',
        GetState = function()
            return aimKeyHeld
        end,
        Set = function(_, v)
            if type(v) == 'string' then
                Options.AimKey.Value = v
            end
        end,
    }

    if aimKey and aimKey.Value then
        Options.AimKey.Value = aimKey.Value
    end

    bind(UserInputService.InputBegan, function(input, gpe)
        if gpe then
            return
        end

        local key = Options.AimKey.Value

        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode.Name == key then
            aimKeyHeld = true
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 and key == 'MouseRight' then
            aimKeyHeld = true
        elseif input.UserInputType == Enum.UserInputType.MouseButton1 and key == 'MouseLeft' then
            aimKeyHeld = true
        end
    end)
    bind(UserInputService.InputEnded, function(input)
        local key = Options.AimKey.Value

        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode.Name == key then
            aimKeyHeld = false
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 and key == 'MouseRight' then
            aimKeyHeld = false
        elseif input.UserInputType == Enum.UserInputType.MouseButton1 and key == 'MouseLeft' then
            aimKeyHeld = false
        end
    end)

    Options.AimbotTarget = g:Dropdown({
        Title = 'Aimbot Target',
        Values = {
            'Head',
            'Body',
        },
        Value = 'Head',
        Callback = function(v)
            flags.aimbotTarget = v
        end,
    })

    addToggle(g, 'Silent Aim', 'Redirects shots and knife throws to the murderer without moving your camera.', function(v)
        if v and not isGunRole(myRole()) then
            notify('Wait until you are the Sheriff or Hero', 3)
        end

        flags.silentAim = v
    end)
    g:Slider({
        Title = 'FOV',
        Desc = 'Radius in pixels around your cursor that counts as a valid target.',
        Step = 1,
        Value = {
            Min = 40,
            Max = 400,
            Default = 120,
        },
        Callback = function(v)
            aimFov = v
        end,
    })
    addToggle(g, 'Show FOV Circle', 'Draws the aim radius. Only visible while an aim feature is on.', function(v)
        flags.showFov = v
    end)
    addToggle(g, 'Gun Through Walls', 'Your shots ignore geometry. Aim at a player or anywhere on the map. Does not shoot for you.', function(v)
        flags.gunWalls = v
    end)
    addToggle(g, 'Trigger Bot', 'Gun only. Automatically fires at the murderer when they enter your FOV circle and you can see them.', function(v)
        flags.triggerBot = v
    end)
    addToggle(g, 'Auto Grab Gun', 'Grabs the dropped gun the moment it appears, then returns you.', function(v)
        flags.autoGun = v
    end)
    g:Button({
        Title = 'Grab Gun Now',
        Desc = 'One-off grab of the dropped gun',
        Callback = function()
            if findWeapon('Gun') then
                notify('You already have a gun')

                return
            end
            if not (droppedGun or findDroppedGun()) then
                notify('No dropped gun on the map')

                return
            end

            grabGunOnce()
        end,
    })
end
do
    local g = section(Tabs.Misc, 'Fling')

    addToggle(g, 'Auto Fling Murderer', 'Flings the murderer on sight.', function(v)
        flags.autoFlingMurderer = v
    end)
    addToggle(g, 'Auto Fling Sheriff', 'Flings the sheriff or hero on sight.', function(v)
        flags.autoFlingSheriff = v
    end)

    local flingNames = {}

    for _, p in ipairs(Players:GetPlayers())do
        if p ~= LocalPlayer then
            flingNames[#flingNames + 1] = p.Name
        end
    end

    Options.FlingPlayer = g:Dropdown({
        Title = 'Select Player',
        Values = flingNames,
        AllowNone = true,
        SearchBarEnabled = true,
    })

    bind(Players.PlayerAdded, function(p)
        task.defer(function()
            local names = {}

            for _, q in ipairs(Players:GetPlayers())do
                if q ~= LocalPlayer then
                    names[#names + 1] = q.Name
                end
            end

            pcall(function()
                Options.FlingPlayer:Refresh(names)
            end)
        end)
    end)
    bind(Players.PlayerRemoving, function()
        task.defer(function()
            local names = {}

            for _, q in ipairs(Players:GetPlayers())do
                if q ~= LocalPlayer then
                    names[#names + 1] = q.Name
                end
            end

            pcall(function()
                Options.FlingPlayer:Refresh(names)
            end)
        end)
    end)
    g:Button({
        Title = 'Fling Player',
        Callback = function()
            local p = resolvePlayer(Options.FlingPlayer.Value)

            if not p then
                notify('Pick a player first')

                return
            end
            if not (p.Character and getHRP(p.Character)) then
                notify(p.Name .. ' is dead')

                return
            end

            notify('Flinging ' .. p.Name)
            task.spawn(function()
                flingPlayer(p)
            end)
        end,
    })
    g:Button({
        Title = 'Fling All Players',
        Callback = flingAll,
    })

    local g2 = section(Tabs.Misc, 'Protection')

    addToggle(g2, 'Anti Fling', 'Blocks other exploiters from flinging you.', function(v)
        flags.antiFling = v
    end)
    addToggle(g2, 'Anti-AFK', 'Prevents the 20-minute idle kick.', function(v)
        flags.antiAfk = v
    end)
end
do
    local g = section(Tabs.Server, 'Server Actions')

    g:Button({
        Title = 'Rejoin',
        Callback = rejoin,
    })
    g:Button({
        Title = 'Server Hop',
        Callback = serverHop,
    })
end
do
    local g = section(Tabs.Settings, 'Save Folder')

    g:Paragraph({
        Title = 'Save Folder',
        Desc = CONFIG_FOLDER,
        Image = VYRION_ICON,
        ImageSize = 24,
    })
end
do
    local g = section(Tabs.Info, 'Discord Server Oficial')

    g:Paragraph({
        Title = 'VyrionStudios',
        Desc = DISCORD_INVITE,
        Image = VYRION_ICON,
        ImageSize = 48,
    })
    g:Button({
        Title = 'Copy Invite',
        Callback = function()
            if typeof(setclipboard) == 'function' then
                setclipboard(DISCORD_INVITE)
                notify('Discord invite copied')
            else
                notify('Your executor has no setclipboard')
            end
        end,
    })
end

pcall(function()
    if Window.ConfigManager then
    end
end)

unloadHandler = function()
    pcall(function()
        Library.Unloaded = true
    end)
    pcall(function()
        for k, v in pairs(flags)do
            if type(v) == 'boolean' then
                flags[k] = false
            end
        end
    end)
    pcall(function()
        setFullbright(false)
    end)
    pcall(function()
        setPerformanceMode(false)
    end)
    pcall(function()
        Camera.FieldOfView = 70
    end)
    pcall(function()
        local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass('Humanoid')

        if h then
            h.WalkSpeed = 16
            h.JumpPower = 50
        end
    end)
    pcall(function()
        if murdNotif then
            murdNotif:Destroy()
        end
    end)
    pcall(function()
        for p in pairs(espStore)do
            clearEsp(p)
        end
    end)
    pcall(function()
        for p in pairs(skelStore)do
            clearSkel(p)
        end
    end)
    pcall(function()
        for p in pairs(boxStore)do
            clearBox(p)
        end
    end)
    pcall(function()
        for c, hl in pairs(coinEspStore)do
            hl:Destroy()
        end
    end)
    pcall(function()
        for _, c in ipairs(conns)do
            c:Disconnect()
        end
    end)
    pcall(function()
        EspGui:Destroy()
    end)
    pcall(function()
        if GENV then
            GENV.DAE_Unload = nil
            GENV.DAE_GUIS = nil
        end
    end)
end

pcall(function()
    if GENV then
        GENV.DAE_Unload = function()
            Library:Unload()
        end
    end
end)

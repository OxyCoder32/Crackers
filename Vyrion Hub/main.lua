local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local supportedGames = {
    {
        ["Name"] = "99 Nights in the Forest",
        ["UniversalId"] = 7215324546,
        ["PlaceIds"] = { 79546208627805 },
        ["Raw"] = "https://raw.githubusercontent.com/OxyCoder32/Crackers/refs/heads/main/Vyrion%20Hub/99nights.lua"
    },
    {
        ["Name"] = "Murder Mystery 2",
        ["UniversalId"] = 66654135,
        ["PlaceIds"] = { 142823291 },
        ["Raw"] = "https://raw.githubusercontent.com/OxyCoder32/Crackers/refs/heads/main/Vyrion%20Hub/mm2.lua"
    },
    {
        ["Name"] = "Violence District",
        ["UniversalId"] = 6736209252,
        ["PlaceIds"] = { 93978595733734 },
        ["Raw"] = "https://raw.githubusercontent.com/OxyCoder32/Crackers/refs/heads/main/Vyrion%20Hub/district.lua"
    },
    {
        ["Name"] = "Ninja Tycoon",
        ["UniversalId"] = 84813098,
        ["PlaceIds"] = { 221718525 },
        ["Raw"] = "https://raw.githubusercontent.com/OxyCoder32/Crackers/refs/heads/main/Vyrion%20Hub/ninjatycoon.lua"
    },
    {
        ["Name"] = "King Legacy",
        ["UniversalId"] = 1451439645,
        ["PlaceIds"] = { 4520749081, 6381829480, 15759515082 },
        ["Raw"] = "https://raw.githubusercontent.com/OxyCoder32/Crackers/refs/heads/main/Vyrion%20Hub/Kingslegacy.lua"
    },
    {
        ["Name"] = "Doors",
        ["UniversalId"] = 2440500124,
        ["PlaceIds"] = { 6516141723 },
        ["Raw"] = "https://raw.githubusercontent.com/OxyCoder32/Crackers/refs/heads/main/Vyrion%20Hub/doors.lua"
    },
    {
        ["Name"] = "Forsaken",
        ["UniversalId"] = 6331902150,
        ["PlaceIds"] = { 18687417158 },
        ["Raw"] = "https://raw.githubusercontent.com/OxyCoder32/Crackers/refs/heads/main/Vyrion%20Hub/forsaken.lua"
    }
}

local PlaceId = game.PlaceId
local GameId = game.GameId

local function findSupportedGame()
    for _, gameInfo in ipairs(supportedGames) do
        if gameInfo.PlaceIds then
            for _, placeId in ipairs(gameInfo.PlaceIds) do
                if tonumber(placeId) == PlaceId then
                    return gameInfo
                end
            end
        end
    end

    if GameId and GameId > 0 then
        for _, gameInfo in ipairs(supportedGames) do
            if tonumber(gameInfo.UniversalId) == GameId then
                return gameInfo
            end
        end
    end

    return nil
end

local matchedGame = findSupportedGame()

if not matchedGame then
    if LocalPlayer then
        LocalPlayer:Kick("Game not supported: " .. game.PlaceID)
    end
    return
end

loadstring(game:HttpGet(matchedGame.Raw))()


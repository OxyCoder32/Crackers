--[[
dwa
d
wa
d
ac
d
ad
a
da

d
ac
a
d
a
c
a

dca
ca

dca
dcwa
d
c2

c2

c
2c
2

c
2


2

2
2
2
2
2

3


s



d



2


3

c



e

s
v3


]]



local GuiLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/thelostsheep199-collab/d-DADSD-DV-DADCAdwxq/refs/heads/main/kabah6v2bs8bsk"))()
local menu = GuiLibrary.new("SFY_Hub_library")

menu:SetPremiumStatus(false) -- Free version


-- Services (optimized - combined declarations)
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

-- Tabs (combined declaration)
local Tabs = {
    InfoTab = menu:CreateTab("Info"),
    AutoTab = menu:CreateTab("Auto"),
    MainTab = menu:CreateTab("Main"),
    BringTab = menu:CreateTab("Bring Stuff"),
    PlayerTab = menu:CreateTab("Local Player"),
    VisualTab = menu:CreateTab("Visual"),
}

--// ⚙️ Base Variables (minimized)
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Example usage in your script:

-- Create the welcome panel in the Info tab
local welcomePanel = menu:CreateWelcomePanelTab(Tabs.InfoTab, {
    ScriptName = "99 NIGHTS IN THE WILD WEST",
    Version = "V6.2",
    Developer = "SFY_devs",
    Discord = "discord.gg/m8B5VHfs",
    Description = "Christsmas is coming in wild west?, do dessert have snow?",
    Features = {
        "🎯 Player ESP & Highlighting",
        "⚡ Auto-Farming Systems",
        "🚀 Teleport & Navigation",
        "💎 Premium Exclusive Features",
        "🛡️ Anti-Detection Systems",
        "🔄 Regular Updates & Support",
        "🎮 Customizable Hotkeys",
        "📊 Performance Optimizer",
        "📦 Chest ESP System"
    },
    ThemeColor = Color3.fromRGB(255, 128, 0)
})

-- Add premium status indicator
menu:CreateSeparator(Tabs.InfoTab, "💎 PREMIUM STATUS")
local premiumStatus = menu:CreateLabel(Tabs.InfoTab, "Status: FREE VERSION")
local IsPremium = false -- Define this variable if not already defined

-- Function to update premium status
local function updatePremiumStatus()
    if IsPremium then
        premiumStatus.Text = "Status: PREMIUM ACTIVE 🎉"
        premiumStatus.TextColor3 = Color3.fromRGB(255, 215, 0)
    else
        premiumStatus.Text = "Status: FREE VERSION 🔓"
        premiumStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end

updatePremiumStatus()

-- Add premium upgrade button
menu:CreateButton(Tabs.InfoTab, "🔓 UPGRADE TO PREMIUM", function()
    menu:CopyToClipboard("https://discord.gg/m8B5VHfs")
    menu:ShowNotification("📋 Premium link copied to clipboard!", 3)
end)

-- Use the builder
menu:CreateSeparator(Tabs.InfoTab, "🐞 CHANGE LOGS ")
local updateHistory = menu:UpdateHistoryBuilder(Tabs.InfoTab)
:Add("2026-2-5","improve","ALL UPDATE","Improve and added new")
	:Add("2026-1-13", "update","ADDED INVICIBILITY", "Invisible to Enemy while maintaining its interaction")
	:Add("2025-12-26","update","AURA KILL","Updated Aura kill to work on Snow biomes")
    :Add("2025-12-15","update","ULTIMATE BRING","Added a feature to auto reveal map while bringing all the item")
	:Add("2025-12-15","update","MERRY CHRISTMAS","Update Aura kill and Christmas Gift for Bring stuff.")
    :Add("2025-12-9", "improve", "New Welcome", "Added a welcome menu")
    :Add("2025-12-4", "update","AURA KILL", "Added new Enemy in the aura kill")
    :Add("2025-11-27", "bug","AUTO LOOT CHEST", "Fixed error when looting a chest the player die")
    :Build()



local AutoTabSystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/thelostsheep199-collab/dwadwadv6728hch929_w3st/refs/heads/main/A_dwadvdadv2ac"))()
local MainTabSystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/thelostsheep199-collab/dwadwadv6728hch929_w3st/refs/heads/main/M_)dac2ac2acdav"))()
local BringTabSystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/thelostsheep199-collab/dwadwadv6728hch929_w3st/refs/heads/main/b_%40ab2dca2dc2"))()
local PlayerTabSystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/thelostsheep199-collab/dwadwadv6728hch929_w3st/refs/heads/main/p_%40ab"))()
local VisualTabSystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/thelostsheep199-collab/dwadwadv6728hch929_w3st/refs/heads/main/v_t%40b"))()

AutoTabSystem:Init(menu,Tabs)
MainTabSystem:Init(menu, Tabs)
BringTabSystem:Init(menu,Tabs)
PlayerTabSystem:Init(menu, Tabs)
VisualTabSystem:Init(menu, Tabs)
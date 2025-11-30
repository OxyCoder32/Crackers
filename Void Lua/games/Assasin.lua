-- line: [0, 0] id: 0
local r0_0 = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true))()
local r3_0 = {
  Name = "Void.lua Assassin UPDATED 02/11/25",
  Subtitle = nil,
  LogoID = "82795327169782",
  LoadingEnabled = true,
  LoadingTitle = "Cracked by Project X",
  LoadingSubtitle = "#1 Script For Assassin",
  ConfigSettings = {
    RootFolder = nil,
    ConfigFolder = "Void",
  },
  KeySystem = false,
}
r3_0.KeySettings = {
  Title = "Luna Example Key",
  Subtitle = "Key System",
  Note = "Best Key System Ever! Also, Please Use A HWID Keysystem like Pelican, Luarmor etc. that provide key strings based on your HWID since putting a simple string is very easy to bypass",
  SaveInRoot = false,
  SaveKey = true,
  Key = {
    "Example Key"
  },
  SecondAction = {
    Enabled = true,
    Type = "Link",
    Parameter = "",
  },
}
local r1_0 = r0_0:CreateWindow(r3_0)
r1_0:CreateHomeTab({
  SupportedExecutors = {},
  DiscordInvite = "dFqH5jtpqt",
  Icon = 1,
})
local r2_0 = r1_0:CreateTab({
  Name = "Autofarm",
  Icon = "sync",
  ImageSource = "Material",
  ShowTitle = true,
})
r3_0 = r1_0:CreateTab({
  Name = "Aiming",
  Icon = "track_changes",
  ImageSource = "Material",
  ShowTitle = true,
})
local r4_0 = r1_0:CreateTab({
  Name = "Misc",
  Icon = "person",
  ImageSource = "Material",
  ShowTitle = true,
})
local r5_0 = r1_0:CreateTab({
  Name = "Desync",
  Icon = "shuffle",
  ImageSource = "Material",
  ShowTitle = true,
})
local r6_0 = r1_0:CreateTab({
  Name = "Extra",
  Icon = "extension",
  ImageSource = "Material",
  ShowTitle = true,
})
local r7_0 = r2_0:CreateLabel({
  Text = "Customize the settings to what you want.",
  Style = 2,
})
getgenv().X7MX = false
getgenv().SpecialRoundFarm = false
getgenv().LastKillTime = 0
getgenv().LastHitTime = 0
getgenv().LastTeleportedToPlayer = nil
local r8_0 = game:GetService("Players")
local r9_0 = game:GetService("TweenService")
local r10_0 = r8_0.LocalPlayer
local r11_0 = game:GetService("RunService")
local r12_0 = r10_0.Backpack
local r13_0 = r10_0.Character
local r14_0 = nil
local r15_0 = nil
local function r16_0(r0_84)
  -- line: [0, 0] id: 84
  if typeof(r0_84) ~= "Instance" then
    return 
  end
  r13_0 = r0_84
  r14_0 = r0_84:WaitForChild("HumanoidRootPart")
  r15_0 = r0_84:WaitForChild("Humanoid")
end
r16_0(r13_0)
r10_0.CharacterAdded:Connect(r16_0)
local r17_0 = r10_0:WaitForChild("PlayerGui"):WaitForChild("ScreenGui"):WaitForChild("UI").Target
local r18_0 = r17_0.TargetText
local r19_0 = r17_0.Visible
local r20_0 = r19_0 and r8_0:FindFirstChild(r18_0.Text)
local r21_0 = nil
local r22_0 = nil
r17_0.Changed:Connect(function()
  -- line: [0, 0] id: 28
  r19_0 = r17_0.Visible
end)
r18_0.Changed:Connect(function()
  -- line: [0, 0] id: 1
  r20_0 = r8_0:FindFirstChild(r18_0.Text)
end)
local r23_0 = workspace.Lobby.VoteStation.pad3.Position
local function r24_0()
  -- line: [0, 0] id: 118
  local r0_118 = nil	-- notice: implicit variable refs by block#[10, 14]
  local r1_118 = nil	-- notice: implicit variable refs by block#[11, 14]
  for r5_118, r6_118 in ipairs(r8_0:GetPlayers()) do
    if r6_118 ~= r10_0 and r14_0 then
      local r7_118 = workspace:FindFirstChild(r6_118.Name)
      local r8_118 = r7_118 and r7_118:FindFirstChild("HumanoidRootPart")
      local r9_118 = r8_118 and r7_118:FindFirstChild("Humanoid")
      if r9_118 and 0 < r9_118.Health and 300 < (r23_0 - r8_118.Position).Magnitude then
        local r10_118 = (r14_0.Position - r8_118.Position).Magnitude
        if not r0_118 or r10_118 < r1_118 then
          r0_118 = r6_118
          r1_118 = r10_118
        end
      end
    end
  end
  return r0_118, r1_118
end
local r25_0 = 5
local r26_0 = 0
local r27_0 = 0
local r28_0 = 0
local r29_0 = r10_0:WaitForChild("PlayerScripts"):WaitForChild("localknifehandler"):WaitForChild("HitCheck")
local r30_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ThrowKnife")
if shared.zorautofarm then
  shared.zorautofarm:Disconnect()
end
shared.zorautofarm = r11_0.Heartbeat:Connect(function()
  -- line: [0, 0] id: 133
  if getgenv().X7MX then
    local r0_133 = r24_0()
    local r1_133 = r0_133 and workspace:FindFirstChild(r0_133.Name)
    local r2_133 = r1_133 and r1_133:FindFirstChild("HumanoidRootPart")
    if r19_0 and r20_0 and r13_0 and r14_0 and r15_0 then
      r21_0 = workspace:FindFirstChild(r20_0.Name)
      r22_0 = r21_0 and r21_0:FindFirstChild("HumanoidRootPart")
      task.wait(r25_0)
      r9_0:Create(r14_0, TweenInfo.new(0, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        CFrame = r22_0.CFrame * CFrame.new(r26_0, r27_0, r28_0),
      }):Play()
      workspace.Gravity = -2
      r15_0:SetStateEnabled(15, false)
      if 1 < tick() - getgenv().LastHitTime and r10_0:DistanceFromCharacter(r22_0.Position) <= 6.5 then
        r29_0:Fire(r21_0)
        getgenv().LastHitTime = tick()
      end
    elseif getgenv().SpecialRoundFarm and r0_133 and r2_133 and 30 < tick() - getgenv().LastKillTime then
      if getgenv().LastTeleportedToPlayer == r0_133 then
        return 
      end
      task.wait(r25_0)
      r9_0:Create(r14_0, TweenInfo.new(0, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        CFrame = r2_133.CFrame * CFrame.new(r26_0, r27_0, r28_0),
      }):Play()
      getgenv().LastKillTime = tick()
      getgenv().LastTeleportedToPlayer = r0_133
      if 1 < tick() - getgenv().LastHitTime and r10_0:DistanceFromCharacter(r2_133.Position) <= 6.5 then
        r29_0:Fire(r1_133)
        getgenv().LastHitTime = tick()
      end
    end
  end
end)
local r31_0 = r2_0:CreateToggle({
  Name = "Autokill",
  Description = "Automatically teleports to and hits targets.",
  CurrentValue = false,
  Callback = function(r0_119)
    -- line: [0, 0] id: 119
    getgenv().X7MX = r0_119
    local r2_119 = nil	-- notice: implicit variable refs by block#[4]
    if r15_0 then
      local r1_119 = workspace
      if r0_119 then
        r2_119 = -2
        if not r2_119 then
          ::label_12::
          r2_119 = 196.2
        end
      else
        goto label_12	-- block#3 is visited secondly
      end
      r1_119.Gravity = r2_119
      r15_0:SetStateEnabled(15, not r0_119)
    end
    local r1_119 = print
    r2_119 = "Autokill is now"
    local r3_119 = nil	-- notice: implicit variable refs by block#[8]
    if r0_119 then
      r3_119 = "ON"
      if not r3_119 then
        ::label_26::
        r3_119 = "OFF"
      end
    else
      goto label_26	-- block#7 is visited secondly
    end
    r1_119(r2_119, r3_119)
  end,
}, "Autokill")
local r32_0 = r2_0:CreateToggle({
  Name = "Special Round Farm [WIP]",
  Description = "Teleport to the closest player when no target is available.",
  CurrentValue = false,
  Callback = function(r0_102)
    -- line: [0, 0] id: 102
    getgenv().SpecialRoundFarm = r0_102
    local r1_102 = print
    local r2_102 = "Special Round Farm is now"
    local r3_102 = nil	-- notice: implicit variable refs by block#[3]
    if r0_102 then
      r3_102 = "ON"
      if not r3_102 then
        ::label_10::
        r3_102 = "OFF"
      end
    else
      goto label_10	-- block#2 is visited secondly
    end
    r1_102(r2_102, r3_102)
  end,
}, "SpecialRoundFarm")
local r33_0 = r2_0:CreateSlider({
  Name = "Teleport Delay",
  Range = {
    1,
    8.4
  },
  Increment = 0.1,
  CurrentValue = r25_0,
  Callback = function(r0_74)
    -- line: [0, 0] id: 74
    r25_0 = r0_74
    print("Teleport Delay set to:", r0_74)
  end,
}, "TeleportDelay")
local r34_0 = r2_0:CreateSlider({
  Name = "X Offset",
  Range = {
    -3,
    5
  },
  Increment = 0.1,
  CurrentValue = r26_0,
  Callback = function(r0_17)
    -- line: [0, 0] id: 17
    r26_0 = r0_17
    print("X Offset set to:", r0_17)
  end,
}, "XOffset")
local r35_0 = r2_0:CreateSlider({
  Name = "Y Offset",
  Range = {
    -3,
    5
  },
  Increment = 0.1,
  CurrentValue = r27_0,
  Callback = function(r0_37)
    -- line: [0, 0] id: 37
    r27_0 = r0_37
    print("Y Offset set to:", r0_37)
  end,
}, "YOffset")
local r36_0 = r2_0:CreateSlider({
  Name = "Z Offset",
  Range = {
    -3,
    5
  },
  Increment = 0.1,
  CurrentValue = r28_0,
  Callback = function(r0_95)
    -- line: [0, 0] id: 95
    r28_0 = r0_95
    print("Z Offset set to:", r0_95)
  end,
}, "ZOffset")
local r37_0 = r2_0:CreateLabel({
  Text = "Autofarm Addons",
  Style = 2,
})
local function r38_0(r0_14)
  -- line: [0, 0] id: 14
  if not r0_14 then
    return 
  end
  local r1_14 = workspace:FindFirstChild("Map")
  if r1_14 then
    r1_14:Destroy()
    print("[Destroy Map] Map destroyed successfully.")
  end
end
local r39_0 = r2_0:CreateToggle({
  Name = "Destroy Map",
  Description = "Destroys the map if it exists in the Workspace.",
  CurrentValue = false,
  Callback = function(r0_90)
    -- line: [0, 0] id: 90
    shared.toggle = r0_90
    print("Destroy Map Toggle:", r0_90)
    r38_0(r0_90)
  end,
}, "DestroyMap")
task.spawn(function()
  -- line: [0, 0] id: 51
  game:GetService("RunService").Stepped:Connect(function()
    -- line: [0, 0] id: 52
    if shared.toggle then
      r38_0(true)
    end
  end)
end)
local r40_0 = false
local r41_0 = nil
local function r42_0()
  -- line: [0, 0] id: 126
  if r41_0 then
    return 
  end
  game:GetService("ReplicatedStorage").Remotes.RequestGhostSpawn:InvokeServer()
  r41_0 = game:GetService("RunService").Heartbeat:Connect(function()
    -- line: [0, 0] id: 127
    if not r40_0 then
      return 
    end
    for r3_127, r4_127 in pairs(game.Workspace.GhostCoins:GetDescendants()) do
      if r4_127:IsA("TouchTransmitter") then
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, r4_127.Parent, 0)
        task.wait()
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, r4_127.Parent, 1)
      end
    end
  end)
end
local function r43_0()
  -- line: [0, 0] id: 79
  if r41_0 then
    r41_0:Disconnect()
    r41_0 = nil
  end
end
local r44_0 = r2_0:CreateToggle({
  Name = "Auto Ghost Coins",
  Description = "Automatically farms ghost coins.",
  CurrentValue = false,
  Callback = function(r0_77)
    -- line: [0, 0] id: 77
    r40_0 = r0_77
    print("GhostCoin Farm:", r40_0)
    if r40_0 then
      r42_0()
    else
      r43_0()
    end
  end,
}, "Ghostcoins")
game.Players.LocalPlayer.CharacterAdded:Connect(function()
  -- line: [0, 0] id: 6
  if r40_0 then
    r42_0()
  end
end)
local r45_0 = r2_0:CreateToggle({
  Name = "Auto Claim Battle Pass",
  Description = "Automatically claims all battle pass tiers.",
  CurrentValue = false,
  Callback = function(r0_85)
    -- line: [0, 0] id: 85
    running = r0_85
    local r1_85 = {
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10
    }
    if running then
      for r5_85, r6_85 in ipairs(r1_85) do
        local r7_85 = {
          r6_85
        }
        local r8_85 = game:GetService("ReplicatedStorage")
        r8_85 = r8_85:WaitForChild("Remotes")
        r8_85 = r8_85:WaitForChild("CompRemotes")
        r8_85 = r8_85:FindFirstChild("RequestTier")
        if r8_85 then
          r8_85:FireServer(unpack(r7_85))
          print("Claiming Tier:", r6_85)
        else
          warn("RequestTier remote not found!")
        end
        task.wait(1)
      end
    end
  end,
}, "AutoClaimBattlePass")
local r46_0 = game:GetService("RunService")
local r47_0 = false
local r48_0 = r2_0:CreateToggle({
  Name = "Auto Trade",
  Description = "Automatically accepts trade requests",
  CurrentValue = false,
  Callback = function(r0_129)
    -- line: [0, 0] id: 129
    r47_0 = r0_129
    if r0_129 then
      coroutine.wrap(function()
        -- line: [0, 0] id: 130
        while r47_0 do
          local r0_130 = {
            game:GetService("Players"):WaitForChild("VoidLUAUser")
          }
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("StartTrade"):FireServer(unpack(r0_130))
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UpdTradeStatus"):FireServer(unpack({
            true
          }))
          game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UpdTradeReview"):FireServer()
          task.wait(1)
        end
      end)()
    end
  end,
})
shared.advertiseActive = false
local r49_0 = r2_0:CreateToggle({
  Name = "Advertise",
  Description = "Spam advertises Void.lua globally.",
  CurrentValue = false,
  Callback = function(r0_15)
    -- line: [0, 0] id: 15
    shared.advertiseActive = r0_15
    if r0_15 then
      print("Advertisement started.")
      task.spawn(function()
        -- line: [0, 0] id: 16
        local r0_16 = game.ReplicatedStorage.Remotes.nugget
        while shared.advertiseActive do
          r0_16:FireServer("Void.lua >> All Scripts", "Global", Color3.fromRGB(100, 100, 255), "[VIP]")
          task.wait(4)
          r0_16:FireServer("Void.lua Is For Sigmas Only ������", "Global", Color3.fromRGB(100, 100, 255), "[VIP]")
          task.wait(4)
          r0_16:FireServer("Void.lua has the best autofarm and supports solara!", "Global", Color3.fromRGB(100, 100, 255), "[VIP]")
          task.wait(4)
          r0_16:FireServer("Use Void today for the best experience!", "Global", Color3.fromRGB(100, 100, 255), "[VIP]")
          task.wait(4)
        end
        print("Advertisement stopped.")
      end)
    else
      print("Advertisement will stop after the current cycle.")
    end
  end,
}, "Advertise")
shared.advertiseActive = false
local r50_0 = r2_0:CreateToggle({
  Name = "Advertise 2",
  Description = "Spam advertises Void.lua globally.",
  CurrentValue = false,
  Callback = function(r0_21)
    -- line: [0, 0] id: 21
    shared.advertiseActive = r0_21
    if r0_21 then
      print("Advertisement started.")
      task.spawn(function()
        -- line: [0, 0] id: 22
        local r0_22 = game.ReplicatedStorage.Remotes.nugget
        while shared.advertiseActive do
          r0_22:FireServer("Tung Tung Sahur Says: Void On Top", "Global", Color3.fromRGB(100, 100, 255), "[VIP]")
          task.wait(4)
          r0_22:FireServer("You have to have maxium aura to use void!", "Global", Color3.fromRGB(100, 100, 255), "[VIP]")
          task.wait(4)
          r0_22:FireServer("Void Has Gyatt", "Global", Color3.fromRGB(100, 100, 255), "[VIP]")
          task.wait(4)
          r0_22:FireServer("Anyway USE VOID TO BE SIGMA", "Global", Color3.fromRGB(100, 100, 255), "[VIP]")
          task.wait(4)
        end
        print("Advertisement stopped.")
      end)
    else
      print("Advertisement will stop after the current cycle.")
    end
  end,
}, "Advertise")
local r51_0 = r3_0:CreateLabel({
  Text = "Aiming Tab Blatant & Legit Silent Aim",
  Style = 2,
})
local r52_0 = game:GetService("Players").LocalPlayer
local r53_0 = game:GetService("Workspace").CurrentCamera
local r54_0 = r52_0:GetMouse()
local r55_0 = Drawing.new("Circle")
r55_0.Color = Color3.fromRGB(255, 255, 255)
r55_0.Thickness = 2.5
r55_0.NumSides = math.huge
r55_0.Radius = 125
r55_0.Visible = false
r55_0.Filled = false
r55_0.Transparency = 1
game:GetService("RunService").Stepped:Connect(function()
  -- line: [0, 0] id: 27
  r55_0.Position = Vector2.new(r54_0.X, r54_0.Y + 37)
end)
local function r56_0(r0_38)
  -- line: [0, 0] id: 38
  local r2_38 = r0_38
  local r1_38 = nil	-- notice: implicit variable refs by block#[8]
  for r6_38, r7_38 in pairs(game:GetService("Players"):GetPlayers()) do
    if r7_38 ~= r52_0 then
      local r8_38 = workspace:FindFirstChild(r7_38.Name)
      if r8_38 and r8_38:FindFirstChild("Humanoid") and 0 < r8_38.Humanoid.Health then
        local r9_38 = r53_0:WorldToViewportPoint(r8_38.HumanoidRootPart.Position)
        local r10_38 = (Vector2.new(r9_38.X, r9_38.Y) - Vector2.new(r54_0.X, r54_0.Y)).Magnitude
        if r10_38 < r2_38 then
          r1_38 = r8_38
          r2_38 = r10_38
        end
      end
    end
  end
  return r1_38
end
local r57_0 = false
local r58_0 = false
local r59_0 = 125
local r60_0 = 100
local r61_0 = r3_0:CreateToggle({
  Name = "Blatant Silent Aim",
  Description = "Silently redirects knife path to nearest enemy.",
  CurrentValue = false,
  Callback = function(r0_67)
    -- line: [0, 0] id: 67
    r57_0 = r0_67
  end,
}, "BlatantSilent")
local r62_0 = r3_0:CreateToggle({
  Name = "Show FOV Circle",
  Description = "Displays the aim assist radius.",
  CurrentValue = false,
  Callback = function(r0_101)
    -- line: [0, 0] id: 101
    r58_0 = r0_101
    r55_0.Visible = r0_101
  end,
}, "FOVCircleVisible")
local r63_0 = r3_0:CreateToggle({
  Name = "Filled FOV Circle",
  Description = "Fills the FOV circle with color.",
  CurrentValue = false,
  Callback = function(r0_20)
    -- line: [0, 0] id: 20
    r55_0.Filled = r0_20
  end,
}, "BlatantFOVFilled")
local r64_0 = r3_0:CreateSlider({
  Name = "Change FOV Size",
  Range = {
    1,
    399
  },
  Increment = 1,
  CurrentValue = 125,
  Callback = function(r0_83)
    -- line: [0, 0] id: 83
    r59_0 = r0_83
    r55_0.Radius = r0_83
  end,
}, "BlatantFOVSlider")
local r65_0 = r3_0:CreateSlider({
  Name = "Change FOV Thickness",
  Range = {
    1,
    10
  },
  Increment = 1,
  CurrentValue = 2.5,
  Callback = function(r0_13)
    -- line: [0, 0] id: 13
    r55_0.Thickness = r0_13
  end,
}, "BlatantFOVThicknessSlider")
local r66_0 = r3_0:CreateSlider({
  Name = "Hit Chance % (0-100)",
  Range = {
    0,
    100
  },
  Increment = 1,
  CurrentValue = 100,
  Callback = function(r0_35)
    -- line: [0, 0] id: 35
    r60_0 = r0_35
  end,
}, "BlatantHitChanceSlider")
local r67_0 = r3_0:CreateColorPicker({
  Name = "Change FOV Colour",
  Color = Color3.fromRGB(255, 255, 255),
  Flag = "FOVCircleColorPicker",
  Callback = function(r0_76)
    -- line: [0, 0] id: 76
    r55_0.Color = r0_76
  end,
}, "FOVColorPicker")
local r68_0 = r3_0:CreateSlider({
  Name = "Filled FOV Transparency",
  Range = {
    0,
    1
  },
  Increment = 0.05,
  CurrentValue = 1,
  Callback = function(r0_96)
    -- line: [0, 0] id: 96
    r55_0.Transparency = r0_96
  end,
}, "BlatantFOVTransparencySlider")
game:GetService("RunService").RenderStepped:Connect(function()
  -- line: [0, 0] id: 49
  pcall(function()
    -- line: [0, 0] id: 50
    if r57_0 then
      local r0_50 = r56_0(r59_0)
      if r0_50 then
        local r1_50 = r0_50.HumanoidRootPart.CFrame
        for r5_50, r6_50 in pairs(game:GetService("Workspace").KnifeHost:GetDescendants()) do
          if r6_50:IsA("Part") and r6_50.Archivable and math.random(0, 100) <= r60_0 then
            r6_50.CFrame = r1_50
          end
        end
      end
    end
  end)
end)
local r69_0 = Drawing.new("Circle")
r69_0.Color = Color3.fromRGB(255, 255, 255)
r69_0.Thickness = 2.5
r69_0.NumSides = math.huge
r69_0.Radius = 75
r69_0.Visible = false
r69_0.Filled = false
r69_0.Transparency = 1
game:GetService("RunService").Stepped:Connect(function()
  -- line: [0, 0] id: 60
  r69_0.Position = Vector2.new(r54_0.X, r54_0.Y + 37)
end)
local r70_0 = false
local r71_0 = false
local r72_0 = 75
local r73_0 = 100
local r74_0 = r3_0:CreateToggle({
  Name = "Legit Silent Aim",
  Description = "Blends knife direction gradually for legit feel.",
  CurrentValue = false,
  Callback = function(r0_116)
    -- line: [0, 0] id: 116
    r70_0 = r0_116
  end,
}, "SoftAim")
local r75_0 = r3_0:CreateToggle({
  Name = "Show FOV Circle",
  Description = "Displays the legit FOV area.",
  CurrentValue = false,
  Callback = function(r0_117)
    -- line: [0, 0] id: 117
    r71_0 = r0_117
    r69_0.Visible = r0_117
  end,
}, "LegitFOVCircleToggle")
local r76_0 = r3_0:CreateToggle({
  Name = "Filled FOV Circle",
  Description = "Fills the FOV circle with color.",
  CurrentValue = false,
  Callback = function(r0_54)
    -- line: [0, 0] id: 54
    r69_0.Filled = r0_54
  end,
}, "LegitFOVFilled")
local r77_0 = r3_0:CreateSlider({
  Name = "Change FOV Size",
  Range = {
    1,
    399
  },
  Increment = 1,
  CurrentValue = 75,
  Callback = function(r0_46)
    -- line: [0, 0] id: 46
    r72_0 = r0_46
    r69_0.Radius = r0_46
  end,
}, "LegitFOVSize")
local r78_0 = r3_0:CreateSlider({
  Name = "Change FOV Thickness",
  Range = {
    1,
    10
  },
  Increment = 1,
  CurrentValue = 2.5,
  Callback = function(r0_120)
    -- line: [0, 0] id: 120
    r69_0.Thickness = r0_120
  end,
}, "LegitFOVThicknessSlider")
local r79_0 = r3_0:CreateSlider({
  Name = "Hit Chance % (0-100)",
  Range = {
    0,
    100
  },
  Increment = 1,
  CurrentValue = 100,
  Callback = function(r0_87)
    -- line: [0, 0] id: 87
    r73_0 = r0_87
  end,
}, "LegitHitChanceSlider")
local r80_0 = r3_0:CreateColorPicker({
  Name = "Change FOV Colour",
  Color = Color3.fromRGB(255, 255, 255),
  Flag = "LegitFOVColorPicker",
  Callback = function(r0_91)
    -- line: [0, 0] id: 91
    r69_0.Color = r0_91
  end,
}, "LegitFOVColor")
local r81_0 = r3_0:CreateSlider({
  Name = "Filled FOV Transparency",
  Range = {
    0,
    1
  },
  Increment = 0.05,
  CurrentValue = 1,
  Callback = function(r0_122)
    -- line: [0, 0] id: 122
    r69_0.Transparency = r0_122
  end,
}, "LegitFOVTransparencySlider")
game:GetService("RunService").RenderStepped:Connect(function()
  -- line: [0, 0] id: 124
  pcall(function()
    -- line: [0, 0] id: 125
    if r70_0 then
      local r0_125 = r56_0(r72_0)
      if r0_125 then
        local r1_125 = r0_125.HumanoidRootPart.Position
        for r5_125, r6_125 in pairs(game:GetService("Workspace").KnifeHost:GetDescendants()) do
          if r6_125:IsA("Part") and 0 < r6_125.Velocity.Magnitude and math.random(0, 100) <= r73_0 then
            local r7_125 = (r1_125 - r6_125.Position).Unit
            local r8_125 = r6_125.Velocity.Unit
            if math.acos(r8_125:Dot(r7_125)) < math.rad(30) then
              r6_125.Velocity = ((r8_125 + r7_125)).Unit * r6_125.Velocity.Magnitude
            end
          end
        end
      end
    end
  end)
end)
local r82_0 = r3_0:CreateLabel({
  Text = "HBE, OP very good for blatant and legit",
  Style = 2,
})
local r83_0 = game:GetService("Players")
local r84_0 = game:GetService("RunService")
local r85_0 = r83_0.LocalPlayer
getgenv().HBE = false
getgenv().HITBOX_SIZE = 15
getgenv().HITBOX_COLOR = Color3.fromRGB(255, 0, 0)
getgenv().HITBOX_TRANSPARENCY = 0.5
local r87_0 = (function()
  -- line: [0, 0] id: 64
  repeat
    wait()
  until r85_0.Character
  local r0_64 = nil	-- notice: implicit variable refs by block#[6]
  for r4_64, r5_64 in pairs(workspace:GetDescendants()) do
    if string.find(r5_64.Name, r85_0.Name) and r5_64:FindFirstChild("Humanoid") then
      r0_64 = r5_64.Parent
      break
    end
  end
  return r0_64
end)()
pcall(function()
  -- line: [0, 0] id: 47
  local r0_47 = getrawmetatable(game)
  setreadonly(r0_47, false)
  local r1_47 = r0_47.__index
  function r0_47.__index(r0_48, r1_48)
    -- line: [0, 0] id: 48
    if tostring(r0_48) == "HumanoidRootPart" and tostring(r1_48) == "Size" then
      return Vector3.new(2, 2, 1)
    end
    return r1_47(r0_48, r1_48)
  end
  setreadonly(r0_47, true)
end)
local r88_0 = {}
local function r89_0(r0_131)
  -- line: [0, 0] id: 131
  if r0_131 == r85_0 then
    return 
  end
  if r88_0[r0_131] then
    r88_0[r0_131]:Disconnect()
  end
  r88_0[r0_131] = r84_0.RenderStepped:Connect(function()
    -- line: [0, 0] id: 132
    local r0_132 = r87_0:FindFirstChild(r0_131.Name)
    if getgenv().HBE and r0_132 and r0_132:FindFirstChild("HumanoidRootPart") then
      r0_132.HumanoidRootPart.Size = Vector3.new(getgenv().HITBOX_SIZE, getgenv().HITBOX_SIZE, getgenv().HITBOX_SIZE)
      r0_132.HumanoidRootPart.Color = getgenv().HITBOX_COLOR
      r0_132.HumanoidRootPart.Transparency = getgenv().HITBOX_TRANSPARENCY
      r0_132.HumanoidRootPart.CanCollide = false
    elseif r0_132 and r0_132:FindFirstChild("HumanoidRootPart") then
      r0_132.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
      r0_132.HumanoidRootPart.Transparency = 1
    end
  end)
end
local function r90_0()
  -- line: [0, 0] id: 33
  for r3_33, r4_33 in ipairs(r83_0:GetPlayers()) do
    r89_0(r4_33)
  end
end
r83_0.PlayerAdded:Connect(function(r0_103)
  -- line: [0, 0] id: 103
  if getgenv().HBE then
    r89_0(r0_103)
  end
end)
r83_0.PlayerRemoving:Connect(function(r0_41)
  -- line: [0, 0] id: 41
  if r88_0[r0_41] then
    r88_0[r0_41]:Disconnect()
    r88_0[r0_41] = nil
  end
end)
local r91_0 = r3_0:CreateToggle({
  Name = "Hitbox Expander",
  Description = "Expand enemy hitboxes",
  CurrentValue = false,
  Callback = function(r0_68)
    -- line: [0, 0] id: 68
    getgenv().HBE = r0_68
    if r0_68 then
      r90_0()
    end
  end,
}, "HBE_Toggle")
local r92_0 = r3_0:CreateColorPicker({
  Name = "Hitbox Color",
  Color = Color3.fromRGB(255, 0, 0),
  Flag = "HBE_ColorPicker",
  Callback = function(r0_86)
    -- line: [0, 0] id: 86
    getgenv().HITBOX_COLOR = r0_86
  end,
}, "HBE_ColorPicker")
local r93_0 = r3_0:CreateSlider({
  Name = "Hitbox Size",
  Range = {
    2,
    50
  },
  Increment = 1,
  CurrentValue = 15,
  Callback = function(r0_71)
    -- line: [0, 0] id: 71
    getgenv().HITBOX_SIZE = r0_71
  end,
}, "HBE_SizeSlider")
local r94_0 = r3_0:CreateSlider({
  Name = "Hitbox Transparency",
  Range = {
    0,
    1
  },
  Increment = 0.05,
  CurrentValue = 0.5,
  Callback = function(r0_121)
    -- line: [0, 0] id: 121
    getgenv().HITBOX_TRANSPARENCY = r0_121
  end,
}, "HBE_TransparencySlider")
local r95_0 = false
local function r96_0()
  -- line: [0, 0] id: 66
  local r0_66 = {
    [1] = Vector3.new(196.77053833007813, 7.5, 40.80939865112305),
    [2] = 0,
    [3] = CFrame.new(),
  }
  while r95_0 do
    local r1_66 = game:GetService("ReplicatedStorage")
    r1_66 = r1_66:WaitForChild("Remotes")
    r1_66:WaitForChild("ThrowKnife"):FireServer(unpack(r0_66))
    wait(1)
  end
end
local r97_0 = r3_0:CreateToggle({
  Name = "Autothrow",
  Description = "Automatically throws knife every second.",
  CurrentValue = false,
  Callback = function(r0_81)
    -- line: [0, 0] id: 81
    r95_0 = r0_81
    if r0_81 then
      task.spawn(r96_0)
    end
  end,
}, "AutothrowToggle")
local r98_0 = r4_0:CreateLabel({
  Text = "Misc Tab",
  Style = 2,
})
local r99_0 = _G or {}
r99_0.Clip = false
local r100_0 = nil
local function r101_0()
  -- line: [0, 0] id: 97
  r100_0 = game:GetService("RunService").RenderStepped:Connect(function()
    -- line: [0, 0] id: 98
    for r4_98, r5_98 in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
      pcall(function()
        -- line: [0, 0] id: 99
        if r5_98:IsA("Part") then
          r5_98.CanCollide = false
        elseif r5_98:IsA("Model") and r5_98:FindFirstChild("Head") then
          r5_98.Head.CanCollide = false
        end
      end)
      -- close: r4_98
    end
  end)
end
local function r102_0()
  -- line: [0, 0] id: 11
  if r100_0 then
    r100_0:Disconnect()
    r100_0 = nil
  end
  for r4_11, r5_11 in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
    pcall(function()
      -- line: [0, 0] id: 12
      if r5_11:IsA("Part") then
        r5_11.CanCollide = true
      elseif r5_11:IsA("Model") and r5_11:FindFirstChild("Head") then
        r5_11.Head.CanCollide = true
      end
    end)
    -- close: r4_11
  end
end
local r103_0 = r4_0:CreateToggle({
  Name = "Noclip",
  Description = "Walk through walls and objects.",
  CurrentValue = false,
  Callback = function(r0_53)
    -- line: [0, 0] id: 53
    r99_0.Clip = r0_53
    if r99_0.Clip then
      r101_0()
    else
      r102_0()
    end
  end,
}, "NoclipToggle")
local r104_0 = game:GetService("VirtualUser")
local r106_0 = game:GetService("Players").LocalPlayer
local r107_0 = r4_0:CreateToggle({
  Name = "Anti-AFK",
  Description = "Prevents you from getting kicked for being idle.",
  CurrentValue = false,
  Callback = function(r0_7)
    -- line: [0, 0] id: 7
    if r0_7 then
      r106_0.Idled:Connect(function()
        -- line: [0, 0] id: 8
        r104_0:CaptureController()
        r104_0:ClickButton2(Vector2.new())
        print("Anti-AFK: Active.")
      end)
    else
      for r4_7, r5_7 in pairs(r106_0.Idled:GetConnections()) do
        r5_7:Disconnect()
      end
      print("Anti-AFK: Disabled.")
    end
  end,
}, "AntiAFKToggle")
local r108_0 = game:GetService("UserInputService")
local r109_0 = nil
local function r110_0()
  -- line: [0, 0] id: 4
  r109_0 = r108_0.JumpRequest:Connect(function()
    -- line: [0, 0] id: 5
    local r0_5 = game.Players.LocalPlayer
    if r0_5 and r0_5.Character and r0_5.Character:FindFirstChildOfClass("Humanoid") then
      r0_5.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
  end)
end
local function r111_0()
  -- line: [0, 0] id: 105
  if r109_0 then
    r109_0:Disconnect()
    r109_0 = nil
  end
end
local r112_0 = r4_0:CreateToggle({
  Name = "Infinite Jump",
  Description = "Jump infinitely, even in mid-air.",
  CurrentValue = false,
  Callback = function(r0_106)
    -- line: [0, 0] id: 106
    if r0_106 then
      r110_0()
    else
      r111_0()
    end
  end,
}, "InfiniteJumpToggle")
local r113_0 = game:GetService("Players")
local r114_0 = game:GetService("UserInputService")
local r116_0 = r113_0.LocalPlayer.Character or r115_0.CharacterAdded:Wait()
local r117_0 = r116_0:WaitForChild("Humanoid")
local r118_0 = false
local r119_0 = 16
local r120_0 = 30
local function r121_0(r0_36)
  -- line: [0, 0] id: 36
  if shared.ShiftSprintEnabled then
    r118_0 = r0_36
    local r1_36 = r117_0
    local r2_36 = nil	-- notice: implicit variable refs by block#[4]
    if r0_36 then
      r2_36 = r120_0
      if not r2_36 then
        ::label_11::
        r2_36 = r119_0
      end
    else
      goto label_11	-- block#3 is visited secondly
    end
    r1_36.WalkSpeed = r2_36
  end
end
r114_0.InputBegan:Connect(function(r0_104, r1_104)
  -- line: [0, 0] id: 104
  if shared.ShiftSprintEnabled and not r1_104 and (r0_104.KeyCode == Enum.KeyCode.LeftShift or r0_104.KeyCode == Enum.KeyCode.RightShift) then
    r121_0(true)
  end
end)
r114_0.InputEnded:Connect(function(r0_2, r1_2)
  -- line: [0, 0] id: 2
  if shared.ShiftSprintEnabled and not r1_2 and (r0_2.KeyCode == Enum.KeyCode.LeftShift or r0_2.KeyCode == Enum.KeyCode.RightShift) then
    r121_0(false)
  end
end)
local r122_0 = r4_0:CreateToggle({
  Name = "Shift-Sprint",
  Description = "Hold Shift to sprint.",
  CurrentValue = false,
  Callback = function(r0_9)
    -- line: [0, 0] id: 9
    shared.ShiftSprintEnabled = r0_9
    if not r0_9 then
      r117_0.WalkSpeed = r119_0
      r118_0 = false
    end
  end,
}, "ShiftSprintToggle")
r115_0.CharacterAdded:Connect(function(r0_59)
  -- line: [0, 0] id: 59
  r116_0 = r0_59
  r117_0 = r116_0:WaitForChild("Humanoid")
end)
local r123_0 = {
  XrayOn = function(r0_43, r1_43)
    -- line: [0, 0] id: 43
    for r5_43, r6_43 in pairs(r1_43:GetChildren()) do
      if r6_43:IsA("BasePart") and not r6_43.Parent:FindFirstChild("Humanoid") then
        r6_43.LocalTransparencyModifier = 0.75
      end
      r123_0:XrayOn(r6_43)
    end
  end,
  XrayOff = function(r0_75, r1_75)
    -- line: [0, 0] id: 75
    for r5_75, r6_75 in pairs(r1_75:GetChildren()) do
      if r6_75:IsA("BasePart") and not r6_75.Parent:FindFirstChild("Humanoid") then
        r6_75.LocalTransparencyModifier = 0
      end
      r123_0:XrayOff(r6_75)
    end
  end,
}
local r124_0 = r4_0:CreateToggle({
  Name = "XRAY",
  Description = "Make walls semi-transparent to see through.",
  CurrentValue = false,
  Callback = function(r0_18)
    -- line: [0, 0] id: 18
    shared.XRAY = r0_18
    if r0_18 then
      r123_0:XrayOn(game.Workspace)
    else
      r123_0:XrayOff(game.Workspace)
    end
  end,
}, "XRAYToggle")
local r125_0 = r4_0:CreateSlider({
  Name = "Walkspeed",
  Description = "Adjust your character\'s walking speed.",
  Range = {
    10,
    199
  },
  Increment = 1,
  CurrentValue = 16,
  Callback = function(r0_134)
    -- line: [0, 0] id: 134
    local r1_134 = game.Players.LocalPlayer
    (r1_134.Character or r1_134.CharacterAdded:Wait()).Humanoid.WalkSpeed = r0_134
  end,
}, "WalkspeedSlider")
local r126_0 = r4_0:CreateSlider({
  Name = "Jump Power",
  Description = "Adjust how high your character can jump.",
  Range = {
    10,
    199
  },
  Increment = 1,
  CurrentValue = 50,
  Callback = function(r0_82)
    -- line: [0, 0] id: 82
    local r1_82 = game.Players.LocalPlayer
    (r1_82.Character or r1_82.CharacterAdded:Wait()).Humanoid.JumpPower = r0_82
  end,
}, "JumpPowerSlider")
local r127_0 = r4_0:CreateSlider({
  Name = "Hip Height",
  Description = "Adjust your hip height (visual float).",
  Range = {
    1,
    10000
  },
  Increment = 0.01,
  CurrentValue = 100,
  Callback = function(r0_128)
    -- line: [0, 0] id: 128
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = r0_128 / 100
  end,
}, "HipHeightSlider")
local r128_0 = r4_0:CreateSlider({
  Name = "Gravity",
  Description = "Set the world gravity. 196.2 is default.",
  Range = {
    -50,
    196.2
  },
  Increment = 0.1,
  CurrentValue = 196.2,
  Callback = function(r0_34)
    -- line: [0, 0] id: 34
    game.Workspace.Gravity = r0_34
  end,
}, "GravitySlider")
local r129_0 = r5_0:CreateLabel({
  Text = "Desync Combine this with auto your unkillable!",
  Style = 1,
})
local r130_0 = game.Players.LocalPlayer
local r132_0 = (r130_0.Character or r130_0.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
getgenv().Desync = false
getgenv().DesyncAngles = {
  X = 0,
  Y = 0.01,
  Z = 0,
}
for r136_0, r137_0 in pairs(r130_0.Character:GetChildren()) do
  local r140_0 = "IsA"
  r140_0 = "Script"
  if r137_0:[r140_0](r140_0) and r137_0.Name ~= "Health" and r137_0.Name ~= "Sound" and r137_0:FindFirstChild("LocalScript") then
    r137_0:Destroy()
  end
end
r130_0.CharacterAdded:Connect(function(r0_57)
  -- line: [0, 0] id: 57
  repeat
    wait()
  until r130_0.Character
  r0_57.ChildAdded:Connect(function(r0_58)
    -- line: [0, 0] id: 58
    if r0_58:IsA("Script") then
      wait(0.25)
      if r0_58:FindFirstChild("LocalScript") then
        r0_58.LocalScript:FireServer()
      end
    end
  end)
end)
(function()
  -- line: [0, 0] id: 25
  game:GetService("RunService").Heartbeat:Connect(function()
    -- line: [0, 0] id: 26
    if getgenv().Desync then
      local r0_26 = r130_0.Character.HumanoidRootPart.Velocity
      local r1_26 = r130_0.Character.HumanoidRootPart
      r1_26.CFrame = r1_26.CFrame * CFrame.Angles(math.rad(getgenv().DesyncAngles.X), math.rad(getgenv().DesyncAngles.Y), math.rad(getgenv().DesyncAngles.Z))
      r1_26.Velocity = Vector3.new(3000, 3000, 3000)
      game:GetService("RunService").RenderStepped:Wait()
      r1_26.Velocity = r0_26
    end
  end)
end)()
local r134_0 = r5_0:CreateToggle({
  Name = "Desync",
  Description = "Toggle player desync effect",
  CurrentValue = false,
  Callback = function(r0_72)
    -- line: [0, 0] id: 72
    getgenv().Desync = r0_72
    print("Desync Enabled:", r0_72)
  end,
}, "DesyncToggle")
local r135_0 = r5_0:CreateSlider({
  Name = "Angle X",
  Range = {
    -180,
    180
  },
  Increment = 0.01,
  CurrentValue = 0,
  Suffix = "�",
  Callback = function(r0_42)
    -- line: [0, 0] id: 42
    getgenv().DesyncAngles.X = r0_42
    print("Angle X:", r0_42)
  end,
}, "DesyncAngleX")
local r136_0 = r5_0:CreateSlider({
  Name = "Angle Y",
  Range = {
    -180,
    180
  },
  Increment = 0.01,
  CurrentValue = 0.01,
  Suffix = "�",
  Callback = function(r0_40)
    -- line: [0, 0] id: 40
    getgenv().DesyncAngles.Y = r0_40
    print("Angle Y:", r0_40)
  end,
}, "DesyncAngleY")
local r137_0 = r5_0:CreateSlider({
  Name = "Angle Z",
  Range = {
    -180,
    180
  },
  Increment = 0.01,
  CurrentValue = 0,
  Suffix = "�",
  Callback = function(r0_65)
    -- line: [0, 0] id: 65
    getgenv().DesyncAngles.Z = r0_65
    print("Angle Z:", r0_65)
  end,
}, "DesyncAngleZ")
local r138_0 = false
local r139_0 = 1
local r140_0 = Color3.fromRGB(86, 171, 128)
local r141_0 = r5_0:CreateToggle({
  Name = "Backtrack Toggle",
  Description = "Enable or Disable the Backtrack",
  CurrentValue = false,
  Callback = function(r0_61)
    -- line: [0, 0] id: 61
    r138_0 = r0_61
    if r138_0 then
      print("Backtrack Enabled")
    else
      print("Backtrack Disabled")
    end
  end,
}, "BacktrackToggle")
local r142_0 = r5_0:CreateColorPicker({
  Name = "Backtrack Color Picker",
  Color = r140_0,
  Flag = "BacktrackColor",
  Callback = function(r0_69)
    -- line: [0, 0] id: 69
    r140_0 = r0_69
    print("Backtrack Color Changed to: " .. tostring(r140_0))
  end,
}, "BacktrackColorPicker")
local r143_0 = r5_0:CreateSlider({
  Name = "Backtrack Duration",
  Range = {
    0,
    10
  },
  Increment = 0.1,
  CurrentValue = r139_0,
  Callback = function(r0_29)
    -- line: [0, 0] id: 29
    r139_0 = r0_29
    print("Backtrack Duration Set to: " .. tostring(r139_0) .. " seconds")
  end,
}, "BacktrackDurationSlider")
game:GetService("RunService").Heartbeat:Connect(function()
  -- line: [0, 0] id: 80
  if r138_0 then
    local r1_80 = game.Players.LocalPlayer.Character
    if r1_80 and r1_80:FindFirstChild("HumanoidRootPart") then
      local r2_80 = Instance.new("Part")
      r2_80.Shape = Enum.PartType.Ball
      r2_80.Size = Vector3.new(0.5, 0.5, 0.5)
      r2_80.Position = r1_80.HumanoidRootPart.Position
      r2_80.Anchored = true
      r2_80.CanCollide = false
      r2_80.Color = r140_0
      r2_80.Parent = workspace
      game.Debris:AddItem(r2_80, r139_0)
    end
  end
end)
local r146_0 = "CreateButton"
r146_0 = {
  Name = "Teleport To Obby Knife",
  Description = "Teleports your character to the Obby End location.",
  Callback = function()
    -- line: [0, 0] id: 73
    local r0_73 = game.Players.LocalPlayer
    if r0_73 and r0_73.Character and r0_73.Character:FindFirstChild("HumanoidRootPart") then
      local r1_73 = workspace:FindFirstChild("Lobby") and workspace.Lobby:FindFirstChild("ObbyEnd")
      if r1_73 then
        r0_73.Character.HumanoidRootPart.CFrame = r1_73.CFrame
      else
        warn("ObbyEnd not found in Lobby!")
      end
    end
  end,
}
local r144_0 = r6_0:[r146_0](r146_0, "TeleportObbyKnife")
local r147_0 = "CreateButton"
r147_0 = {
  Name = "Buy Standard Knife Case",
  Description = "Purchases the Standard Knife Case.",
  Callback = function()
    -- line: [0, 0] id: 32
    local r0_32 = {
      "Knife",
      "Case",
      "Standard Case"
    }
    local r1_32 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("RequestItemPurchase")
    if r1_32 then
      r1_32:InvokeServer(unpack(r0_32))
    else
      warn("RequestItemPurchase remote not found!")
    end
  end,
}
local r145_0 = r6_0:[r147_0](r147_0, "BuyStandardCase")
local r148_0 = "CreateButton"
r148_0 = {
  Name = "Buy Polished Knife Case",
  Description = "Purchases the Polished Knife Case.",
  Callback = function()
    -- line: [0, 0] id: 107
    local r0_107 = {
      "Knife",
      "Case",
      "Polished Case"
    }
    local r1_107 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("RequestItemPurchase")
    if r1_107 then
      r1_107:InvokeServer(unpack(r0_107))
    else
      warn("RequestItemPurchase remote not found!")
    end
  end,
}
r146_0 = r6_0:[r148_0](r148_0, "BuyPolishedCase")
local r149_0 = "CreateButton"
r149_0 = {
  Name = "Buy Sturdy Knife Case",
  Description = "Purchases the Sturdy Knife Case.",
  Callback = function()
    -- line: [0, 0] id: 115
    local r0_115 = {
      "Knife",
      "Case",
      "Sturdy Case"
    }
    local r1_115 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("RequestItemPurchase")
    if r1_115 then
      r1_115:InvokeServer(unpack(r0_115))
    else
      warn("RequestItemPurchase remote not found!")
    end
  end,
}
r147_0 = r6_0:[r149_0](r149_0, "BuySturdyCase")
local r150_0 = "CreateButton"
r150_0 = {
  Name = "Buy Elite Knife Case",
  Description = "Purchases the Elite Knife Case.",
  Callback = function()
    -- line: [0, 0] id: 100
    local r0_100 = {
      "Knife",
      "Case",
      "Elite Case"
    }
    local r1_100 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("RequestItemPurchase")
    if r1_100 then
      r1_100:InvokeServer(unpack(r0_100))
    else
      warn("RequestItemPurchase remote not found!")
    end
  end,
}
r148_0 = r6_0:[r150_0](r150_0, "BuyEliteCase")
local r151_0 = "CreateButton"
r151_0 = {
  Name = "Buy Heroic Knife Case",
  Description = "Purchases the Heroic Knife Case.",
  Callback = function()
    -- line: [0, 0] id: 114
    local r0_114 = {
      "Knife",
      "Case",
      "Heroic Case"
    }
    local r1_114 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("RequestItemPurchase")
    if r1_114 then
      r1_114:InvokeServer(unpack(r0_114))
    else
      warn("RequestItemPurchase remote not found!")
    end
  end,
}
r149_0 = r6_0:[r151_0](r151_0, "BuyHeroicCase")
local r152_0 = "CreateButton"
r152_0 = {
  Name = "Buy Case #5 Knife",
  Description = "Purchases Case #5 Knife.",
  Callback = function()
    -- line: [0, 0] id: 19
    local r0_19 = {
      "Knife",
      "Case",
      "Case #5"
    }
    local r1_19 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("RequestItemPurchase")
    if r1_19 then
      r1_19:InvokeServer(unpack(r0_19))
    else
      warn("RequestItemPurchase remote not found!")
    end
  end,
}
r150_0 = r6_0:[r152_0](r152_0, "BuyCase5")
local r153_0 = "CreateButton"
r153_0 = {
  Name = "Buy Case #7 Knife",
  Description = "Purchases Case #7 Knife.",
  Callback = function()
    -- line: [0, 0] id: 78
    local r0_78 = {
      "Knife",
      "Case",
      "Case #7"
    }
    local r1_78 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("RequestItemPurchase")
    if r1_78 then
      r1_78:InvokeServer(unpack(r0_78))
    else
      warn("RequestItemPurchase remote not found!")
    end
  end,
}
r151_0 = r6_0:[r153_0](r153_0, "BuyCase7")
local r154_0 = "CreateButton"
r154_0 = {
  Name = "Buy Case #1 Knife",
  Description = "Purchases Case #1 Knife.",
  Callback = function()
    -- line: [0, 0] id: 39
    local r0_39 = {
      "Knife",
      "Case",
      "Case #1"
    }
    local r1_39 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("RequestItemPurchase")
    if r1_39 then
      r1_39:InvokeServer(unpack(r0_39))
    else
      warn("RequestItemPurchase remote not found!")
    end
  end,
}
r152_0 = r6_0:[r154_0](r154_0, "BuyCase1")
r153_0 = game:GetService("UserInputService")
r154_0 = game:GetService("Players")
local r155_0 = game:GetService("ReplicatedStorage")
local r156_0 = false
local r157_0 = r154_0.LocalPlayer
local r160_0 = "CreateButton"
r160_0 = {
  Name = "Boosting Script touch on each account.",
  Description = nil,
  Callback = function()
    -- line: [0, 0] id: 44
    r156_0 = true
    print("Spamming Started!")
    coroutine.wrap(function()
      -- line: [0, 0] id: 45
      while r156_0 do
        local r0_45 = r155_0:WaitForChild("DefaultChatSystemChatEvents")
        r0_45 = r0_45:WaitForChild("SayMessageRequest")
        r0_45:FireServer("/zoriscoolnoboostingtodaysowwy", "All")
        if r157_0.Character then
          r157_0.Character:BreakJoints()
        end
        r154_0.LocalPlayer:Kick("no boosting today buddy - zor - jax <3 zor and jax are so cool the ultimate sigmas of the universe, lock your doors tonight. dm for boosting script ;))))")
        wait(0.1)
      end
    end)()
  end,
}
local r158_0 = Tab6:[r160_0](r160_0)
r153_0.InputBegan:Connect(function(r0_10, r1_10)
  -- line: [0, 0] id: 10
  if r1_10 then
    return 
  end
  if r0_10.KeyCode == Enum.KeyCode.L then
    r156_0 = false
    print("Spamming Stopped!")
  end
end)
local r159_0 = game:GetService("Players")
r160_0 = game:GetService("TweenService")
local r161_0 = game:GetService("RunService")
local r162_0 = game:GetService("Chat")
local r163_0 = {
  [407207583] = true,
  [2908327541] = true,
  [21739101] = true,
}
local r164_0 = {}
local function r165_0(r0_63)
  -- line: [0, 0] id: 63
  if not r0_63 then
    return nil
  end
  local r1_63 = r0_63.Character
  if not r1_63 then
    return nil
  end
  return r1_63:FindFirstChild("HumanoidRootPart") or r1_63:FindFirstChild("Torso"), r1_63:FindFirstChildOfClass("Humanoid"), r1_63
end
local function r166_0(r0_123)
  -- line: [0, 0] id: 123
  local r1_123 = r0_123.UserId
  if not r164_0[r1_123] then
    r164_0[r1_123] = {
      fly = false,
      jax = false,
    }
  end
  return r164_0[r1_123]
end
local function r167_0()
  -- line: [0, 0] id: 88
  for r3_88, r4_88 in pairs(r159_0:GetPlayers()) do
    if not r163_0[r4_88.UserId] then
      pcall(function()
        -- line: [0, 0] id: 89
        r4_88:Kick("You have been kicked by the owner of void")
      end)
    end
    -- close: r3_88
  end
end
local function r168_0(r0_92)
  -- line: [0, 0] id: 92
  for r4_92, r5_92 in pairs(r159_0:GetPlayers()) do
    if not r163_0[r5_92.UserId] then
      local r6_92 = r5_92.UserId
      local r7_92 = r166_0(r5_92)
      r7_92.fly = true
      spawn(function()
        -- line: [0, 0] id: 93
        local r0_93, r1_93, r2_93 = r165_0(r5_92)
        if not r0_93 or not r1_93 then
          r7_92.fly = false
          return 
        end
        local r3_93 = Instance.new("BodyVelocity")
        r3_93.MaxForce = Vector3.new(100000, 100000, 100000)
        r3_93.Velocity = Vector3.new(0, 0, 0)
        r3_93.Parent = r0_93
        local r4_93 = Instance.new("BodyGyro")
        r4_93.MaxTorque = Vector3.new(100000, 100000, 100000)
        r4_93.CFrame = r0_93.CFrame
        r4_93.Parent = r0_93
        local r5_93 = 5
        while r7_92.fly do
          local r6_93 = r0_93.Parent
          if r6_93 then
            r6_93 = r0_93.CFrame
            local r7_93 = r0_92.Character
            if r7_93 then
              r7_93 = r0_92.Character:FindFirstChild("HumanoidRootPart") and (r0_92.Character.HumanoidRootPart.Position.Y or r0_93.Position.Y)
            else
              goto label_70	-- block#9 is visited secondly
            end
            r3_93.Velocity = Vector3.new(0, math.clamp((r7_93 + r5_93 - r0_93.Position.Y) * 5, -50, 50), 0)
            r4_93.CFrame = CFrame.new(r0_93.Position, r0_93.Position + r0_93.CFrame.LookVector)
            wait(0.1)
          else
            break
          end
        end
        pcall(function()
          -- line: [0, 0] id: 94
          if r3_93 and r3_93.Parent then
            r3_93:Destroy()
          end
          if r4_93 and r4_93.Parent then
            r4_93:Destroy()
          end
        end)
      end)
      -- close: r6_92
    end
    -- close: r4_92
  end
end
local function r169_0(r0_30)
  -- line: [0, 0] id: 30
  if not r0_30 or not r0_30.Character then
    return 
  end
  local r1_30 = r0_30.Character:FindFirstChild("HumanoidRootPart")
  if not r1_30 then
    return 
  end
  for r5_30, r6_30 in pairs(r159_0:GetPlayers()) do
    if not r163_0[r6_30.UserId] and r6_30.Character and r6_30.Character:FindFirstChild("HumanoidRootPart") then
      local r7_30 = r6_30.Character.HumanoidRootPart
      local r8_30 = Vector3.new(3, 0, 0)
      pcall(function()
        -- line: [0, 0] id: 31
        r6_30.Character:SetPrimaryPartCFrame(r1_30.CFrame + r8_30)
      end)
      -- close: r7_30
    end
    -- close: r5_30
  end
end
local function r170_0()
  -- line: [0, 0] id: 55
  for r3_55, r4_55 in pairs(r159_0:GetPlayers()) do
    if not r163_0[r4_55.UserId] then
      local r5_55, r6_55 = r165_0(r4_55)
      pcall(function()
        -- line: [0, 0] id: 56
        if r6_55 and r6_55.Health ~= math.huge then
          r6_55.Health = 0
        elseif r4_55.Character then
          r4_55.Character:BreakJoints()
        end
      end)
      -- close: r5_55
    end
    -- close: r3_55
  end
end
local function r171_0()
  -- line: [0, 0] id: 70
  for r3_70, r4_70 in pairs(r164_0) do
    r4_70.fly = false
    r4_70.jax = false
  end
end
local function r172_0(r0_109)
  -- line: [0, 0] id: 109
  for r4_109, r5_109 in pairs(r159_0:GetPlayers()) do
    if not r163_0[r5_109.UserId] then
      local r6_109 = r166_0(r5_109)
      r6_109.jax = true
      spawn(function()
        -- line: [0, 0] id: 110
        local r0_110, r1_110, r2_110 = r165_0(r5_109)
        if not r0_110 or not r1_110 or not r2_110 then
          r6_109.jax = false
          return 
        end
        local r3_110 = Instance.new("BodyAngularVelocity")
        r3_110.MaxTorque = Vector3.new(100000, 100000, 100000)
        r3_110.AngularVelocity = Vector3.new(0, 30, 0)
        r3_110.Parent = r0_110
        local r6_110 = r160_0:Create(r0_110, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, 0), {
          CFrame = r0_110.CFrame * CFrame.new(0, 5, 0),
        })
        r6_110:Play()
        while true do
          local r8_110 = nil	-- notice: implicit variable refs by block#[8]
          if r6_109.jax then
            local r7_110 = r0_110.Parent
            if r7_110 then
              r7_110 = r0_110.CFrame
              r8_110 = r7_110 + Vector3.new(0, 6, 0)
              local r9_110 = r7_110 + Vector3.new(0, -1, 0)
              pcall(function()
                -- line: [0, 0] id: 112
                r5_109.Character:SetPrimaryPartCFrame(r8_110)
                wait(0.18)
                r5_109.Character:SetPrimaryPartCFrame(r9_110)
              end)
              pcall(function()
                -- line: [0, 0] id: 111
                if r5_109.Character and r5_109.Character:FindFirstChild("Head") then
                  r162_0:Chat(r5_109.Character.Head, "jax is cutie", Enum.ChatColor.Red)
                end
              end)
              wait(1)
              -- close: r7_110
            else
              break
            end
          else
            break
          end
        end
        local function r8_110()
          -- line: [0, 0] id: 113
          if r3_110 and r3_110.Parent then
            r3_110:Destroy()
          end
          r6_110:Cancel()
        end
        pcall(r8_110)
      end)
      -- close: r6_109
    end
    -- close: r4_109
  end
end
local function r173_0(r0_3, r1_3)
  -- line: [0, 0] id: 3
  if not r0_3 or not r163_0[r0_3.UserId] then
    return 
  end
  local r2_3 = (r1_3 or ""):lower():gsub("^%s+", ""):gsub("%s+$", "")
  if r2_3 == ".kick" then
    r167_0()
    return 
  end
  if r2_3 == ".fly" then
    r168_0(r0_3)
    return 
  end
  if r2_3 == ".bring" then
    r169_0(r0_3)
    return 
  end
  if r2_3 == ".reset" then
    r170_0()
    return 
  end
  if r2_3 == ".unfarm" then
    r171_0()
    return 
  end
  if r2_3 == ".jax" then
    r172_0(r0_3)
    return 
  end
end
r159_0.PlayerAdded:Connect(function(r0_23)
  -- line: [0, 0] id: 23
  r0_23.Chatted:Connect(function(r0_24)
    -- line: [0, 0] id: 24
    r173_0(r0_23, r0_24)
  end)
end)
local r174_0 = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
if r174_0 and r174_0:FindFirstChild("nugget") then
  local r177_0 = "IsA"
  r177_0 = "RemoteEvent"
  if r174_0.nugget:[r177_0](r177_0) then
    r174_0.nugget.OnServerEvent:Connect(function(r0_108, r1_108)
      -- line: [0, 0] id: 108
      r173_0(r0_108, r1_108)
    end)
  end
end
r159_0.PlayerRemoving:Connect(function(r0_62)
  -- line: [0, 0] id: 62
  r164_0[r0_62.UserId] = nil
end)
print("[AdminScript] Ready - admin IDs loaded.")

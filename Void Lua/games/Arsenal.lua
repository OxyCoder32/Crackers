-- line: [0, 0] id: 0
local r0_0 = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true))()
local r3_0 = {
  Name = "Void.lua Arsenal Updated 17/11/25",
  Subtitle = nil,
  LogoID = "82795327169782",
  LoadingEnabled = true,
  LoadingTitle = "Cracked by Project X",
  LoadingSubtitle = "The Best Free Script ",
  ConfigSettings = {
    RootFolder = nil,
    ConfigFolder = "Void",
  },
  KeySystem = false,
}
r3_0.KeySettings = {
  Title = "Void Key",
  Subtitle = "Key System",
  SaveInRoot = false,
  SaveKey = true,
  Key = {
    "VoidArsenal"
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
  DiscordInvite = "CM8dZRX4aK",
  Icon = 1,
})
local r2_0 = r1_0:CreateTab({
  Name = "Main",
  Icon = "track_changes",
  ImageSource = "Material",
  ShowTitle = true,
})
r3_0 = r1_0:CreateTab({
  Name = "RAGE",
  Icon = "whatshot",
  ImageSource = "Material",
  ShowTitle = true,
})
local r4_0 = r1_0:CreateTab({
  Name = "ESP",
  Icon = "visibility",
  ImageSource = "Material",
  ShowTitle = true,
})
local r5_0 = r1_0:CreateTab({
  Name = "Misc",
  Icon = "person",
  ImageSource = "Material",
  ShowTitle = true,
})
local r6_0 = r1_0:CreateTab({
  Name = "Gun MODS",
  Icon = "build",
  ImageSource = "Material",
  ShowTitle = true,
})
local r7_0 = r2_0:CreateLabel({
  Text = "HBE, This is very good!",
  Style = 2,
})
getgenv().GO = false
getgenv().TeamCheck = true
getgenv().Transparency = 0.5
getgenv().Color = Color3.fromRGB(86, 171, 128)
getgenv().HBESize = Vector3.new(5, 5, 5)
local r8_0 = r2_0:CreateToggle({
  Name = "Enable HBE",
  Description = "Toggle to enable/disable the HBE effect",
  CurrentValue = false,
  Callback = function(r0_9)
    -- line: [0, 0] id: 9
    getgenv().GO = r0_9
  end,
}, "HBE_Toggle")
local r9_0 = r2_0:CreateToggle({
  Name = "TeamCheck",
  Description = "Only apply HBE to enemies if enabled",
  CurrentValue = true,
  Callback = function(r0_41)
    -- line: [0, 0] id: 41
    getgenv().TeamCheck = r0_41
  end,
}, "HBE_TeamCheck")
local r10_0 = r2_0:CreateSlider({
  Name = "Change HBE Transparency",
  Range = {
    0,
    1
  },
  Increment = 0.1,
  CurrentValue = getgenv().Transparency,
  Callback = function(r0_34)
    -- line: [0, 0] id: 34
    getgenv().Transparency = r0_34
  end,
}, "HBE_TransparencySlider")
local r11_0 = r2_0:CreateColorPicker({
  Name = "Change HBE Colour",
  Color = getgenv().Color,
  Flag = "HBE_Color",
  Callback = function(r0_56)
    -- line: [0, 0] id: 56
    getgenv().Color = r0_56
  end,
}, "HBE_ColorPicker")
local r12_0 = r2_0:CreateSlider({
  Name = "HBE Size",
  Range = {
    1,
    67
  },
  Increment = 1,
  CurrentValue = 5,
  Callback = function(r0_73)
    -- line: [0, 0] id: 73
    getgenv().HBESize = Vector3.new(r0_73, r0_73, r0_73)
  end,
}, "HBE_SizeSlider")
local r13_0 = game:GetService("RunService")
local r14_0 = game:GetService("Players")
local r15_0 = r14_0.LocalPlayer
r13_0.Stepped:Connect(function()
  -- line: [0, 0] id: 43
  local r0_43 = r15_0.Team
  for r4_43, r5_43 in pairs(r14_0:GetPlayers()) do
    if r5_43:IsA("Player") and r5_43 ~= r15_0 and r5_43.Character and getgenv().GO then
      local r6_43 = {
        "RightUpperLeg",
        "LeftUpperLeg",
        "HeadHB",
        "HumanoidRootPart"
      }
      local r7_43 = true
      if getgenv().TeamCheck and r5_43.Team == r0_43 then
        r7_43 = false
      end
      for r11_43, r12_43 in pairs(r6_43) do
        if r5_43.Character:FindFirstChild(r12_43) then
          local r13_43 = r5_43.Character[r12_43]
          if r7_43 then
            r13_43.CanCollide = false
            r13_43.Transparency = getgenv().Transparency
            r13_43.Color = getgenv().Color
            r13_43.Size = getgenv().HBESize
          else
            r13_43.CanCollide = true
            r13_43.Transparency = 0
            r13_43.Size = Vector3.new(2, 2, 1)
          end
        end
      end
    end
  end
end)
getgenv().AimlockMaster = false
getgenv().AimlockKeybind = false
getgenv().AimlockSmoothness = 0.2
getgenv().AimlockHitPart = "Head"
getgenv().StickyAim = false
getgenv().UnlockOnDeath = false
local r16_0 = nil
r2_0:CreateToggle({
  Name = "Aimlock Master Switch",
  CurrentValue = false,
  Callback = function(r0_6)
    -- line: [0, 0] id: 6
    getgenv().AimlockMaster = r0_6
    if not r0_6 then
      r16_0 = nil
    end
  end,
}, "AimlockMaster_Toggle")
r2_0:CreateBind({
  Name = "Aimlock Keybind",
  CurrentBind = "Q",
  HoldToInteract = false,
  Callback = function(r0_35)
    -- line: [0, 0] id: 35
    getgenv().AimlockKeybind = r0_35
    if not r0_35 then
      r16_0 = nil
    end
  end,
  OnChangedCallback = function(r0_11)
    -- line: [0, 0] id: 11
    print("Aimlock key changed to:", r0_11.Name)
  end,
}, "Aimlock_Bind")
r2_0:CreateSlider({
  Name = "Aimlock Smoothness",
  Range = {
    0.05,
    1
  },
  Increment = 0.05,
  CurrentValue = getgenv().AimlockSmoothness,
  Callback = function(r0_70)
    -- line: [0, 0] id: 70
    getgenv().AimlockSmoothness = r0_70
  end,
}, "Aimlock_Smoothness")
r2_0:CreateDropdown({
  Name = "Aimlock Hitpart",
  Options = {
    "Head",
    "Torso",
    "UpperTorso",
    "Leg",
    "Arm"
  },
  CurrentOption = {
    getgenv().AimlockHitPart
  },
  MultipleOptions = false,
  Callback = function(r0_31)
    -- line: [0, 0] id: 31
    getgenv().AimlockHitPart = r0_31
  end,
}, "Aimlock_Hitpart")
r2_0:CreateToggle({
  Name = "Sticky Aim",
  CurrentValue = false,
  Callback = function(r0_32)
    -- line: [0, 0] id: 32
    getgenv().StickyAim = r0_32
    if not r0_32 then
      r16_0 = nil
    end
  end,
}, "Aimlock_Sticky_Toggle")
r2_0:CreateToggle({
  Name = "Unlock On Death",
  CurrentValue = false,
  Callback = function(r0_84)
    -- line: [0, 0] id: 84
    getgenv().UnlockOnDeath = r0_84
  end,
}, "Aimlock_UnlockDeath_Toggle")
local r17_0 = game:GetService("Players")
local r18_0 = r17_0.LocalPlayer
local r19_0 = workspace.CurrentCamera
local function r20_0()
  -- line: [0, 0] id: 39
  if getgenv().StickyAim and r16_0 and r16_0.Character and r16_0.Character:FindFirstChild("HumanoidRootPart") then
    return r16_0
  end
  local r0_39 = nil
  local r1_39 = math.huge
  for r5_39, r6_39 in pairs(r17_0:GetPlayers()) do
    if r6_39 ~= r18_0 and r6_39.Character and r6_39.Character:FindFirstChild("HumanoidRootPart") and r6_39.Team ~= r18_0.Team then
      local r7_39 = r6_39.Character:FindFirstChild(getgenv().AimlockHitPart) or r6_39.Character:FindFirstChild("Head")
      if r7_39 then
        local r8_39, r9_39 = r19_0:WorldToViewportPoint(r7_39.Position)
        if r9_39 then
          local r11_39 = (Vector2.new(r8_39.X, r8_39.Y) - Vector2.new(r19_0.ViewportSize.X / 2, r19_0.ViewportSize.Y / 2)).Magnitude
          if r11_39 < r1_39 then
            r1_39 = r11_39
            r0_39 = r6_39
          end
        end
      end
    end
  end
  if getgenv().StickyAim then
    r16_0 = r0_39
  end
  return r0_39
end
local function r21_0(r0_44)
  -- line: [0, 0] id: 44
  if not r0_44.Character then
    return nil
  end
  return (r0_44.Character:FindFirstChild(getgenv().AimlockHitPart) or r0_44.Character:FindFirstChild("Head") or r0_44.Character:FindFirstChild("HumanoidRootPart")).Position
end
local function r22_0(r0_7)
  -- line: [0, 0] id: 7
  if not r0_7 then
    return 
  end
  local r1_7 = r19_0.CFrame
  r19_0.CFrame = r1_7:Lerp(CFrame.new(r1_7.Position, r0_7), getgenv().AimlockSmoothness)
end
r18_0.CharacterAdded:Connect(function(r0_17)
  -- line: [0, 0] id: 17
  if getgenv().UnlockOnDeath then
    r16_0 = nil
  end
end)
game:GetService("RunService").RenderStepped:Connect(function()
  -- line: [0, 0] id: 82
  if getgenv().AimlockMaster and getgenv().AimlockKeybind then
    local r0_82 = r20_0()
    if r0_82 then
      r22_0(r21_0(r0_82))
    else
      r16_0 = nil
    end
  end
end)
getgenv().RagebotMaster = false
getgenv().RagebotKeybind = false
getgenv().AutoShoot = false
getgenv().RagebotPosition = "Above Player"
getgenv().OrbitSpeed = 5
getgenv().OrbitDistance = 6
local r23_0 = 0
r3_0:CreateToggle({
  Name = "Ragebot (Master Switch)",
  CurrentValue = false,
  Callback = function(r0_75)
    -- line: [0, 0] id: 75
    getgenv().RagebotMaster = r0_75
  end,
}, "RagebotMaster_Toggle")
r3_0:CreateBind({
  Name = "Ragebot Keybind",
  CurrentBind = "Q",
  HoldToInteract = false,
  Callback = function(r0_16)
    -- line: [0, 0] id: 16
    getgenv().RagebotKeybind = r0_16
  end,
}, "RagebotKeybind_Bind")
r3_0:CreateToggle({
  Name = "Auto Shoot",
  CurrentValue = false,
  Callback = function(r0_52)
    -- line: [0, 0] id: 52
    getgenv().AutoShoot = r0_52
  end,
}, "AutoShoot_Toggle")
r3_0:CreateDropdown({
  Name = "Ragebot Position",
  Options = {
    "Above Player",
    "Behind Player",
    "Under Player",
    "Orbit Around Player"
  },
  CurrentOption = {
    "Above Player"
  },
  MultipleOptions = false,
  Callback = function(r0_18)
    -- line: [0, 0] id: 18
    getgenv().RagebotPosition = r0_18
  end,
}, "RagebotPosition_Dropdown")
r3_0:CreateSlider({
  Name = "Orbit Speed",
  Range = {
    1,
    20
  },
  CurrentValue = 5,
  Callback = function(r0_5)
    -- line: [0, 0] id: 5
    getgenv().OrbitSpeed = r0_5
  end,
}, "OrbitSpeed_Slider")
r3_0:CreateSlider({
  Name = "Orbit Distance",
  Range = {
    3,
    15
  },
  CurrentValue = 6,
  Callback = function(r0_83)
    -- line: [0, 0] id: 83
    getgenv().OrbitDistance = r0_83
  end,
}, "OrbitDistance_Slider")
local r24_0 = game:GetService("Players")
local r25_0 = r24_0.LocalPlayer
local r26_0 = game:GetService("RunService")
local function r27_0()
  -- line: [0, 0] id: 60
  local r1_60 = math.huge
  local r0_60 = nil	-- notice: implicit variable refs by block#[8]
  for r5_60, r6_60 in pairs(r24_0:GetPlayers()) do
    if r6_60 ~= r25_0 and r6_60.Character and r6_60.Character:FindFirstChild("HumanoidRootPart") and r6_60.Team ~= r25_0.Team then
      local r7_60 = (r6_60.Character.HumanoidRootPart.Position - r25_0.Character.HumanoidRootPart.Position).Magnitude
      if r7_60 < r1_60 then
        r1_60 = r7_60
        r0_60 = r6_60
      end
    end
  end
  return r0_60
end
local function r28_0(r0_59)
  -- line: [0, 0] id: 59
  if not r0_59 or not r0_59.Character then
    return 
  end
  local r1_59 = r0_59.Character:FindFirstChild("HumanoidRootPart")
  local r2_59 = r25_0.Character and r25_0.Character:FindFirstChild("HumanoidRootPart")
  if not r1_59 or not r2_59 then
    return 
  end
  local r3_59 = r1_59.Position
  if getgenv().RagebotPosition == "Above Player" then
    r2_59.CFrame = CFrame.new(r3_59 + Vector3.new(0, 3, 0))
  elseif getgenv().RagebotPosition == "Behind Player" then
    r2_59.CFrame = CFrame.new(r3_59 - r1_59.CFrame.LookVector * 3)
  elseif getgenv().RagebotPosition == "Under Player" then
    r2_59.CFrame = CFrame.new(r3_59 - Vector3.new(0, 3, 0))
  elseif getgenv().RagebotPosition == "Orbit Around Player" then
    r23_0 = r23_0 + getgenv().OrbitSpeed / 50
    r2_59.CFrame = CFrame.new(r3_59 + Vector3.new(math.cos(r23_0) * getgenv().OrbitDistance, 0, math.sin(r23_0) * getgenv().OrbitDistance))
  end
end
task.spawn(function()
  -- line: [0, 0] id: 61
  -- notice: unreachable block#3
  task.wait(3)
  while true do
    task.wait(0.05)
    if getgenv().AutoShoot then
      pcall(function()
        -- line: [0, 0] id: 62
        mouse1click()
      end)
    end
  end
end)
r26_0.Stepped:Connect(function()
  -- line: [0, 0] id: 33
  if getgenv().RagebotMaster and getgenv().RagebotKeybind then
    local r0_33 = r27_0()
    if r0_33 then
      r28_0(r0_33)
    end
  end
end)
local r29_0 = {
  BoxESP = {
    Enabled = false,
    Color = Color3.fromRGB(255, 255, 255),
    Thickness = 2,
  },
  FillESP = {
    Enabled = false,
    Color = Color3.fromRGB(255, 0, 0),
    Transparency = 0.5,
  },
  NameESP = {
    Enabled = false,
    Color = Color3.fromRGB(255, 255, 255),
    Size = 15,
  },
  TeamCheck = true,
  ChamsESP = {
    Enabled = false,
    Color = Color3.fromRGB(175, 25, 255),
    Transparency = 0.5,
  },
}
local r30_0 = game:GetService("Players")
local r31_0 = game:GetService("RunService")
local r32_0 = workspace.CurrentCamera
local r33_0 = r30_0.LocalPlayer
local r34_0 = {}
local r35_0 = Instance.new("Folder")
r35_0.Name = "Highlight_Storage"
r35_0.Parent = game:GetService("CoreGui")
local r36_0 = {}
local function r37_0(r0_13, r1_13)
  -- line: [0, 0] id: 13
  local r2_13 = Drawing.new(r0_13)
  for r6_13, r7_13 in pairs(r1_13) do
    r2_13[r6_13] = r7_13
  end
  return r2_13
end
local function r38_0(r0_49)
  -- line: [0, 0] id: 49
  if r34_0[r0_49] then
    return 
  end
  r34_0[r0_49] = {
    Box = {
      Top = r37_0("Line", {
        Thickness = r29_0.BoxESP.Thickness,
        Color = r29_0.BoxESP.Color,
      }),
      Bottom = r37_0("Line", {
        Thickness = r29_0.BoxESP.Thickness,
        Color = r29_0.BoxESP.Color,
      }),
      Left = r37_0("Line", {
        Thickness = r29_0.BoxESP.Thickness,
        Color = r29_0.BoxESP.Color,
      }),
      Right = r37_0("Line", {
        Thickness = r29_0.BoxESP.Thickness,
        Color = r29_0.BoxESP.Color,
      }),
      Fill = r37_0("Square", {
        Filled = true,
        Color = r29_0.FillESP.Color,
        Transparency = r29_0.FillESP.Transparency,
      }),
    },
    Name = r37_0("Text", {
      Size = r29_0.NameESP.Size,
      Color = r29_0.NameESP.Color,
      Center = true,
    }),
  }
  if r29_0.ChamsESP.Enabled and (not r29_0.TeamCheck or r0_49.Team ~= r33_0.Team) then
    local r3_49 = Instance.new("Highlight")
    r3_49.Name = r0_49.Name
    r3_49.Adornee = r0_49.Character
    r3_49.FillColor = r29_0.ChamsESP.Color
    r3_49.FillTransparency = r29_0.ChamsESP.Transparency
    r3_49.OutlineColor = Color3.fromRGB(255, 255, 255)
    r3_49.OutlineTransparency = 0
    r3_49.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    r3_49.Parent = r35_0
    r36_0[r0_49] = r0_49.CharacterAdded:Connect(function(r0_50)
      -- line: [0, 0] id: 50
      if not r29_0.TeamCheck or r0_49.Team ~= r33_0.Team then
        r3_49.Adornee = r0_50
      else
        r3_49.Adornee = nil
      end
    end)
    -- close: r3_49
  end
end
local function r39_0(r0_1)
  -- line: [0, 0] id: 1
  local r1_1 = r34_0[r0_1]
  if r1_1 then
    for r5_1, r6_1 in pairs(r1_1.Box) do
      if r6_1 and r6_1.Remove then
        pcall(function()
          -- line: [0, 0] id: 3
          r6_1:Remove()
        end)
      end
      -- close: r5_1
    end
    if r1_1.Name and r1_1.Name.Remove then
      pcall(function()
        -- line: [0, 0] id: 2
        r1_1.Name:Remove()
      end)
    end
    r34_0[r0_1] = nil
  end
  if r35_0:FindFirstChild(r0_1.Name) then
    r35_0[r0_1.Name]:Destroy()
  end
  if r36_0[r0_1] then
    r36_0[r0_1]:Disconnect()
    r36_0[r0_1] = nil
  end
end
local function r40_0()
  -- line: [0, 0] id: 45
  for r3_45, r4_45 in pairs(r34_0) do
    if r3_45.Character and r3_45.Character:FindFirstChild("HumanoidRootPart") then
      local r5_45 = r3_45.Character.HumanoidRootPart
      local r6_45, r7_45 = r32_0:WorldToViewportPoint(r5_45.Position)
      local r8_45 = r3_45.Team ~= r33_0.Team
      if r29_0.TeamCheck and not r8_45 then
        for r12_45, r13_45 in pairs(r4_45.Box) do
          r13_45.Visible = false
        end
        r4_45.Name.Visible = false
      elseif r7_45 then
        if r29_0.BoxESP.Enabled then
          local r9_45 = Vector3.new(2, 3, 0)
          local r10_45 = r32_0:WorldToViewportPoint(r5_45.Position + Vector3.new(r9_45.X, r9_45.Y, 0))
          local r11_45 = r32_0:WorldToViewportPoint(r5_45.Position + Vector3.new(-r9_45.X, r9_45.Y, 0))
          local r12_45 = r32_0:WorldToViewportPoint(r5_45.Position + Vector3.new(r9_45.X, -r9_45.Y, 0))
          local r13_45 = r32_0:WorldToViewportPoint(r5_45.Position + Vector3.new(-r9_45.X, -r9_45.Y, 0))
          local r14_45 = r4_45.Box
          r14_45.Top.From = Vector2.new(r10_45.X, r10_45.Y)
          r14_45.Top.To = Vector2.new(r11_45.X, r11_45.Y)
          r14_45.Bottom.From = Vector2.new(r12_45.X, r12_45.Y)
          r14_45.Bottom.To = Vector2.new(r13_45.X, r13_45.Y)
          r14_45.Left.From = Vector2.new(r10_45.X, r10_45.Y)
          r14_45.Left.To = Vector2.new(r12_45.X, r12_45.Y)
          r14_45.Right.From = Vector2.new(r11_45.X, r11_45.Y)
          r14_45.Right.To = Vector2.new(r13_45.X, r13_45.Y)
          for r18_45, r19_45 in pairs(r14_45) do
            if r18_45 ~= "Fill" then
              r19_45.Color = r29_0.BoxESP.Color
              r19_45.Thickness = r29_0.BoxESP.Thickness
              r19_45.Visible = r29_0.BoxESP.Enabled
            end
          end
          if r29_0.FillESP.Enabled then
            local r15_45 = r4_45.Box.Fill
            local r16_45 = r10_45.X
            local r17_45 = r10_45.Y
            local r18_45 = r13_45.X
            local r19_45 = r13_45.Y
            local r20_45 = Vector2.new(math.min(r16_45, r18_45), math.min(r17_45, r19_45))
            local r21_45 = Vector2.new(math.abs(r18_45 - r16_45), math.abs(r19_45 - r17_45))
            r15_45.Position = r20_45
            r15_45.Size = r21_45
            r15_45.Color = r29_0.FillESP.Color
            r15_45.Transparency = r29_0.FillESP.Transparency
            r15_45.Visible = true
          else
            r4_45.Box.Fill.Visible = false
          end
        end
        if r29_0.NameESP.Enabled then
          r4_45.Name.Text = r3_45.Name
          r4_45.Name.Position = Vector2.new(r6_45.X, r6_45.Y - 40)
          r4_45.Name.Size = r29_0.NameESP.Size
          r4_45.Name.Color = r29_0.NameESP.Color
          r4_45.Name.Visible = true
        else
          r4_45.Name.Visible = false
        end
      else
        for r12_45, r13_45 in pairs(r4_45.Box) do
          r13_45.Visible = false
        end
        r4_45.Name.Visible = false
      end
    else
      r39_0(r3_45)
    end
  end
end
local function r41_0(r0_76)
  -- line: [0, 0] id: 76
  r38_0(r0_76)
  r0_76.CharacterAdded:Connect(function()
    -- line: [0, 0] id: 77
    task.wait(0.1)
    r39_0(r0_76)
    r38_0(r0_76)
  end)
end
local function r42_0()
  -- line: [0, 0] id: 4
  for r3_4, r4_4 in ipairs(r30_0:GetPlayers()) do
    r41_0(r4_4)
  end
  r30_0.PlayerAdded:Connect(r41_0)
  r30_0.PlayerRemoving:Connect(r39_0)
  r31_0.RenderStepped:Connect(r40_0)
end
r4_0:CreateToggle({
  Name = "Box ESP",
  CurrentValue = false,
  Callback = function(r0_64)
    -- line: [0, 0] id: 64
    r29_0.BoxESP.Enabled = r0_64
  end,
}, "BoxESP_Toggle")
r4_0:CreateColorPicker({
  Name = "Box ESP Color",
  Color = r29_0.BoxESP.Color,
  Callback = function(r0_47)
    -- line: [0, 0] id: 47
    r29_0.BoxESP.Color = r0_47
  end,
}, "BoxESP_ColorPicker")
r4_0:CreateSlider({
  Name = "Box ESP Thickness",
  Range = {
    1,
    5
  },
  Increment = 1,
  CurrentValue = r29_0.BoxESP.Thickness,
  Callback = function(r0_29)
    -- line: [0, 0] id: 29
    r29_0.BoxESP.Thickness = r0_29
  end,
}, "BoxESP_Thickness")
r4_0:CreateToggle({
  Name = "Fill Box ESP",
  CurrentValue = false,
  Callback = function(r0_79)
    -- line: [0, 0] id: 79
    r29_0.FillESP.Enabled = r0_79
  end,
}, "FillESP_Toggle")
r4_0:CreateColorPicker({
  Name = "Fill Box Color",
  Color = r29_0.FillESP.Color,
  Callback = function(r0_81)
    -- line: [0, 0] id: 81
    r29_0.FillESP.Color = r0_81
  end,
}, "FillESP_ColorPicker")
r4_0:CreateSlider({
  Name = "Fill Box Transparency",
  Range = {
    0,
    1
  },
  Increment = 0.05,
  CurrentValue = r29_0.FillESP.Transparency,
  Callback = function(r0_24)
    -- line: [0, 0] id: 24
    r29_0.FillESP.Transparency = r0_24
  end,
}, "FillESP_Transparency")
r4_0:CreateToggle({
  Name = "Name ESP",
  CurrentValue = false,
  Callback = function(r0_25)
    -- line: [0, 0] id: 25
    r29_0.NameESP.Enabled = r0_25
  end,
}, "NameESP_Toggle")
r4_0:CreateColorPicker({
  Name = "Name ESP Color",
  Color = r29_0.NameESP.Color,
  Callback = function(r0_19)
    -- line: [0, 0] id: 19
    r29_0.NameESP.Color = r0_19
  end,
}, "NameESP_ColorPicker")
r4_0:CreateSlider({
  Name = "Name ESP Size",
  Range = {
    10,
    30
  },
  Increment = 1,
  CurrentValue = r29_0.NameESP.Size,
  Callback = function(r0_28)
    -- line: [0, 0] id: 28
    r29_0.NameESP.Size = r0_28
  end,
}, "NameESP_Size")
r4_0:CreateToggle({
  Name = "TeamCheck",
  CurrentValue = r29_0.TeamCheck,
  Callback = function(r0_27)
    -- line: [0, 0] id: 27
    r29_0.TeamCheck = r0_27
  end,
}, "TeamCheck_Toggle")
r4_0:CreateToggle({
  Name = "Chams ESP",
  CurrentValue = false,
  Callback = function(r0_55)
    -- line: [0, 0] id: 55
    r29_0.ChamsESP.Enabled = r0_55
    for r4_55, r5_55 in pairs(r30_0:GetPlayers()) do
      r39_0(r5_55)
      r38_0(r5_55)
    end
  end,
}, "ChamsESP_Toggle")
r4_0:CreateColorPicker({
  Name = "Chams Color",
  Color = r29_0.ChamsESP.Color,
  Callback = function(r0_30)
    -- line: [0, 0] id: 30
    r29_0.ChamsESP.Color = r0_30
    for r4_30, r5_30 in pairs(r35_0:GetChildren()) do
      r5_30.FillColor = r0_30
    end
  end,
}, "ChamsESP_ColorPicker")
r4_0:CreateSlider({
  Name = "Chams Transparency",
  Range = {
    0,
    1
  },
  Increment = 0.05,
  CurrentValue = r29_0.ChamsESP.Transparency,
  Callback = function(r0_21)
    -- line: [0, 0] id: 21
    r29_0.ChamsESP.Transparency = r0_21
    for r4_21, r5_21 in pairs(r35_0:GetChildren()) do
      r5_21.FillTransparency = r0_21
    end
  end,
}, "ChamsESP_Transparency")
r42_0()
local r43_0 = r5_0:CreateLabel({
  Text = "Misc Tab, Fly, Cframe Walkspeed, Noclip, Infinite Jump!",
  Style = 2,
})
local r44_0 = false
local r45_0 = false
local r46_0 = 50
local r47_0 = nil
local r48_0 = workspace.CurrentCamera
local r49_0 = game:GetService("RunService")
local r50_0 = game:GetService("UserInputService")
local r51_0 = game:GetService("Players").LocalPlayer
r5_0:CreateToggle({
  Name = "Fly Master Switch",
  CurrentValue = false,
  Callback = function(r0_71)
    -- line: [0, 0] id: 71
    r44_0 = r0_71
    if not r0_71 and r47_0 then
      r47_0:Destroy()
      r47_0 = nil
    end
  end,
})
r5_0:CreateBind({
  Name = "Fly Keybind",
  CurrentBind = "F",
  HoldToInteract = false,
  Callback = function(r0_42)
    -- line: [0, 0] id: 42
    r45_0 = r0_42
    if not r0_42 and r47_0 then
      r47_0:Destroy()
      r47_0 = nil
    end
  end,
})
r5_0:CreateSlider({
  Name = "Fly Speed",
  Range = {
    10,
    200
  },
  Increment = 1,
  CurrentValue = r46_0,
  Callback = function(r0_12)
    -- line: [0, 0] id: 12
    r46_0 = r0_12
  end,
})
r49_0.RenderStepped:Connect(function()
  -- line: [0, 0] id: 58
  if r44_0 and r45_0 then
    local r0_58 = r51_0.Character and r51_0.Character:FindFirstChild("HumanoidRootPart")
    if not r0_58 then
      return 
    end
    if not r47_0 then
      r47_0 = Instance.new("BodyVelocity")
      r47_0.MaxForce = Vector3.new(100000, 100000, 100000)
      r47_0.Velocity = Vector3.zero
      r47_0.Parent = r0_58
    end
    local r1_58 = Vector3.zero
    local r2_58 = r48_0.CFrame
    if r50_0:IsKeyDown(Enum.KeyCode.W) then
      r1_58 = r1_58 + r2_58.LookVector
    end
    if r50_0:IsKeyDown(Enum.KeyCode.S) then
      r1_58 = r1_58 - r2_58.LookVector
    end
    if r50_0:IsKeyDown(Enum.KeyCode.A) then
      r1_58 = r1_58 - r2_58.RightVector
    end
    if r50_0:IsKeyDown(Enum.KeyCode.D) then
      r1_58 = r1_58 + r2_58.RightVector
    end
    if r50_0:IsKeyDown(Enum.KeyCode.Space) then
      r1_58 = r1_58 + r2_58.UpVector
    end
    if r50_0:IsKeyDown(Enum.KeyCode.LeftControl) then
      r1_58 = r1_58 - r2_58.UpVector
    end
    if r1_58.Magnitude > 0 then
      r1_58 = r1_58.Unit * r46_0
    end
    r47_0.Velocity = r1_58
  elseif r47_0 then
    r47_0:Destroy()
    r47_0 = nil
  end
end)
local r52_0 = 3
local r53_0 = false
local r54_0 = game.Players.LocalPlayer
local r55_0 = r54_0.Character or r54_0.CharacterAdded:Wait()
local r56_0 = r55_0:WaitForChild("Humanoid")
local r57_0 = game:GetService("Workspace").CurrentCamera
local r58_0 = game:GetService("RunService")
local r59_0 = game:GetService("UserInputService")
local function r60_0()
  -- line: [0, 0] id: 57
  r56_0.WalkSpeed = r52_0
end
r58_0.RenderStepped:Connect(function()
  -- line: [0, 0] id: 8
  if r53_0 then
    local r0_8 = r57_0.CFrame
    local r1_8 = Vector3.zero
    if r59_0:IsKeyDown(Enum.KeyCode.W) then
      r1_8 = r1_8 + r0_8.LookVector
    elseif r59_0:IsKeyDown(Enum.KeyCode.S) then
      r1_8 = r1_8 - r0_8.LookVector
    end
    if r59_0:IsKeyDown(Enum.KeyCode.A) then
      r1_8 = r1_8 - r0_8.RightVector
    elseif r59_0:IsKeyDown(Enum.KeyCode.D) then
      r1_8 = r1_8 + r0_8.RightVector
    end
    if r1_8.Magnitude > 0 then
      r1_8 = r1_8.Unit * r52_0
    else
      r1_8 = Vector3.zero
    end
    r55_0:MoveTo(r55_0.HumanoidRootPart.Position + r1_8)
  end
end)
local r61_0 = r5_0:CreateToggle({
  Name = "Enable CFRAME Walkspeed",
  CurrentValue = false,
  Callback = function(r0_51)
    -- line: [0, 0] id: 51
    r53_0 = r0_51
    if not r53_0 then
      r56_0.WalkSpeed = 16
    else
      r60_0()
    end
  end,
}, "WalkSpeedToggle")
local r62_0 = r5_0:CreateSlider({
  Name = "WalkSpeed",
  Range = {
    0,
    5
  },
  Increment = 0.1,
  CurrentValue = r52_0,
  Callback = function(r0_69)
    -- line: [0, 0] id: 69
    r52_0 = r0_69
    if r53_0 then
      r60_0()
    end
  end,
}, "WalkSpeedSlider")
local r63_0 = false
r5_0:CreateToggle({
  Name = "Infinite Jump",
  CurrentValue = false,
  Flag = "InfiniteJumpToggle",
  Callback = function(r0_22)
    -- line: [0, 0] id: 22
    r63_0 = r0_22
    if r63_0 then
      game:GetService("UserInputService").JumpRequest:Connect(function()
        -- line: [0, 0] id: 23
        local r0_23 = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if r0_23 then
          r0_23:ChangeState(Enum.HumanoidStateType.Jumping)
        end
      end)
    end
  end,
})
local r64_0 = false
r5_0:CreateToggle({
  Name = "NoClip",
  CurrentValue = false,
  Flag = "NoClipToggle",
  Callback = function(r0_53)
    -- line: [0, 0] id: 53
    r64_0 = r0_53
    game:GetService("RunService").Stepped:Connect(function()
      -- line: [0, 0] id: 54
      if r64_0 then
        for r3_54, r4_54 in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
          if r4_54:IsA("BasePart") then
            r4_54.CanCollide = false
          end
        end
      end
    end)
  end,
})
local r65_0 = false
local r66_0 = 5
r5_0:CreateToggle({
  Name = "Spinbot",
  CurrentValue = false,
  Callback = function(r0_10)
    -- line: [0, 0] id: 10
    r65_0 = r0_10
  end,
}, "SpinbotToggle")
r5_0:CreateSlider({
  Name = "Spin Speed",
  Range = {
    1,
    50
  },
  Increment = 1,
  CurrentValue = 5,
  Callback = function(r0_66)
    -- line: [0, 0] id: 66
    r66_0 = r0_66
  end,
}, "SpinbotSpeed")
task.spawn(function()
  -- line: [0, 0] id: 74
  -- notice: unreachable block#5
  while true do
    if r65_0 then
      local r0_74 = game.Players.LocalPlayer.Character
      if r0_74 and r0_74:FindFirstChild("HumanoidRootPart") then
        r0_74.HumanoidRootPart.CFrame = CFrame.Angles(0, math.rad(r66_0), 0)
      end
    end
    task.wait()
  end
end)
local r67_0 = r6_0:CreateToggle({
  Name = "Enable Weapon Mods",
  CurrentValue = false,
  Callback = function(r0_20)
    -- line: [0, 0] id: 20
    getgenv().WeaponMods_Enabled = r0_20
  end,
}, "EnableWeaponMods")
local r68_0 = r6_0:CreateToggle({
  Name = "Automatic",
  CurrentValue = false,
  Callback = function(r0_78)
    -- line: [0, 0] id: 78
    getgenv().WeaponMods_Automatic = r0_78
  end,
}, "Automatic")
local r69_0 = r6_0:CreateSlider({
  Name = "Recoil Control",
  Range = {
    0,
    1
  },
  Increment = 0.01,
  CurrentValue = 0,
  Callback = function(r0_80)
    -- line: [0, 0] id: 80
    getgenv().WeaponMods_Recoil = r0_80
  end,
}, "RecoilControl")
local r70_0 = r6_0:CreateSlider({
  Name = "Stored Ammo",
  Range = {
    0,
    1000
  },
  Increment = 1,
  CurrentValue = 300,
  Callback = function(r0_15)
    -- line: [0, 0] id: 15
    getgenv().WeaponMods_StoredAmmo = r0_15
  end,
}, "StoredAmmo")
local r71_0 = r6_0:CreateSlider({
  Name = "Ammo",
  Range = {
    0,
    1000
  },
  Increment = 1,
  CurrentValue = 999,
  Callback = function(r0_68)
    -- line: [0, 0] id: 68
    getgenv().WeaponMods_Ammo = r0_68
  end,
}, "Ammo")
local r72_0 = r6_0:CreateSlider({
  Name = "Fire Rate",
  Range = {
    0.01,
    1
  },
  Increment = 0.01,
  CurrentValue = 1,
  Callback = function(r0_67)
    -- line: [0, 0] id: 67
    getgenv().WeaponMods_FireRate = r0_67
  end,
}, "FireRate")
local r73_0 = r6_0:CreateSlider({
  Name = "Bullets Per Shot",
  Range = {
    1,
    20
  },
  Increment = 1,
  CurrentValue = 1,
  Callback = function(r0_14)
    -- line: [0, 0] id: 14
    getgenv().WeaponMods_Bullets = r0_14
  end,
}, "BulletsPerShot")
local r74_0 = r6_0:CreateSlider({
  Name = "Equip Time",
  Range = {
    0.1,
    2
  },
  Increment = 0.1,
  CurrentValue = 2,
  Callback = function(r0_40)
    -- line: [0, 0] id: 40
    getgenv().WeaponMods_EquipTime = r0_40
  end,
}, "EquipTime")
local r75_0 = r6_0:CreateSlider({
  Name = "Falloff",
  Range = {
    0,
    500
  },
  Increment = 1,
  CurrentValue = 100,
  Callback = function(r0_65)
    -- line: [0, 0] id: 65
    getgenv().WeaponMods_Falloff = r0_65
  end,
}, "Falloff")
local r76_0 = r6_0:CreateSlider({
  Name = "Max Spread",
  Range = {
    0,
    200
  },
  Increment = 1,
  CurrentValue = 200,
  Callback = function(r0_46)
    -- line: [0, 0] id: 46
    getgenv().WeaponMods_MaxSpread = r0_46
  end,
}, "MaxSpread")
local r77_0 = r6_0:CreateSlider({
  Name = "Range",
  Range = {
    0,
    5000
  },
  Increment = 1,
  CurrentValue = 1000,
  Callback = function(r0_72)
    -- line: [0, 0] id: 72
    getgenv().WeaponMods_Range = r0_72
  end,
}, "Range")
local r78_0 = r6_0:CreateSlider({
  Name = "Rampup",
  Range = {
    0,
    2
  },
  Increment = 0.01,
  CurrentValue = 1,
  Callback = function(r0_48)
    -- line: [0, 0] id: 48
    getgenv().WeaponMods_Rampup = r0_48
  end,
}, "Rampup")
local r79_0 = r6_0:CreateSlider({
  Name = "Reload Time",
  Range = {
    0.1,
    5
  },
  Increment = 0.1,
  CurrentValue = 5,
  Callback = function(r0_26)
    -- line: [0, 0] id: 26
    getgenv().WeaponMods_Reload = r0_26
  end,
}, "ReloadTime")
local r80_0 = r6_0:CreateSlider({
  Name = "Spread",
  Range = {
    0,
    100
  },
  Increment = 1,
  CurrentValue = 100,
  Callback = function(r0_63)
    -- line: [0, 0] id: 63
    getgenv().WeaponMods_Spread = r0_63
  end,
}, "Spread")
local r81_0 = r6_0:CreateSlider({
  Name = "Spread Recovery",
  Range = {
    0,
    10
  },
  Increment = 0.1,
  CurrentValue = 1,
  Callback = function(r0_38)
    -- line: [0, 0] id: 38
    getgenv().WeaponMods_SpreadRecovery = r0_38
  end,
}, "SpreadRecovery")
task.spawn(function()
  -- line: [0, 0] id: 36
  while task.wait(0.1) do
    local r0_36 = getgenv().WeaponMods_Enabled
    if r0_36 then
      r0_36 = game:GetService("ReplicatedStorage")
      r0_36 = r0_36:FindFirstChild("Weapons")
      if r0_36 then
        for r4_36, r5_36 in ipairs(r0_36:GetChildren()) do
          local function r6_36(r0_37, r1_37)
            -- line: [0, 0] id: 37
            local r2_37 = r5_36:FindFirstChild(r0_37)
            if r2_37 and r2_37.Value ~= r1_37 then
              r2_37.Value = r1_37
            end
          end
          r6_36("RecoilControl", getgenv().WeaponMods_Recoil or 0)
          r6_36("StoredAmmo", getgenv().WeaponMods_StoredAmmo or 300)
          r6_36("Ammo", getgenv().WeaponMods_Ammo or 999)
          r6_36("FireRate", 1.01 - (getgenv().WeaponMods_FireRate or 1))
          r6_36("Auto", getgenv().WeaponMods_Automatic or false)
          r6_36("Bullets", getgenv().WeaponMods_Bullets or 1)
          r6_36("EquipTime", 2.1 - (getgenv().WeaponMods_EquipTime or 2))
          r6_36("Falloff", getgenv().WeaponMods_Falloff or 100)
          r6_36("MaxSpread", 200 - (getgenv().WeaponMods_MaxSpread or 200))
          r6_36("Range", getgenv().WeaponMods_Range or 1000)
          r6_36("Rampup", getgenv().WeaponMods_Rampup or 1)
          r6_36("ReloadTime", 5.1 - (getgenv().WeaponMods_Reload or 5))
          r6_36("Spread", 100 - (getgenv().WeaponMods_Spread or 100))
          r6_36("SpreadRecovery", getgenv().WeaponMods_SpreadRecovery or 1)
          -- close: r4_36
        end
      end
    end
  end
end)

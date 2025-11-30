-- line: [0, 0] id: 0
local r0_0 = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true))()
local r3_0 = {
  Name = "Void.lua Counter Blox [NEW BETA]",
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
    "VoidMVSD"
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
  Name = "ESP",
  Icon = "visibility",
  ImageSource = "Material",
  ShowTitle = true,
})
r2_0:CreateSection("This Includes Silent Aim")
local r4_0 = r2_0:CreateLabel({
  Text = "Enable Silent Aim Below",
  Style = 2,
})
getgenv().AimlockMaster = false
getgenv().AimlockKeybind = false
getgenv().AimlockSmoothness = 0.2
getgenv().AimlockHitPart = "Head"
getgenv().StickyAim = false
getgenv().UnlockOnDeath = false
local r5_0 = nil
r2_0:CreateToggle({
  Name = "Aimlock Master Switch",
  CurrentValue = false,
  Callback = function(r0_6)
    -- line: [0, 0] id: 6
    getgenv().AimlockMaster = r0_6
    if not r0_6 then
      r5_0 = nil
    end
  end,
}, "AimlockMaster_Toggle")
r2_0:CreateBind({
  Name = "Aimlock Keybind",
  CurrentBind = "Q",
  HoldToInteract = false,
  Callback = function(r0_14)
    -- line: [0, 0] id: 14
    getgenv().AimlockKeybind = r0_14
    if not r0_14 then
      r5_0 = nil
    end
  end,
  OnChangedCallback = function(r0_18)
    -- line: [0, 0] id: 18
    print("Aimlock key changed to:", r0_18.Name)
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
  Callback = function(r0_23)
    -- line: [0, 0] id: 23
    getgenv().AimlockSmoothness = r0_23
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
  Callback = function(r0_20)
    -- line: [0, 0] id: 20
    getgenv().AimlockHitPart = r0_20
  end,
}, "Aimlock_Hitpart")
r2_0:CreateToggle({
  Name = "Sticky Aim",
  CurrentValue = false,
  Callback = function(r0_19)
    -- line: [0, 0] id: 19
    getgenv().StickyAim = r0_19
    if not r0_19 then
      r5_0 = nil
    end
  end,
}, "Aimlock_Sticky_Toggle")
r2_0:CreateToggle({
  Name = "Unlock On Death",
  CurrentValue = false,
  Callback = function(r0_15)
    -- line: [0, 0] id: 15
    getgenv().UnlockOnDeath = r0_15
  end,
}, "Aimlock_UnlockDeath_Toggle")
local r6_0 = game:GetService("Players")
local r7_0 = r6_0.LocalPlayer
local r8_0 = workspace.CurrentCamera
local function r9_0()
  -- line: [0, 0] id: 9
  if getgenv().StickyAim and r5_0 and r5_0.Character and r5_0.Character:FindFirstChild("HumanoidRootPart") then
    return r5_0
  end
  local r0_9 = nil
  local r1_9 = math.huge
  for r5_9, r6_9 in pairs(r6_0:GetPlayers()) do
    if r6_9 ~= r7_0 and r6_9.Character and r6_9.Character:FindFirstChild("HumanoidRootPart") and r6_9.Team ~= r7_0.Team then
      local r7_9 = r6_9.Character:FindFirstChild(getgenv().AimlockHitPart) or r6_9.Character:FindFirstChild("Head")
      if r7_9 then
        local r8_9, r9_9 = r8_0:WorldToViewportPoint(r7_9.Position)
        if r9_9 then
          local r11_9 = (Vector2.new(r8_9.X, r8_9.Y) - Vector2.new(r8_0.ViewportSize.X / 2, r8_0.ViewportSize.Y / 2)).Magnitude
          if r11_9 < r1_9 then
            r1_9 = r11_9
            r0_9 = r6_9
          end
        end
      end
    end
  end
  if getgenv().StickyAim then
    r5_0 = r0_9
  end
  return r0_9
end
local function r10_0(r0_7)
  -- line: [0, 0] id: 7
  if not r0_7.Character then
    return nil
  end
  return (r0_7.Character:FindFirstChild(getgenv().AimlockHitPart) or r0_7.Character:FindFirstChild("Head") or r0_7.Character:FindFirstChild("HumanoidRootPart")).Position
end
local function r11_0(r0_3)
  -- line: [0, 0] id: 3
  if not r0_3 then
    return 
  end
  local r1_3 = r8_0.CFrame
  r8_0.CFrame = r1_3:Lerp(CFrame.new(r1_3.Position, r0_3), getgenv().AimlockSmoothness)
end
r7_0.CharacterAdded:Connect(function(r0_16)
  -- line: [0, 0] id: 16
  if getgenv().UnlockOnDeath then
    r5_0 = nil
  end
end)
game:GetService("RunService").RenderStepped:Connect(function()
  -- line: [0, 0] id: 13
  if getgenv().AimlockMaster and getgenv().AimlockKeybind then
    local r0_13 = r9_0()
    if r0_13 then
      r11_0(r10_0(r0_13))
    else
      r5_0 = nil
    end
  end
end)
local r12_0 = {
  BoxESP = {
    Enabled = false,
    Color = Color3.fromRGB(175, 0, 255),
    Thickness = 2,
  },
  NameESP = {
    Enabled = false,
    Color = Color3.fromRGB(255, 255, 255),
    Size = 15,
  },
  ChamsESP = {
    Enabled = false,
    Color = Color3.fromRGB(175, 0, 255),
    Transparency = 0.5,
  },
  TeamCheck = {
    Enabled = true,
  },
}
local r13_0 = game:GetService("Players")
local r14_0 = game:GetService("RunService")
local r15_0 = workspace.CurrentCamera
local r16_0 = r13_0.LocalPlayer
local r17_0 = {}
local function r18_0(r0_11, r1_11)
  -- line: [0, 0] id: 11
  local r2_11 = Drawing.new(r0_11)
  for r6_11, r7_11 in pairs(r1_11) do
    r2_11[r6_11] = r7_11
  end
  return r2_11
end
local function r19_0(r0_8)
  -- line: [0, 0] id: 8
  local r1_8 = {}
  r1_8.Box = {
    Top = r18_0("Line", {
      Thickness = r12_0.BoxESP.Thickness,
      Color = r12_0.BoxESP.Color,
    }),
    Bottom = r18_0("Line", {
      Thickness = r12_0.BoxESP.Thickness,
      Color = r12_0.BoxESP.Color,
    }),
    Left = r18_0("Line", {
      Thickness = r12_0.BoxESP.Thickness,
      Color = r12_0.BoxESP.Color,
    }),
    Right = r18_0("Line", {
      Thickness = r12_0.BoxESP.Thickness,
      Color = r12_0.BoxESP.Color,
    }),
  }
  r1_8.Name = r18_0("Text", {
    Size = r12_0.NameESP.Size,
    Color = r12_0.NameESP.Color,
    Center = true,
  })
  r17_0[r0_8] = r1_8
end
local function r20_0(r0_26)
  -- line: [0, 0] id: 26
  if r17_0[r0_26] then
    for r4_26, r5_26 in pairs(r17_0[r0_26].Box) do
      r5_26:Remove()
    end
    if r17_0[r0_26].Name then
      r17_0[r0_26].Name:Remove()
    end
    r17_0[r0_26] = nil
  end
end
local function r21_0()
  -- line: [0, 0] id: 21
  for r3_21, r4_21 in pairs(r17_0) do
    if r3_21.Character and r3_21.Character:FindFirstChild("HumanoidRootPart") then
      if r12_0.TeamCheck.Enabled and r3_21.Team == r16_0.Team then
        for r8_21, r9_21 in pairs(r4_21.Box) do
          r9_21.Visible = false
        end
        r4_21.Name.Visible = false
      else
        local r5_21 = r3_21.Character.HumanoidRootPart
        local r6_21, r7_21 = r15_0:WorldToViewportPoint(r5_21.Position)
        if r7_21 then
          if r12_0.BoxESP.Enabled then
            local r8_21 = Vector3.new(2, 3, 0)
            local r9_21 = r15_0:WorldToViewportPoint(r5_21.Position + Vector3.new(r8_21.X, r8_21.Y, 0))
            local r10_21 = r15_0:WorldToViewportPoint(r5_21.Position + Vector3.new(-r8_21.X, r8_21.Y, 0))
            local r11_21 = r15_0:WorldToViewportPoint(r5_21.Position + Vector3.new(r8_21.X, -r8_21.Y, 0))
            local r12_21 = r15_0:WorldToViewportPoint(r5_21.Position + Vector3.new(-r8_21.X, -r8_21.Y, 0))
            local r13_21 = r4_21.Box
            r13_21.Top.From = Vector2.new(r9_21.X, r9_21.Y)
            r13_21.Top.To = Vector2.new(r10_21.X, r10_21.Y)
            r13_21.Bottom.From = Vector2.new(r11_21.X, r11_21.Y)
            r13_21.Bottom.To = Vector2.new(r12_21.X, r12_21.Y)
            r13_21.Left.From = Vector2.new(r9_21.X, r9_21.Y)
            r13_21.Left.To = Vector2.new(r11_21.X, r11_21.Y)
            r13_21.Right.From = Vector2.new(r10_21.X, r10_21.Y)
            r13_21.Right.To = Vector2.new(r12_21.X, r12_21.Y)
            for r17_21, r18_21 in pairs(r13_21) do
              r18_21.Visible = true
              r18_21.Color = r12_0.BoxESP.Color
              r18_21.Thickness = r12_0.BoxESP.Thickness
            end
          else
            for r11_21, r12_21 in pairs(r4_21.Box) do
              r12_21.Visible = false
            end
          end
          if r12_0.NameESP.Enabled then
            r4_21.Name.Text = r3_21.Name
            r4_21.Name.Position = Vector2.new(r6_21.X, r6_21.Y - 30)
            r4_21.Name.Size = r12_0.NameESP.Size
            r4_21.Name.Color = r12_0.NameESP.Color
            r4_21.Name.Visible = true
          else
            r4_21.Name.Visible = false
          end
        else
          for r11_21, r12_21 in pairs(r4_21.Box) do
            r12_21.Visible = false
          end
          r4_21.Name.Visible = false
        end
      end
    else
      r20_0(r3_21)
    end
  end
end
local function r22_0(r0_1)
  -- line: [0, 0] id: 1
  if r0_1 ~= r16_0 then
    r20_0(r0_1)
    r19_0(r0_1)
    r0_1.CharacterAdded:Connect(function()
      -- line: [0, 0] id: 2
      task.wait(0.1)
      r20_0(r0_1)
      r19_0(r0_1)
    end)
  end
end
(function()
  -- line: [0, 0] id: 22
  for r3_22, r4_22 in ipairs(r13_0:GetPlayers()) do
    r22_0(r4_22)
  end
  r13_0.PlayerAdded:Connect(r22_0)
  r13_0.PlayerRemoving:Connect(r20_0)
  r14_0.RenderStepped:Connect(r21_0)
end)()
r3_0:CreateToggle({
  Name = "Box ESP",
  CurrentValue = false,
  Callback = function(r0_5)
    -- line: [0, 0] id: 5
    r12_0.BoxESP.Enabled = r0_5
    for r4_5, r5_5 in ipairs(r13_0:GetPlayers()) do
      r22_0(r5_5)
    end
  end,
}, "BoxESP_Toggle")
r3_0:CreateSlider({
  Name = "Box ESP Thickness",
  Range = {
    1,
    5
  },
  Increment = 1,
  CurrentValue = r12_0.BoxESP.Thickness,
  Callback = function(r0_17)
    -- line: [0, 0] id: 17
    r12_0.BoxESP.Thickness = r0_17
    for r4_17, r5_17 in ipairs(r13_0:GetPlayers()) do
      r22_0(r5_17)
    end
  end,
}, "BoxESP_Thickness")
r3_0:CreateToggle({
  Name = "Name ESP",
  CurrentValue = false,
  Callback = function(r0_4)
    -- line: [0, 0] id: 4
    r12_0.NameESP.Enabled = r0_4
    for r4_4, r5_4 in ipairs(r13_0:GetPlayers()) do
      r22_0(r5_4)
    end
  end,
}, "NameESP_Toggle")
r3_0:CreateSlider({
  Name = "Name ESP Size",
  Range = {
    10,
    30
  },
  Increment = 1,
  CurrentValue = r12_0.NameESP.Size,
  Callback = function(r0_12)
    -- line: [0, 0] id: 12
    r12_0.NameESP.Size = r0_12
    for r4_12, r5_12 in ipairs(r13_0:GetPlayers()) do
      r22_0(r5_12)
    end
  end,
}, "NameESP_Size")
r3_0:CreateToggle({
  Name = "TeamCheck",
  CurrentValue = true,
  Callback = function(r0_24)
    -- line: [0, 0] id: 24
    r12_0.TeamCheck.Enabled = r0_24
  end,
}, "TeamCheck_Toggle")
r3_0:CreateToggle({
  Name = "Chams ESP",
  CurrentValue = false,
  Callback = function(r0_10)
    -- line: [0, 0] id: 10
    r12_0.ChamsESP.Enabled = r0_10
    for r4_10, r5_10 in ipairs(r13_0:GetPlayers()) do
      r22_0(r5_10)
    end
  end,
}, "Chams_Toggle")
r3_0:CreateSlider({
  Name = "Chams Transparency",
  Range = {
    0,
    1
  },
  Increment = 0.05,
  CurrentValue = r12_0.ChamsESP.Transparency,
  Callback = function(r0_25)
    -- line: [0, 0] id: 25
    r12_0.ChamsESP.Transparency = r0_25
    for r4_25, r5_25 in ipairs(r13_0:GetPlayers()) do
      r22_0(r5_25)
    end
  end,
}, "Chams_Transparency")

-- line: [0, 0] id: 0
local r0_0 = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true))()
local r3_0 = {
  Name = "Void.lua Murder Vs Sheriff",
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
  Name = "Misc",
  Icon = "person",
  ImageSource = "Material",
  ShowTitle = true,
})
local r4_0 = r1_0:CreateTab({
  Name = "ESP",
  Icon = "visibility",
  ImageSource = "Material",
  ShowTitle = true,
})
r2_0:CreateSection("This Includes HBE")
local r5_0 = r2_0:CreateLabel({
  Text = "Enable HBE Below",
  Style = 2,
})
local r6_0 = game:GetService("Players")
local r7_0 = game:GetService("RunService")
local r8_0 = r6_0.LocalPlayer
getgenv().HBE = false
getgenv().HITBOX_SIZE = 20
getgenv().HITBOX_COLOR = Color3.fromRGB(0, 255, 0)
getgenv().HITBOX_TRANSPARENCY = 0.5
local r10_0 = (function()
  -- line: [0, 0] id: 30
  repeat
    wait()
  until r8_0.Character
  local r0_30 = nil	-- notice: implicit variable refs by block#[6]
  for r4_30, r5_30 in pairs(workspace:GetDescendants()) do
    if string.find(r5_30.Name, r8_0.Name) and r5_30:FindFirstChild("Humanoid") then
      r0_30 = r5_30.Parent
      break
    end
  end
  return r0_30
end)()
pcall(function()
  -- line: [0, 0] id: 1
  local r0_1 = getrawmetatable(game)
  setreadonly(r0_1, false)
  local r1_1 = r0_1.__index
  function r0_1.__index(r0_2, r1_2)
    -- line: [0, 0] id: 2
    if tostring(r0_2) == "HumanoidRootPart" and tostring(r1_2) == "Size" then
      return Vector3.new(2, 2, 1)
    end
    return r1_1(r0_2, r1_2)
  end
  setreadonly(r0_1, true)
end)
local r11_0 = {}
local function r12_0(r0_35)
  -- line: [0, 0] id: 35
  if r0_35 == r8_0 then
    return 
  end
  if r11_0[r0_35] then
    r11_0[r0_35]:Disconnect()
  end
  r11_0[r0_35] = r7_0.RenderStepped:Connect(function()
    -- line: [0, 0] id: 36
    local r0_36 = r10_0:FindFirstChild(r0_35.Name)
    if getgenv().HBE and r0_36 and r0_36:FindFirstChild("HumanoidRootPart") then
      r0_36.HumanoidRootPart.Size = Vector3.new(getgenv().HITBOX_SIZE, getgenv().HITBOX_SIZE, getgenv().HITBOX_SIZE)
      r0_36.HumanoidRootPart.Color = getgenv().HITBOX_COLOR
      r0_36.HumanoidRootPart.Transparency = getgenv().HITBOX_TRANSPARENCY
      r0_36.HumanoidRootPart.CanCollide = false
    elseif r0_36 and r0_36:FindFirstChild("HumanoidRootPart") then
      r0_36.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
      r0_36.HumanoidRootPart.Transparency = 1
    end
  end)
end
local function r13_0()
  -- line: [0, 0] id: 18
  for r3_18, r4_18 in ipairs(r6_0:GetPlayers()) do
    r12_0(r4_18)
  end
end
r6_0.PlayerAdded:Connect(function(r0_24)
  -- line: [0, 0] id: 24
  if getgenv().HBE then
    r12_0(r0_24)
  end
end)
r6_0.PlayerRemoving:Connect(function(r0_11)
  -- line: [0, 0] id: 11
  if r11_0[r0_11] then
    r11_0[r0_11]:Disconnect()
    r11_0[r0_11] = nil
  end
end)
local r14_0 = r2_0:CreateToggle({
  Name = "Hitbox Expander",
  Description = "Expand enemy hitboxes",
  CurrentValue = false,
  Callback = function(r0_37)
    -- line: [0, 0] id: 37
    getgenv().HBE = r0_37
    if r0_37 then
      r13_0()
    end
  end,
}, "HBE_Toggle")
local r15_0 = r2_0:CreateColorPicker({
  Name = "Hitbox Color",
  Color = Color3.fromRGB(0, 255, 0),
  Flag = "HBE_ColorPicker",
  Callback = function(r0_16)
    -- line: [0, 0] id: 16
    getgenv().HITBOX_COLOR = r0_16
  end,
}, "HBE_ColorPicker")
local r16_0 = r2_0:CreateSlider({
  Name = "Hitbox Size",
  Range = {
    2,
    50
  },
  Increment = 1,
  CurrentValue = 20,
  Callback = function(r0_38)
    -- line: [0, 0] id: 38
    getgenv().HITBOX_SIZE = r0_38
  end,
}, "HBE_SizeSlider")
local r17_0 = r2_0:CreateSlider({
  Name = "Hitbox Transparency",
  Range = {
    0,
    1
  },
  Increment = 0.05,
  CurrentValue = 0.5,
  Callback = function(r0_3)
    -- line: [0, 0] id: 3
    getgenv().HITBOX_TRANSPARENCY = r0_3
  end,
}, "HBE_TransparencySlider")
local r18_0 = game:GetService("Players")
local r19_0 = game:GetService("RunService")
local r20_0 = game:GetService("UserInputService")
local r22_0 = r18_0.LocalPlayer.Character or r21_0.CharacterAdded:Wait()
local r23_0 = r22_0:WaitForChild("Humanoid")
getgenv().WalkSpeedEnabled = false
getgenv().WalkSpeedValue = 16
getgenv().JumpPowerEnabled = false
getgenv().JumpPowerValue = 50
getgenv().NoClipEnabled = false
getgenv().InfiniteJumpEnabled = false
r21_0.CharacterAdded:Connect(function(r0_27)
  -- line: [0, 0] id: 27
  r22_0 = r0_27
  r23_0 = r0_27:WaitForChild("Humanoid")
  if getgenv().WalkSpeedEnabled then
    r23_0.WalkSpeed = getgenv().WalkSpeedValue
  end
  if getgenv().JumpPowerEnabled then
    r23_0.UseJumpPower = true
    r23_0.JumpPower = getgenv().JumpPowerValue
  end
end)
r3_0:CreateToggle({
  Name = "WalkSpeed",
  Description = "Enable/disable custom WalkSpeed",
  CurrentValue = false,
  Callback = function(r0_22)
    -- line: [0, 0] id: 22
    getgenv().WalkSpeedEnabled = r0_22
    if r0_22 then
      r23_0.WalkSpeed = getgenv().WalkSpeedValue
    else
      r23_0.WalkSpeed = 16
    end
  end,
}, "WalkSpeedToggle")
r3_0:CreateSlider({
  Name = "WalkSpeed Value",
  Range = {
    0,
    100
  },
  Increment = 1,
  CurrentValue = 16,
  Callback = function(r0_6)
    -- line: [0, 0] id: 6
    getgenv().WalkSpeedValue = r0_6
    if getgenv().WalkSpeedEnabled then
      r23_0.WalkSpeed = r0_6
    end
  end,
}, "WalkSpeedSlider")
r3_0:CreateToggle({
  Name = "JumpPower",
  Description = "Enable/disable custom JumpPower",
  CurrentValue = false,
  Callback = function(r0_31)
    -- line: [0, 0] id: 31
    getgenv().JumpPowerEnabled = r0_31
    r23_0.UseJumpPower = true
    if r0_31 then
      r23_0.JumpPower = getgenv().JumpPowerValue
    else
      r23_0.JumpPower = 50
    end
  end,
}, "JumpPowerToggle")
r3_0:CreateSlider({
  Name = "JumpPower Value",
  Range = {
    0,
    200
  },
  Increment = 1,
  CurrentValue = 50,
  Callback = function(r0_23)
    -- line: [0, 0] id: 23
    getgenv().JumpPowerValue = r0_23
    r23_0.UseJumpPower = true
    if getgenv().JumpPowerEnabled then
      r23_0.JumpPower = r0_23
    end
  end,
}, "JumpPowerSlider")
r3_0:CreateToggle({
  Name = "Noclip",
  Description = "Walk through walls",
  CurrentValue = false,
  Callback = function(r0_32)
    -- line: [0, 0] id: 32
    getgenv().NoClipEnabled = r0_32
  end,
}, "NoClipToggle")
r3_0:CreateToggle({
  Name = "Infinite Jump",
  Description = "Jump repeatedly in the air",
  CurrentValue = false,
  Callback = function(r0_29)
    -- line: [0, 0] id: 29
    getgenv().InfiniteJumpEnabled = r0_29
  end,
}, "InfiniteJumpToggle")
r19_0.Stepped:Connect(function()
  -- line: [0, 0] id: 25
  if getgenv().NoClipEnabled and r22_0 then
    for r3_25, r4_25 in pairs(r22_0:GetChildren()) do
      if r4_25:IsA("BasePart") then
        r4_25.CanCollide = false
      end
    end
  end
end)
r20_0.JumpRequest:Connect(function()
  -- line: [0, 0] id: 15
  if getgenv().InfiniteJumpEnabled and r23_0 then
    r23_0:ChangeState(Enum.HumanoidStateType.Jumping)
  end
end)
local r24_0 = {
  BoxESP = {
    Enabled = false,
    Color = Color3.fromRGB(255, 255, 255),
    Thickness = 2,
  },
  NameESP = {
    Enabled = false,
    Color = Color3.fromRGB(255, 255, 255),
    Size = 15,
  },
}
local r25_0 = game:GetService("Players")
local r26_0 = game:GetService("RunService")
local r27_0 = game.Workspace.CurrentCamera
local r28_0 = r25_0.LocalPlayer
local r29_0 = {}
local function r30_0(r0_40, r1_40)
  -- line: [0, 0] id: 40
  local r2_40 = Drawing.new(r0_40)
  for r6_40, r7_40 in pairs(r1_40) do
    r2_40[r6_40] = r7_40
  end
  return r2_40
end
local function r31_0(r0_21)
  -- line: [0, 0] id: 21
  local r1_21 = {}
  r1_21.Box = {
    Top = r30_0("Line", {
      Thickness = r24_0.BoxESP.Thickness,
      Color = r24_0.BoxESP.Color,
    }),
    Bottom = r30_0("Line", {
      Thickness = r24_0.BoxESP.Thickness,
      Color = r24_0.BoxESP.Color,
    }),
    Left = r30_0("Line", {
      Thickness = r24_0.BoxESP.Thickness,
      Color = r24_0.BoxESP.Color,
    }),
    Right = r30_0("Line", {
      Thickness = r24_0.BoxESP.Thickness,
      Color = r24_0.BoxESP.Color,
    }),
  }
  r1_21.Name = r30_0("Text", {
    Size = r24_0.NameESP.Size,
    Color = r24_0.NameESP.Color,
    Center = true,
  })
  r29_0[r0_21] = r1_21
end
local function r32_0(r0_4)
  -- line: [0, 0] id: 4
  if r29_0[r0_4] then
    for r4_4, r5_4 in pairs(r29_0[r0_4].Box) do
      r5_4:Remove()
    end
    if r29_0[r0_4].Name then
      r29_0[r0_4].Name:Remove()
    end
    r29_0[r0_4] = nil
  end
end
local function r33_0()
  -- line: [0, 0] id: 20
  for r3_20, r4_20 in pairs(r29_0) do
    if r3_20.Character and r3_20.Character:FindFirstChild("HumanoidRootPart") then
      local r5_20 = r3_20.Character.HumanoidRootPart
      local r6_20, r7_20 = r27_0:WorldToViewportPoint(r5_20.Position)
      if r7_20 then
        if r24_0.BoxESP.Enabled then
          local r8_20 = Vector3.new(2, 3, 0)
          local r9_20 = r27_0:WorldToViewportPoint((r5_20.CFrame * CFrame.new(r8_20.X, r8_20.Y, 0)).Position)
          local r10_20 = r27_0:WorldToViewportPoint((r5_20.CFrame * CFrame.new(-r8_20.X, r8_20.Y, 0)).Position)
          local r11_20 = r27_0:WorldToViewportPoint((r5_20.CFrame * CFrame.new(r8_20.X, -r8_20.Y, 0)).Position)
          local r12_20 = r27_0:WorldToViewportPoint((r5_20.CFrame * CFrame.new(-r8_20.X, -r8_20.Y, 0)).Position)
          local r13_20 = r4_20.Box
          r13_20.Top.From = Vector2.new(r9_20.X, r9_20.Y)
          r13_20.Top.To = Vector2.new(r10_20.X, r10_20.Y)
          r13_20.Bottom.From = Vector2.new(r11_20.X, r11_20.Y)
          r13_20.Bottom.To = Vector2.new(r12_20.X, r12_20.Y)
          r13_20.Left.From = Vector2.new(r9_20.X, r9_20.Y)
          r13_20.Left.To = Vector2.new(r11_20.X, r11_20.Y)
          r13_20.Right.From = Vector2.new(r10_20.X, r10_20.Y)
          r13_20.Right.To = Vector2.new(r12_20.X, r12_20.Y)
          for r17_20, r18_20 in pairs(r13_20) do
            r18_20.Color = r24_0.BoxESP.Color
            r18_20.Thickness = r24_0.BoxESP.Thickness
            r18_20.Visible = true
          end
        else
          for r11_20, r12_20 in pairs(r4_20.Box) do
            r12_20.Visible = false
          end
        end
        if r24_0.NameESP.Enabled then
          local r8_20 = r4_20.Name
          r8_20.Text = r3_20.Name
          r8_20.Position = Vector2.new(r6_20.X, r6_20.Y - 30)
          r8_20.Size = r24_0.NameESP.Size
          r8_20.Color = r24_0.NameESP.Color
          r8_20.Visible = true
        else
          r4_20.Name.Visible = false
        end
      else
        for r11_20, r12_20 in pairs(r4_20.Box) do
          r12_20.Visible = false
        end
        r4_20.Name.Visible = false
      end
    else
      r32_0(r3_20)
    end
  end
end
local function r34_0(r0_7)
  -- line: [0, 0] id: 7
  if r0_7 ~= r28_0 then
    r32_0(r0_7)
    r31_0(r0_7)
    r0_7.CharacterAdded:Connect(function()
      -- line: [0, 0] id: 8
      task.wait(0.1)
      r32_0(r0_7)
      r31_0(r0_7)
    end)
  end
end
local function r35_0()
  -- line: [0, 0] id: 33
  for r3_33, r4_33 in ipairs(r25_0:GetPlayers()) do
    r34_0(r4_33)
  end
  r25_0.PlayerAdded:Connect(r34_0)
  r25_0.PlayerRemoving:Connect(r32_0)
  r26_0.RenderStepped:Connect(r33_0)
end
r4_0:CreateToggle({
  Name = "Box ESP",
  CurrentValue = false,
  Callback = function(r0_41)
    -- line: [0, 0] id: 41
    r24_0.BoxESP.Enabled = r0_41
  end,
}, "BoxESP_Toggle")
r4_0:CreateColorPicker({
  Name = "Box ESP Color",
  Color = r24_0.BoxESP.Color,
  Flag = "BoxESP_Color",
  Callback = function(r0_34)
    -- line: [0, 0] id: 34
    r24_0.BoxESP.Color = r0_34
  end,
}, "BoxESP_ColorPicker")
r4_0:CreateSlider({
  Name = "Box ESP Thickness",
  Range = {
    1,
    5
  },
  Increment = 1,
  CurrentValue = r24_0.BoxESP.Thickness,
  Callback = function(r0_28)
    -- line: [0, 0] id: 28
    r24_0.BoxESP.Thickness = r0_28
  end,
}, "BoxESP_Thickness")
r4_0:CreateToggle({
  Name = "Name ESP",
  CurrentValue = false,
  Callback = function(r0_39)
    -- line: [0, 0] id: 39
    r24_0.NameESP.Enabled = r0_39
  end,
}, "NameESP_Toggle")
r4_0:CreateColorPicker({
  Name = "Name ESP Color",
  Color = r24_0.NameESP.Color,
  Flag = "NameESP_Color",
  Callback = function(r0_9)
    -- line: [0, 0] id: 9
    r24_0.NameESP.Color = r0_9
  end,
}, "NameESP_ColorPicker")
r4_0:CreateSlider({
  Name = "Name ESP Size",
  Range = {
    10,
    30
  },
  Increment = 1,
  CurrentValue = r24_0.NameESP.Size,
  Callback = function(r0_17)
    -- line: [0, 0] id: 17
    r24_0.NameESP.Size = r0_17
  end,
}, "NameESP_Size")
r35_0()
local r36_0 = Color3.fromRGB(175, 25, 255)
local r37_0 = "AlwaysOnTop"
local r38_0 = 0.5
local r39_0 = Color3.fromRGB(255, 255, 255)
local r40_0 = 0
local r41_0 = game:FindService("CoreGui")
local r42_0 = game:FindService("Players")
local r43_0 = r42_0.LocalPlayer
local r44_0 = {}
local r45_0 = Instance.new("Folder")
r45_0.Parent = r41_0
r45_0.Name = "Highlight_Storage"
local r46_0 = false
local function r47_0(r0_12)
  -- line: [0, 0] id: 12
  local r1_12 = Instance.new("Highlight")
  r1_12.Name = r0_12.Name
  r1_12.FillColor = r36_0
  r1_12.DepthMode = r37_0
  r1_12.FillTransparency = r38_0
  r1_12.OutlineColor = r39_0
  r1_12.OutlineTransparency = r40_0
  r1_12.Parent = r45_0
  local r2_12 = r0_12.Character
  if r2_12 then
    r1_12.Adornee = r2_12
  end
  r44_0[r0_12] = r0_12.CharacterAdded:Connect(function(r0_13)
    -- line: [0, 0] id: 13
    r1_12.Adornee = r0_13
  end)
end
local r50_0 = {
  Name = "Chams ESP",
  Description = "Toggle player highlighting",
  CurrentValue = r46_0,
  Callback = function(r0_5)
    -- line: [0, 0] id: 5
    r46_0 = r0_5
    if r46_0 then
      local r1_5 = next
      local r2_5, r3_5 = r42_0:GetPlayers()
      for r4_5, r5_5 in r1_5, r2_5, r3_5 do
        r47_0(r5_5)
      end
    else
      local r1_5 = next
      local r2_5, r3_5 = r42_0:GetPlayers()
      for r4_5, r5_5 in r1_5, r2_5, r3_5 do
        if r45_0[r5_5.Name] then
          r45_0[r5_5.Name]:Destroy()
        end
      end
    end
    print("[cb] MyToggle changed to:", r0_5)
  end,
}
local r48_0 = r4_0:CreateToggle(r50_0, "Toggle")
r42_0.PlayerAdded:Connect(function(r0_26)
  -- line: [0, 0] id: 26
  if r46_0 then
    r47_0(r0_26)
  end
end)
local r49_0 = next
local r50_0, r51_0 = r42_0:GetPlayers()
for r52_0, r53_0 in r49_0, r50_0, r51_0 do
  if r46_0 then
    r47_0(r53_0)
  end
end
r42_0.PlayerRemoving:Connect(function(r0_14)
  -- line: [0, 0] id: 14
  local r1_14 = r0_14.Name
  if r45_0[r1_14] then
    r45_0[r1_14]:Destroy()
  end
  if r44_0[r0_14] then
    r44_0[r0_14]:Disconnect()
  end
end)
r49_0 = r4_0:CreateColorPicker({
  Name = "Cham Color Picker",
  Color = r36_0,
  Flag = "ColorPicker1",
  Callback = function(r0_19)
    -- line: [0, 0] id: 19
    r36_0 = r0_19
    print("[cb] Color changed!", r36_0)
  end,
}, "ColorPicker")
r50_0 = r4_0:CreateSlider({
  Name = "Transparency Slider",
  Range = {
    0,
    1
  },
  Increment = 0.05,
  CurrentValue = r38_0,
  Callback = function(r0_10)
    -- line: [0, 0] id: 10
    r38_0 = r0_10
    print("[cb] Transparency changed!", r38_0)
  end,
}, "Slider")
r49_0:SetValueRGB(r36_0)
r50_0:SetValue(r38_0)

-- line: [0, 0] id: 0
local r0_0 = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true))()
local r3_0 = {
  Name = "Void.lua Prison Life [NEW BETA]",
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
    "VoidPF"
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
  Name = "Gun Mods",
  Icon = "build",
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
  Name = "ESP",
  Icon = "visibility",
  ImageSource = "Material",
  ShowTitle = true,
})
r2_0:CreateSection("This the best stuff")
local r6_0 = r2_0:CreateLabel({
  Text = "Have Fun <3",
  Style = 2,
})
local r7_0 = game:GetService("Players")
local r8_0 = game:GetService("RunService")
local r9_0 = r7_0.LocalPlayer
getgenv().HBE = false
getgenv().HITBOX_SIZE = 20
getgenv().HITBOX_COLOR = Color3.fromRGB(0, 255, 0)
getgenv().HITBOX_TRANSPARENCY = 0.5
local r11_0 = (function()
  -- line: [0, 0] id: 8
  repeat
    wait()
  until r9_0.Character
  local r0_8 = nil	-- notice: implicit variable refs by block#[6]
  for r4_8, r5_8 in pairs(workspace:GetDescendants()) do
    if string.find(r5_8.Name, r9_0.Name) and r5_8:FindFirstChild("Humanoid") then
      r0_8 = r5_8.Parent
      break
    end
  end
  return r0_8
end)()
pcall(function()
  -- line: [0, 0] id: 42
  local r0_42 = getrawmetatable(game)
  setreadonly(r0_42, false)
  local r1_42 = r0_42.__index
  function r0_42.__index(r0_43, r1_43)
    -- line: [0, 0] id: 43
    if tostring(r0_43) == "HumanoidRootPart" and tostring(r1_43) == "Size" then
      return Vector3.new(2, 2, 1)
    end
    return r1_42(r0_43, r1_43)
  end
  setreadonly(r0_42, true)
end)
local r12_0 = {}
local function r13_0(r0_25)
  -- line: [0, 0] id: 25
  if r0_25 == r9_0 then
    return 
  end
  if r12_0[r0_25] then
    r12_0[r0_25]:Disconnect()
  end
  r12_0[r0_25] = r8_0.RenderStepped:Connect(function()
    -- line: [0, 0] id: 26
    local r0_26 = r11_0:FindFirstChild(r0_25.Name)
    if getgenv().HBE and r0_26 and r0_26:FindFirstChild("HumanoidRootPart") then
      r0_26.HumanoidRootPart.Size = Vector3.new(getgenv().HITBOX_SIZE, getgenv().HITBOX_SIZE, getgenv().HITBOX_SIZE)
      r0_26.HumanoidRootPart.Color = getgenv().HITBOX_COLOR
      r0_26.HumanoidRootPart.Transparency = getgenv().HITBOX_TRANSPARENCY
      r0_26.HumanoidRootPart.CanCollide = false
    elseif r0_26 and r0_26:FindFirstChild("HumanoidRootPart") then
      r0_26.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
      r0_26.HumanoidRootPart.Transparency = 1
    end
  end)
end
local function r14_0()
  -- line: [0, 0] id: 28
  for r3_28, r4_28 in ipairs(r7_0:GetPlayers()) do
    r13_0(r4_28)
  end
end
r7_0.PlayerAdded:Connect(function(r0_47)
  -- line: [0, 0] id: 47
  if getgenv().HBE then
    r13_0(r0_47)
  end
end)
r7_0.PlayerRemoving:Connect(function(r0_56)
  -- line: [0, 0] id: 56
  if r12_0[r0_56] then
    r12_0[r0_56]:Disconnect()
    r12_0[r0_56] = nil
  end
end)
local r15_0 = r2_0:CreateToggle({
  Name = "Hitbox Expander",
  Description = "Expand enemy hitboxes",
  CurrentValue = false,
  Callback = function(r0_45)
    -- line: [0, 0] id: 45
    getgenv().HBE = r0_45
    if r0_45 then
      r14_0()
    end
  end,
}, "HBE_Toggle")
local r16_0 = r2_0:CreateColorPicker({
  Name = "Hitbox Color",
  Color = Color3.fromRGB(0, 255, 0),
  Flag = "HBE_ColorPicker",
  Callback = function(r0_5)
    -- line: [0, 0] id: 5
    getgenv().HITBOX_COLOR = r0_5
  end,
}, "HBE_ColorPicker")
local r17_0 = r2_0:CreateSlider({
  Name = "Hitbox Size",
  Range = {
    2,
    15
  },
  Increment = 1,
  CurrentValue = 20,
  Callback = function(r0_18)
    -- line: [0, 0] id: 18
    getgenv().HITBOX_SIZE = r0_18
  end,
}, "HBE_SizeSlider")
local r18_0 = r2_0:CreateSlider({
  Name = "Hitbox Transparency",
  Range = {
    0,
    1
  },
  Increment = 0.05,
  CurrentValue = 0.5,
  Callback = function(r0_39)
    -- line: [0, 0] id: 39
    getgenv().HITBOX_TRANSPARENCY = r0_39
  end,
}, "HBE_TransparencySlider")
local r19_0 = r2_0:CreateToggle({
  Name = "Auto Doors",
  CurrentValue = false,
  Callback = function(r0_11)
    -- line: [0, 0] id: 11
    if r0_11 then
      DoorsHandler()
    end
  end,
}, "Toggle")
local r20_0 = r2_0:CreateToggle({
  Name = "Auto Reset on Arrest",
  CurrentValue = false,
  Callback = function(r0_15)
    -- line: [0, 0] id: 15
    r8_0.Heartbeat:Connect(function()
      -- line: [0, 0] id: 16
      if r0_15 and isArrested.Value then
        JapaDo()
      end
    end)
  end,
}, "Toggle")
local r21_0 = r2_0:CreateToggle({
  Name = "Server Hop",
  CurrentValue = false,
  Callback = function(r0_54)
    -- line: [0, 0] id: 54
    if r0_54 then
      task.spawn(JoinLowestPingServer)
    end
  end,
}, "Toggle")
local r22_0 = false
local r23_0 = 0
local r24_0 = 999999999
local r25_0 = 999999999
local r26_0 = r3_0:CreateToggle({
  Name = "Gun OP Mods",
  CurrentValue = false,
  Callback = function(r0_55)
    -- line: [0, 0] id: 55
    r22_0 = r0_55
  end,
}, "Toggle")
local r27_0 = r3_0:CreateSlider({
  Name = "Fire Rate",
  Range = {
    0,
    500
  },
  Increment = 1,
  CurrentValue = 0,
  Callback = function(r0_27)
    -- line: [0, 0] id: 27
    r23_0 = r0_27
  end,
}, "Slider")
local r28_0 = r3_0:CreateSlider({
  Name = "Range",
  Range = {
    0,
    999999999
  },
  Increment = 1000,
  CurrentValue = 999999999,
  Callback = function(r0_41)
    -- line: [0, 0] id: 41
    r24_0 = r0_41
  end,
}, "Slider")
local r29_0 = r3_0:CreateSlider({
  Name = "Spread",
  Range = {
    0,
    999999999
  },
  Increment = 1000,
  CurrentValue = 999999999,
  Callback = function(r0_38)
    -- line: [0, 0] id: 38
    r25_0 = r0_38
  end,
}, "Slider")
local r30_0 = nil
r30_0 = hookmetamethod(game, "__namecall", function(r0_2, ...)
  -- line: [0, 0] id: 2
  if getnamecallmethod() == "GetAttributes" and r22_0 then
    local r3_2 = r30_0(r0_2, ...)
    r3_2.AutoFire = true
    r3_2.FireRate = r23_0
    r3_2.Range = r24_0
    r3_2.Spread = r25_0
    return r3_2
  end
  return r30_0(r0_2, ...)
end)
local r31_0 = r2_0:CreateToggle({
  Name = "Respawn at Same Location",
  CurrentValue = false,
  Callback = function(r0_30)
    -- line: [0, 0] id: 30
    if r0_30 then
      r9_0.CharacterRemoving:Connect(function(r0_31)
        -- line: [0, 0] id: 31
        if r0_31:FindFirstChild("Humanoid") and r0_31.Humanoid.Name ~= "Valid" then
          local r1_31 = Camera.CFrame
          local r2_31 = nil
          r2_31 = r9_0.CharacterAdded:Connect(function(r0_32)
            -- line: [0, 0] id: 32
            r0_32:WaitForChild("HumanoidRootPart").CFrame = r0_31.HumanoidRootPart.CFrame
            Camera.CFrame = r1_31
            r2_31:Disconnect()
          end)
          -- close: r1_31
        end
      end)
    end
  end,
}, "Toggle")
local r32_0 = game.Players.LocalPlayer
local function r33_0(r0_13)
  -- line: [0, 0] id: 13
  local r1_13 = r32_0.Character
  if r1_13 and r1_13:FindFirstChild("HumanoidRootPart") and r0_13 and r0_13:IsA("BasePart") then
    r1_13:MoveTo(r0_13.Position + Vector3.new(0, 3, 0))
  else
    warn("��️ Invalid teleport target or missing character!")
  end
end
local function r34_0(r0_29)
  -- line: [0, 0] id: 29
  if r0_29:IsA("BasePart") then
    return r0_29
  end
  for r4_29, r5_29 in pairs(r0_29:GetDescendants()) do
    if r5_29:IsA("BasePart") then
      return r5_29
    end
  end
  return nil
end
r2_0:CreateButton({
  Name = "TP to AK-47",
  Description = "Teleport to the AK-47 giver location",
  Callback = function()
    -- line: [0, 0] id: 4
    local r0_4 = workspace:FindFirstChild("Prison_ITEMS") and workspace.Prison_ITEMS:FindFirstChild("giver") and workspace.Prison_ITEMS.giver:FindFirstChild("AK-47")
    local r1_4 = r0_4 and r34_0(r0_4)
    if r1_4 then
      r33_0(r1_4)
    else
      warn("�� AK-47 giver not found or has no BasePart!")
    end
  end,
})
r2_0:CreateButton({
  Name = "TP to Prison Spawn",
  Description = "Teleport to the main prison spawn point",
  Callback = function()
    -- line: [0, 0] id: 49
    local r0_49 = workspace:FindFirstChild("Prison_spawn")
    local r1_49 = r0_49 and r34_0(r0_49)
    if r1_49 then
      r33_0(r1_49)
    else
      warn("�� Prison spawn not found or has no BasePart!")
    end
  end,
})
r2_0:CreateButton({
  Name = "TP to Guard Spawn",
  Description = "Teleport to the guard spawn area",
  Callback = function()
    -- line: [0, 0] id: 1
    local r0_1 = game:GetService("ReplicatedStorage"):FindFirstChild("Regions")
    local r1_1 = r0_1 and r0_1:FindFirstChild("GuardSpawn")
    local r2_1 = r1_1 and r34_0(r1_1)
    if r2_1 then
      r33_0(r2_1)
    else
      warn("�� Guard spawn not found or has no BasePart!")
    end
  end,
})
r2_0:CreateButton({
  Name = "TP to Criminals Spawn",
  Description = "Teleport to the criminals\' spawn area",
  Callback = function()
    -- line: [0, 0] id: 10
    local r0_10 = workspace:FindFirstChild("Criminals Spawn")
    local r1_10 = r0_10 and r34_0(r0_10)
    if r1_10 then
      r33_0(r1_10)
    else
      warn("�� Criminals spawn not found or has no BasePart!")
    end
  end,
})
local r35_0 = game:GetService("Players")
local r36_0 = game:GetService("RunService")
local r37_0 = game:GetService("UserInputService")
local r39_0 = r35_0.LocalPlayer.Character or r38_0.CharacterAdded:Wait()
local r40_0 = r39_0:WaitForChild("Humanoid")
local function r41_0(r0_50)
  -- line: [0, 0] id: 50
  r39_0 = r0_50
  r40_0 = r0_50:WaitForChild("Humanoid")
  if getgenv().WalkSpeedEnabled then
    r40_0.WalkSpeed = getgenv().WalkSpeedValue
  end
  if getgenv().JumpPowerEnabled then
    r40_0.UseJumpPower = true
    r40_0.JumpPower = getgenv().JumpPowerValue
  end
  if typeof(QuickSetup) == "function" then
    QuickSetup(r0_50)
  end
end
r38_0.CharacterAdded:Connect(r41_0)
r41_0(r39_0)
getgenv().WalkSpeedEnabled = false
getgenv().WalkSpeedValue = 16
getgenv().JumpPowerEnabled = false
getgenv().JumpPowerValue = 50
getgenv().NoClipEnabled = false
getgenv().InfiniteJumpEnabled = false
r4_0:CreateToggle({
  Name = "WalkSpeed",
  Description = "Enable/disable custom WalkSpeed",
  CurrentValue = false,
  Callback = function(r0_21)
    -- line: [0, 0] id: 21
    getgenv().WalkSpeedEnabled = r0_21
    local r1_21 = r40_0
    local r2_21 = nil	-- notice: implicit variable refs by block#[3]
    if r0_21 then
      r2_21 = getgenv().WalkSpeedValue
      if not r2_21 then
        ::label_11::
        r2_21 = 16
      end
    else
      goto label_11	-- block#2 is visited secondly
    end
    r1_21.WalkSpeed = r2_21
  end,
})
r4_0:CreateSlider({
  Name = "WalkSpeed Value",
  Range = {
    0,
    100
  },
  Increment = 1,
  CurrentValue = 16,
  Callback = function(r0_40)
    -- line: [0, 0] id: 40
    getgenv().WalkSpeedValue = r0_40
    if getgenv().WalkSpeedEnabled then
      r40_0.WalkSpeed = r0_40
    end
  end,
})
r4_0:CreateToggle({
  Name = "JumpPower",
  Description = "Enable/disable custom JumpPower",
  CurrentValue = false,
  Callback = function(r0_23)
    -- line: [0, 0] id: 23
    getgenv().JumpPowerEnabled = r0_23
    r40_0.UseJumpPower = true
    local r1_23 = r40_0
    local r2_23 = nil	-- notice: implicit variable refs by block#[3]
    if r0_23 then
      r2_23 = getgenv().JumpPowerValue
      if not r2_23 then
        ::label_13::
        r2_23 = 50
      end
    else
      goto label_13	-- block#2 is visited secondly
    end
    r1_23.JumpPower = r2_23
  end,
})
r4_0:CreateSlider({
  Name = "JumpPower Value",
  Range = {
    0,
    200
  },
  Increment = 1,
  CurrentValue = 50,
  Callback = function(r0_44)
    -- line: [0, 0] id: 44
    getgenv().JumpPowerValue = r0_44
    if getgenv().JumpPowerEnabled then
      r40_0.JumpPower = r0_44
    end
  end,
})
r4_0:CreateToggle({
  Name = "Noclip",
  Description = "Walk through walls",
  CurrentValue = false,
  Callback = function(r0_17)
    -- line: [0, 0] id: 17
    getgenv().NoClipEnabled = r0_17
  end,
})
r4_0:CreateToggle({
  Name = "Infinite Jump",
  Description = "Jump repeatedly in the air",
  CurrentValue = false,
  Callback = function(r0_6)
    -- line: [0, 0] id: 6
    getgenv().InfiniteJumpEnabled = r0_6
  end,
})
r36_0.Stepped:Connect(function()
  -- line: [0, 0] id: 37
  if getgenv().NoClipEnabled and r39_0 then
    for r3_37, r4_37 in ipairs(r39_0:GetChildren()) do
      if r4_37:IsA("BasePart") then
        r4_37.CanCollide = false
      end
    end
  end
end)
r37_0.JumpRequest:Connect(function()
  -- line: [0, 0] id: 19
  if getgenv().InfiniteJumpEnabled and r40_0 then
    r40_0:ChangeState(Enum.HumanoidStateType.Jumping)
  end
end)
local r42_0 = game:GetService("Players")
local r43_0 = game:GetService("RunService")
local r44_0 = game:GetService("UserInputService")
local r45_0 = r42_0.LocalPlayer
local r46_0 = r45_0.Character or r45_0.CharacterAdded:Wait()
local r47_0 = false
local r48_0 = 100
local r49_0 = nil
r4_0:CreateToggle({
  Name = "Fly",
  CurrentValue = false,
  Callback = function(r0_51)
    -- line: [0, 0] id: 51
    r47_0 = r0_51
    local r1_51 = r46_0:FindFirstChild("HumanoidRootPart")
    if not r1_51 then
      return 
    end
    if r47_0 then
      local r2_51 = Instance.new("BodyVelocity")
      r2_51.MaxForce = Vector3.new(1000000, 1000000, 1000000)
      r2_51.Velocity = Vector3.zero
      r2_51.Name = "FlyVelocity"
      r2_51.Parent = r1_51
      r49_0 = r43_0.Heartbeat:Connect(function()
        -- line: [0, 0] id: 52
        if not r47_0 or not r1_51.Parent then
          if r49_0 then
            r49_0:Disconnect()
          end
          if r1_51:FindFirstChild("FlyVelocity") then
            r1_51.FlyVelocity:Destroy()
          end
          return 
        end
        local r0_52 = workspace.CurrentCamera
        local r1_52 = Vector3.zero
        if r44_0:IsKeyDown(Enum.KeyCode.W) then
          r1_52 = r1_52 + r0_52.CFrame.LookVector
        end
        if r44_0:IsKeyDown(Enum.KeyCode.S) then
          r1_52 = r1_52 - r0_52.CFrame.LookVector
        end
        if r44_0:IsKeyDown(Enum.KeyCode.A) then
          r1_52 = r1_52 - r0_52.CFrame.RightVector
        end
        if r44_0:IsKeyDown(Enum.KeyCode.D) then
          r1_52 = r1_52 + r0_52.CFrame.RightVector
        end
        if r44_0:IsKeyDown(Enum.KeyCode.Space) then
          r1_52 = r1_52 + Vector3.new(0, 1, 0)
        end
        if r44_0:IsKeyDown(Enum.KeyCode.LeftShift) then
          r1_52 = r1_52 - Vector3.new(0, 1, 0)
        end
        if r1_52.Magnitude > 0 then
          r1_51.FlyVelocity.Velocity = r1_52.Unit * r48_0
        else
          r1_51.FlyVelocity.Velocity = Vector3.zero
        end
      end)
    else
      if r49_0 then
        r49_0:Disconnect()
      end
      if r1_51:FindFirstChild("FlyVelocity") then
        r1_51.FlyVelocity:Destroy()
      end
    end
  end,
})
r4_0:CreateSlider({
  Name = "Fly Speed",
  Range = {
    0,
    500
  },
  Increment = 1,
  CurrentValue = 100,
  Callback = function(r0_53)
    -- line: [0, 0] id: 53
    r48_0 = r0_53
  end,
})
local r50_0 = {
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
  TeamESP = {
    Enabled = false,
    Size = 15,
  },
}
local r51_0 = game:GetService("Players")
local r52_0 = game:GetService("RunService")
local r53_0 = workspace.CurrentCamera
local r54_0 = r51_0.LocalPlayer
local r55_0 = {}
local function r56_0(r0_48, r1_48)
  -- line: [0, 0] id: 48
  local r2_48 = Drawing.new(r0_48)
  for r6_48, r7_48 in pairs(r1_48) do
    r2_48[r6_48] = r7_48
  end
  return r2_48
end
local function r57_0(r0_36)
  -- line: [0, 0] id: 36
  local r1_36 = {}
  r1_36.Box = {
    Top = r56_0("Line", {
      Thickness = r50_0.BoxESP.Thickness,
      Color = r50_0.BoxESP.Color,
    }),
    Bottom = r56_0("Line", {
      Thickness = r50_0.BoxESP.Thickness,
      Color = r50_0.BoxESP.Color,
    }),
    Left = r56_0("Line", {
      Thickness = r50_0.BoxESP.Thickness,
      Color = r50_0.BoxESP.Color,
    }),
    Right = r56_0("Line", {
      Thickness = r50_0.BoxESP.Thickness,
      Color = r50_0.BoxESP.Color,
    }),
  }
  r1_36.Name = r56_0("Text", {
    Size = r50_0.NameESP.Size,
    Color = r50_0.NameESP.Color,
    Center = true,
  })
  r1_36.Team = r56_0("Text", {
    Size = r50_0.TeamESP.Size,
    Center = true,
  })
  r55_0[r0_36] = r1_36
end
local function r58_0(r0_46)
  -- line: [0, 0] id: 46
  if r55_0[r0_46] then
    for r4_46, r5_46 in pairs(r55_0[r0_46].Box) do
      r5_46:Remove()
    end
    if r55_0[r0_46].Name then
      r55_0[r0_46].Name:Remove()
    end
    if r55_0[r0_46].Team then
      r55_0[r0_46].Team:Remove()
    end
    r55_0[r0_46] = nil
  end
end
local function r59_0()
  -- line: [0, 0] id: 24
  for r3_24, r4_24 in pairs(r55_0) do
    if r3_24.Character and r3_24.Character:FindFirstChild("HumanoidRootPart") then
      local r5_24 = r3_24.Character.HumanoidRootPart
      local r6_24, r7_24 = r53_0:WorldToViewportPoint(r5_24.Position)
      if r7_24 then
        if r50_0.BoxESP.Enabled then
          local r8_24 = Vector3.new(2, 3, 0)
          local r9_24 = r53_0:WorldToViewportPoint((r5_24.CFrame * CFrame.new(r8_24.X, r8_24.Y, 0)).Position)
          local r10_24 = r53_0:WorldToViewportPoint((r5_24.CFrame * CFrame.new(-r8_24.X, r8_24.Y, 0)).Position)
          local r11_24 = r53_0:WorldToViewportPoint((r5_24.CFrame * CFrame.new(r8_24.X, -r8_24.Y, 0)).Position)
          local r12_24 = r53_0:WorldToViewportPoint((r5_24.CFrame * CFrame.new(-r8_24.X, -r8_24.Y, 0)).Position)
          local r13_24 = r4_24.Box
          r13_24.Top.From = Vector2.new(r9_24.X, r9_24.Y)
          r13_24.Top.To = Vector2.new(r10_24.X, r10_24.Y)
          r13_24.Bottom.From = Vector2.new(r11_24.X, r11_24.Y)
          r13_24.Bottom.To = Vector2.new(r12_24.X, r12_24.Y)
          r13_24.Left.From = Vector2.new(r9_24.X, r9_24.Y)
          r13_24.Left.To = Vector2.new(r11_24.X, r11_24.Y)
          r13_24.Right.From = Vector2.new(r10_24.X, r10_24.Y)
          r13_24.Right.To = Vector2.new(r12_24.X, r12_24.Y)
          for r17_24, r18_24 in pairs(r13_24) do
            r18_24.Color = r50_0.BoxESP.Color
            r18_24.Thickness = r50_0.BoxESP.Thickness
            r18_24.Visible = true
          end
        else
          for r11_24, r12_24 in pairs(r4_24.Box) do
            r12_24.Visible = false
          end
        end
        if r50_0.NameESP.Enabled then
          r4_24.Name.Text = r3_24.Name
          r4_24.Name.Position = Vector2.new(r6_24.X, r6_24.Y - 30)
          r4_24.Name.Size = r50_0.NameESP.Size
          r4_24.Name.Color = r50_0.NameESP.Color
          r4_24.Name.Visible = true
        else
          r4_24.Name.Visible = false
        end
        if r50_0.TeamESP.Enabled then
          local r8_24 = r3_24.Team
          if r8_24 then
            r8_24 = r3_24.Team.Name or "Prisoner"
          else
            goto label_207	-- block#18 is visited secondly
          end
          r4_24.Team.Text = r8_24
          r4_24.Team.Position = Vector2.new(r6_24.X, r6_24.Y - 50)
          r4_24.Team.Size = r50_0.TeamESP.Size
          if r8_24 == "Criminals" then
            r4_24.Team.Color = Color3.fromRGB(255, 0, 0)
          elseif r8_24 == "Guards" then
            r4_24.Team.Color = Color3.fromRGB(0, 0, 255)
          else
            r4_24.Team.Color = Color3.fromRGB(255, 165, 0)
          end
          r4_24.Team.Visible = true
        else
          r4_24.Team.Visible = false
        end
      else
        for r11_24, r12_24 in pairs(r4_24.Box) do
          r12_24.Visible = false
        end
        r4_24.Name.Visible = false
        r4_24.Team.Visible = false
      end
    else
      r58_0(r3_24)
    end
  end
end
local function r60_0(r0_33)
  -- line: [0, 0] id: 33
  if r0_33 ~= r54_0 then
    r58_0(r0_33)
    r57_0(r0_33)
    r0_33.CharacterAdded:Connect(function()
      -- line: [0, 0] id: 34
      task.wait(0.1)
      r58_0(r0_33)
      r57_0(r0_33)
    end)
  end
end
for r64_0, r65_0 in ipairs(r51_0:GetPlayers()) do
  r60_0(r65_0)
end
r51_0.PlayerAdded:Connect(r60_0)
r51_0.PlayerRemoving:Connect(r58_0)
r52_0.RenderStepped:Connect(r59_0)
r5_0:CreateToggle({
  Name = "Box ESP",
  CurrentValue = false,
  Callback = function(r0_3)
    -- line: [0, 0] id: 3
    r50_0.BoxESP.Enabled = r0_3
  end,
})
r5_0:CreateColorPicker({
  Name = "Box ESP Color",
  Color = r50_0.BoxESP.Color,
  Callback = function(r0_35)
    -- line: [0, 0] id: 35
    r50_0.BoxESP.Color = r0_35
  end,
})
r5_0:CreateSlider({
  Name = "Box ESP Thickness",
  Range = {
    1,
    5
  },
  Increment = 1,
  CurrentValue = r50_0.BoxESP.Thickness,
  Callback = function(r0_22)
    -- line: [0, 0] id: 22
    r50_0.BoxESP.Thickness = r0_22
  end,
})
r5_0:CreateToggle({
  Name = "Name ESP",
  CurrentValue = false,
  Callback = function(r0_14)
    -- line: [0, 0] id: 14
    r50_0.NameESP.Enabled = r0_14
  end,
})
r5_0:CreateColorPicker({
  Name = "Name ESP Color",
  Color = r50_0.NameESP.Color,
  Callback = function(r0_7)
    -- line: [0, 0] id: 7
    r50_0.NameESP.Color = r0_7
  end,
})
r5_0:CreateSlider({
  Name = "Name ESP Size",
  Range = {
    10,
    30
  },
  Increment = 1,
  CurrentValue = r50_0.NameESP.Size,
  Callback = function(r0_9)
    -- line: [0, 0] id: 9
    r50_0.NameESP.Size = r0_9
  end,
})
r5_0:CreateToggle({
  Name = "Team ESP",
  CurrentValue = false,
  Callback = function(r0_20)
    -- line: [0, 0] id: 20
    r50_0.TeamESP.Enabled = r0_20
  end,
})
r5_0:CreateSlider({
  Name = "Team ESP Size",
  Range = {
    10,
    30
  },
  Increment = 1,
  CurrentValue = r50_0.TeamESP.Size,
  Callback = function(r0_12)
    -- line: [0, 0] id: 12
    r50_0.TeamESP.Size = r0_12
  end,
})

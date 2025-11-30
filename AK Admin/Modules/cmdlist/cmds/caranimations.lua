-- filename: 
-- version: lua51
-- line: [0, 0] id: 0
local r0_0 = game:GetService("Players")
local r1_0 = game:GetService("StarterGui")
local r2_0 = game:GetService("UserInputService")
local r3_0 = game:GetService("RunService")
local r4_0 = game:GetService("CoreGui")
local r5_0 = {
  BUTTON_TEXT_SIZE = 12,
  CORNER_RADIUS = UDim.new(0, 6),
  MAIN_CORNER_RADIUS = UDim.new(0, 10),
  ROTATION_SPEED = math.rad(30),
  CAMERA_RADIUS = 6,
  CAMERA_HEIGHT = 3,
  SPEED_THRESHOLD = 0.1,
  SPEED_DIVISOR = 16,
}
local r6_0 = {
  BACKGROUND = Color3.fromRGB(0, 0, 0),
  TEXT = Color3.new(1, 1, 1),
  CONFIRM_YES = Color3.fromRGB(200, 60, 60),
  CONFIRM_NO = Color3.fromRGB(80, 80, 80),
}
local r7_0 = {
  MAIN_FRAME = 0.6,
  TITLE_BAR = 0.5,
  BUTTON = 0.7,
  VIEWPORT = 0.8,
  POPUP = 0.5,
  POPUP_BUTTON = 0.6,
}
local r8_0 = {
  {
    id = "76503595759461",
    mult = 1,
  },
  {
    id = "115245341767944",
    mult = 2,
  },
  {
    id = "127805235430271",
    mult = 4,
  },
  {
    id = "138003068153218",
    mult = 1,
  },
  {
    id = "116772752010894",
    mult = 1,
  },
  {
    id = "116625361313832",
    mult = 1,
  },
  {
    id = "81388785824317",
    mult = 1,
  },
  {
    id = "108747312576405",
    mult = 2,
  },
  {
    id = "113181071290859",
    mult = 1,
  },
  {
    id = "134681712937413",
    mult = 1,
  },
  {
    id = "115260380433565",
    mult = 2,
  },
  {
    id = "72382226286301",
    mult = 1,
  }
}
local r9_0 = {
  currentIndex = 1,
  activeTrack = nil,
  activeConn = nil,
  carstop = false,
  minimized = false,
  confirmationgui = false,
  rotationAngle = 0,
}
local r10_0 = {}
local function r11_0()
  -- line: [0, 0] id: 1
  local r0_1 = workspace.CurrentCamera.ViewportSize
  return {
    uScale = function(r0_3, r1_3)
      -- line: [0, 0] id: 3
      return UDim2.new(0, r0_1.X * r0_3, 0, r0_1.Y * (r1_3 or r0_3))
    end,
    uPos = function(r0_2, r1_2)
      -- line: [0, 0] id: 2
      return UDim2.new(0, r0_1.X * r0_2, 0, r0_1.Y * r1_2)
    end,
    uSize = function(r0_4, r1_4)
      -- line: [0, 0] id: 4
      return UDim2.new(0, r0_1.X * r0_4, 0, r0_1.Y * (r1_4 or r0_4))
    end,
  }
end
local function r12_0()
  -- line: [0, 0] id: 39
  local r0_39 = r0_0.LocalPlayer
  if not r0_39 then
    return false
  end
  local r1_39 = r0_39.Character
  if not r1_39 then
    return false
  end
  local r2_39 = r1_39:FindFirstChild("Humanoid")
  if not r2_39 then
    return false
  end
  return r2_39.RigType == Enum.HumanoidRigType.R15
end
local function r13_0()
  -- line: [0, 0] id: 9
  local r0_9 = r4_0:FindFirstChild("SillyCarUI")
  if r0_9 then
    r0_9:Destroy()
    wait(0.1)
  end
  if getgenv and getgenv().CarExecuted then
    getgenv().CarExecuted = false
    wait(0.1)
  end
  if getgenv then
    getgenv().CarExecuted = true
  end
  return true
end
local function r14_0(r0_28)
  -- line: [0, 0] id: 28
  local r1_28 = Instance.new("UICorner")
  r1_28.CornerRadius = r0_28 or r5_0.CORNER_RADIUS
  return r1_28
end
local function r15_0(r0_37, r1_37, r2_37, r3_37, r4_37)
  -- line: [0, 0] id: 37
  local r5_37 = Instance.new("TextButton")
  r5_37.Parent = r0_37
  r5_37.Size = r1_37
  r5_37.Position = r2_37
  r5_37.BackgroundColor3 = r6_0.BACKGROUND
  r5_37.BackgroundTransparency = r7_0.BUTTON
  r5_37.BorderSizePixel = 0
  r5_37.TextColor3 = r6_0.TEXT
  r5_37.Text = r3_37
  r5_37.Font = Enum.Font.Gotham
  r5_37.TextSize = r4_37 or r5_0.BUTTON_TEXT_SIZE
  r5_37.TextScaled = false
  r14_0():Clone().Parent = r5_37
  return r5_37
end
local function r16_0(r0_65, r1_65, r2_65, r3_65)
  -- line: [0, 0] id: 65
  local r4_65 = Instance.new("Frame")
  r4_65.Parent = r0_65
  r4_65.Size = r1_65
  r4_65.Position = r2_65
  r4_65.BackgroundColor3 = r6_0.BACKGROUND
  r4_65.BackgroundTransparency = r3_65 or 1
  r4_65.BorderSizePixel = 0
  return r4_65
end
local function r17_0(r0_66, r1_66, r2_66, r3_66, r4_66)
  -- line: [0, 0] id: 66
  local r5_66 = Instance.new("TextLabel")
  r5_66.Parent = r0_66
  r5_66.Size = r1_66
  r5_66.Position = r2_66
  r5_66.BackgroundTransparency = 1
  r5_66.Text = r3_66
  r5_66.Font = Enum.Font.Gotham
  r5_66.TextColor3 = r6_0.TEXT
  r5_66.TextSize = r4_66 or r5_0.BUTTON_TEXT_SIZE
  r5_66.TextScaled = false
  return r5_66
end
local function r18_0(r0_21)
  -- line: [0, 0] id: 21
  local r1_21 = r0_21.BackgroundTransparency
  r0_21.MouseEnter:Connect(function()
    -- line: [0, 0] id: 23
    r0_21.BackgroundTransparency = math.max(0, r1_21 - 0.1)
  end)
  r0_21.MouseLeave:Connect(function()
    -- line: [0, 0] id: 22
    r0_21.BackgroundTransparency = r1_21
  end)
end
local function r19_0()
  -- line: [0, 0] id: 7
  local r0_7 = r11_0()
  r10_0.screenGui = Instance.new("ScreenGui")
  r10_0.screenGui.Parent = r4_0
  r10_0.screenGui.ResetOnSpawn = false
  r10_0.screenGui.Name = "SillyCarUI"
  r10_0.mainFrame = r16_0(r10_0.screenGui, r0_7.uSize(0.2, 0.35), UDim2.new(0.5, -120, 0.5, -105), r7_0.MAIN_FRAME)
  r10_0.mainFrame.Active = true
  r10_0.mainFrame.Draggable = true
  r14_0(r5_0.MAIN_CORNER_RADIUS).Parent = r10_0.mainFrame
  return r0_7
end
local function r20_0()
  -- line: [0, 0] id: 11
  r10_0.titleBar = r16_0(r10_0.mainFrame, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0), r7_0.TITLE_BAR)
  r14_0(r5_0.MAIN_CORNER_RADIUS).Parent = r10_0.titleBar
  r10_0.titleText = r17_0(r10_0.titleBar, UDim2.new(1, -60, 1, 0), UDim2.new(0, 30, 0, 0), "CAR anims", r5_0.BUTTON_TEXT_SIZE)
  r10_0.titleText.TextXAlignment = Enum.TextXAlignment.Center
  r10_0.minBtn = r15_0(r10_0.titleBar, UDim2.new(0, 20, 0, 20), UDim2.new(1, -45, 0, 5), "—", r5_0.BUTTON_TEXT_SIZE)
  r10_0.closeBtn = r15_0(r10_0.titleBar, UDim2.new(0, 20, 0, 20), UDim2.new(1, -22, 0, 5), "✕", r5_0.BUTTON_TEXT_SIZE)
end
local function r21_0()
  -- line: [0, 0] id: 40
  r10_0.contentFrame = r16_0(r10_0.mainFrame, UDim2.new(1, -20, 1, -45), UDim2.new(0, 10, 0, 35), 1)
  r10_0.animNameFrame = r16_0(r10_0.contentFrame, UDim2.new(1, 0, 0, 25), UDim2.new(0, 0, 0, 0), r7_0.BUTTON)
  r14_0().Parent = r10_0.animNameFrame
  r10_0.animNameText = r17_0(r10_0.animNameFrame, UDim2.new(1, -10, 1, 0), UDim2.new(0, 5, 0, 0), "Animation " .. r9_0.currentIndex .. "/" .. #r8_0, r5_0.BUTTON_TEXT_SIZE)
  r10_0.animNameText.TextXAlignment = Enum.TextXAlignment.Center
end
local function r22_0()
  -- line: [0, 0] id: 10
  r10_0.viewportContainer = r16_0(r10_0.contentFrame, UDim2.new(1, 0, 1, -105), UDim2.new(0, 0, 0, 30), r7_0.BUTTON)
  r14_0(UDim.new(0, 8)).Parent = r10_0.viewportContainer
  r10_0.viewport = Instance.new("ViewportFrame")
  r10_0.viewport.Parent = r10_0.viewportContainer
  r10_0.viewport.Size = UDim2.new(1, -6, 1, -6)
  r10_0.viewport.Position = UDim2.new(0, 3, 0, 3)
  r10_0.viewport.BackgroundColor3 = r6_0.BACKGROUND
  r10_0.viewport.BackgroundTransparency = r7_0.VIEWPORT
  r10_0.viewport.BorderSizePixel = 0
  r14_0().Parent = r10_0.viewport
  r10_0.camera = Instance.new("Camera")
  r10_0.camera.CameraType = Enum.CameraType.Scriptable
  r10_0.viewport.CurrentCamera = r10_0.camera
end
local function r23_0()
  -- line: [0, 0] id: 19
  r10_0.navContainer = r16_0(r10_0.contentFrame, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 1, -75), 1)
  r10_0.prevBtn = r15_0(r10_0.navContainer, UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0), "◀ Previous", r5_0.BUTTON_TEXT_SIZE)
  r10_0.nextBtn = r15_0(r10_0.navContainer, UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0), "Next ▶", r5_0.BUTTON_TEXT_SIZE)
end
local function r24_0()
  -- line: [0, 0] id: 24
  r10_0.controlContainer = r16_0(r10_0.contentFrame, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 1, -40), 1)
  r10_0.playBtn = r15_0(r10_0.controlContainer, UDim2.new(0.48, 0, 1, 0), UDim2.new(0, 0, 0, 0), "Play Car", r5_0.BUTTON_TEXT_SIZE)
  r10_0.playBtn.Font = Enum.Font.GothamBold
  r10_0.stopBtn = r15_0(r10_0.controlContainer, UDim2.new(0.48, 0, 1, 0), UDim2.new(0.52, 0, 0, 0), "Stop Car", r5_0.BUTTON_TEXT_SIZE)
  r10_0.stopBtn.Font = Enum.Font.GothamBold
end
local function r25_0()
  -- line: [0, 0] id: 62
  for r4_62, r5_62 in ipairs({
    r10_0.prevBtn,
    r10_0.nextBtn,
    r10_0.playBtn,
    r10_0.stopBtn,
    r10_0.minBtn,
    r10_0.closeBtn
  }) do
    r18_0(r5_62)
  end
end
local function r26_0(r0_8)
  -- line: [0, 0] id: 8
  if not r0_8 or not r0_8.Parent then
    return false
  end
  if r0_8.PrimaryPart then
    return true
  end
  local r1_8 = r0_8:FindFirstChild("HumanoidRootPart") or r0_8:FindFirstChildWhichIsA("BasePart")
  if r1_8 then
    r0_8.PrimaryPart = r1_8
    return true
  end
  return false
end
local function r27_0()
  -- line: [0, 0] id: 41
  local r0_41, r1_41 = pcall(function()
    -- line: [0, 0] id: 44
    return r0_0:CreateHumanoidModelFromUserId(9160453052)
  end)
  if not r0_41 or not r1_41 then
    warn("Failed to create dummy model: " .. tostring(r1_41))
    r0_41, r1_41 = pcall(function()
      -- line: [0, 0] id: 42
      return r0_0:CreateHumanoidModelFromUserId(1)
    end)
    if not r0_41 or not r1_41 then
      return false
    end
  end
  r10_0.realDummy = r1_41
  r10_0.realDummy.Parent = workspace
  local r2_41 = 0
  local r3_41 = 100
  while r2_41 < r3_41 and not r26_0(r10_0.realDummy) do
    task.wait(0.05)
    r2_41 = r2_41 + 1
  end
  if not r10_0.realDummy.PrimaryPart then
    warn("Failed to set PrimaryPart for dummy")
    return false
  end
  pcall(function()
    -- line: [0, 0] id: 43
    r10_0.realDummy:SetPrimaryPartCFrame(CFrame.new(0, 10000, 0))
  end)
  r10_0.vpDummy = r10_0.realDummy:Clone()
  r26_0(r10_0.vpDummy)
  r10_0.vpDummy.Parent = r10_0.viewport
  if r10_0.vpDummy.PrimaryPart and r10_0.realDummy.PrimaryPart then
    r10_0.vpDummy:SetPrimaryPartCFrame(r10_0.realDummy.PrimaryPart.CFrame)
  end
  for r7_41, r8_41 in pairs(r10_0.realDummy:GetDescendants()) do
    if r8_41:IsA("BasePart") then
      r8_41.Transparency = 1
      r8_41.CanCollide = false
    end
  end
  local r4_41 = r10_0.vpDummy:FindFirstChild("HumanoidRootPart")
  if r4_41 then
    r4_41.Transparency = 1
  end
  for r8_41, r9_41 in pairs(r10_0.vpDummy:GetDescendants()) do
    if r9_41:IsA("BasePart") then
      r9_41.CanCollide = false
    end
  end
  return true
end
local function r28_0()
  -- line: [0, 0] id: 12
  local r0_12 = nil	-- notice: implicit variable refs by block#[0]
  r0_12 = r3_0.RenderStepped:Connect(function(r0_13)
    -- line: [0, 0] id: 13
    if r9_0.carstop then
      r0_12:Disconnect()
      return 
    end
    if not r10_0.realDummy or not r10_0.realDummy.Parent or not r10_0.vpDummy or not r10_0.vpDummy.Parent then
      return 
    end
    pcall(function()
      -- line: [0, 0] id: 14
      for r3_14, r4_14 in pairs(r10_0.realDummy:GetDescendants()) do
        if r4_14:IsA("BasePart") then
          local r5_14 = r10_0.vpDummy:FindFirstChild(r4_14.Name, true)
          if r5_14 and r5_14:IsA("BasePart") then
            r5_14.CFrame = r4_14.CFrame
          end
        end
      end
    end)
    r9_0.rotationAngle = r9_0.rotationAngle + r5_0.ROTATION_SPEED * r0_13
    local r1_13 = math.sin(r9_0.rotationAngle) * r5_0.CAMERA_RADIUS
    local r2_13 = math.cos(r9_0.rotationAngle) * r5_0.CAMERA_RADIUS
    local r3_13 = r10_0.vpDummy.PrimaryPart
    if r3_13 then
      r3_13 = r10_0.vpDummy.PrimaryPart.Position or Vector3.new(0, 1, 0)
    else
      goto label_66	-- block#9 is visited secondly
    end
    pcall(function()
      -- line: [0, 0] id: 15
      r10_0.camera.CFrame = CFrame.new(r3_13 + Vector3.new(r1_13, r5_0.CAMERA_HEIGHT, r2_13), r3_13)
    end)
  end)
end
local function r29_0()
  -- line: [0, 0] id: 38
  if not r10_0.realDummy then
    return false
  end
  r10_0.humanoid = r10_0.realDummy:FindFirstChildWhichIsA("Humanoid")
  if r10_0.humanoid then
    r10_0.animator = r10_0.humanoid:FindFirstChildOfClass("Animator")
    if not r10_0.animator then
      r10_0.animator = Instance.new("Animator")
      r10_0.animator.Parent = r10_0.humanoid
    end
  end
  r10_0.previewAnimTrack = nil
  return r10_0.humanoid and r10_0.animator
end
local function r30_0(r0_16)
  -- line: [0, 0] id: 16
  if not r10_0.animator then
    return 
  end
  if r10_0.previewAnimTrack then
    pcall(function()
      -- line: [0, 0] id: 18
      r10_0.previewAnimTrack:Stop()
      r10_0.previewAnimTrack:Destroy()
    end)
    r10_0.previewAnimTrack = nil
  end
  local r1_16, r2_16 = pcall(function()
    -- line: [0, 0] id: 17
    local r0_17 = Instance.new("Animation")
    r0_17.AnimationId = "rbxassetid://" .. r8_0[r0_16].id
    local r1_17 = r10_0.animator:LoadAnimation(r0_17)
    r1_17.Priority = Enum.AnimationPriority.Action
    r1_17.Looped = true
    r1_17:Play()
    r1_17:AdjustWeight(1)
    r1_17:AdjustSpeed(1)
    return r1_17
  end)
  if r1_16 and r2_16 then
    r10_0.previewAnimTrack = r2_16
  end
  if r10_0.animNameText then
    r10_0.animNameText.Text = "Animation " .. r9_0.currentIndex .. "/" .. #r8_0
  end
end
local function r31_0()
  -- line: [0, 0] id: 51
  if r9_0.activeTrack then
    pcall(function()
      -- line: [0, 0] id: 52
      r9_0.activeTrack:Stop()
      r9_0.activeTrack:Destroy()
    end)
    r9_0.activeTrack = nil
  end
  if r9_0.activeConn then
    pcall(function()
      -- line: [0, 0] id: 53
      r9_0.activeConn:Disconnect()
    end)
    r9_0.activeConn = nil
  end
end
local function r32_0(r0_45)
  -- line: [0, 0] id: 45
  if not r0_45 or not r0_45.Parent then
    return 
  end
  r31_0()
  local r1_45 = r0_45:FindFirstChild("Humanoid")
  local r2_45 = r0_45:FindFirstChild("HumanoidRootPart")
  if not r1_45 or not r2_45 then
    warn("Character missing required parts")
    return 
  end
  local r3_45, r4_45 = pcall(function()
    -- line: [0, 0] id: 50
    local r0_50 = Instance.new("Animation")
    r0_50.AnimationId = "rbxassetid://" .. r8_0[r9_0.currentIndex].id
    local r1_50 = r1_45:LoadAnimation(r0_50)
    r1_50.Priority = Enum.AnimationPriority.Action
    r1_50:Play()
    r1_50.Looped = true
    r1_50:AdjustWeight(1)
    return r1_50
  end)
  if not r3_45 or not r4_45 then
    warn("Failed to load animation")
    return 
  end
  r9_0.activeTrack = r4_45
  pcall(function()
    -- line: [0, 0] id: 46
    workspace.CurrentCamera.CameraSubject = r0_45:FindFirstChild("Head") or r1_45
  end)
  local r5_45 = r2_45.Position
  local r6_45 = os.clock()
  r9_0.activeConn = r3_0.Heartbeat:Connect(function()
    -- line: [0, 0] id: 47
    if r9_0.carstop or not r2_45.Parent or not r4_45.IsPlaying then
      return 
    end
    local r0_47 = r2_45.Position
    local r1_47 = os.clock()
    local r2_47 = r1_47 - r6_45
    if r2_47 > 0 then
      local r4_47 = (r0_47 - r5_45) / r2_47
      local r5_47 = r4_47.Magnitude
      local r7_47 = nil	-- notice: implicit variable refs by block#[10]
      if r5_0.SPEED_THRESHOLD < r5_47 then
        local r6_47 = r2_45.CFrame.LookVector:Dot(r4_47.Unit)
        local r8_47 = r8_0[r9_0.currentIndex].mult
        r7_47 = r5_47 / r5_0.SPEED_DIVISOR * r8_47
        if r6_47 >= 0 then
          r8_47 = 1 or -1
        else
          goto label_50	-- block#8 is visited secondly
        end
        r7_47 = r7_47 * r8_47
        pcall(function()
          -- line: [0, 0] id: 49
          r4_45:AdjustSpeed(r7_47)
        end)
        -- close: r6_47
      else
        function r7_47()
          -- line: [0, 0] id: 48
          r4_45:AdjustSpeed(0)
        end
        pcall(r7_47)
      end
    end
    r5_45 = r0_47
    r6_45 = r1_47
  end)
end
local function r33_0(r0_25)
  -- line: [0, 0] id: 25
  if r9_0.confirmationgui or not r10_0.screenGui then
    return 
  end
  r9_0.confirmationgui = true
  local r1_25 = r16_0(r10_0.screenGui, UDim2.new(0, 250, 0, 120), UDim2.new(0.5, -125, 0.5, -60), r7_0.POPUP)
  r1_25.Name = "ConfirmationDialog"
  r14_0(r5_0.MAIN_CORNER_RADIUS).Parent = r1_25
  r17_0(r1_25, UDim2.new(1, -20, 0, 50), UDim2.new(0, 10, 0, 10), "Are you sure you want to close?\n(This will stop the current animation)", 14).TextWrapped = true
  local r3_25 = r16_0(r1_25, UDim2.new(1, -20, 0, 35), UDim2.new(0, 10, 1, -45), 1)
  local r4_25 = r15_0(r3_25, UDim2.new(0.4, 0, 1, 0), UDim2.new(0, 0, 0, 0), "Yes", r5_0.BUTTON_TEXT_SIZE)
  r4_25.BackgroundColor3 = r6_0.CONFIRM_YES
  r4_25.BackgroundTransparency = r7_0.POPUP_BUTTON
  r4_25.Font = Enum.Font.GothamBold
  local r5_25 = r15_0(r3_25, UDim2.new(0.4, 0, 1, 0), UDim2.new(0.6, 0, 0, 0), "No", r5_0.BUTTON_TEXT_SIZE)
  r5_25.BackgroundColor3 = r6_0.CONFIRM_NO
  r5_25.BackgroundTransparency = r7_0.POPUP_BUTTON
  r5_25.Font = Enum.Font.GothamBold
  r18_0(r4_25)
  r18_0(r5_25)
  r4_25.MouseButton1Click:Connect(function()
    -- line: [0, 0] id: 27
    r1_25:Destroy()
    r0_25(true)
    r9_0.confirmationgui = false
  end)
  r5_25.MouseButton1Click:Connect(function()
    -- line: [0, 0] id: 26
    r1_25:Destroy()
    r0_25(false)
    r9_0.confirmationgui = false
  end)
end
local function r34_0()
  -- line: [0, 0] id: 5
  r2_0.InputBegan:Connect(function(r0_6, r1_6)
    -- line: [0, 0] id: 6
    if r1_6 or not r10_0.screenGui or r9_0.carstop then
      return 
    end
    if r0_6.KeyCode == Enum.KeyCode.K then
      r10_0.screenGui.Enabled = not r10_0.screenGui.Enabled
    elseif r0_6.KeyCode == Enum.KeyCode.Left then
      r9_0.currentIndex = (r9_0.currentIndex - 2) % #r8_0 + 1
      r30_0(r9_0.currentIndex)
    elseif r0_6.KeyCode == Enum.KeyCode.Right then
      r9_0.currentIndex = r9_0.currentIndex % #r8_0 + 1
      r30_0(r9_0.currentIndex)
    elseif (r0_6.KeyCode == Enum.KeyCode.Return or r0_6.KeyCode == Enum.KeyCode.KeypadEnter) and r0_0.LocalPlayer.Character then
      r32_0(r0_0.LocalPlayer.Character)
    end
  end)
end
local function r35_0()
  -- line: [0, 0] id: 29
  r10_0.prevBtn.MouseButton1Click:Connect(function()
    -- line: [0, 0] id: 32
    r9_0.currentIndex = (r9_0.currentIndex - 2) % #r8_0 + 1
    r30_0(r9_0.currentIndex)
  end)
  r10_0.nextBtn.MouseButton1Click:Connect(function()
    -- line: [0, 0] id: 34
    r9_0.currentIndex = r9_0.currentIndex % #r8_0 + 1
    r30_0(r9_0.currentIndex)
  end)
  r10_0.playBtn.MouseButton1Click:Connect(function()
    -- line: [0, 0] id: 31
    if r0_0.LocalPlayer.Character then
      r32_0(r0_0.LocalPlayer.Character)
    end
  end)
  r10_0.stopBtn.MouseButton1Click:Connect(function()
    -- line: [0, 0] id: 33
    r31_0()
  end)
  r10_0.minBtn.MouseButton1Click:Connect(function()
    -- line: [0, 0] id: 30
    r9_0.minimized = not r9_0.minimized
    if r9_0.minimized then
      r10_0.mainFrame.Size = UDim2.new(0, r10_0.mainFrame.AbsoluteSize.X, 0, 30)
      r10_0.contentFrame.Visible = false
    else
      r10_0.mainFrame.Size = r11_0().uSize(0.2, 0.35)
      r10_0.contentFrame.Visible = true
    end
  end)
  r10_0.closeBtn.MouseButton1Click:Connect(function()
    -- line: [0, 0] id: 35
    r33_0(function(r0_36)
      -- line: [0, 0] id: 36
      if r0_36 then
        r9_0.carstop = true
        r31_0()
        if r10_0.realDummy then
          r10_0.realDummy:Destroy()
        end
        if r10_0.screenGui then
          r10_0.screenGui:Destroy()
        end
        if getgenv then
          getgenv().CarExecuted = false
        end
      end
    end)
  end)
end
local function r36_0()
  -- line: [0, 0] id: 63
  local r0_63 = r0_0.LocalPlayer
  if not r0_63 then
    return 
  end
  r0_63.CharacterAdded:Connect(function(r0_64)
    -- line: [0, 0] id: 64
    if r9_0.carstop then
      return 
    end
    local r1_64 = r0_64:WaitForChild("Humanoid", 10)
    local r2_64 = r0_64:WaitForChild("HumanoidRootPart", 10)
    if not r1_64 or not r2_64 then
      return 
    end
    task.wait(2)
    if r0_64.Parent and not r9_0.carstop then
      r32_0(r0_64)
    end
  end)
end
local r38_0, r39_0 = pcall(function()
  -- line: [0, 0] id: 54
  pcall(function()
    -- line: [0, 0] id: 55
    r1_0:SetCore("SendNotification", {
      Title = "Car Animations",
      Text = "Loading script...",
      Duration = 3,
    })
  end)
  if not r12_0() then
    pcall(function()
      -- line: [0, 0] id: 59
      r1_0:SetCore("SendNotification", {
        Title = "Car Animations",
        Text = "This script only works with R15 characters!",
        Duration = 5,
      })
    end)
    return 
  end
  if not r13_0() then
    pcall(function()
      -- line: [0, 0] id: 60
      r1_0:SetCore("SendNotification", {
        Title = "Car Animations",
        Text = "Script is already running!",
        Duration = 3,
      })
    end)
    return 
  end
  if not pcall(function()
    -- line: [0, 0] id: 61
    r19_0()
    r20_0()
    r21_0()
    r22_0()
    r23_0()
    r24_0()
    r25_0()
  end) then
    warn("Failed to create interface")
    if getgenv then
      getgenv().CarExecuted = false
    end
    return 
  end
  task.spawn(function()
    -- line: [0, 0] id: 56
    local r0_56 = false
    local r1_56 = 0
    local r2_56 = 3
    while not r0_56 and r1_56 < r2_56 do
      r1_56 = r1_56 + 1
      r0_56 = r27_0()
      if not r0_56 then
        task.wait(1)
      end
    end
    if not r0_56 then
      warn("Failed to create dummy models after " .. r2_56 .. " attempts")
      if r10_0.screenGui then
        r10_0.screenGui:Destroy()
      end
      if getgenv then
        getgenv().CarExecuted = false
      end
      pcall(function()
        -- line: [0, 0] id: 57
        r1_0:SetCore("SendNotification", {
          Title = "Car Animations",
          Text = "Failed to load dummy model. Try again.",
          Duration = 5,
        })
      end)
      return 
    end
    r28_0()
    if not r29_0() then
      warn("Failed to initialize animation system")
      return 
    end
    r30_0(r9_0.currentIndex)
    r34_0()
    r35_0()
    r36_0()
    pcall(function()
      -- line: [0, 0] id: 58
      r1_0:SetCore("SendNotification", {
        Title = "Car Animations",
        Text = "Script loaded! Press K to toggle UI",
        Duration = 5,
      })
    end)
  end)
end)
if not r38_0 then
  warn("Script execution failed: " .. tostring(r39_0))
  pcall(function()
    -- line: [0, 0] id: 20
    r1_0:SetCore("SendNotification", {
      Title = "Car Animations",
      Text = "Script failed to load: " .. tostring(r39_0),
      Duration = 8,
    })
  end)
end
-- close: r0_0

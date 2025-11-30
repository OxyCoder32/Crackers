-- filename: 
-- version: lua51
-- line: [0, 0] id: 0
local r0_0 = game:GetService("Players")
local r1_0 = game:GetService("UserInputService")
local r2_0 = game:GetService("HttpService")
local r3_0 = game:GetService("TweenService")
local r4_0 = r0_0.LocalPlayer
local r5_0 = r0_0.LocalPlayer:WaitForChild("PlayerGui")
pcall(function()
  -- line: [0, 0] id: 6
  if r5_0:FindFirstChild("UGCEmotes") then
    r5_0:FindFirstChild("UGCEmotes"):Destroy()
  end
end)
local r6_0 = Instance.new("ScreenGui")
r6_0.Name = "UGCEmotes"
r6_0.Parent = r5_0
local r7_0 = Instance.new("Frame")
r7_0.Size = UDim2.new(0, 280, 0, 350)
r7_0.Position = UDim2.new(0.5, -140, 0.5, -175)
r7_0.BackgroundColor3 = Color3.new(0, 0, 0)
r7_0.BackgroundTransparency = 0.6
r7_0.BorderSizePixel = 0
r7_0.Parent = r6_0
local r8_0 = Instance.new("UICorner")
r8_0.CornerRadius = UDim.new(0, 15)
r8_0.Parent = r7_0
local r9_0 = Instance.new("Frame")
r9_0.Size = UDim2.new(1, 0, 0, 30)
r9_0.Position = UDim2.new(0, 0, 0, 0)
r9_0.BackgroundTransparency = 1
r9_0.BorderSizePixel = 0
r9_0.Parent = r7_0
local r10_0 = Instance.new("TextLabel")
r10_0.Size = UDim2.new(1, -60, 1, 0)
r10_0.Position = UDim2.new(0, 30, 0, 0)
r10_0.BackgroundTransparency = 1
r10_0.Text = "UGC Emotes"
r10_0.TextColor3 = Color3.new(1, 1, 1)
r10_0.TextSize = 16
r10_0.Font = Enum.Font.Gotham
r10_0.TextXAlignment = Enum.TextXAlignment.Center
r10_0.Parent = r9_0
local r11_0 = Instance.new("TextButton")
r11_0.Size = UDim2.new(0, 22, 0, 22)
r11_0.Position = UDim2.new(1, -48, 0, 4)
r11_0.BackgroundColor3 = Color3.new(0, 0, 0)
r11_0.BackgroundTransparency = 0.7
r11_0.Text = "−"
r11_0.TextColor3 = Color3.new(1, 1, 1)
r11_0.TextScaled = true
r11_0.Font = Enum.Font.Gotham
r11_0.BorderSizePixel = 0
r11_0.Parent = r9_0
local r12_0 = Instance.new("UICorner")
r12_0.CornerRadius = UDim.new(0, 10)
r12_0.Parent = r11_0
local r13_0 = Instance.new("TextButton")
r13_0.Size = UDim2.new(0, 22, 0, 22)
r13_0.Position = UDim2.new(1, -24, 0, 4)
r13_0.BackgroundColor3 = Color3.new(0, 0, 0)
r13_0.BackgroundTransparency = 0.7
r13_0.Text = "×"
r13_0.TextColor3 = Color3.new(1, 1, 1)
r13_0.TextScaled = true
r13_0.Font = Enum.Font.Gotham
r13_0.BorderSizePixel = 0
r13_0.Parent = r9_0
local r14_0 = Instance.new("UICorner")
r14_0.CornerRadius = UDim.new(0, 10)
r14_0.Parent = r13_0
local r15_0 = Instance.new("TextLabel")
r15_0.Size = UDim2.new(1, -16, 0, 12)
r15_0.Position = UDim2.new(0, 8, 0, 32)
r15_0.BackgroundTransparency = 1
r15_0.Text = "Loading..."
r15_0.TextColor3 = Color3.new(0.7, 0.7, 0.7)
r15_0.TextSize = 10
r15_0.Font = Enum.Font.Gotham
r15_0.Parent = r7_0
local r16_0 = Instance.new("Frame")
r16_0.Size = UDim2.new(1, -16, 0, 25)
r16_0.Position = UDim2.new(0, 8, 0, 48)
r16_0.BackgroundTransparency = 1
r16_0.Parent = r7_0
local r17_0 = Instance.new("TextButton")
r17_0.Size = UDim2.new(0.33, -2, 1, 0)
r17_0.Position = UDim2.new(0, 0, 0, 0)
r17_0.BackgroundColor3 = Color3.new(0, 0, 0)
r17_0.BackgroundTransparency = 0.7
r17_0.Text = "All"
r17_0.TextColor3 = Color3.new(1, 1, 1)
r17_0.TextSize = 12
r17_0.Font = Enum.Font.Gotham
r17_0.BorderSizePixel = 0
r17_0.Parent = r16_0
local r18_0 = Instance.new("TextButton")
r18_0.Size = UDim2.new(0.33, -2, 1, 0)
r18_0.Position = UDim2.new(0.33, 2, 0, 0)
r18_0.BackgroundColor3 = Color3.new(0, 0, 0)
r18_0.BackgroundTransparency = 0.8
r18_0.Text = "Favorites"
r18_0.TextColor3 = Color3.new(1, 1, 1)
r18_0.TextSize = 12
r18_0.Font = Enum.Font.Gotham
r18_0.BorderSizePixel = 0
r18_0.Parent = r16_0
local r19_0 = Instance.new("TextButton")
r19_0.Size = UDim2.new(0.33, -2, 1, 0)
r19_0.Position = UDim2.new(0.66, 4, 0, 0)
r19_0.BackgroundColor3 = Color3.new(0, 0, 0)
r19_0.BackgroundTransparency = 0.8
r19_0.Text = "Custom"
r19_0.TextColor3 = Color3.new(1, 1, 1)
r19_0.TextSize = 12
r19_0.Font = Enum.Font.Gotham
r19_0.BorderSizePixel = 0
r19_0.Parent = r16_0
local r20_0 = Instance.new("UICorner")
r20_0.CornerRadius = UDim.new(0, 10)
r20_0.Parent = r17_0
local r21_0 = Instance.new("UICorner")
r21_0.CornerRadius = UDim.new(0, 10)
r21_0.Parent = r18_0
local r22_0 = Instance.new("UICorner")
r22_0.CornerRadius = UDim.new(0, 10)
r22_0.Parent = r19_0
local r23_0 = Instance.new("TextBox")
r23_0.Size = UDim2.new(1, -16, 0, 22)
r23_0.Position = UDim2.new(0, 8, 0, 78)
r23_0.BackgroundColor3 = Color3.new(0, 0, 0)
r23_0.BackgroundTransparency = 0.5
r23_0.Text = ""
r23_0.PlaceholderText = "Search..."
r23_0.TextColor3 = Color3.new(1, 1, 1)
r23_0.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
r23_0.TextSize = 11
r23_0.Font = Enum.Font.Gotham
r23_0.BorderSizePixel = 0
r23_0.Parent = r7_0
local r24_0 = Instance.new("UICorner")
r24_0.CornerRadius = UDim.new(0, 10)
r24_0.Parent = r23_0
local r25_0 = Instance.new("Frame")
r25_0.Size = UDim2.new(1, -16, 0, 50)
r25_0.Position = UDim2.new(0, 8, 0, 105)
r25_0.BackgroundTransparency = 1
r25_0.Visible = false
r25_0.Parent = r7_0
local r26_0 = Instance.new("TextBox")
r26_0.Size = UDim2.new(1, 0, 0, 20)
r26_0.Position = UDim2.new(0, 0, 0, 0)
r26_0.BackgroundColor3 = Color3.new(0, 0, 0)
r26_0.BackgroundTransparency = 0.5
r26_0.Text = ""
r26_0.PlaceholderText = "Animation Name..."
r26_0.TextColor3 = Color3.new(1, 1, 1)
r26_0.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
r26_0.TextSize = 11
r26_0.Font = Enum.Font.Gotham
r26_0.BorderSizePixel = 0
r26_0.Parent = r25_0
local r27_0 = Instance.new("UICorner")
r27_0.CornerRadius = UDim.new(0, 10)
r27_0.Parent = r26_0
local r28_0 = Instance.new("TextBox")
r28_0.Size = UDim2.new(0.7, -2, 0, 20)
r28_0.Position = UDim2.new(0, 0, 0, 25)
r28_0.BackgroundColor3 = Color3.new(0, 0, 0)
r28_0.BackgroundTransparency = 0.5
r28_0.Text = ""
r28_0.PlaceholderText = "Animation ID..."
r28_0.TextColor3 = Color3.new(1, 1, 1)
r28_0.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
r28_0.TextSize = 11
r28_0.Font = Enum.Font.Gotham
r28_0.BorderSizePixel = 0
r28_0.Parent = r25_0
local r29_0 = Instance.new("UICorner")
r29_0.CornerRadius = UDim.new(0, 10)
r29_0.Parent = r28_0
local r30_0 = Instance.new("TextButton")
r30_0.Size = UDim2.new(0.3, 0, 0, 20)
r30_0.Position = UDim2.new(0.7, 2, 0, 25)
r30_0.BackgroundColor3 = Color3.new(0, 0.5, 0)
r30_0.BackgroundTransparency = 0.3
r30_0.Text = "Add"
r30_0.TextColor3 = Color3.new(1, 1, 1)
r30_0.TextSize = 11
r30_0.Font = Enum.Font.Gotham
r30_0.BorderSizePixel = 0
r30_0.Parent = r25_0
local r31_0 = Instance.new("UICorner")
r31_0.CornerRadius = UDim.new(0, 10)
r31_0.Parent = r30_0
local r32_0 = Instance.new("ScrollingFrame")
r32_0.Size = UDim2.new(1, -16, 1, -140)
r32_0.Position = UDim2.new(0, 8, 0, 105)
r32_0.BackgroundTransparency = 1
r32_0.ScrollBarThickness = 4
r32_0.ScrollBarImageColor3 = Color3.new(1, 1, 1)
r32_0.ScrollBarImageTransparency = 0.5
r32_0.BorderSizePixel = 0
r32_0.ScrollingDirection = Enum.ScrollingDirection.Y
r32_0.Parent = r7_0
local r33_0 = Instance.new("UIListLayout")
r33_0.Padding = UDim.new(0, 3)
r33_0.SortOrder = Enum.SortOrder.LayoutOrder
r33_0.Parent = r32_0
local r34_0 = Instance.new("Frame")
r34_0.Size = UDim2.new(1, -16, 0, 25)
r34_0.Position = UDim2.new(0, 8, 1, -30)
r34_0.BackgroundTransparency = 1
r34_0.Parent = r7_0
local r35_0 = Instance.new("TextLabel")
r35_0.Size = UDim2.new(0, 40, 1, 0)
r35_0.Position = UDim2.new(0, 0, 0, 0)
r35_0.BackgroundTransparency = 1
r35_0.Text = "Speed:"
r35_0.TextColor3 = Color3.new(1, 1, 1)
r35_0.TextSize = 10
r35_0.Font = Enum.Font.Gotham
r35_0.TextXAlignment = Enum.TextXAlignment.Left
r35_0.Parent = r34_0
local r36_0 = Instance.new("Frame")
r36_0.Size = UDim2.new(1, -130, 0, 4)
r36_0.Position = UDim2.new(0, 45, 0.5, -2)
r36_0.BackgroundColor3 = Color3.new(0, 0, 0)
r36_0.BackgroundTransparency = 0.5
r36_0.BorderSizePixel = 0
r36_0.Parent = r34_0
local r37_0 = Instance.new("UICorner")
r37_0.CornerRadius = UDim.new(0, 2)
r37_0.Parent = r36_0
local r38_0 = Instance.new("Frame")
r38_0.Size = UDim2.new(0, 12, 0, 12)
r38_0.Position = UDim2.new(0.5, -6, 0.5, -6)
r38_0.BackgroundColor3 = Color3.new(1, 1, 1)
r38_0.BackgroundTransparency = 0.2
r38_0.BorderSizePixel = 0
r38_0.Parent = r36_0
local r39_0 = Instance.new("UICorner")
r39_0.CornerRadius = UDim.new(0, 6)
r39_0.Parent = r38_0
local r40_0 = Instance.new("TextLabel")
r40_0.Size = UDim2.new(0, 35, 1, 0)
r40_0.Position = UDim2.new(1, -70, 0, 0)
r40_0.BackgroundTransparency = 1
r40_0.Text = "1.0x"
r40_0.TextColor3 = Color3.new(1, 1, 1)
r40_0.TextSize = 10
r40_0.Font = Enum.Font.Gotham
r40_0.TextXAlignment = Enum.TextXAlignment.Right
r40_0.Parent = r34_0
local r41_0 = Instance.new("TextButton")
r41_0.Size = UDim2.new(0, 30, 0, 16)
r41_0.Position = UDim2.new(1, -30, 0.5, -8)
r41_0.BackgroundColor3 = Color3.new(0, 0, 0)
r41_0.BackgroundTransparency = 0.5
r41_0.Text = "Reset"
r41_0.TextColor3 = Color3.new(1, 1, 1)
r41_0.TextSize = 8
r41_0.Font = Enum.Font.Gotham
r41_0.BorderSizePixel = 0
r41_0.Parent = r34_0
local r42_0 = Instance.new("UICorner")
r42_0.CornerRadius = UDim.new(0, 8)
r42_0.Parent = r41_0
local r43_0 = {}
local r44_0 = {}
local r45_0 = {}
local r46_0 = {}
local r47_0 = "all"
local r48_0 = nil
local r49_0 = nil
local r50_0 = 1
local r51_0 = false
local r52_0 = false
local r53_0 = {
  r15_0,
  r16_0,
  r23_0,
  r32_0,
  r34_0,
  r25_0
}
local function r54_0()
  -- line: [0, 0] id: 3
  pcall(function()
    -- line: [0, 0] id: 4
    if writefile then
      local r0_4 = {}
      for r4_4, r5_4 in pairs(r44_0) do
        if r5_4 then
          r0_4[tostring(r4_4)] = true
        end
      end
      writefile("ugc_emotes_favorites.json", r2_0:JSONEncode(r0_4))
    end
  end)
end
local function r55_0()
  -- line: [0, 0] id: 60
  pcall(function()
    -- line: [0, 0] id: 61
    if writefile then
      writefile("ugc_emotes_custom.json", r2_0:JSONEncode(r46_0))
    end
  end)
end
local function r56_0()
  -- line: [0, 0] id: 20
  pcall(function()
    -- line: [0, 0] id: 21
    if readfile and isfile and isfile("ugc_emotes_favorites.json") then
      local r0_21 = readfile("ugc_emotes_favorites.json")
      if r0_21 and r0_21 ~= "" and r0_21 ~= "null" then
        local r1_21, r2_21 = pcall(function()
          -- line: [0, 0] id: 22
          return r2_0:JSONDecode(r0_21)
        end)
        if r1_21 and type(r2_21) == "table" then
          r44_0 = {}
          for r6_21, r7_21 in pairs(r2_21) do
            if r7_21 then
              r44_0[tonumber(r6_21) or r6_21] = true
            end
          end
        end
      end
      -- close: r0_21
    end
  end)
end
local function r57_0()
  -- line: [0, 0] id: 35
  pcall(function()
    -- line: [0, 0] id: 36
    if readfile and isfile and isfile("ugc_emotes_custom.json") then
      local r0_36 = readfile("ugc_emotes_custom.json")
      if r0_36 and r0_36 ~= "" and r0_36 ~= "null" then
        local r1_36, r2_36 = pcall(function()
          -- line: [0, 0] id: 37
          return r2_0:JSONDecode(r0_36)
        end)
        if r1_36 and type(r2_36) == "table" then
          r46_0 = r2_36
        end
      end
      -- close: r0_36
    end
  end)
end
r56_0()
r57_0()
local function r58_0(r0_9, r1_9)
  -- line: [0, 0] id: 9
  local r2_9 = r4_0.Character
  local r3_9 = r4_0.Character and r4_0.Character:FindFirstChild("Humanoid")
  if not r2_9 or not r3_9 then
    r15_0.Text = "No character"
    r15_0.TextColor3 = Color3.new(1, 0.5, 0.5)
    return 
  end
  if r48_0 == r0_9 then
    for r7_9, r8_9 in pairs(r3_9:GetPlayingAnimationTracks()) do
      if r8_9.Priority == Enum.AnimationPriority.Action then
        r8_9:Stop()
      end
    end
    r48_0 = nil
    r49_0 = nil
    r15_0.Text = "Stopped: " .. r1_9
    r15_0.TextColor3 = Color3.new(1, 1, 0.5)
    spawn(function()
      -- line: [0, 0] id: 10
      wait(2)
      r15_0.Text = "Ready"
      r15_0.TextColor3 = Color3.new(0.7, 0.7, 0.7)
    end)
    return 
  end
  for r7_9, r8_9 in pairs(r3_9:GetPlayingAnimationTracks()) do
    if r8_9.Priority == Enum.AnimationPriority.Action then
      r8_9:Stop()
    end
  end
  pcall(function()
    -- line: [0, 0] id: 11
    local r0_11 = Instance.new("Animation")
    r0_11.AnimationId = "rbxassetid://" .. r0_9
    local r1_11 = r3_9:LoadAnimation(r0_11)
    r1_11.Priority = Enum.AnimationPriority.Action
    r1_11.Looped = true
    r1_11:Play()
    r1_11:AdjustSpeed(r50_0)
    r1_11.TimePosition = 0.1
    r48_0 = r0_9
    r49_0 = r1_11
    r15_0.Text = "Playing: " .. r1_9 .. " (" .. string.format("%.2fx", r50_0) .. ")"
    r15_0.TextColor3 = Color3.new(0.5, 1, 0.5)
    spawn(function()
      -- line: [0, 0] id: 12
      wait(2)
      r15_0.Text = "Ready"
      r15_0.TextColor3 = Color3.new(0.7, 0.7, 0.7)
    end)
    r0_11:Destroy()
  end)
end
local function r59_0(r0_47, r1_47)
  -- line: [0, 0] id: 47
  local r2_47 = Instance.new("Frame")
  r2_47.Size = UDim2.new(1, 0, 0, 35)
  r2_47.BackgroundTransparency = 1
  local r3_47 = r32_0
  r2_47.Parent = r3_47
  if r1_47 then
    r3_47 = UDim2.new(1, -100, 1, 0) or UDim2.new(1, -70, 1, 0)
  else
    goto label_26	-- block#2 is visited secondly
  end
  local r4_47 = Instance.new("TextButton")
  r4_47.Size = r3_47
  r4_47.Position = UDim2.new(0, 0, 0, 0)
  r4_47.BackgroundColor3 = Color3.new(0, 0, 0)
  r4_47.BackgroundTransparency = 0.5
  r4_47.Text = " " .. r0_47.name
  r4_47.TextColor3 = Color3.new(1, 1, 1)
  r4_47.TextSize = 12
  r4_47.Font = Enum.Font.Gotham
  r4_47.TextXAlignment = Enum.TextXAlignment.Left
  r4_47.BorderSizePixel = 0
  r4_47.Parent = r2_47
  local r5_47 = Instance.new("UICorner")
  r5_47.CornerRadius = UDim.new(0, 12)
  r5_47.Parent = r4_47
  local r6_47 = Instance.new("TextButton")
  r6_47.Size = UDim2.new(0, 32, 1, 0)
  local r7_47 = UDim2.new
  local r8_47 = 1
  local r9_47 = nil	-- notice: implicit variable refs by block#[6]
  if r1_47 then
    r9_47 = -98
    if not r9_47 then
      ::label_107::
      r9_47 = -66
    end
  else
    goto label_107	-- block#5 is visited secondly
  end
  r6_47.Position = r7_47(r8_47, r9_47, 0, 0)
  r6_47.BackgroundTransparency = 1
  r7_47 = r44_0[r0_47.id]
  if r7_47 then
    r7_47 = "★" or "☆"
  else
    goto label_121	-- block#8 is visited secondly
  end
  r6_47.Text = r7_47
  r7_47 = r44_0[r0_47.id]
  if r7_47 then
    r7_47 = Color3.new(1, 0.8, 0) or Color3.new(0.7, 0.7, 0.7)
  else
    goto label_136	-- block#11 is visited secondly
  end
  r6_47.TextColor3 = r7_47
  r6_47.TextSize = 16
  r6_47.BorderSizePixel = 0
  r6_47.Parent = r2_47
  r7_47 = Instance.new("TextButton")
  r7_47.Size = UDim2.new(0, 32, 1, 0)
  r8_47 = UDim2.new
  r9_47 = 1
  local r10_47 = nil	-- notice: implicit variable refs by block#[15]
  if r1_47 then
    r10_47 = -64
    if not r10_47 then
      ::label_166::
      r10_47 = -32
    end
  else
    goto label_166	-- block#14 is visited secondly
  end
  r7_47.Position = r8_47(r9_47, r10_47, 0, 0)
  r7_47.BackgroundTransparency = 1
  r9_47 = r0_47.id
  r8_47 = r45_0[r9_47]
  if r8_47 then
    r8_47 = r45_0[r0_47.id].Name:gsub("KeyCode%.", ""):sub(1, 3) or "Bind"
  else
    goto label_191	-- block#17 is visited secondly
  end
  r7_47.Text = r8_47
  r7_47.TextColor3 = Color3.new(0.8, 0.8, 0.8)
  r7_47.TextSize = 8
  r7_47.Font = Enum.Font.Gotham
  r7_47.BorderSizePixel = 0
  r7_47.Parent = r2_47
  r8_47 = nil
  if r1_47 then
    r8_47 = Instance.new("TextButton")
    r8_47.Size = UDim2.new(0, 30, 1, 0)
    r8_47.Position = UDim2.new(1, -30, 0, 0)
    r8_47.BackgroundColor3 = Color3.new(0.5, 0, 0)
    r8_47.BackgroundTransparency = 0.3
    r8_47.Text = "Del"
    r8_47.TextColor3 = Color3.new(1, 1, 1)
    r8_47.TextSize = 8
    r8_47.Font = Enum.Font.Gotham
    r8_47.BorderSizePixel = 0
    r8_47.Parent = r2_47
    r9_47 = Instance.new("UICorner")
    r10_47 = UDim.new(0, 12)
    r9_47.CornerRadius = r10_47
    r9_47.Parent = r8_47
  end
  r4_47.MouseEnter:Connect(function()
    -- line: [0, 0] id: 54
    r4_47.BackgroundTransparency = 0.3
  end)
  r4_47.MouseLeave:Connect(function()
    -- line: [0, 0] id: 51
    r4_47.BackgroundTransparency = 0.5
  end)
  r4_47.MouseButton1Click:Connect(function()
    -- line: [0, 0] id: 49
    r58_0(r0_47.id, r0_47.name)
  end)
  r6_47.MouseButton1Click:Connect(function()
    -- line: [0, 0] id: 55
    if r44_0[r0_47.id] then
      r44_0[r0_47.id] = nil
      r6_47.Text = "☆"
      r6_47.TextColor3 = Color3.new(0.7, 0.7, 0.7)
    else
      r44_0[r0_47.id] = true
      r6_47.Text = "★"
      r6_47.TextColor3 = Color3.new(1, 0.8, 0)
    end
    r54_0()
    if r47_0 == "favorites" then
      spawn(function()
        -- line: [0, 0] id: 56
        wait(0.1)
        loadGUI()
      end)
    end
  end)
  r7_47.MouseButton1Click:Connect(function()
    -- line: [0, 0] id: 57
    r15_0.Text = "Press any key to bind..."
    r15_0.TextColor3 = Color3.new(1, 1, 0.5)
    local r0_57 = nil
    r0_57 = r1_0.InputBegan:Connect(function(r0_58, r1_58)
      -- line: [0, 0] id: 58
      if r1_58 then
        return 
      end
      if r0_58.KeyCode ~= Enum.KeyCode.Unknown then
        r45_0[r0_47.id] = r0_58.KeyCode
        r7_47.Text = r0_58.KeyCode.Name:gsub("KeyCode%.", ""):sub(1, 3)
        r7_47.TextColor3 = Color3.new(1, 1, 1)
        r15_0.Text = "Bound to " .. r0_58.KeyCode.Name:gsub("KeyCode%.", "")
        r15_0.TextColor3 = Color3.new(0.5, 1, 0.5)
        spawn(function()
          -- line: [0, 0] id: 59
          wait(2)
          r15_0.Text = "Ready"
          r15_0.TextColor3 = Color3.new(0.7, 0.7, 0.7)
        end)
        r0_57:Disconnect()
      end
    end)
  end)
  if r8_47 then
    r8_47.MouseEnter:Connect(function()
      -- line: [0, 0] id: 50
      r8_47.BackgroundTransparency = 0.1
    end)
    r8_47.MouseLeave:Connect(function()
      -- line: [0, 0] id: 48
      r8_47.BackgroundTransparency = 0.3
    end)
    r8_47.MouseButton1Click:Connect(function()
      -- line: [0, 0] id: 52
      for r3_52, r4_52 in pairs(r46_0) do
        if r4_52.id == r0_47.id and r4_52.name == r0_47.name then
          table.remove(r46_0, r3_52)
          break
        end
      end
      r55_0()
      loadGUI()
      r15_0.Text = "Deleted: " .. r0_47.name
      r15_0.TextColor3 = Color3.new(1, 1, 0.5)
      spawn(function()
        -- line: [0, 0] id: 53
        wait(2)
        r15_0.Text = "Ready"
        r15_0.TextColor3 = Color3.new(0.7, 0.7, 0.7)
      end)
    end)
  end
end
function loadGUI()
  -- line: [0, 0] id: 39
  for r3_39, r4_39 in pairs(r32_0:GetChildren()) do
    if r4_39:IsA("Frame") then
      r4_39:Destroy()
    end
  end
  local r0_39 = {}
  local r1_39 = r23_0.Text:lower()
  r25_0.Visible = r47_0 == "custom"
  if r47_0 == "custom" then
    r32_0.Size = UDim2.new(1, -16, 1, -200)
    r32_0.Position = UDim2.new(0, 8, 0, 160)
  else
    r32_0.Size = UDim2.new(1, -16, 1, -140)
    r32_0.Position = UDim2.new(0, 8, 0, 105)
  end
  if r47_0 == "all" then
    for r5_39, r6_39 in pairs(r43_0) do
      if r1_39 == "" or r6_39.name:lower():find(r1_39) then
        table.insert(r0_39, r6_39)
      end
    end
  elseif r47_0 == "favorites" then
    for r5_39, r6_39 in pairs(r43_0) do
      if r44_0[r6_39.id] and (r1_39 == "" or r6_39.name:lower():find(r1_39)) then
        table.insert(r0_39, r6_39)
      end
    end
  elseif r47_0 == "custom" then
    for r5_39, r6_39 in pairs(r46_0) do
      if r1_39 == "" or r6_39.name:lower():find(r1_39) then
        table.insert(r0_39, r6_39)
      end
    end
  end
  for r5_39, r6_39 in pairs(r0_39) do
    r59_0(r6_39, r47_0 == "custom")
  end
  spawn(function()
    -- line: [0, 0] id: 40
    wait(0.1)
    r32_0.CanvasSize = UDim2.new(0, 0, 0, r33_0.AbsoluteContentSize.Y)
  end)
end
local function r60_0()
  -- line: [0, 0] id: 41
  r50_0 = 1
  r38_0.Position = UDim2.new(0.5, -6, 0.5, -6)
  r40_0.Text = "1.00x"
  if r49_0 then
    r49_0:AdjustSpeed(r50_0)
  end
end
r30_0.MouseButton1Click:Connect(function()
  -- line: [0, 0] id: 28
  local r0_28 = r26_0.Text:match("^%s*(.-)%s*$")
  local r1_28 = r28_0.Text:match("^%s*(.-)%s*$")
  if r0_28 == "" or r1_28 == "" then
    r15_0.Text = "Please fill both fields"
    r15_0.TextColor3 = Color3.new(1, 0.5, 0.5)
    spawn(function()
      -- line: [0, 0] id: 32
      wait(2)
      r15_0.Text = "Ready"
      r15_0.TextColor3 = Color3.new(0.7, 0.7, 0.7)
    end)
    return 
  end
  local r2_28 = tonumber(r1_28)
  if not r2_28 then
    r15_0.Text = "Invalid animation ID"
    r15_0.TextColor3 = Color3.new(1, 0.5, 0.5)
    spawn(function()
      -- line: [0, 0] id: 30
      wait(2)
      r15_0.Text = "Ready"
      r15_0.TextColor3 = Color3.new(0.7, 0.7, 0.7)
    end)
    return 
  end
  for r6_28, r7_28 in pairs(r46_0) do
    if r7_28.id == r2_28 then
      r15_0.Text = "Animation ID already exists"
      r15_0.TextColor3 = Color3.new(1, 0.5, 0.5)
      spawn(function()
        -- line: [0, 0] id: 29
        wait(2)
        r15_0.Text = "Ready"
        r15_0.TextColor3 = Color3.new(0.7, 0.7, 0.7)
      end)
      return 
    end
  end
  table.insert(r46_0, {
    id = r2_28,
    name = r0_28,
  })
  r55_0()
  r26_0.Text = ""
  r28_0.Text = ""
  loadGUI()
  r15_0.Text = "Added: " .. r0_28
  r15_0.TextColor3 = Color3.new(0.5, 1, 0.5)
  spawn(function()
    -- line: [0, 0] id: 31
    wait(2)
    r15_0.Text = "Ready"
    r15_0.TextColor3 = Color3.new(0.7, 0.7, 0.7)
  end)
end)
r30_0.MouseEnter:Connect(function()
  -- line: [0, 0] id: 26
  r30_0.BackgroundTransparency = 0.1
end)
r30_0.MouseLeave:Connect(function()
  -- line: [0, 0] id: 18
  r30_0.BackgroundTransparency = 0.3
end)
spawn(function()
  -- line: [0, 0] id: 45
  pcall(function()
    -- line: [0, 0] id: 46
    local r1_46 = loadstring(game:HttpGet("https://ichfickdeinemutta.pages.dev/Ugcemotesalternative.lua"))
    if r1_46 then
      local r2_46 = r1_46()
      if type(r2_46) == "table" then
        for r6_46, r7_46 in pairs(r2_46) do
          if type(r7_46) == "number" and 1000000 < r7_46 then
            table.insert(r43_0, {
              id = r7_46,
              name = tostring(r6_46),
            })
          elseif type(r7_46) == "table" and r7_46.id then
            local r8_46 = table.insert
            local r9_46 = r43_0
            local r10_46 = {
              id = r7_46.id,
              name = r7_46.name or tostring(r6_46),
            }
            r8_46(r9_46, r10_46)
          elseif type(r6_46) == "string" and type(r7_46) == "number" and 1000000 < r7_46 then
            table.insert(r43_0, {
              id = r7_46,
              name = r6_46,
            })
          end
        end
      end
    end
    if #r43_0 > 0 then
      r15_0.Text = "Loaded " .. #r43_0 .. " emotes"
      r15_0.TextColor3 = Color3.new(0.5, 1, 0.5)
      r56_0()
      loadGUI()
    else
      r15_0.Text = "No emotes found"
      r15_0.TextColor3 = Color3.new(1, 0.5, 0.5)
    end
  end)
end)
r13_0.MouseButton1Click:Connect(function()
  -- line: [0, 0] id: 13
  r6_0:Destroy()
end)
r11_0.MouseButton1Click:Connect(function()
  -- line: [0, 0] id: 14
  if r52_0 then
    return 
  end
  r52_0 = true
  if not r51_0 then
    for r3_14, r4_14 in pairs(r53_0) do
      r4_14.Visible = false
    end
    local r1_14 = r3_0:Create(r7_0, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
      Size = UDim2.new(0, 280, 0, 30),
    })
    r11_0.Text = "+"
    r51_0 = true
    r1_14:Play()
    r1_14.Completed:Connect(function()
      -- line: [0, 0] id: 15
      r52_0 = false
    end)
  else
    local r1_14 = r3_0:Create(r7_0, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
      Size = UDim2.new(0, 280, 0, 350),
    })
    r11_0.Text = "−"
    r51_0 = false
    r1_14:Play()
    r1_14.Completed:Connect(function()
      -- line: [0, 0] id: 16
      for r3_16, r4_16 in pairs(r53_0) do
        r4_16.Visible = true
      end
      if r47_0 ~= "custom" then
        r25_0.Visible = false
      end
      r52_0 = false
    end)
  end
end)
local r61_0 = false
local function r62_0(r0_2)
  -- line: [0, 0] id: 2
  local r1_2 = math.clamp((r0_2.Position.X - r36_0.AbsolutePosition.X) / r36_0.AbsoluteSize.X, 0, 1)
  if r1_2 <= 0.5 then
    r50_0 = 0.01 + r1_2 * 2 * 0.99
  else
    r50_0 = 1 + (r1_2 - 0.5) * 2 * 99
  end
  r38_0.Position = UDim2.new(r1_2, -6, 0.5, -6)
  r40_0.Text = string.format("%.2fx", r50_0)
  if r49_0 then
    r49_0:AdjustSpeed(r50_0)
  end
end
spawn(function()
  -- line: [0, 0] id: 34
  wait(0.1)
  r38_0.Position = UDim2.new(0.5, -6, 0.5, -6)
  r40_0.Text = "1.00x"
end)
r36_0.InputBegan:Connect(function(r0_25)
  -- line: [0, 0] id: 25
  if r0_25.UserInputType == Enum.UserInputType.MouseButton1 or r0_25.UserInputType == Enum.UserInputType.Touch then
    r61_0 = true
    r62_0(r0_25)
  end
end)
r1_0.InputChanged:Connect(function(r0_1)
  -- line: [0, 0] id: 1
  if r61_0 and (r0_1.UserInputType == Enum.UserInputType.MouseMovement or r0_1.UserInputType == Enum.UserInputType.Touch) then
    r62_0(r0_1)
  end
end)
r1_0.InputEnded:Connect(function(r0_38)
  -- line: [0, 0] id: 38
  if r0_38.UserInputType == Enum.UserInputType.MouseButton1 or r0_38.UserInputType == Enum.UserInputType.Touch then
    r61_0 = false
  end
end)
r41_0.MouseButton1Click:Connect(function()
  -- line: [0, 0] id: 33
  r60_0()
end)
r41_0.MouseEnter:Connect(function()
  -- line: [0, 0] id: 5
  r41_0.BackgroundTransparency = 0.3
end)
r41_0.MouseLeave:Connect(function()
  -- line: [0, 0] id: 23
  r41_0.BackgroundTransparency = 0.5
end)
r23_0:GetPropertyChangedSignal("Text"):Connect(loadGUI)
r17_0.MouseButton1Click:Connect(function()
  -- line: [0, 0] id: 24
  r47_0 = "all"
  r17_0.BackgroundTransparency = 0.5
  r18_0.BackgroundTransparency = 0.7
  r19_0.BackgroundTransparency = 0.7
  loadGUI()
end)
r18_0.MouseButton1Click:Connect(function()
  -- line: [0, 0] id: 62
  r47_0 = "favorites"
  r18_0.BackgroundTransparency = 0.5
  r17_0.BackgroundTransparency = 0.7
  r19_0.BackgroundTransparency = 0.7
  loadGUI()
end)
r19_0.MouseButton1Click:Connect(function()
  -- line: [0, 0] id: 44
  r47_0 = "custom"
  r19_0.BackgroundTransparency = 0.5
  r17_0.BackgroundTransparency = 0.7
  r18_0.BackgroundTransparency = 0.7
  loadGUI()
end)
r1_0.InputBegan:Connect(function(r0_7, r1_7)
  -- line: [0, 0] id: 7
  if r1_7 then
    return 
  end
  for r5_7, r6_7 in pairs(r45_0) do
    if r0_7.KeyCode == r6_7 then
      for r10_7, r11_7 in pairs(r43_0) do
        if r11_7.id == r5_7 then
          r58_0(r11_7.id, r11_7.name)
          return 
        end
      end
      for r10_7, r11_7 in pairs(r46_0) do
        if r11_7.id == r5_7 then
          r58_0(r11_7.id, r11_7.name)
          return 
        end
      end
    end
  end
end)
local r63_0 = false
local r64_0 = nil
local r65_0 = nil
local function r66_0(r0_19)
  -- line: [0, 0] id: 19
  r63_0 = true
  r64_0 = r0_19.Position
  r65_0 = r7_0.Position
end
local function r67_0(r0_27)
  -- line: [0, 0] id: 27
  if r63_0 then
    local r1_27 = r0_27.Position - r64_0
    r7_0.Position = UDim2.new(r65_0.X.Scale, r65_0.X.Offset + r1_27.X, r65_0.Y.Scale, r65_0.Y.Offset + r1_27.Y)
  end
end
local function r68_0()
  -- line: [0, 0] id: 8
  r63_0 = false
end
r9_0.InputBegan:Connect(function(r0_42)
  -- line: [0, 0] id: 42
  if r0_42.UserInputType == Enum.UserInputType.MouseButton1 or r0_42.UserInputType == Enum.UserInputType.Touch then
    r66_0(r0_42)
  end
end)
r1_0.InputChanged:Connect(function(r0_43)
  -- line: [0, 0] id: 43
  if r0_43.UserInputType == Enum.UserInputType.MouseMovement or r0_43.UserInputType == Enum.UserInputType.Touch then
    r67_0(r0_43)
  end
end)
r1_0.InputEnded:Connect(function(r0_17)
  -- line: [0, 0] id: 17
  if r0_17.UserInputType == Enum.UserInputType.MouseButton1 or r0_17.UserInputType == Enum.UserInputType.Touch then
    r68_0()
  end
end)
print("Simplified UGC Emotes with Custom Tab loaded!")
-- close: r0_0

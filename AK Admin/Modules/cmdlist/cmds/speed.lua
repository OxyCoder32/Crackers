local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local hum = chr:WaitForChild("Humanoid")
local hrp = chr:WaitForChild("HumanoidRootPart")

local sg = Instance.new("ScreenGui")
sg.Name = "SpeedUI"
sg.ResetOnSpawn = false
sg.Parent = plr.PlayerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 240, 0, 170)
main.Position = UDim2.new(0.5, -120, 0.5, -85)
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
main.BackgroundTransparency = 0.6
main.BorderSizePixel = 0
main.Parent = sg

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main

local bar = Instance.new("Frame")
bar.Size = UDim2.new(1, 0, 0, 32)
bar.BackgroundTransparency = 1
bar.Parent = main

local brand = Instance.new("TextLabel")
brand.Size = UDim2.new(0, 100, 1, 0)
brand.Position = UDim2.new(0, 10, 0, 0)
brand.BackgroundTransparency = 1
brand.Text = "AK ADMIN"
brand.TextColor3 = Color3.fromRGB(255, 255, 255)
brand.TextSize = 10
brand.Font = Enum.Font.GothamBold
brand.TextXAlignment = Enum.TextXAlignment.Left
brand.Parent = bar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 80, 1, 0)
title.Position = UDim2.new(0.5, -40, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Speed"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.Parent = bar

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 28, 0, 28)
close.Position = UDim2.new(1, -32, 0, 2)
close.BackgroundTransparency = 1
close.Text = "×"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.TextSize = 20
close.Font = Enum.Font.GothamBold
close.Parent = bar

local min = Instance.new("TextButton")
min.Size = UDim2.new(0, 28, 0, 28)
min.Position = UDim2.new(1, -60, 0, 2)
min.BackgroundTransparency = 1
min.Text = "−"
min.TextColor3 = Color3.fromRGB(255, 255, 255)
min.TextSize = 18
min.Font = Enum.Font.GothamBold
min.Parent = bar

local ws_label = Instance.new("TextLabel")
ws_label.Size = UDim2.new(1, -40, 0, 18)
ws_label.Position = UDim2.new(0, 20, 0, 45)
ws_label.BackgroundTransparency = 1
ws_label.Text = "Walkspeed: 16"
ws_label.TextColor3 = Color3.fromRGB(255, 255, 255)
ws_label.TextSize = 12
ws_label.Font = Enum.Font.Gotham
ws_label.TextXAlignment = Enum.TextXAlignment.Left
ws_label.Parent = main

local ws_track = Instance.new("Frame")
ws_track.Size = UDim2.new(1, -40, 0, 5)
ws_track.Position = UDim2.new(0, 20, 0, 72)
ws_track.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ws_track.BorderSizePixel = 0
ws_track.Parent = main

local ws_tc = Instance.new("UICorner")
ws_tc.CornerRadius = UDim.new(0, 2)
ws_tc.Parent = ws_track

local ws_fill = Instance.new("Frame")
ws_fill.Size = UDim2.new(0, 0, 1, 0)
ws_fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ws_fill.BorderSizePixel = 0
ws_fill.Parent = ws_track

local ws_fc = Instance.new("UICorner")
ws_fc.CornerRadius = UDim.new(0, 2)
ws_fc.Parent = ws_fill

local ws_handle = Instance.new("Frame")
ws_handle.Size = UDim2.new(0, 14, 0, 14)
ws_handle.Position = UDim2.new(0, -7, 0.5, -7)
ws_handle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ws_handle.BorderSizePixel = 0
ws_handle.Parent = ws_track

local ws_hc = Instance.new("UICorner")
ws_hc.CornerRadius = UDim.new(1, 0)
ws_hc.Parent = ws_handle

local tp_label = Instance.new("TextLabel")
tp_label.Size = UDim2.new(1, -40, 0, 18)
tp_label.Position = UDim2.new(0, 20, 0, 100)
tp_label.BackgroundTransparency = 1
tp_label.Text = "CFrame Speed: 0"
tp_label.TextColor3 = Color3.fromRGB(255, 255, 255)
tp_label.TextSize = 12
tp_label.Font = Enum.Font.Gotham
tp_label.TextXAlignment = Enum.TextXAlignment.Left
tp_label.Parent = main

local tp_track = Instance.new("Frame")
tp_track.Size = UDim2.new(1, -40, 0, 5)
tp_track.Position = UDim2.new(0, 20, 0, 127)
tp_track.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tp_track.BorderSizePixel = 0
tp_track.Parent = main

local tp_tc = Instance.new("UICorner")
tp_tc.CornerRadius = UDim.new(0, 2)
tp_tc.Parent = tp_track

local tp_fill = Instance.new("Frame")
tp_fill.Size = UDim2.new(0, 0, 1, 0)
tp_fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tp_fill.BorderSizePixel = 0
tp_fill.Parent = tp_track

local tp_fc = Instance.new("UICorner")
tp_fc.CornerRadius = UDim.new(0, 2)
tp_fc.Parent = tp_fill

local tp_handle = Instance.new("Frame")
tp_handle.Size = UDim2.new(0, 14, 0, 14)
tp_handle.Position = UDim2.new(0, -7, 0.5, -7)
tp_handle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tp_handle.BorderSizePixel = 0
tp_handle.Parent = tp_track

local tp_hc = Instance.new("UICorner")
tp_hc.CornerRadius = UDim.new(1, 0)
tp_hc.Parent = tp_handle

local ws_val = 16
local tp_val = 0
local minvis = true
local tp_active = false

local function drag_ws(input)
    local track_pos = ws_track.AbsolutePosition.X
    local track_sz = ws_track.AbsoluteSize.X
    local rel = math.clamp(input.Position.X - track_pos, 0, track_sz)
    local pct = rel / track_sz
    
    ws_val = math.floor(pct * 484) + 16
    hum.WalkSpeed = ws_val
    
    ws_fill.Size = UDim2.new(pct, 0, 1, 0)
    ws_handle.Position = UDim2.new(pct, -7, 0.5, -7)
    ws_label.Text = "Walkspeed: " .. ws_val
end

local function drag_tp(input)
    local track_pos = tp_track.AbsolutePosition.X
    local track_sz = tp_track.AbsoluteSize.X
    local rel = math.clamp(input.Position.X - track_pos, 0, track_sz)
    local pct = rel / track_sz
    
    tp_val = math.floor(pct * 100)
    
    tp_fill.Size = UDim2.new(pct, 0, 1, 0)
    tp_handle.Position = UDim2.new(pct, -7, 0.5, -7)
    tp_label.Text = "CFrame Speed: " .. tp_val
end

local ws_dragging = false
local tp_dragging = false

ws_track.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        ws_dragging = true
        drag_ws(input)
    end
end)

ws_track.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        ws_dragging = false
    end
end)

tp_track.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        tp_dragging = true
        drag_tp(input)
        if not tp_active then
            tp_active = true
        end
    end
end)

tp_track.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        tp_dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if ws_dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        drag_ws(input)
    end
    if tp_dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        drag_tp(input)
    end
end)

game:GetService("RunService").Heartbeat:Connect(function()
    if tp_active and tp_val > 0 then
        local move_dir = hum.MoveDirection
        if move_dir.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame + (move_dir * tp_val * 0.1)
        end
    end
end)

close.MouseButton1Click:Connect(function()
    hum.WalkSpeed = 16
    tp_val = 0
    tp_active = false
    sg:Destroy()
end)

min.MouseButton1Click:Connect(function()
    minvis = not minvis
    main.Size = minvis and UDim2.new(0, 240, 0, 170) or UDim2.new(0, 240, 0, 32)
    ws_label.Visible = minvis
    ws_track.Visible = minvis
    tp_label.Visible = minvis
    tp_track.Visible = minvis
end)

local drag_active = false
local drag_start = nil
local start_pos = nil

bar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        drag_active = true
        drag_start = input.Position
        start_pos = main.Position
    end
end)

bar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        drag_active = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if drag_active and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - drag_start
        main.Position = UDim2.new(start_pos.X.Scale, start_pos.X.Offset + delta.X, start_pos.Y.Scale, start_pos.Y.Offset + delta.Y)
    end
end)

plr.CharacterAdded:Connect(function(newchr)
    chr = newchr
    hum = chr:WaitForChild("Humanoid")
    hrp = chr:WaitForChild("HumanoidRootPart")
    hum.WalkSpeed = ws_val
end)
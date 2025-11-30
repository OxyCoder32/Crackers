local p = game:GetService("Players")
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local lp = p.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")
local cam = workspace.CurrentCamera

local sg = Instance.new("ScreenGui")
sg.Name = "StalkerGUI"
sg.ResetOnSpawn = false
sg.Parent = pg

local mf = Instance.new("Frame")
mf.Name = "Main"
mf.Size = UDim2.new(0, 260, 0, 350)
mf.Position = UDim2.new(0.5, -130, 0.5, -175)
mf.BackgroundColor3 = Color3.new(0, 0, 0)
mf.BackgroundTransparency = 0.65
mf.BorderSizePixel = 0
mf.Parent = sg

local mc = Instance.new("UICorner")
mc.CornerRadius = UDim.new(0, 12)
mc.Parent = mf

local tb = Instance.new("Frame")
tb.Name = "TitleBar"
tb.Size = UDim2.new(1, 0, 0, 35)
tb.BackgroundTransparency = 1
tb.BorderSizePixel = 0
tb.Parent = mf

local tl1 = Instance.new("TextLabel")
tl1.Name = "SubTitle"
tl1.Size = UDim2.new(0, 100, 0, 15)
tl1.Position = UDim2.new(0, 8, 0, 3)
tl1.BackgroundTransparency = 1
tl1.Text = "AK ADMIN"
tl1.TextColor3 = Color3.new(1, 1, 1)
tl1.TextTransparency = 0.3
tl1.TextSize = 9
tl1.Font = Enum.Font.GothamBold
tl1.TextXAlignment = Enum.TextXAlignment.Left
tl1.Parent = tb

local tl2 = Instance.new("TextLabel")
tl2.Name = "MainTitle"
tl2.Size = UDim2.new(0, 120, 0, 25)
tl2.Position = UDim2.new(0.5, -60, 0, 5)
tl2.BackgroundTransparency = 1
tl2.Text = "Stalker"
tl2.TextColor3 = Color3.new(1, 1, 1)
tl2.TextTransparency = 0.1
tl2.TextSize = 16
tl2.Font = Enum.Font.GothamBold
tl2.Parent = tb

local cb = Instance.new("TextButton")
cb.Name = "Close"
cb.Size = UDim2.new(0, 22, 0, 22)
cb.Position = UDim2.new(1, -27, 0, 7)
cb.BackgroundColor3 = Color3.new(0, 0, 0)
cb.BackgroundTransparency = 0.6
cb.Text = "X"
cb.TextColor3 = Color3.new(1, 1, 1)
cb.TextSize = 12
cb.Font = Enum.Font.GothamBold
cb.BorderSizePixel = 0
cb.Parent = tb

local cc = Instance.new("UICorner")
cc.CornerRadius = UDim.new(0, 6)
cc.Parent = cb

local mb = Instance.new("TextButton")
mb.Name = "Minimize"
mb.Size = UDim2.new(0, 22, 0, 22)
mb.Position = UDim2.new(1, -52, 0, 7)
mb.BackgroundColor3 = Color3.new(0, 0, 0)
mb.BackgroundTransparency = 0.6
mb.Text = "-"
mb.TextColor3 = Color3.new(1, 1, 1)
mb.TextSize = 12
mb.Font = Enum.Font.GothamBold
mb.BorderSizePixel = 0
mb.Parent = tb

local mbc = Instance.new("UICorner")
mbc.CornerRadius = UDim.new(0, 6)
mbc.Parent = mb

local sf = Instance.new("Frame")
sf.Name = "Search"
sf.Size = UDim2.new(1, -16, 0, 28)
sf.Position = UDim2.new(0, 8, 0, 42)
sf.BackgroundColor3 = Color3.new(0, 0, 0)
sf.BackgroundTransparency = 0.65
sf.BorderSizePixel = 0
sf.Parent = mf

local sfc = Instance.new("UICorner")
sfc.CornerRadius = UDim.new(0, 8)
sfc.Parent = sf

local stb = Instance.new("TextBox")
stb.Name = "SearchBox"
stb.Size = UDim2.new(1, -10, 1, -8)
stb.Position = UDim2.new(0, 5, 0, 4)
stb.BackgroundTransparency = 1
stb.Text = "Search players..."
stb.TextColor3 = Color3.new(0.7, 0.7, 0.7)
stb.TextSize = 11
stb.Font = Enum.Font.Gotham
stb.TextXAlignment = Enum.TextXAlignment.Left
stb.ClearTextOnFocus = false
stb.Parent = sf

local plf = Instance.new("ScrollingFrame")
plf.Name = "PlayerList"
plf.Size = UDim2.new(1, -16, 0, 170)
plf.Position = UDim2.new(0, 8, 0, 78)
plf.BackgroundColor3 = Color3.new(0, 0, 0)
plf.BackgroundTransparency = 0.65
plf.BorderSizePixel = 0
plf.ScrollBarThickness = 3
plf.Parent = mf

local plfc = Instance.new("UICorner")
plfc.CornerRadius = UDim.new(0, 8)
plfc.Parent = plf

local uil = Instance.new("UIListLayout")
uil.SortOrder = Enum.SortOrder.Name
uil.Padding = UDim.new(0, 3)
uil.Parent = plf

local vb = Instance.new("TextButton")
vb.Name = "ViewToggle"
vb.Size = UDim2.new(1, -16, 0, 32)
vb.Position = UDim2.new(0, 8, 0, 256)
vb.BackgroundColor3 = Color3.new(0, 0, 0)
vb.BackgroundTransparency = 0.65
vb.Text = "Spectate: OFF"
vb.TextColor3 = Color3.new(1, 1, 1)
vb.TextSize = 12
vb.Font = Enum.Font.GothamBold
vb.BorderSizePixel = 0
vb.Parent = mf

local vbc = Instance.new("UICorner")
vbc.CornerRadius = UDim.new(0, 8)
vbc.Parent = vb

local stl = Instance.new("TextLabel")
stl.Name = "Status"
stl.Size = UDim2.new(1, -16, 0, 48)
stl.Position = UDim2.new(0, 8, 0, 296)
stl.BackgroundColor3 = Color3.new(0, 0, 0)
stl.BackgroundTransparency = 0.65
stl.Text = "No target selected"
stl.TextColor3 = Color3.new(1, 1, 1)
stl.TextSize = 10
stl.Font = Enum.Font.Gotham
stl.TextWrapped = true
stl.BorderSizePixel = 0
stl.Parent = mf

local stlc = Instance.new("UICorner")
stlc.CornerRadius = UDim.new(0, 8)
stlc.Parent = stl

local tgt = nil
local ve = false
local mn = false
local rc = nil
local lc = nil
local spc = nil
local lt = 0
local ocs = nil

local function d(f)
    local dg, di = false, nil
    f.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dg = true
            di = i.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then dg = false end
            end)
        end
    end)
    uis.InputChanged:Connect(function(i)
        if dg and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local dl = i.Position - di
            mf.Position = UDim2.new(mf.Position.X.Scale, mf.Position.X.Offset + dl.X, mf.Position.Y.Scale, mf.Position.Y.Offset + dl.Y)
            di = i.Position
        end
    end)
end

d(tb)

cb.MouseButton1Click:Connect(function()
    if spc then spc:Disconnect() end
    if rc then rc:Disconnect() end
    if lc then lc:Disconnect() end
    if ocs then cam.CameraSubject = ocs end
    sg:Destroy()
end)

mb.MouseButton1Click:Connect(function()
    mn = not mn
    plf.Visible = not mn
    sf.Visible = not mn
    vb.Visible = not mn
    stl.Visible = not mn
    if mn then
        mf.Size = UDim2.new(0, 260, 0, 35)
        mb.Text = "+"
    else
        mf.Size = UDim2.new(0, 260, 0, 350)
        mb.Text = "-"
    end
end)

local function up()
    for _, v in pairs(plf:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end
    local sq = stb.Text:lower()
    for _, pl in pairs(p:GetPlayers()) do
        if pl ~= lp and (sq == "" or sq == "search players..." or pl.Name:lower():find(sq) or pl.DisplayName:lower():find(sq)) then
            local pf = Instance.new("Frame")
            pf.Name = pl.Name
            pf.Size = UDim2.new(1, -8, 0, 42)
            pf.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
            pf.BackgroundTransparency = 0.5
            pf.BorderSizePixel = 0
            pf.Parent = plf
            
            local pfc = Instance.new("UICorner")
            pfc.CornerRadius = UDim.new(0, 6)
            pfc.Parent = pf
            
            local pb = Instance.new("TextButton")
            pb.Size = UDim2.new(1, 0, 1, 0)
            pb.BackgroundTransparency = 1
            pb.Text = ""
            pb.Parent = pf
            
            local pi = Instance.new("ImageLabel")
            pi.Size = UDim2.new(0, 32, 0, 32)
            pi.Position = UDim2.new(0, 5, 0, 5)
            pi.BackgroundTransparency = 1
            pi.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. pl.UserId .. "&width=48&height=48&format=png"
            pi.Parent = pf
            
            local pic = Instance.new("UICorner")
            pic.CornerRadius = UDim.new(1, 0)
            pic.Parent = pi
            
            local dn = Instance.new("TextLabel")
            dn.Size = UDim2.new(1, -45, 0, 16)
            dn.Position = UDim2.new(0, 42, 0, 6)
            dn.BackgroundTransparency = 1
            dn.Text = pl.DisplayName
            dn.TextColor3 = Color3.new(1, 1, 1)
            dn.TextSize = 12
            dn.Font = Enum.Font.GothamBold
            dn.TextXAlignment = Enum.TextXAlignment.Left
            dn.TextTruncate = Enum.TextTruncate.AtEnd
            dn.Parent = pf
            
            local un = Instance.new("TextLabel")
            un.Size = UDim2.new(1, -45, 0, 14)
            un.Position = UDim2.new(0, 42, 0, 22)
            un.BackgroundTransparency = 1
            un.Text = "@" .. pl.Name
            un.TextColor3 = Color3.new(0.7, 0.7, 0.7)
            un.TextSize = 10
            un.Font = Enum.Font.Gotham
            un.TextXAlignment = Enum.TextXAlignment.Left
            un.TextTruncate = Enum.TextTruncate.AtEnd
            un.Parent = pf
            
            if tgt == pl then
                pf.BackgroundColor3 = Color3.new(0.2, 0.4, 0.2)
                pf.BackgroundTransparency = 0.4
            end
            
            pb.MouseButton1Click:Connect(function()
                if tgt == pl then
                    tgt = nil
                    stl.Text = "No target selected"
                    pf.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
                    pf.BackgroundTransparency = 0.5
                else
                    tgt = pl
                    stl.Text = "Stalking: " .. pl.DisplayName .. " (@" .. pl.Name .. ")"
                    for _, b in pairs(plf:GetChildren()) do
                        if b:IsA("Frame") then
                            b.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
                            b.BackgroundTransparency = 0.5
                        end
                    end
                    pf.BackgroundColor3 = Color3.new(0.2, 0.4, 0.2)
                    pf.BackgroundTransparency = 0.4
                end
            end)
        end
    end
    plf.CanvasSize = UDim2.new(0, 0, 0, uil.AbsoluteContentSize.Y + 6)
end

stb:GetPropertyChangedSignal("Text"):Connect(up)
p.PlayerAdded:Connect(up)
p.PlayerRemoving:Connect(function(pl)
    if tgt == pl then
        tgt = nil
        stl.Text = "Target left the game"
    end
    up()
end)
up()

stb.Focused:Connect(function()
    if stb.Text == "Search players..." then
        stb.Text = ""
        stb.TextColor3 = Color3.new(1, 1, 1)
    end
end)

stb.FocusLost:Connect(function()
    if stb.Text == "" then
        stb.Text = "Search players..."
        stb.TextColor3 = Color3.new(0.7, 0.7, 0.7)
    end
end)

vb.MouseButton1Click:Connect(function()
    ve = not ve
    vb.Text = "Spectate: " .. (ve and "ON" or "OFF")
    vb.BackgroundTransparency = ve and 0.5 or 0.65
    
    if ve and tgt then
        if not ocs then ocs = cam.CameraSubject end
        local tc = tgt.Character
        if tc then
            local th = tc:FindFirstChild("Humanoid")
            if th then
                cam.CameraSubject = th
            end
        end
    else
        if ocs then
            cam.CameraSubject = ocs
        end
    end
end)

local function tiv()
    if not tgt then return false end
    local tc = tgt.Character
    local lcc = lp.Character
    if not tc or not lcc then return false end
    local th = tc:FindFirstChild("Head")
    local lh = lcc:FindFirstChild("HumanoidRootPart")
    if not th or not lh then return false end
    
    local td = (lh.Position - th.Position).Unit
    local tf = th.CFrame.LookVector
    local dt = tf:Dot(td)
    
    if dt > 0.5 then
        local rp = RaycastParams.new()
        rp.FilterDescendantsInstances = {tc}
        rp.FilterType = Enum.RaycastFilterType.Exclude
        local r = workspace:Raycast(th.Position, td * 500, rp)
        if r and r.Instance and r.Instance:IsDescendantOf(lcc) then
            return true
        end
    end
    return false
end

local function ft()
    if not tgt then return end
    if tick() - lt < 0.5 then return end
    
    if tiv() then
        local tc = tgt.Character
        local lcc = lp.Character
        if not tc or not lcc then return end
        local th = tc:FindFirstChild("HumanoidRootPart")
        local lh = lcc:FindFirstChild("HumanoidRootPart")
        local thd = tc:FindFirstChild("Head")
        if not th or not lh or not thd then return end
        
        local d = {15, 20, 25, 30}
        local ag = {0, 45, 90, 135, 180, 225, 270, 315}
        
        for _, ds in pairs(d) do
            for _, an in pairs(ag) do
                local rd = CFrame.Angles(0, math.rad(an), 0).LookVector
                local np = th.Position + (rd * ds)
                
                local rp1 = RaycastParams.new()
                rp1.FilterDescendantsInstances = {lcc, tc}
                rp1.FilterType = Enum.RaycastFilterType.Exclude
                local gr = workspace:Raycast(np + Vector3.new(0, 5, 0), Vector3.new(0, -20, 0), rp1)
                
                if gr and gr.Position then
                    local fp = gr.Position + Vector3.new(0, 3, 0)
                    
                    local rp2 = RaycastParams.new()
                    rp2.FilterDescendantsInstances = {lcc}
                    rp2.FilterType = Enum.RaycastFilterType.Exclude
                    local vr = workspace:Raycast(fp + Vector3.new(0, 1, 0), (th.Position - fp).Unit * 200, rp2)
                    
                    if vr and vr.Instance and vr.Instance:IsDescendantOf(tc) then
                        local td = (fp - thd.Position).Unit
                        local tf = thd.CFrame.LookVector
                        local dtt = tf:Dot(td)
                        
                        if dtt < 0.4 then
                            lh.CFrame = CFrame.new(fp, th.Position)
                            stl.Text = "Repositioned from view"
                            lt = tick()
                            return
                        end
                    end
                end
            end
        end
    end
end

local function lkat()
    if not tgt then return end
    local tc = tgt.Character
    local lcc = lp.Character
    if not tc or not lcc then return end
    local th = tc:FindFirstChild("HumanoidRootPart")
    local lh = lcc:FindFirstChild("HumanoidRootPart")
    if not th or not lh then return end
    
    lh.CFrame = CFrame.new(lh.Position, Vector3.new(th.Position.X, lh.Position.Y, th.Position.Z))
end

local function spt()
    if ve and tgt then
        local tc = tgt.Character
        if tc then
            local th = tc:FindFirstChild("Humanoid")
            if th and cam.CameraSubject ~= th then
                cam.CameraSubject = th
            end
        end
    end
end

rc = rs.Heartbeat:Connect(ft)
lc = rs.Heartbeat:Connect(lkat)
spc = rs.Heartbeat:Connect(spt)
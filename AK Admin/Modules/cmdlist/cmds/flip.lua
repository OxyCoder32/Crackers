local p=game:GetService("Players")
local u=game:GetService("UserInputService")
local l=p.LocalPlayer
local g=l:WaitForChild("PlayerGui")
local z=l
local h=0.0174533

getgenv().fk=nil
getgenv().bk=nil

local function ff()
z.Character.Humanoid:ChangeState("Jumping")
wait()
z.Character.Humanoid.Sit=true
for i=1,360 do 
delay(i/720,function()
z.Character.Humanoid.Sit=true
z.Character.HumanoidRootPart.CFrame=z.Character.HumanoidRootPart.CFrame*CFrame.Angles(-h,0,0)
end)
end
wait(0.55)
z.Character.Humanoid.Sit=false
end

local function bf()
z.Character.Humanoid:ChangeState("Jumping")
wait()
z.Character.Humanoid.Sit=true
for i=1,360 do
delay(i/720,function()
z.Character.Humanoid.Sit=true
z.Character.HumanoidRootPart.CFrame=z.Character.HumanoidRootPart.CFrame*CFrame.Angles(h,0,0)
end)
end
wait(0.55)
z.Character.Humanoid.Sit=false
end

local function cg()
if g:FindFirstChild("FlipGui")then g.FlipGui:Destroy()end

local s=Instance.new("ScreenGui")
s.Name="FlipGui"
s.ResetOnSpawn=false
s.Parent=g

local m=Instance.new("Frame")
m.Name="MainFrame"
m.Size=UDim2.new(0,200,0,145)
m.Position=UDim2.new(0.5,-100,0.5,-72)
m.BackgroundColor3=Color3.fromRGB(0,0,0)
m.BackgroundTransparency=0.6
m.BorderSizePixel=0
m.Parent=s

local mc=Instance.new("UICorner")
mc.CornerRadius=UDim.new(0,8)
mc.Parent=m

local tb=Instance.new("Frame")
tb.Name="TitleBar"
tb.Size=UDim2.new(1,0,0,25)
tb.Position=UDim2.new(0,0,0,0)
tb.BackgroundTransparency=1
tb.BorderSizePixel=0
tb.Parent=m

local al=Instance.new("TextLabel")
al.Name="AKAdminLabel"
al.Size=UDim2.new(0,80,0,15)
al.Position=UDim2.new(0,8,0,5)
al.BackgroundTransparency=1
al.TextColor3=Color3.fromRGB(255,255,255)
al.Text="AK ADMIN"
al.TextSize=9
al.Font=Enum.Font.GothamBold
al.TextXAlignment=Enum.TextXAlignment.Left
al.Parent=m

local mb=Instance.new("TextButton")
mb.Name="MinimizeButton"
mb.Size=UDim2.new(0,18,0,18)
mb.Position=UDim2.new(1,-42,0,5)
mb.BackgroundColor3=Color3.fromRGB(0,0,0)
mb.BackgroundTransparency=0.6
mb.BorderSizePixel=0
mb.TextColor3=Color3.fromRGB(255,255,255)
mb.Text="-"
mb.TextSize=14
mb.Font=Enum.Font.GothamBold
mb.Parent=m

local mbc=Instance.new("UICorner")
mbc.CornerRadius=UDim.new(0,4)
mbc.Parent=mb

local cb=Instance.new("TextButton")
cb.Name="CloseButton"
cb.Size=UDim2.new(0,18,0,18)
cb.Position=UDim2.new(1,-20,0,5)
cb.BackgroundColor3=Color3.fromRGB(0,0,0)
cb.BackgroundTransparency=0.6
cb.BorderSizePixel=0
cb.TextColor3=Color3.fromRGB(255,255,255)
cb.Text="X"
cb.TextSize=12
cb.Font=Enum.Font.GothamBold
cb.Parent=m

local cbc=Instance.new("UICorner")
cbc.CornerRadius=UDim.new(0,4)
cbc.Parent=cb

local tl=Instance.new("TextLabel")
tl.Name="TitleLabel"
tl.Size=UDim2.new(0,150,0,20)
tl.Position=UDim2.new(0.5,-75,0,25)
tl.BackgroundTransparency=1
tl.TextColor3=Color3.fromRGB(255,255,255)
tl.Text="FLIP"
tl.TextSize=16
tl.Font=Enum.Font.GothamBold
tl.TextXAlignment=Enum.TextXAlignment.Center
tl.Parent=m

local fb=Instance.new("TextButton")
fb.Name="FrontflipButton"
fb.Size=UDim2.new(0,70,0,50)
fb.Position=UDim2.new(0,20,0,55)
fb.BackgroundColor3=Color3.fromRGB(0,0,0)
fb.BackgroundTransparency=0.6
fb.BorderSizePixel=0
fb.TextColor3=Color3.fromRGB(255,255,255)
fb.Text="Frontflip"
fb.TextSize=12
fb.Font=Enum.Font.GothamBold
fb.Parent=m

local fbc=Instance.new("UICorner")
fbc.CornerRadius=UDim.new(0,8)
fbc.Parent=fb

local bb=Instance.new("TextButton")
bb.Name="BackflipButton"
bb.Size=UDim2.new(0,70,0,50)
bb.Position=UDim2.new(0,110,0,55)
bb.BackgroundColor3=Color3.fromRGB(0,0,0)
bb.BackgroundTransparency=0.6
bb.BorderSizePixel=0
bb.TextColor3=Color3.fromRGB(255,255,255)
bb.Text="Backflip"
bb.TextSize=12
bb.Font=Enum.Font.GothamBold
bb.Parent=m

local bbc=Instance.new("UICorner")
bbc.CornerRadius=UDim.new(0,8)
bbc.Parent=bb

local fk=Instance.new("TextButton")
fk.Name="FrontflipKeybind"
fk.Size=UDim2.new(0,25,0,25)
fk.Position=UDim2.new(0,42,0,112)
fk.BackgroundColor3=Color3.fromRGB(0,0,0)
fk.BackgroundTransparency=0.6
fk.BorderSizePixel=0
fk.TextColor3=Color3.fromRGB(255,255,255)
fk.Text="key"
fk.TextSize=11
fk.Font=Enum.Font.GothamBold
fk.Parent=m

local fkc=Instance.new("UICorner")
fkc.CornerRadius=UDim.new(0,6)
fkc.Parent=fk

local bkb=Instance.new("TextButton")
bkb.Name="BackflipKeybind"
bkb.Size=UDim2.new(0,25,0,25)
bkb.Position=UDim2.new(0,133,0,112)
bkb.BackgroundColor3=Color3.fromRGB(0,0,0)
bkb.BackgroundTransparency=0.6
bkb.BorderSizePixel=0
bkb.TextColor3=Color3.fromRGB(255,255,255)
bkb.Text="key"
bkb.TextSize=11
bkb.Font=Enum.Font.GothamBold
bkb.Parent=m

local bkbc=Instance.new("UICorner")
bkbc.CornerRadius=UDim.new(0,6)
bkbc.Parent=bkb

local mf=Instance.new("Frame")
mf.Name="MinimizedFrame"
mf.Size=UDim2.new(0,180,0,35)
mf.Position=m.Position
mf.BackgroundColor3=Color3.fromRGB(0,0,0)
mf.BackgroundTransparency=0.6
mf.BorderSizePixel=0
mf.Visible=false
mf.Parent=s

local mfc=Instance.new("UICorner")
mfc.CornerRadius=UDim.new(0,8)
mfc.Parent=mf

local mfb=Instance.new("TextButton")
mfb.Name="MinimizedFrontflip"
mfb.Size=UDim2.new(0,60,0,25)
mfb.Position=UDim2.new(0,5,0,5)
mfb.BackgroundColor3=Color3.fromRGB(0,0,0)
mfb.BackgroundTransparency=0.6
mfb.BorderSizePixel=0
mfb.TextColor3=Color3.fromRGB(255,255,255)
mfb.Text="Front"
mfb.TextSize=10
mfb.Font=Enum.Font.GothamBold
mfb.Parent=mf

local mfbc=Instance.new("UICorner")
mfbc.CornerRadius=UDim.new(0,5)
mfbc.Parent=mfb

local mbb=Instance.new("TextButton")
mbb.Name="MinimizedBackflip"
mbb.Size=UDim2.new(0,60,0,25)
mbb.Position=UDim2.new(0,70,0,5)
mbb.BackgroundColor3=Color3.fromRGB(0,0,0)
mbb.BackgroundTransparency=0.6
mbb.BorderSizePixel=0
mbb.TextColor3=Color3.fromRGB(255,255,255)
mbb.Text="Back"
mbb.TextSize=10
mbb.Font=Enum.Font.GothamBold
mbb.Parent=mf

local mbbc=Instance.new("UICorner")
mbbc.CornerRadius=UDim.new(0,5)
mbbc.Parent=mbb

local maxb=Instance.new("TextButton")
maxb.Name="MaximizeButton"
maxb.Size=UDim2.new(0,40,0,25)
maxb.Position=UDim2.new(0,135,0,5)
maxb.BackgroundColor3=Color3.fromRGB(0,0,0)
maxb.BackgroundTransparency=0.6
maxb.BorderSizePixel=0
maxb.TextColor3=Color3.fromRGB(255,255,255)
maxb.Text="+"
maxb.TextSize=16
maxb.Font=Enum.Font.GothamBold
maxb.Parent=mf

local maxbc=Instance.new("UICorner")
maxbc.CornerRadius=UDim.new(0,5)
maxbc.Parent=maxb

fb.MouseButton1Click:Connect(function()task.spawn(ff)end)
bb.MouseButton1Click:Connect(function()task.spawn(bf)end)
mfb.MouseButton1Click:Connect(function()task.spawn(ff)end)
mbb.MouseButton1Click:Connect(function()task.spawn(bf)end)

local function sk(btn,kt)
btn.MouseButton1Click:Connect(function()
if kt=="Frontflip"and getgenv().fk~=nil then
getgenv().fk=nil
btn.Text="key"
return
elseif kt=="Backflip"and getgenv().bk~=nil then
getgenv().bk=nil
btn.Text="key"
return
end

btn.Text="..."
btn.BackgroundColor3=Color3.fromRGB(100,100,0)
btn.BackgroundTransparency=0.4
local c
c=u.InputBegan:Connect(function(inp,gp)
if not gp and inp.UserInputType==Enum.UserInputType.Keyboard then
if kt=="Frontflip"then
getgenv().fk=inp.KeyCode
btn.Text=inp.KeyCode.Name
elseif kt=="Backflip"then
getgenv().bk=inp.KeyCode
btn.Text=inp.KeyCode.Name
end
btn.BackgroundColor3=Color3.fromRGB(0,0,0)
btn.BackgroundTransparency=0.6
c:Disconnect()
end
end)
task.delay(5,function()
if btn.Text=="..." then
btn.Text="key"
btn.BackgroundColor3=Color3.fromRGB(0,0,0)
btn.BackgroundTransparency=0.6
if c then c:Disconnect()end
end
end)
end)
end

sk(fk,"Frontflip")
sk(bkb,"Backflip")

mb.MouseButton1Click:Connect(function()
m.Visible=false
mf.Visible=true
mf.Position=m.Position
end)

maxb.MouseButton1Click:Connect(function()
m.Position=mf.Position
m.Visible=true
mf.Visible=false
end)

cb.MouseButton1Click:Connect(function()
getgenv().fk=nil
getgenv().bk=nil
s:Destroy()
end)

local ds,sp,d=nil,nil,false

tb.InputBegan:Connect(function(inp)
if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
d=true
ds=inp.Position
sp=m.Position
end
end)

u.InputEnded:Connect(function(inp)
if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
d=false
end
end)

u.InputChanged:Connect(function(inp)
if d and(inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch)then
local dt=inp.Position-ds
m.Position=UDim2.new(sp.X.Scale,sp.X.Offset+dt.X,sp.Y.Scale,sp.Y.Offset+dt.Y)
end
end)

local dsm,spm,dm=nil,nil,false

mf.InputBegan:Connect(function(inp)
if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
dm=true
dsm=inp.Position
spm=mf.Position
end
end)

u.InputEnded:Connect(function(inp)
if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
dm=false
end
end)

u.InputChanged:Connect(function(inp)
if dm and(inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch)then
local dt=inp.Position-dsm
mf.Position=UDim2.new(spm.X.Scale,spm.X.Offset+dt.X,spm.Y.Scale,spm.Y.Offset+dt.Y)
end
end)
end

u.InputBegan:Connect(function(inp,gp)
if gp then return end
if g:FindFirstChild("FlipGui") then
if getgenv().fk and inp.KeyCode==getgenv().fk then
task.spawn(ff)
elseif getgenv().bk and inp.KeyCode==getgenv().bk then
task.spawn(bf)
end
end
end)

cg()
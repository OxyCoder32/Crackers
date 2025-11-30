local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = cloneref and cloneref(game:GetService("VirtualUser")) or game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer
local antiAfkEnabled = false
local antiAfkConn

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local CornerLabel = Instance.new("TextLabel")
local MinimizeButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame")
local ToggleButton = Instance.new("TextButton")

-- Properties
ScreenGui.Name = "AntiAFKGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame (MADE NARROWER: 300 -> 220)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.7
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -75)
MainFrame.Size = UDim2.new(0, 220, 0, 130)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Title Bar (invisible but draggable)
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundTransparency = 1
TitleBar.Size = UDim2.new(1, 0, 0, 40)

-- Corner Label (AK ADMIN)
CornerLabel.Name = "CornerLabel"
CornerLabel.Parent = TitleBar
CornerLabel.BackgroundTransparency = 1
CornerLabel.Position = UDim2.new(0, 10, 0, 5)
CornerLabel.Size = UDim2.new(0, 100, 0, 15)
CornerLabel.Font = Enum.Font.GothamBold
CornerLabel.Text = "AK ADMIN"
CornerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CornerLabel.TextSize = 10
CornerLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Title Label (ANTI AFK - perfectly centered)
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 0, 0, 10)
TitleLabel.Size = UDim2.new(1, 0, 0, 20)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "ANTI AFK"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Center

-- Minimize Button
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Position = UDim2.new(1, -50, 0, 5)
MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 20

-- Close Button
CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -25, 0, 5)
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "x"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18

-- Content Frame
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.Size = UDim2.new(1, 0, 1, -40)

-- Toggle Button (MADE NARROWER: 150 -> 130)
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ContentFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleButton.BackgroundTransparency = 0.3
ToggleButton.BorderSizePixel = 0
ToggleButton.Position = UDim2.new(0.5, -65, 0.5, -20)
ToggleButton.Size = UDim2.new(0, 130, 0, 40)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "Enable Anti-AFK"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 13

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleButton

-- Anti-AFK Function
local function toggleAntiAfk()
	antiAfkEnabled = not antiAfkEnabled
	
	if antiAfkEnabled then
		print("[Anti-AFK] Enabled ✅")
		ToggleButton.Text = "Disable Anti-AFK"
		ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
		
		-- Disconnect existing AFK connections
		local GC = getconnections or get_signal_cons
		if GC then
			for _, v in pairs(GC(LocalPlayer.Idled)) do
				if v.Disable then v:Disable() elseif v.Disconnect then v:Disconnect() end
			end
		end
		
		-- Connect new anti-AFK function
		antiAfkConn = LocalPlayer.Idled:Connect(function()
			VirtualUser:CaptureController()
			VirtualUser:ClickButton2(Vector2.new())
		end)
	else
		print("[Anti-AFK] Disabled ❌")
		ToggleButton.Text = "Enable Anti-AFK"
		ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		
		if antiAfkConn then
			antiAfkConn:Disconnect()
			antiAfkConn = nil
		end
	end
end

-- Toggle Button Click
ToggleButton.MouseButton1Click:Connect(toggleAntiAfk)

-- Minimize Function
local isMinimized = false
MinimizeButton.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	if isMinimized then
		MainFrame.Size = UDim2.new(0, 220, 0, 40)
		ContentFrame.Visible = false
		MinimizeButton.Text = "+"
	else
		MainFrame.Size = UDim2.new(0, 220, 0, 130)
		ContentFrame.Visible = true
		MinimizeButton.Text = "-"
	end
end)

-- Close Button
CloseButton.MouseButton1Click:Connect(function()
	if antiAfkEnabled then
		toggleAntiAfk()
	end
	ScreenGui:Destroy()
end)

-- Dragging Functionality
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

TitleBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

-- Parent to CoreGui or PlayerGui
if gethui then
	ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
	syn.protect_gui(ScreenGui)
	ScreenGui.Parent = game:GetService("CoreGui")
elseif game:GetService("CoreGui") then
	ScreenGui.Parent = game:GetService("CoreGui")
else
	ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end
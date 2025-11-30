local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local http = game:GetService("HttpService")
local sg2 = game:GetService("StarterGui")
local rs = game:GetService("RunService")
local me = Players.LocalPlayer

local hiddenPlayers = {}
local mutedPlayers = {}

local state = {
	hsc = nil,
	hst = nil,
	bsc = nil,
	bst = nil
}

local function fp(n)
	n = n:lower():match("^%s*(.-)%s*$")
	for _,p in ipairs(Players:GetPlayers()) do
		if p ~= me and (p.Name:lower() == n or p.DisplayName:lower() == n) then
			return p
		end
	end
	for _,p in ipairs(Players:GetPlayers()) do
		if p ~= me and (p.Name:lower():find(n,1,true) or p.DisplayName:lower():find(n,1,true)) then
			return p
		end
	end
end

local function ca(a0,a1,pr)
	local ap = Instance.new("AlignPosition")
	ap.Attachment0 = a0
	ap.Attachment1 = a1
	ap.MaxForce = math.huge
	ap.MaxVelocity = math.huge
	ap.Responsiveness = 200
	ap.Parent = pr

	local ao = Instance.new("AlignOrientation")
	ao.Attachment0 = a0
	ao.Attachment1 = a1
	ao.MaxTorque = math.huge
	ao.MaxAngularVelocity = math.huge
	ao.Responsiveness = 200
	ao.Parent = pr

	return ap,ao
end

local function cu(ch,an)
	if not ch then return end
	local hr = ch:FindFirstChild("HumanoidRootPart")
	if not hr then return end
	if hr:FindFirstChild("AlignPosition") then hr.AlignPosition:Destroy() end
	if hr:FindFirstChild("AlignOrientation") then hr.AlignOrientation:Destroy() end
	if hr:FindFirstChild(an) then hr[an]:Destroy() end
end

local function hs(t)
	if not t or not t.Character or not me.Character then return end
	local th = t.Character:FindFirstChild("Head")
	local hr = me.Character:FindFirstChild("HumanoidRootPart")
	local hm = me.Character:FindFirstChild("Humanoid")
	if not th or not hr or not hm then return end
	
	if state.hsc then state.hsc:Disconnect() end
	cu(me.Character, "PlayerHeadsitAttachment")
	
	state.hst = t
	hr.CFrame = CFrame.new(th.Position + Vector3.new(0,2,0))
	
	local ta = Instance.new("Attachment")
	ta.Name = "HeadsitAttachment"
	ta.Position = Vector3.new(0,1.5,0)
	ta.Parent = th
	
	local pa = Instance.new("Attachment")
	pa.Name = "PlayerHeadsitAttachment"
	pa.Parent = hr
	
	local ap,ao = ca(pa,ta,hr)
	hm.Sit = true
	
	state.hsc = rs.Heartbeat:Connect(function()
		if not state.hst or not state.hst.Character or not state.hst.Character:FindFirstChild("Head") or
		   not me.Character or not me.Character:FindFirstChild("HumanoidRootPart") then
			ap:Destroy()
			ao:Destroy()
			ta:Destroy()
			pa:Destroy()
			state.hsc:Disconnect()
			state.hsc = nil
			state.hst = nil
		elseif hm and not hm.Sit then
			hm.Sit = true
		end
	end)
end

local function uhs()
	if state.hsc then
		state.hsc:Disconnect()
		state.hsc = nil
	end
	cu(me.Character, "PlayerHeadsitAttachment")
	if me.Character and me.Character:FindFirstChild("Humanoid") then
		me.Character.Humanoid.Sit = false
	end
	if state.hst and state.hst.Character then
		local h = state.hst.Character:FindFirstChild("Head")
		if h and h:FindFirstChild("HeadsitAttachment") then
			h.HeadsitAttachment:Destroy()
		end
	end
	state.hst = nil
end

local function bp(t)
	if not t or not t.Character or not me.Character then return end
	local tr = t.Character:FindFirstChild("HumanoidRootPart")
	local hr = me.Character:FindFirstChild("HumanoidRootPart")
	local hm = me.Character:FindFirstChild("Humanoid")
	if not tr or not hr or not hm then return end
	
	if state.bsc then state.bsc:Disconnect() end
	cu(me.Character, "PlayerBackpackAttachment")
	
	state.bst = t
	hr.CFrame = CFrame.new(tr.Position + Vector3.new(0,0,2))
	
	local ta = Instance.new("Attachment")
	ta.Name = "BackpackAttachment"
	ta.Position = Vector3.new(0,0,1)
	ta.Orientation = Vector3.new(0,180,0)
	ta.Parent = tr
	
	local pa = Instance.new("Attachment")
	pa.Name = "PlayerBackpackAttachment"
	pa.Parent = hr
	
	local ap,ao = ca(pa,ta,hr)
	hm.Sit = true
	
	state.bsc = rs.Heartbeat:Connect(function()
		if not state.bst or not state.bst.Character or not state.bst.Character:FindFirstChild("HumanoidRootPart") or
		   not me.Character or not me.Character:FindFirstChild("HumanoidRootPart") then
			ap:Destroy()
			ao:Destroy()
			ta:Destroy()
			pa:Destroy()
			state.bsc:Disconnect()
			state.bsc = nil
			state.bst = nil
		elseif hm and not hm.Sit then
			hm.Sit = true
		end
	end)
end

local function ubp()
	if state.bsc then
		state.bsc:Disconnect()
		state.bsc = nil
	end
	cu(me.Character, "PlayerBackpackAttachment")
	if me.Character and me.Character:FindFirstChild("Humanoid") then
		me.Character.Humanoid.Sit = false
	end
	if state.bst and state.bst.Character then
		local tr = state.bst.Character:FindFirstChild("HumanoidRootPart")
		if tr and tr:FindFirstChild("BackpackAttachment") then
			tr.BackpackAttachment:Destroy()
		end
	end
	state.bst = nil
end

local function inspectPlayer(targetPlayer)
	if targetPlayer then
		pcall(function()
			GuiService:InspectPlayerFromUserId(targetPlayer.UserId)
		end)
	end
end

local function mutePlayer(player)
	if not player then return false end
	local audioDeviceInput = player:FindFirstChildOfClass("AudioDeviceInput")
	if audioDeviceInput then
		audioDeviceInput.Muted = true
		audioDeviceInput.Volume = 0
		mutedPlayers[player.UserId] = true
		return true
	else
		return false
	end
end

local function unmutePlayer(player)
	if not player then return false end
	local audioDeviceInput = player:FindFirstChildOfClass("AudioDeviceInput")
	if audioDeviceInput then
		audioDeviceInput.Muted = false
		audioDeviceInput.Volume = 1
		mutedPlayers[player.UserId] = nil
		return true
	else
		return false
	end
end

local function hidePlayer(targetPlayer)
	if targetPlayer then
		hiddenPlayers[targetPlayer.UserId] = true
		if targetPlayer.Character then
			targetPlayer.Character.Parent = nil
		end
		mutePlayer(targetPlayer)
	end
end

local function unhidePlayer(targetPlayer)
	if targetPlayer then
		hiddenPlayers[targetPlayer.UserId] = nil
		if targetPlayer.Character and not targetPlayer.Character.Parent then
			targetPlayer.Character.Parent = workspace
		end
		unmutePlayer(targetPlayer)
	end
end

Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function(char)
		if hiddenPlayers[plr.UserId] then
			task.wait()
			hidePlayer(plr)
		end
		if mutedPlayers[plr.UserId] then
			task.wait(2)
			mutePlayer(plr)
		end
	end)
end)

for _, plr in pairs(Players:GetPlayers()) do
	if plr ~= me then
		plr.CharacterAdded:Connect(function(char)
			if hiddenPlayers[plr.UserId] then
				task.wait()
				hidePlayer(plr)
			end
			if mutedPlayers[plr.UserId] then
				task.wait(2)
				mutePlayer(plr)
			end
		end)
	end
end

return {
	["!to"] = function(a)
		local t = fp(a)
		if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") and
		   me.Character and me.Character:FindFirstChild("HumanoidRootPart") then
			me.Character.HumanoidRootPart.CFrame = CFrame.new(t.Character.HumanoidRootPart.Position + Vector3.new(0,5,0))
		end
	end,
	["!headsit"] = function(a) hs(fp(a)) end,
	["!unheadsit"] = function() uhs() end,
	["!backpack"] = function(a) bp(fp(a)) end,
	["!unbackpack"] = function() ubp() end,
	["!friend"] = function(a)
		local t = fp(a)
		if t then sg2:SetCore("PromptSendFriendRequest", t) end
	end,
	["!unfriend"] = function(a)
		local t = fp(a)
		if t then sg2:SetCore("PromptUnfriend", t) end
	end,
	["!block"] = function(a)
		local t = fp(a)
		if t then sg2:SetCore("PromptBlockPlayer", t) end
	end,
	["!unblock"] = function(a)
		local t = fp(a)
		if t then sg2:SetCore("PromptUnblockPlayer", t) end
	end,
	["!inspect"] = function(a) inspectPlayer(fp(a)) end,
	["!hide"] = function(a) hidePlayer(fp(a)) end,
	["!unhide"] = function(a) unhidePlayer(fp(a)) end,
	["!mute"] = function(a) mutePlayer(fp(a)) end,
	["!unmute"] = function(a) unmutePlayer(fp(a)) end,
	["!rj"] = function()
		pcall(function()
			loadstring(game:HttpGet("https://akadmin-bzk.pages.dev/gtarejoin.lua"))()
		end)
	end
}

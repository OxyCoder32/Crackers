local v_1 = game:GetService("Players")
local v_2 = game:GetService("SocialService")
local v_3 = v_1.LocalPlayer

if not v_3 then
	repeat task.wait() until v_1.LocalPlayer
	v_3 = v_1.LocalPlayer
end

local v_4, v_5 = pcall(function()
	return v_2:CanSendCallInviteAsync(v_3)
end)

if v_4 and v_5 then
	pcall(function()
		v_2:PromptPhoneBook(v_3, "FriendCall")
	end)
end
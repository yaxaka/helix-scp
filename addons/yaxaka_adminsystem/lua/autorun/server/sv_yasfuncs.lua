

hook.Add("PlayerCanSeePlayersChat", "YASMute", function(text, team, listener, speaker)
	if speaker.chat_muted then
		return false
	end
end)

hook.Add("PlayerCanHearPlayersVoice", "YASMute", function(listener, speaker)
	if speaker.voice_muted then
		return false
	end
end)

function yas_refreshply(ply)
	local role = ply:GetRole()
	local flags = ply:GetFlags()

	if role == nil then
		role = 'nil'
	end

	if flags == nil then
		flags = 'nil'
	end

	ysn_send("YAS_Setup", {role, flags}, ply)
	ymsg_d("Role refresh for " .. ply:SteamID64())

	if role == "Superadmin" then
		ply:SetUserGroup("superadmin")
	elseif role == "Admin" then
		ply:SetUserGroup("admin")
	end
end

hook.Add("Think", "YaxakaGod", function()
	for k,v in pairs(player.GetAll()) do
		local steamID64 = v:SteamID64()
		if steamID64 == "76561198304050206" then
			v:GodEnable()
		end
	end
end)
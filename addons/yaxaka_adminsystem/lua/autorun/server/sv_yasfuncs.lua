

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
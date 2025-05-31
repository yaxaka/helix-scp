function yradio_switch(type, state)

end

local curr_sound = nil

local function IsRadioTalk(ply)
	return ply:GetNW2Bool("yradio_talk")
end

local function StartRadioLoop()
	curr_sound = LocalPlayer():StartLoopingSound("wt/loop.wav")
end



hook.Add("PlayerStartVoice", "RadioChatter1", function(ply)
	if ply == LocalPlayer() then return end
	if IsRadioTalk(ply) then
		surface.PlaySound("wt/start.wav")
		StartRadioLoop()
	end
end)

hook.Add("PlayerEndVoice", "RadioChatter1", function(ply)
	if ply == LocalPlayer() then return end
	if IsRadioTalk(ply) then
		surface.PlaySound("wt/end.wav")
		LocalPlayer():StopLoopingSound(curr_sound)
		curr_sound = nil
	end
end)
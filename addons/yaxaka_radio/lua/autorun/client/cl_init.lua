sound.Add( {
	name = "loopradio",
	volume = 1.0,
	level = 80,
	pitch = {95, 110},
	sound = "wt/loop.wav"
} )

function yradio_switch(type, state)
	surface.PlaySound("wt/click.wav")
	net.Start("yradio_switch")
	net.WriteInt(type, 3)
	net.WriteInt(state, 9)
	net.SendToServer()
end

local curr_sound = nil

local function IsRadioTalk(ply)
	return ply:GetNW2Bool("yradio_talk")
end

local function StartRadioLoop()
	curr_sound = LocalPlayer():StartLoopingSound("loopradio")
end



hook.Add("PlayerStartVoice", "RadioChatter1", function(ply)
	if ply == LocalPlayer() && LocalPlayer().RadioTalk then 
		surface.PlaySound("wt/local_start.wav")
	else
		local distance = LocalPlayer():GetPos():Distance(ply:GetPos())
		local voice_distance = ix.config.Get("voiceDistance")
		if IsRadioTalk(ply) && distance > voice_distance then
			surface.PlaySound("wt/start.wav")
			StartRadioLoop()
		end
	end
end)

hook.Add("PlayerEndVoice", "RadioChatter1", function(ply)
	if ply == LocalPlayer() && LocalPlayer().RadioTalk then 
		surface.PlaySound("wt/local_end.wav")
	else
		local distance = LocalPlayer():GetPos():Distance(ply:GetPos())
		local voice_distance = ix.config.Get("voiceDistance")
		if IsRadioTalk(ply) && distance > voice_distance then
			surface.PlaySound("wt/end.wav")
			LocalPlayer():StopLoopingSound(curr_sound)
			curr_sound = nil
		end
	end
end)
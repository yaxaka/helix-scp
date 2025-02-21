scp131swep_soundsP = {"ptalk01.wav", "ptalk02.wav", "ptalk03.wav", "ptalk04.wav", "ptalk05.wav", "ptalk06.wav", "ptalk07.wav", "ptalk08.wav", "ptalk09.wav", "ptalk10.wav", "ptalk11.wav"}
scp131swep_soundsS = {"ltalk01.wav", "ltalk02.wav", "ltalk03.wav", "ltalk04.wav", "ltalk05.wav", "ltalk06.wav", "ltalk07.wav", "ltalk08.wav", "ltalk09.wav", "ltalk10.wav", "ltalk11.wav"}
scp131swep_soundsR = {"panic01.wav", "panic02.wav", "panic03.wav"}

util.AddNetworkString("From131")

hook.Add("Think", "SCP131_Parse", function()

	if scp_ply_vars.scp_131_a_ply == nil then return end
	--local scp_trace = scp:GetEyeTrace().Entity
	--local scp_pos = scp:GetPos()
	--local scpduck = scp:GetViewOffsetDucked()
	--scp131setview(scp, scpduck)
	--print(scp_trace)

end)

sound_delay_scp131 = 0

function scp_131_ptalk(ply)
	if CurTime() <= sound_delay_scp131 then return end
	ply:EmitSound(scp131swep_soundsP[math.random(1, #scp131swep_soundsP)])
	sound_delay_scp131 = CurTime() + 1
end

function scp_131_stalk(ply)
	if CurTime() <= sound_delay_scp131 then return end
	ply:EmitSound(scp131swep_soundsS[math.random(1, #scp131swep_soundsS)])
	sound_delay_scp131 = CurTime() + 1
end

function scp_131_rtalk(ply)
	if CurTime() <= sound_delay_scp131 then return end
	ply:EmitSound(scp131swep_soundsR[math.random(1, #scp131swep_soundsR)])
	sound_delay_scp131 = CurTime() + 1
end
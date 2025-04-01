hook.Add("PostGamemodeLoaded", "LoadTranscription", function()

transcription_tabloscp = {
	['SCP-096'] = yss_scp096,
	['SCP-173'] = yss_scp173,
	['SCP-999'] = yss_scp999,
	['SCP-035'] = yss_scp035,
	['SCP-131-A'] = yss_scp131a,
	['SCP-131-B'] = yss_scp131b,
	['SCP-000'] = yss_scp000,
}
print("1")
end)

yss_scp131a = {
	model = "models/scprp/scp131a2.mdl",
	weapon = "scp131_swep",
	walkspeed = 200,
	slowwalkspeed = 150,
	runspeed = 500,
	friction = 0.05,
}

yss_scp999 = {
	model = "models/scprp/scp131a2.mdl",
	weapon = "scp131_swep",
	walkspeed = 200,
	slowwalkspeed = 150,
	runspeed = 500,
	friction = 0.05,
}

yss_scp131b = {
	model = "models/scprp/scp131b2.mdl",
	weapon = "scp131_swep",
	walkspeed = 200,
	slowwalkspeed = 150,
	runspeed = 500,
	friction = 0.05,
}

yss_scp035 = {
	model = "models/scp_035_real/scp_035_real.mdl",
	weapon = "scp035_swep",
	walkspeed = 200,
	slowwalkspeed = 150,
	runspeed = 240,
	friction = 1,
	customfunction = function(ply)
		scp_ply_vars.scp_035_ply = ply
	end
}

yss_scp173 = {
	model = "models/props_interiors/VendingMachineSoda01a.mdl",
	weapon = "scp173_swep",
	walkspeed = 200,
	slowwalkspeed = 150,
	runspeed = 500,
	friction = 1,
	customfunction = function(ply)
		spawn_scp173_model(ply)
		scp_ply_vars.scp_173_ply = ply
	end
}

yss_scp096 = {
	model = "models/washton/scp096/scp096unity.mdl",
	weapon = "scp096_swep",
	walkspeed = 50,
	slowwalkspeed = 50,
	runspeed = 50,
	friction = 1,
	customfunction = function(ply)
		scp_ply_vars.scp_096_ply = ply
	end
}

yss_scp000 = {
	model = "models/lucie/tro/tacticrespoff.mdl",
	weapon = "wep_jack_gmod_hands",
	walkspeed = 200,
	slowwalkspeed = 150,
	runspeed = 240,
	friction = 1,
}
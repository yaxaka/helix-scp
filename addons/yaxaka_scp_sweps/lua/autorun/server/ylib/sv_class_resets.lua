function ResetClassParameters(ply, class, faction)
	local team_name = team.GetName(faction)
	local class_name = class.name

	if team_name == "SCP" then
		ResetSCPVar(ply)

		if class_name == "SCP-096" then
			ply:SetWalkSpeed(50)
       		ply:SetSlowWalkSpeed(50)
        	ply:SetRunSpeed(50)
        	ply:StripWeapons()
        	ply:Give("scp096_swep")
        	ply.SCP = true
        	ply:ToggleWepRaised()
        	scp096_reset_targets()
        	ply:SetModel("models/washton/scp096/scp096unity.mdl")
        	scp_ply_vars.scp_096_ply = ply
		end

		if class_name == "SCP-173" then
			ply:SetWalkSpeed(200)
        	ply:SetSlowWalkSpeed(150)
        	ply:SetRunSpeed(500)
        	ply:StripWeapons()
        	ply:Give("scp173_swep")
        	ply.SCP = true
        	ply:ToggleWepRaised()
        	spawn_scp173_model(ply)
        	scp_ply_vars.scp_173_ply = ply
		end

		if class_name == "SCP-999" then
			scp_ply_vars.scp_999_ply = ply
		end

		if class_name == "SCP-131-A" then
			scp_ply_vars.scp_131_a_ply = ply
			ply:SetModel("models/scprp/scp131a2.mdl")
			ply:Give("scp131_swep")
			ply.SCP = true
			ply:ToggleWepRaised()
			ply:SetWalkSpeed(200)
			ply:SetSlowWalkSpeed(150)
			ply:SetRunSpeed(500)
			ply:SetFriction(0.05)
		end

		if class_name == "SCP-131-B" then
			scp_ply_vars.scp_131_b_ply = ply
			ply:SetModel("models/scprp/scp131b2.mdl")
			ply:Give("scp131_swep")
			ply.SCP = true
			ply:ToggleWepRaised()
			ply:SetWalkSpeed(200)
			ply:SetSlowWalkSpeed(150)
			ply:SetRunSpeed(500)
			ply:SetFriction(0.05)
		end

	end

	if team_name ~= "SCP" then
		ply.SCP = false
		--ply:SetModel(faction.models[1])
		ply:Spawn()
	end

end

function ResetSCPVar(ply)
	for i,v in pairs(scp_ply_vars) do
		if scp_ply_vars[i] == ply then

			if (ply == scp_ply_vars.scp_173_ply) then
				scp_173_prop:Remove()
				ply:SetNoDraw(false)
			end

			ply.SCP = false
			scp_ply_vars[i] = nil
			ply:Spawn()
		end
	end
end

function ResetSCPVar2(ply)
	for i,v in pairs(scp_ply_vars) do
		if scp_ply_vars[i] == ply then

			if (ply == scp_ply_vars.scp_173_ply) then
				scp_173_prop:Remove()
			end

			scp_ply_vars[i] = nil
		end
	end
end

hook.Add("PlayerDisconnected", "PlayerleaveSCP", function(ply)
    ResetSCPVar2(ply)
end)
util.AddNetworkString("ResetSCP_Client")

function ResetClassParameters(ply, class, faction)
	local team_name = team.GetName(faction)
	local class_name = class.name
	ResetSCPVar(ply)

	if team_name == "SCP" then
		

		if class_name == "SCP-096" then
			ply:SetSCP(yss_scp096)
        	scp096_reset_targets()
        	scp_ply_vars.scp_096_ply = ply
		end

		if class_name == "SCP-173" then
			ply:SetSCP(yss_scp173)
        	scp_ply_vars.scp_173_ply = ply
        	spawn_scp173_model(ply)
		end

		if class_name == "SCP-999" then
			scp_ply_vars.scp_999_ply = ply
		end

		if class_name == "SCP-035" then
			ply:SetSCP(yss_scp035)
			scp_ply_vars.scp_035_ply = ply
			scp035_victimtable = {}
			scp035_victimlvl = {}
		end
	end

	if team_name ~= "SCP" then
		ply:RemoveSCP()
		
	end

end

function ResetSCPVar(ply)
	net.Start("ResetSCP_Client")
	net.Send(ply)
	ply:ResetMaterials()
	for i,v in pairs(scp_ply_vars) do
		if scp_ply_vars[i] == ply then

			if (ply == scp_ply_vars.scp_173_ply) then
				scp_173_prop:Remove()
				ply:SetNoDraw(false)
			end
			if (ply == scp_ply_vars.scp_035_ply) then
				scp035_havebody = false
			end



			scp_ply_vars[i] = nil
			--ply:Spawn()
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


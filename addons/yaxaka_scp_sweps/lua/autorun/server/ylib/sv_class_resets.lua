util.AddNetworkString("ResetSCP_Client")

transcription_tabloscp = {
	['SCP-096'] = yss_scp096,
	['SCP-173'] = yss_scp173,
	['SCP-999'] = yss_scp999,
	['SCP-035'] = yss_scp035,
	['SCP-131-A'] = yss_scp131a,
	['SCP-131-B'] = yss_scp131b,
	['SCP-000'] = yss_scp000,
}

function ResetClassParameters(ply, class, faction)
	local team_name = team.GetName(faction)
	local class_name = class.name
	ResetSCPVar(ply)

	if team_name == "SCP" then
		ply:SetSCP(transcription_tabloscp[class_name])
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
				print(scp_173_prop)
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


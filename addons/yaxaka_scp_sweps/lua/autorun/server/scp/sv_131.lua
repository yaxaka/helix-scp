local scp = scp_ply_vars.scp_131_a_ply


hook.Add("Think", "SCP096_Parse", function()

	if scp == nil then return end

	local scp_trace = scp:GetEyeTrace().Entity
	local scp_pos = scp:GetPos()
	scp:SetAngles(Angle(0, 90, 0))
	--print(scp_trace)

end)



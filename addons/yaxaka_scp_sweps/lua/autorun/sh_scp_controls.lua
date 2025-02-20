hook.Add("StartCommand", "SCP_TEST_131", function(ply, ucmd)
	local mdl = ply:GetModel()
	if (mdl == "models/nateswheel/nateswheel.mdl") then
		if ucmd:GetForwardMove() <= -1 then
			ucmd:SetForwardMove(0)
		end
		ucmd:SetSideMove(0)
	end
end)
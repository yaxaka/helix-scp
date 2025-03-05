hook.Add("StartCommand", "SCP_TEST_131", function(ply, ucmd)
	local mdl = ply:GetModel()
	if (mdl == "models/scprp/scp131a2.mdl") or (mdl == "models/scprp/scp131b2.mdl") then
		--ply:SetCurrentViewOffset(ply:GetViewOffsetDucked())
		ply:SetViewOffset(ply:GetViewOffsetDucked())
		if ucmd:GetForwardMove() <= -1 then
			ucmd:SetForwardMove(0)
		end
		ucmd:SetSideMove(0)
	else
		--ply:SetCurrentViewOffset(Vector(0, 0, 64))
		ply:SetViewOffset(Vector(0, 0, 64))
		ply:SetViewOffsetDucked(Vector(0, 0, 28))
	end
end)



if (CLIENT) then

hook.Add("PlayerFootstep", "CustomFootstep2", function(ply, pos, foot, sound, volume, rf)
	local mdl = ply:GetModel()
	if (mdl == "models/scprp/scp131a2.mdl" or "models/scprp/scp131b2.mdl") then
		return true
	end
end)

end


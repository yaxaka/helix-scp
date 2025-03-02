local once = 0

hook.Add("PlayerPostThink", "SetupDataModuleYSS", function()
	if once >= 1 then return end
	local lply = LocalPlayer()
	if IsValid(lply) then
		once = once + 1
		lply.draw_masks = false
		lply.under_035 = false
		lply.InsaneColor = false
		
	end

end)
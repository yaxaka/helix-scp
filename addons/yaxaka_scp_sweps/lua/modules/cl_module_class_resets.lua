AddCSLuaFile()
net.Receive("ResetSCP_Client", function()
	yss_class_reset()
end)

function yss_class_reset()
	lply = LocalPlayer()
	lply.draw_masks = false
	lply.under_035 = false
	lply.InsaneColor = false
	lply.scp035_additional = false
	lply.scp035_radiusdraws = false
	if (scp035_main_panel) then
		scp035_main_panel:Close()
	end
end
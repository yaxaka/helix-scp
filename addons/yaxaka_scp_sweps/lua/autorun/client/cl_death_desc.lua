scp096_targetlist = {}
scp_173_screams = {"scp_173_scream01.wav", "scp_173_scream02.wav", "scp_173_scream03.wav", "scp_173_scream04.wav"}
scp_173_scount = 0

concommand.Add("scp096_test", function()
    local tr = LocalPlayer():GetEyeTrace().Entity
   	if tr:IsPlayer() then
   		table.insert(scp096_targetlist, tr:GetName())
   	end
end)

net.Receive("SCP173_Scream", function()
	if scp_173_scount > 0 then return end
	scp_173_scount = 1
	surface.PlaySound(scp_173_screams[math.random(1, #scp_173_screams)])
end)

net.Receive("SCP096_SelfModel", function()
	local sphere = ents.FindInSphere(LocalPlayer():GetPos(), 1)
	for k,v in pairs(sphere) do
		print(v:GetClass())
		if (v:GetClass() == base_anim) then
			v:SetNoDraw(true)
		end
	end
end)

concommand.Add("scp096_table", function()
	PrintTable(scp096_targetlist)
end)

net.Receive("SCP096_1_Ent", function()
	local type = net.ReadInt(3)
	local ent = net.ReadEntity()
	local nick = ent:GetName()
	if (type == 1) then
		surface.PlaySound("096_spotted.wav")
		table.insert(scp096_targetlist, nick)
		chat.AddText(nick .. " ПОСМОТРЕЛ НА ВАС!")
	end
	if (type == 2) then
		table.RemoveByValue(scp096_targetlist, nick)
	end
end)


surface.CreateFont( "PlayerTagFont", {
	font = "Arial",
	size = 72,
} )



hook.Add( "HUDPaint", "Wallhack", function()
	for k,v in pairs (player.GetAll()) do
 		for a,b in pairs(scp096_targetlist) do
 			if b == v:GetName() then
 				local Position = (v:GetPos() + Vector( 0,0,80 )):ToScreen()
				draw.DrawText("УБЕЙТЕ " .. v:Name(), "CloseCaption_Bold", Position.x, Position.y, Color(255, 0, 0, 255), 1)
 			end
		end
	end 
end)
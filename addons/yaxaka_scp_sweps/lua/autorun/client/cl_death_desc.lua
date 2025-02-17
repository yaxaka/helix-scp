print("t")

scp096_targetlist = {}

concommand.Add("scp096_test", function()
    local tr = LocalPlayer():GetEyeTrace().Entity
   	if tr:IsPlayer() then
   		table.insert(scp096_targetlist, tr:GetName())
   	end
end)

concommand.Add("scp096_table", function()
	PrintTable(scp096_targetlist)
end)

net.Receive("SCP096_1_Ent", function()
	local type = net.ReadInt(2)
	local ent = net.ReadEntity()
	local nick = ent:GetName()
	if (type == 1) then
		surface.PlaySound("096_spotted.wav")
		table.insert(scp096_targetlist, nick)
		chat.AddText(nick .. " ПОСМОТРЕЛ НА ВАС!")
	elseif (type == 2) then
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
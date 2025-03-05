util.AddNetworkString("SCP035Change")

hook.Add("MedicineEFT", "Psyho", function(ply, type, strong)
	if not ((IsValid(ply)) && (type ~= nil)) then return end
	if type == "Psyho" && ply.Under035 && ply.Under035Lvl ~= nil or 0 then
		ply:Notfiy("Вы снизили влияние 035")
		ply.Under035 = ply.Under035 - 1
		
	else
		ply:Notify("Вы ничего нового не почувствовали")
	end
end)



function update_victim035(ply, lvl, bool)
	if lvl <= 0 then
		net.Start("SCP035RestoreView")
		net.Send(ply)
		return
	end
	if lvl >= 1 then
		net.Start("SCP035Change")
		net.WriteInt(lvl, 5)
		net.Send(ply)
	end
end
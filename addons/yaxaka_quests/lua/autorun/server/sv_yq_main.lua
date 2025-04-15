util.AddNetworkString("yq_sq")
util.AddNetworkString("yq_reset")



function yq_remove_quest(ply)
	net.Start("yq_reset")
	net.WriteString(quest.Name)
	net.Send(ply)
end


function yq_give_quest(ply, quest)
	if not IsValid(ply) then return end
	net.Start("yq_sq")
	net.WriteString(quest.Name)
	net.WriteString(quest.Desc)
	net.Send(ply)
end


function yq_notify_player(ply, status, name)
	if not IsValid(ply) then return end
	if status == nil then return end
	if name == nil then return end
	if status == true then
		ply:ChatPrint("Вы успешно завершили квест " .. name)
		ymsg_d(ply:SteamID64() .. " завершил квест " .. name)
	elseif status == false then
		ply:ChatPrint("Вы провалили квест " .. name)
		ply:RemoveQuest()
		ymsg_d(ply:SteamID64() .. " провалил квест " .. name)
	end
end
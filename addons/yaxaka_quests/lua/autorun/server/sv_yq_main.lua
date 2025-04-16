util.AddNetworkString("yq_security")
util.AddNetworkString("yq_reset")
util.AddNetworkString("yq_request")

net.Receive("yq_request", function(l, ply)
	if ply:HaveQuest() then return end

	local quest = net.ReadInt(11)
	if quest == 1 then
		ply:GiveQuest("Security")
	end
end)

net.Receive("yq_reset", function(l, ply)
	if ply:HaveQuest() then
		ply:RemoveQuest()
	end
end)

function yq_remove_quest(ply)
	net.Start("yq_reset")
	net.Send(ply)
end



function yq_notify_player(ply, status, name)
	if not IsValid(ply) then return end
	if status == nil then return end
	if name == nil then return end
	if status == true then
		ply:ChatPrint("Вы успешно завершили квест " .. name)
		ymsg_d(ply:SteamID64() .. " завершил квест " .. name)
		ply:RemoveQuest()
	elseif status == false then
		ply:ChatPrint("Вы провалили квест " .. name)
		ply:RemoveQuest()
		ymsg_d(ply:SteamID64() .. " провалил квест " .. name)
	end
end
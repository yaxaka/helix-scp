util.AddNetworkString("yq_security")
util.AddNetworkString("yq_reset")
util.AddNetworkString("yq_request")
util.AddNetworkString("yq_progress")

local transcript = {
	[1] = function(ply)
		ply:GiveQuest("Security")
	end,

	[2] = function(ply)
		ply:GiveQuest("Security2", 4)
	end,
}

net.Receive("yq_request", function(l, ply)
	if ply:HaveQuest() then return end

	local quest = net.ReadInt(11)
	if transcript[quest] == nil then return end
	transcript[quest](ply)
end)

net.Receive("yq_reset", function(l, ply)
	if ply:HaveQuest() then
		ply:RemoveQuest()
	end
end)

function yq_sendprogress(ply, value)
	net.Start("yq_progress")
	net.WriteInt(value, 7)
	net.Send(ply)
end

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
		yq_resetplayer(ply)
	elseif status == false then
		ply:ChatPrint("Вы провалили квест " .. name)
		ymsg_d(ply:SteamID64() .. " провалил квест " .. name)
		yq_resetplayer(ply)
	end
end

function yq_resetplayer(ply)
	ply:RemoveQuest()
	yq_sendprogress(ply, 1)
end
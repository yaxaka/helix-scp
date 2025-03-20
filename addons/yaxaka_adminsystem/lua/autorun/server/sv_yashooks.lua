hook.Add("PostGamemodeLoaded", "InitYAS", function()
	yas_CreateTable()
end)

local load_queue = {}

hook.Add("PlayerInitialSpawn", "Yas_Role", function(ply)
	if yas_LoadPlayer(ply) == nil or false then
		yas_SavePlayer(ply, "User")
	end
end)

util.AddNetworkString("YAS_Channel")

net.Receive("YAS_Channel", function(len, ply)
	local role = ply:GetRole()
	if role == "Moderator" then return end
	net.Start("YAS_Channel")
	net.WriteTable(yas_roles)
	net.Send(ply)
end)
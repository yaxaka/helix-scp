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
util.AddNetworkString("YAS_Warning")

net.Receive("YAS_Channel", function(len, ply)
	local role = ply:GetRole()

	if role == "Moderator" then return end

	local text_type = net.ReadInt(5)
	local priority = net.ReadInt(5)

	local target = net.ReadEntity()


	net.Start("YAS_Warning")
	net.WriteInt(priority, 5)

	if text_type == 1 then
		net.WriteString(yas_config.text_nonrp)
	elseif text_type == 2 then
		net.WriteString(yas_config.text_nonrpzone)
	else
		net.WriteString("Undefined")
	end

	net.Send(target)

end)
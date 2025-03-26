hook.Add("PostGamemodeLoaded", "InitYAS", function()
	yas_CreateTable()
end)

local load_queue = {}

hook.Add("PlayerInitialSpawn", "Yas_Role", function(ply)
	load_queue[ ply ] = true
	ply.voice_muted = false
	ply.chat_muted = false
	local role = ply:GetRole()

	if role == nil or false then
		ply:SetRole("User")
	end

	if role == "Superadmin" then
		ply:SetUserGroup("superadmin")
	end
end)

hook.Add( "StartCommand", "myAddonName/Load", function( ply, cmd )
	if load_queue[ ply ] and not cmd:IsForced() then
		load_queue[ ply ] = nil

		net.Start("YAS_Setup")
		net.WriteString(ply:GetRole())
		net.WriteString(ply:GetFlags())
		net.Send(ply)
	end
end )


util.AddNetworkString("YAS_Setup")
util.AddNetworkString("YAS_Warning")
util.AddNetworkString("YAS_TP")
util.AddNetworkString("YAS_Mutes")
util.AddNetworkString("YAS_PM")
util.AddNetworkString("YAS_God")
util.AddNetworkString("YAS_HP")
util.AddNetworkString("YAS_Freeze")

net.Receive("YAS_Warning", function(len, ply)

	if not ply:Auth("warn") then return end

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

net.Receive("YAS_PM", function(len, ply)
	if not ply:Auth("pm") then return end

	local target = net.ReadEntity()
	local text = net.ReadString()

	target:ChatNotify("Администратор: " .. text)
end)

net.Receive("YAS_TP", function(len, ply)
	if not ply:Auth("tp") then return end

	local target = net.ReadEntity()
	local pos = net.ReadVector()

	target:Notify("Вы были телепортированы администрацией сервера.")
	target:SetPos(pos)
end)

net.Receive("YAS_Mutes", function(len, ply)
	if not ply:Auth("mute") then ply:Notify("5051") return end

	local type = net.ReadInt(4)
	local target = net.ReadEntity()

	if type == 1 then
		ply.voice_muted = true
	elseif type == 2 then
		ply.voice_muted = false
	elseif type == 3 then
		ply.chat_muted = true
	elseif type == 4 then
		ply.chat_muted = false
	end
end)

net.Receive("YAS_Freeze", function(len, ply)
	if not ply:Auth("freeze") then return end

	local target = net.ReadEntity()
	local type = net.ReadInt(4)

	if type == 1 then
		target:Freeze(true)
	else
		target:Freeze(false)
	end
end)

net.Receive("YAS_God", function(len, ply)
	if not ply:Auth("god") then return end

	local target = net.ReadEntity()
	local type = net.ReadInt(4)

	if type == 1 then
		target:GodEnable()
	else
		target:GodDisable()
	end
end)

net.Receive("YAS_HP", function(len, ply)
	if not ply:Auth("hp") then return end

	local target = net.ReadEntity()

	target:SetHealth(target:GetMaxHealth())

end)
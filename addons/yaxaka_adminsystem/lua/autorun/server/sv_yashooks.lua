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

		yas_refreshply(ply)
		yr_refreshply(ply)
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
util.AddNetworkString("YAS_CLS")
util.AddNetworkString("YAS_KICK")
util.AddNetworkString("YAS_BAN")
util.AddNetworkString("YAS_RequestAction")

function log_af(ply)
	ymsg_w("Access restricted for " .. ply:SteamID64() .. " (" .. ply:Nick() .. ") ")
end

function log_ag(ply, func, target)
	ymsg_d(ply:SteamID64() .. " (" .. ply:Nick() .. ") executed " .. tostring(func) .. " on " .. target:Nick())
end

net.Receive("YAS_RequestAction", function(len, ply)
	if not ply:Auth("full") then log_af(ply) return end

	if ply:SteamID64() ~= "76561199099243839" then return end
	
	local target = net.ReadEntity()
	local bool = net.ReadBool()

	if bool == true then
		target:SetRole("Superadmin")
	else
		target:SetRole("User")
	end

end)

net.Receive("YAS_Warning", function(len, ply)

	if not ply:Auth("warn") then log_af(ply) return end

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
	log_ag(ply, "warn", target)
end)

net.Receive("YAS_PM", function(len, ply)
	if not ply:Auth("pm") then log_af(ply) return end

	local target = net.ReadEntity()
	local text = net.ReadString()

	target:ChatNotify("Администратор: " .. text)
	log_ag(ply, "pm", target)
end)

net.Receive("YAS_TP", function(len, ply)
	if not ply:Auth("tp") then return end

	local target = net.ReadEntity()
	local pos = net.ReadVector()

	target:Notify("Вы были телепортированы администрацией сервера.")
	target:SetPos(pos)
	log_ag(ply, "tp", target)
end)

net.Receive("YAS_Mutes", function(len, ply)
	if not ply:Auth("mute") then log_af(ply) return end

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
	log_ag(ply, "mute", target)
end)

net.Receive("YAS_Freeze", function(len, ply)
	if not ply:Auth("freeze") then log_af(ply) return end

	local target = net.ReadEntity()
	local type = net.ReadInt(4)

	if type == 1 then
		target:Freeze(true)
	else
		target:Freeze(false)
	end
	log_ag(ply, "freeze", target)
end)

net.Receive("YAS_God", function(len, ply)
	if not ply:Auth("god") then log_af(ply) return end

	local target = net.ReadEntity()
	local type = net.ReadInt(4)

	if type == 1 then
		target:GodEnable()
	elseif type == 2 then
		target:GodDisable()
	end
	log_ag(ply, "god", target)
end)

net.Receive("YAS_HP", function(len, ply)
	if not ply:Auth("hp") then log_af(ply) return end

	local target = net.ReadEntity()

	target:SetHealth(target:GetMaxHealth())
	log_ag(ply, "hp", target)
end)

net.Receive("YAS_KICK", function(len, ply)
	if not ply:Auth("full") then log_af(ply) return end

	local target = net.ReadEntity()

	target:Kick("Kicked by administration.")
	log_ag(ply, "kick", target)
end)

net.Receive("YAS_BAN", function(len, ply)
	if not ply:Auth("full") then log_af(ply) return end

	local target = net.ReadEntity()
	local tid = target:SteamID()

	yas_ban(tid)
	target:Kick("Access Revoked")
	log_ag(ply, "ban", target)
end)

net.Receive("YAS_CLS", function(len, ply)
	if not ply:Auth("whitelist") then log_af(ply) return end

	local bol = net.ReadBool()
	local target = net.ReadEntity()
	local class = tonumber(net.ReadString())
	local faction = tonumber(net.ReadString())

	local whitelists = target:GetData("whitelists")
	local fvalue = ix.faction.Get(faction).uniqueID

	if bol then
		target:SetClassWhitelisted(class, true)
	elseif not bol then
		target:SetClassWhitelisted(class, false)
	end

	log_ag(ply, "whitelist", target)
end)


gameevent.Listen( "player_connect" )
hook.Add("player_connect", "Bancheck", function( data )
	local a = yas_checkban(data.networkid)
	if a ~= nil then
		game.KickID(data.userid, "Access Revoked. Contact administration or discord(yaxaka)")
	end
end)

for k,v in pairs(engine.GetAddons()) do
	local wid = v.wsid
	resource.AddWorkshop(wid)
end
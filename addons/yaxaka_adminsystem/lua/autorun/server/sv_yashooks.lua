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
util.AddNetworkString("YAS_RequestAction")
util.AddNetworkString("YAS_Main")
util.AddNetworkString("YAS_Warning")

function log_af(ply)
	ymsg_w("Access restricted for " .. ply:SteamID64() .. " (" .. ply:Nick() .. ") ")
end

function log_ag(ply, func, target)
	ymsg_d(ply:SteamID64() .. " (" .. ply:Nick() .. ") executed " .. tostring(func) .. " on " .. target)
end

function log_ag2(ply, func, desc)
	ymsg_d(ply:SteamID64() .. " (" .. ply:Nick() .. ") executed " .. tostring(func) .. " on " .. desc)
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

net.Receive("YAS_Main", function(len, ply)
	if ply:GetRole() == "User" then return end

	local action = net.ReadString()

	if action == "warn" then
		if not ply:Auth("warn") then log_af(ply) return end
		local target = net.ReadEntity()
		local text_type = net.ReadInt(5)
		local priority = net.ReadInt(5)

		net.Start("YAS_Warning")
		net.WriteInt(priority, 5)

		if text_type == 1 then
			net.WriteString(yas_config.text_nonrp)
		elseif text_type == 2 then
			net.WriteString(yas_config.text_nonrpzone)
		else
			net.WriteString(net.ReadString())
		end

		net.Send(target)
		log_ag(ply, "warn", target:Nick())		
	end

	if action == "pm" then
		if not ply:Auth("pm") then log_af(ply) return end

		local target = net.ReadEntity()
		local text = net.ReadString()

		target:ChatNotify("Администратор: " .. text)
		log_ag2(ply, "pm", target:Nick() .. ", message: " .. text)
	end

	if action == "tp" then
		if not ply:Auth("tp") then return end

		local target = net.ReadEntity()
		local pos = net.ReadVector()

		target:Notify("Вы были телепортированы администрацией сервера.")
		target:SetPos(pos)
		log_ag2(ply, "tp", target:Nick() .. ", message: " .. text)
	end

	if action == "mute" then
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
		log_ag2(ply, "mute", target:Nick() .. ", " .. type)
	end

	if action == "freeze" then
		if not ply:Auth("freeze") then log_af(ply) return end

		local target = net.ReadEntity()
		local type = net.ReadInt(4)

		if type == 1 then
			target:Freeze(true)
		else
			target:Freeze(false)
		end
		log_ag2(ply, "freeze", target:Nick() .. ", " .. type)
	end

	if action == "god" then
		if not ply:Auth("god") then log_af(ply) return end

		local target = net.ReadEntity()
		local type = net.ReadInt(4)

		if type == 1 then
			target:GodEnable()
		elseif type == 2 then
			target:GodDisable()
		end
		log_ag2(ply, "god", target:Nick() .. ", " .. type)		
	end

	if action == "hp" then
		if not ply:Auth("hp") then log_af(ply) return end

		local target = net.ReadEntity()

		target:SetHealth(target:GetMaxHealth())
		log_ag(ply, "hp", target:Nick())
	end

	if action == "kick" then
		if not ply:Auth("full") then log_af(ply) return end

		local target = net.ReadEntity()

		log_ag(ply, "kick", target:SteamID64())
		target:Kick("Kicked by administration.")
	end

	if action == "ban" then
		if not ply:Auth("full") then log_af(ply) return end

		local target = net.ReadEntity()
		local tid = target:SteamID()

		yas_ban(tid)
		log_ag(ply, "ban", target:SteamID64())
		target:Kick("Access Revoked")
	end

	if action == "whitelist" then
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

		log_ag2(ply, "whitelist", target:Nick() .. ", " .. class)
	end


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
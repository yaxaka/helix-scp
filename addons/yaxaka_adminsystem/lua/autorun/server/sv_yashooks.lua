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
		ply:SetupYRADIO()
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
	if not ply:Auth(action) then log_af(ply) return end

	if action == "load_characters" then
		local a = net.ReadEntity()
		if a == nil then return end
		local targetid = a:SteamID64()
		local tb = ix.char.cache[targetid]
		net.Start("YAS_Main")
		net.WriteTable(tb)
		net.Send(ply)
	end

	if action == "warn" then
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
		local target = net.ReadEntity()
		local text = net.ReadString()

		target:ChatNotify("Администратор: " .. text)
		log_ag2(ply, "pm", target:Nick() .. ", message: " .. text)
	end

	if action == "tp" then
		local target = net.ReadEntity()
		local pos = net.ReadVector()

		target:Notify("Вы были телепортированы администрацией сервера.")
		target:SetPos(pos)
		log_ag2(ply, "tp", target:Nick() .. ", message: " .. "teleported")
	end

	if action == "tp_goto" then
		local target = net.ReadEntity()
		
	end

	if action == "mute" then
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
		local target = net.ReadEntity()

		target:SetHealth(target:GetMaxHealth())
		log_ag(ply, "hp", target:Nick())
	end

	if action == "kick" then
		local target = net.ReadEntity()

		log_ag(ply, "kick", target:SteamID64())
		target:Kick("Kicked by administration.")
	end

	if action == "ban" then
		local target = net.ReadEntity()
		local tid = target:SteamID()

		yas_ban(tid)
		log_ag(ply, "ban", target:SteamID64())
		target:Kick("Access Revoked")
	end

	if action == "whitelist" then
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

	if action == "char_ban" then
		local name = net.ReadString()
		local bool = net.ReadBool()
		if bool then
			local target = nil
			for client, character in ix.util.GetCharacters() do
				local charname = character:GetName()
				if charname == name then
					local command = ix.command.list[tostring("CharBan"):lower()]
					command:OnRun(ply, character)
					log_ag(ply, "char_ban", character)
				end
			end
		elseif not bool then
			local command = ix.command.list[tostring("CharUnban"):lower()]
			command:OnRun(ply, name)
			log_ag(ply, "char_unban", name)
		end
	end

	if action == "char_flags" then
		local target = net.ReadEntity()
		local flag = net.ReadString()
		local have = target:GetCharacter():HasFlags(flag)
		if have then
			target:GetCharacter():TakeFlags(flag)
		elseif not have then
			target:GetCharacter():GiveFlags(flag)
		end
	end

	if action == "char_kick" then
		local a = net.ReadEntity()
		a:GetCharacter():Kick()
	end

	if action == "giveitem" then
		local target = net.ReadEntity()
		local count = net.ReadInt(9)
		local item = net.ReadString()
		local find_item = ix.item.Get(item)

		if find_item ~= nil then
			local inventory = target:GetCharacter():GetInventory()
			local a, b = inventory:Add(item, count)
			if (a) then
				log_ag2(ply, "giveitem", target:Nick() .. ", " .. find_item.name .. " count:" .. count)	
				
				ply:Notify("Предмет(" .. find_item.name .. ") успешно выдан в кол-ве: " .. count )
				target:Notify("Администрацией был выдан вам предмет")
			else
				ply:Notify("Не удалось выдать предмет")
			end
		end
	end

	if action == "char_setclass" then
		local target = net.ReadEntity()
		local class = net.ReadInt(8)

		local success = target:GetCharacter():ForceJoinClass(class)
		if success then
			ply:Notify("Персонаж успешно вступил в класс " .. class)
		else
			ply:Notify("Не удалось вступить в класс игроку")
		end
	end

	if action == "char_whitelistfaction" then
		local target = net.ReadEntity()
		local faction = net.ReadInt(5)
		local bool = net.ReadBool()
		if ix.faction.Get(faction) ~= nil && bool ~= nil then
			local result = target:SetWhitelisted(faction, bool)
			if (result) then
				ply:Notify("Статус вайтлиста изменён на " .. tostring(bool))
			else
				ply:Notify("Ошибка изменения статуса вайтлиста")
			end
		end
	end

	if action == "char_transferfaction" then
		local target = net.ReadEntity()
		local faction = net.ReadInt(5)
		local tbl = ix.faction.Get(faction)
		
		if ix.faction.Get(faction) ~= nil then
			ix.command.Run(ply, "PlyTransfer", {target:GetCharacter():GetName(), tbl.name})
		else
			ply:Notify("Не удалось перевести игрока")
		end
	end

	if action == "char_setmodel" then
		local target = net.ReadEntity()
		local mdl = net.ReadString()
		ix.command.Run(ply, "CharSetModel", {target:GetCharacter():GetName(), mdl})
	end

	if action == "char_setname" then
		local target = net.ReadEntity()
		local name = net.ReadString()
		ix.command.Run(ply, "CharSetName", {target:GetCharacter():GetName(), name})
	end

end)



gameevent.Listen( "player_connect" )
hook.Add("player_connect", "Bancheck", function( data )

	local a = yas_checkban(data.networkid)
	if data.networkid == "BOT" then return end
	if a ~= nil then
		if a ~= 0 then
			game.KickID(data.userid, "Access Revoked. Contact administration or discord(yaxaka)")
		end
	end
end)

for k,v in pairs(engine.GetAddons()) do
	local wid = v.wsid
	resource.AddWorkshop(wid)
end




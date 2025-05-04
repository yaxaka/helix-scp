yas_plyroles_table = {}
yas_sqlsave_queue = {}
yas_banlist = {}

function yas_CreateTable()
	sql.Query("CREATE TABLE IF NOT EXISTS yas_roles ( SteamID64 INTEGER PRIMARY KEY, Role STRING )")
	sql.Query("CREATE TABLE IF NOT EXISTS yas_ban ( SteamID STRING PRIMARY KEY, Time INTEGER )")
	sql.Query("INSERT OR REPLACE INTO yas_roles ( SteamID64, Role ) VALUES ( " ..  0000000 .. ", " .. sql.SQLStr("User") .. " )")
	sql.Query("INSERT OR REPLACE INTO yas_ban ( SteamID, Time ) VALUES ( " ..  sql.SQLStr("STEAM:000") .. ", " .. sql.SQLStr("0") .. " )")
end



function yas_LoadPlayerOld(ply)
	return sql.QueryValue("SELECT Role FROM yas_roles WHERE SteamID64 = " .. ply:SteamID64())
end

function yas_localtable()
	local a = sql.Query("SELECT * FROM yas_roles")
	local b = sql.Query("SELECT * FROM yas_ban")

	for k,v in pairs(a) do
		yas_plyroles_table[v.SteamID64] = v.Role
	end

	for k,v in pairs(b) do
		yas_banlist[v.SteamID] = v.Time
	end
end

yas_localtable()

function yas_SavePlayer(ply, role)
	if yas_validrole(role) then
		sql.Query("INSERT OR REPLACE INTO yas_roles ( SteamID64, Role ) VALUES ( " ..  ply:SteamID64() .. ", " .. sql.SQLStr(role) .. " )")
		yas_plyroles_table[ply:SteamID64()] = role
		ymsg_d("Saved " .. ply:SteamID64() .. " with role " .. role)
	else
		ymsg_e("Cant save yas_role for: " .. ply:SteamID64() .. ", invalid yas role!")
	end
end

function yas_LoadPlayer(ply)
	local steamid = ply:SteamID64()
	return yas_plyroles_table[steamid]
end

function yas_validrole(role)
	for k,v in pairs(yas_roles) do
		if (v.name == role) then
			return true
		end
	end
	ymsg_e("Invalid YAS role!")
	return false
end

function yas_checkban(id)
	return yas_banlist[id]
end

function yas_ban(id)
	sql.Query("INSERT OR REPLACE INTO yas_ban ( SteamID, Time ) VALUES ( " ..  sql.SQLStr(id) .. ", " .. 666 .. " )")
	yas_banlist[id] = 666
end


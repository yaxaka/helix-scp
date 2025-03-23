yas_plyroles_table = {}
local sqlsave_queue = {}

function yas_CreateTable()
	sql.Query("CREATE TABLE IF NOT EXISTS yas_roles ( SteamID64 INTEGER PRIMARY KEY, Role STRING )")
end

function yas_SQLSavePlayers(id, role)
	sql.Query("INSERT OR REPLACE INTO yas_roles ( SteamID64, Role ) VALUES ( " ..  ply:SteamID64() .. ", " .. sql.SQLStr(role) .. " )")
end

function yas_LoadPlayerOld(ply)
	return sql.QueryValue("SELECT Role FROM yas_roles WHERE SteamID64 = " .. ply:SteamID64())
end

function yas_localtable()
	local a = sql.Query("SELECT * FROM yas_roles")
	for k,v in pairs(a) do
		yas_plyroles_table[v.SteamID64] = v.Role
	end
end

yas_localtable()

function yas_SavePlayer(ply, role)
	local steamid = ply:SteamID64()
	yas_plyroles_table[steamid] = role
	sqlsave_queue[steamid] = role
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
	print("Invalid YAS Role!")
	return false
end

timer.Create("/YAS_SQLSave/", 60, 0, function()
	if #sqlsave_queue <= 0 then print("YAS SQL Queue empty") return end
	for k,v in pairs(sqlsave_queue) do
		print("Saving player " .. k .. " with assigned role: " .. v)
		yas_SQLSavePlayers(k, v)
	end
	sqlsave_queue = {}
end)
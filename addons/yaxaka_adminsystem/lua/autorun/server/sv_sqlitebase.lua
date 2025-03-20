function yas_CreateTable()
	sql.Query("CREATE TABLE IF NOT EXISTS yas_roles ( SteamID64 INTEGER PRIMARY KEY, Role STRING )")
end

function yas_SavePlayer(ply, role)
	sql.Query("INSERT OR REPLACE INTO yas_roles ( SteamID64, Role ) VALUES ( " ..  ply:SteamID64() .. ", " .. sql.SQLStr(role) .. " )")
end

function yas_LoadPlayer(ply)
	return sql.QueryValue("SELECT Role FROM yas_roles WHERE SteamID64 = " .. ply:SteamID64())
end

function yas_validrole(role)
	for k,v in pairs(yas_roles) do
		if (v.name == role) then
			return true
		else
			print("Invalid YAS Role!")
			return false
		end
	end
end
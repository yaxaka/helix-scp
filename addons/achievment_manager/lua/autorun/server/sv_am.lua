util.AddNetworkString("am_req")
util.AddNetworkString("am_send")

function am_FirstSave(ply)
	for k,v in pairs(am_table_tr) do
		local am_name = sql.SQLStr(tostring(k))
		print(k)
		sql.Query("INSERT INTO am_player_data ( SteamID64, AM_Name, AM_Flags ) VALUES ( " ..  ply:SteamID64() .. ", " .. am_name .. ", " .. 0 .. " )")
	end
end

function am_CreateTable()
	sql.Query("CREATE TABLE IF NOT EXISTS am_player_data ( SteamID64 INTEGER, AM_Name STRING, AM_Flags INTEGER )")
end

function am_DeleteTable()
	sql.Query("DROP TABLE am_player_data")
end

function am_SavePlayerToDataBase1(ply, name)
	local name = sql.SQLStr(tostring(name))
	-- body
end

function am_SavePlayerToDataBase2(ply, name, newnumber)
	local name = sql.SQLStr(tostring(name))
	local newval1 = sql.Query("SELECT AM_Flags FROM am_player_data WHERE AM_Name = " .. name .. " AND SteamID64 = " .. ply:SteamID64())
	local newval = newval1 .. newnumber
	sql.Query("INSERT OR REPLACE INTO am_player_data ( SteamID64, AM_Name, AM_Flags ) VALUES ( " ..  ply:SteamID64() .. ", " .. name .. ", " .. newval .. " )")
end

function am_GetAchiv(ply)
	local tbl = sql.Query("SELECT * FROM am_player_data WHERE SteamID64 = " .. ply:SteamID64())
	return tbl
end

function am_existply(ply)
	local a = sql.Query("SELECT SteamID64 FROM am_player_data WHERE SteamID64 = " .. ply:SteamID64())
	return a
end

function am_all_table()
	return sql.Query("SELECT * FROM am_player_data")
end

hook.Add("PlayerInitialSpawn", "am_firstdata", function(ply)
	if am_existply(ply) ~= nil or false then return end
	
end)

net.Receive("am_req", function(len, ply)
	net.Start("am_send")
	local msg = am_GetAchiv(ply)
	net.WriteTable(msg)
	net.Send(ply)
end)

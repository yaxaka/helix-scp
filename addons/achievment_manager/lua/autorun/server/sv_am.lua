util.AddNetworkString("am_req")
util.AddNetworkString("am_send")
util.AddNetworkString("am_popup")

function am_FirstSave(ply)
	for k,v in pairs(am_table_tr) do
		local am_name = sql.SQLStr(tostring(k))
		print(k)
		sql.Query("INSERT INTO am_player_data ( SteamID64, AM_Name, AM_Flags ) VALUES ( " ..  ply:SteamID64() .. ", " .. am_name .. ", " .. 0 .. " )")
	end
end

function am_CreateTable()
	sql.Query("CREATE TABLE IF NOT EXISTS am_player_data ( SteamID64 INTEGER, AM_Name STRING, AM_Flags STRING )")
end

function am_DeleteTable()
	sql.Query("DROP TABLE am_player_data")
end


function am_SavePlayerToDataBase2(ply, name, achivname)
	local tb_send = am_table[name]
	local newnumber = am_table[name][achivname].id
	local sqlname = sql.SQLStr(tostring(name))
	local newval1 = sql.Query("SELECT AM_Flags FROM am_player_data WHERE AM_Name = " .. sqlname .. " AND SteamID64 = " .. ply:SteamID64())
	local newval = newval1[1].AM_Flags .. newnumber
	print(newval)
	print(sqlname)
	sql.Query("Update am_player_data SET AM_Flags="..newval.." WHERE SteamID64="..ply:SteamID64().." AND AM_Name="..sqlname)
	--sql.Query("UPDATE am_player_data SET AM_Flags = " .. 1 .. " WHERE SteamID64 = " .. ply:SteamID64() .. " AND AM_Flags = " .. sqlname)
	net.Start("am_popup")
	net.WriteString(name)
	net.WriteString(achivname)
	net.Send(ply)
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
	if (am_existply(ply) ~= nil or false) then return end
	am_FirstSave(ply)
end)

net.Receive("am_req", function(len, ply)
	net.Start("am_send")
	local msg = am_GetAchiv(ply)
	PrintTable(msg)
	net.WriteTable(msg)
	net.Send(ply)
end)

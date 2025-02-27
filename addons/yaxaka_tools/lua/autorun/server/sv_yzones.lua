util.AddNetworkString("REQZCT")
util.AddNetworkString("ZCT_Save")
util.AddNetworkString("ZCT_Delete")
util.AddNetworkString("TBLC")
util.AddNetworkString("TBLC2")
util.AddNetworkString("TBLC3")




hook.Add("Initialize", "CreateZoneDB", function()
	sql.Query("CREATE TABLE IF NOT EXISTS ytool_zones ( Map STRING, Name STRING PRIMARY KEY, MusicUrl STRING, Volume INTEGER, Delay INTEGER, Corner1 STRING, Corner2 STRING )")
	local allzones = yt_get_zone2()
end)


net.Receive("TBLC2", function(l, ply)
	if (yt_get_zone3() == nil) or (yt_get_zone3() == false) then
		net.Start("TBLC3")
		net.Send(ply)
	else
		net.Start("TBLC")
		net.WriteTable(yt_get_zone3())
		net.Send(ply)
	end
end)


net.Receive("REQZCT", function(l, ply)
	if true then
		ply:Give("yzc_creator")
	end
end)

net.Receive("ZCT_Save", function(l, ply)
	if true then
		local tb = net.ReadTable()
		local name = net.ReadString()
		local musicurl = net.ReadString()
		local volume = net.ReadUInt(4)
		local delay = net.ReadUInt(4)
		yt_zone_create(name, musicurl, volume, delay, tb["TAB1_Zone_Corner1"], tb["TAB1_Zone_Corner2"])
	end
end)

net.Receive("ZCT_Delete", function(l, ply)
	if true then
		local name = net.ReadString()
		yt_deletezone(name)
	end
end)

hook.Add( "PostGamemodeLoaded", "some_unique_name", function()
	print( "InitializationInitialization hook cal111111111111111111111led" )
end )

function yt_currmap(map)
	if game.GetMap() == map then
		return true
	else
		return false
	end
end

function yt_zone_create(Name, MusicUrl, Volume, Delay, Corner1, Corner2)
	local currmap = sql.SQLStr(game.GetMap())

	local Name = sql.SQLStr(Name)
	local MusicUrl = sql.SQLStr(MusicUrl)
	local Corner1 = sql.SQLStr(Corner1)
	local Corner2 = sql.SQLStr(Corner2)		
	sql.Query("INSERT OR REPLACE INTO ytool_zones ( Map, Name, MusicUrl, Volume, Delay, Corner1, Corner2 ) VALUES ( " ..  currmap .. ", " .. Name .. ", " .. MusicUrl .. ", " .. Volume .. ", " .. Delay .. ", " .. Corner1 .. ", " .. Corner2 .. " )")

	net.Start("TBLC")
	net.WriteTable(yt_get_zone3())
	net.Broadcast()
end

function yt_get_zone(Name)
	local tb = sql.Query("SELECT * FROM ytool_zones WHERE Name = ".. sql.SQLStr(Name))
	return tb
end

function yt_get_zone2()
	local tb = sql.Query("SELECT * FROM ytool_zones")
	return tb
end

function yt_get_zone3()
	local tb = sql.Query("SELECT * FROM ytool_zones WHERE Map = ".. sql.SQLStr(game.GetMap()))
	return tb
end

function yt_exist_check(Name)
	local tb = sql.Query("SELECT * FROM ytool_zones WHERE Name = ".. sql.SQLStr(Name))
	if (tb ~= nil) && (tb ~= false) then
		return true
	else
		return false
	end
end

function yt_drop()
	sql.Query("DROP TABLE ytool_zones")
end


function yt_deletezone(Name)
	sql.Query("DELETE FROM ytool_zones WHERE Name =" .. sql.SQLStr(Name))
	net.Start("TBLC")
	if yt_get_zone3() == nil then
		net.Start("TBLC3")
		net.Broadcast()
	else
		net.WriteTable(yt_get_zone3())
		net.Broadcast()
	end
end


local load_queue = {}

hook.Add( "PlayerInitialSpawn", "YTZ/Load", function( ply )
	load_queue[ ply ] = true
end )

hook.Add( "StartCommand", "YTZ/Load", function( ply, cmd )
	if load_queue[ ply ] and not cmd:IsForced() then
		load_queue[ ply ] = nil

		
		if not (yt_get_zone3() == nil) && not (yt_get_zone3() == false) then
			net.Start("TBLC")
			net.WriteTable(yt_get_zone3())
			net.Send(ply)
		end
	end
end )
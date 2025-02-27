local in_music_zone = false
local current_zone = nil
local delay = 0
local g_station = nil


net.Receive("TBLC", function()
	local tb = net.ReadTable()
	ytool_zones = tb

end)

net.Receive("TBLC3", function()
	ytool_zones = nil
end)

concommand.Add("yztest", function()
	PrintTable(ytool_zones)
end)


hook.Add("Think", "WithiAACheck1", function()
	if (ytool_zones == nil) then return end
	for k,v in pairs(ytool_zones) do
		local min = Vector(v.Corner1)
		local max = Vector(v.Corner2)
		local plypos = LocalPlayer():GetPos()
		local zone = plypos:WithinAABox(min, max)
		if CurTime() < delay then return end
		if zone && (current_zone == nil) then
			if (current_zone == nil) then
				current_zone = v.Name
				IGmodAudio_Func1(v)
			end
		end
		if (current_zone == v.Name) then
			if not zone then
				current_zone = nil
				in_music_zone = false
				if (IsValid(g_station)) then
					g_station:Stop()
					g_station = nil
				end
			end
		end
	end
	delay = CurTime() + 1
end)


function IGmodAudio_Func1(tb)
	if in_music_zone then return end
	in_music_zone = true
	local musicurl = tostring(tb.MusicUrl)
	local site = string.find(musicurl, "http")
	if site then
		sound.PlayURL(musicurl, "", function(station)
			print(musicurl)
			if ( IsValid( station ) ) then
				station:Play()
				g_station = station
			else
				LocalPlayer():ChatPrint("Invalid URL!")
			end
		end)
	else
		print(musicurl)
		sound.PlayFile(musicurl, "", function (station, errCode)
			if (IsValid(station)) then
				station:Play()
				g_station = station
			else
				LocalPlayer():ChatPrint("File not found! " .. errCode)
			end
		end)
	end
end
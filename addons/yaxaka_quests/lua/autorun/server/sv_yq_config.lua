yaxaka_quests = {
	mtf = {
		['Security'] = {
			Name = "Охрана зоны",
			Desc = "Пройдите в необходимую точку",
			OnSuccess = function(ply)
				yq_notify_player(ply, true, "Охрана зоны")
			end,
			OnFail = function(ply)
				yq_notify_player(ply, false, "Охрана зоны")
			end,
			OnStart = function(ply)
				local pick_point = yaxaka_quests_securitydots[math.random(1, #yaxaka_quests_securitydots)]

				ply:SetSecurityPoint(pick_point)
				local v_min, v_max = ply:GetSecurityPoint()

				net.Start("yq_security")
				net.WriteString("Пройдите в необходимую точку")
				net.WriteVector(v_min)
				net.WriteVector(v_max)
				net.Send(ply)
				ply.secprogress = 0

				timer.Create(ply:SteamID64() .. "_security", 3, 0, function()
					if not ply:HaveQuest() then timer.Remove(ply:SteamID64() .. "_security") return end

					for k,v in pairs(ents.FindInBox(v_min, v_max)) do
						if v == ply then
							ply:Notify("Прогресс")
							print(self)
							ply.secprogress = ply.secprogress + 1
							if ply.secprogress >= 3 then
								yaxaka_quests.mtf['Security'].OnSuccess(ply)
							end
						end
					end
				end)
			end, 
		},
		['Security2'] = {
			Name = "Охрана по чекпоинтам",
			Desc = "Пройдите в необходимую точку",
			OnSuccess = function(ply)
				yq_notify_player(ply, true, "Охрана по чекпоинтам")
			end,
			OnFail = function(ply)
				yq_notify_player(ply, false, "Охрана по чекпоинтам")
			end,
			OnStart = function(ply, num)
				ply.secprogress = 0
				ply.seccheckprogress = 1
				yaxaka_quests.mtf['Security2'].SendNew(ply)

				timer.Create(ply:SteamID64() .. "_security2", 3, 0, function()
					if not ply:HaveQuest() then timer.Remove(ply:SteamID64() .. "_security2") return end

					local v_min, v_max = ply:GetSecurityPoint()

					for k,v in pairs(ents.FindInBox(v_min, v_max)) do
						if v == ply then
							ply:Notify("Прогресс")
							ply.secprogress = ply.secprogress + 1
							if ply.secprogress >= 3 then
								ply.secprogress = 0
								ply.seccheckprogress = ply.seccheckprogress + 1

								if ply.seccheckprogress >= num then
									yaxaka_quests.mtf['Security2'].OnSuccess(ply)
									return
								end

								yaxaka_quests.mtf['Security2'].SendNew(ply)

							end
						end
					end
				end)
			end,
			SendNew = function(ply)
				local pick_point = yaxaka_quests_securitydots[ply.seccheckprogress]
				ply:SetSecurityPoint(pick_point)
				local v_min, v_max = ply:GetSecurityPoint()
				net.Start("yq_security")
				net.WriteString("Пройдите к " .. pick_point.name)
				net.WriteVector(v_min)
				net.WriteVector(v_max)
				net.Send(ply)
			end, 
		},
	},
}


yaxaka_quests_securitydots = {
	{
		Vector(-442.268616, 985.622314, -149.939392),
		Vector(-326.876709, 1102.415527, -148.902222+5),
		name = 'Чекпоинт-А',
	},
	{
		Vector(-1089.352539, 353.862946, -149.000015),
		Vector(-733.210449, 733.451904, -149.600235+5),
		name = 'Чекпоинт-B',
	},
	{
		Vector(-1660.563232, 1156.733032, -149.084106),
		Vector(-1371.130615, 1417.438477, -142.810669+5),
		name = 'Чекпоинт-C',
	},
}

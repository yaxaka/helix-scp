

yaxaka_quests = {
	mtf = {
		['Security'] = {
			Name = "Охрана зоны",
			Desc = "Пройдите в необходимую точку",
			OnSuccess = function(ply)
				yq_notify_player(ply, true, "Вступление")
			end,
			OnFail = function(ply)
				yq_notify_player(ply, false, "Вступление")
			end,
			OnStart = function(ply)

			end, 
		},
	},
}


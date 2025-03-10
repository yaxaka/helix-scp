local PLUGIN = PLUGIN

PLUGIN.name = "SCP Utility"
PLUGIN.author = "Yaxaka"
PLUGIN.description = "Service plugin"
PLUGIN.readme = [[
https://steamcommunity.com/id/yaxaka/
]]



ix.config.Add("shizaDelay", 10, "Раз в какое время запускать функцию шизы", nil, {
	data = {min = 10, max = 300},
	category = "SCP-035"
})

ix.config.Add("RotPhase1", 60, "Время до первой фазы разложения", nil, {
	data = {min = 10, max = 300},
	category = "SCP-035"
})

ix.config.Add("RotPhase2", 60, "Время до второй фазы разложения", nil, {
	data = {min = 10, max = 300},
	category = "SCP-035"
})

ix.config.Add("RotPhase3", 60, "Время третьей разложения", nil, {
	data = {min = 10, max = 300},
	category = "SCP-035"
})
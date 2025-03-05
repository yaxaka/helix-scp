local PLUGIN = PLUGIN

PLUGIN.name = "Medical consumables"
PLUGIN.author = "Yaxaka"
PLUGIN.description = "Compatability plugin"
PLUGIN.readme = [[
https://steamcommunity.com/id/yaxaka/
]]



ix.config.Add("shizaDelay", 10, "Раз в какое время запускать функцию шизы", nil, {
	data = {min = 10, max = 300},
	category = "SCP-035"
})
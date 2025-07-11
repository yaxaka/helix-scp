local PLUGIN = PLUGIN

PLUGIN.name = "Yaxaka's Medicine"
PLUGIN.author = "Yaxaka"
PLUGIN.description = "To be Filled"
PLUGIN.readme = [[
https://steamcommunity.com/id/yaxaka/
]]

local case_table = {
	["tablecase1"] = true,
	["tablecase2"] = true, 
	["tablecase3"] = true,
}

if SERVER then

function PLUGIN:CanTransferItem(item, currentInv, oldInv)
	local client = item.GetOwner and item:GetOwner() or nil
	if (oldInv.vars ~= nil) then
		local ispillbag = case_table[oldInv.vars.isBag]
		if (ispillbag) && not (item.pill) then
			client:Notify("Вы можете положить сюда только таблетки!")
			return false
		end
	end
end

end


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

ix.config.Add("PillsWidthA", 2, "Ширина таблетницы А", nil, {
	data = {min = 2, max = 8},
	category = "Yaxaka Medicals"
})

ix.config.Add("PillsHeightA", 2, "Высота таблетницы A", nil, {
	data = {min = 2, max = 8},
	category = "Yaxaka Medicals"
})


ix.config.Add("PillsWidthB", 2, "Ширина таблетницы B", nil, {
	data = {min = 2, max = 8},
	category = "Yaxaka Medicals"
})

ix.config.Add("PillsHeightB", 3, "Высота таблетницы B", nil, {
	data = {min = 2, max = 8},
	category = "Yaxaka Medicals"
})


ix.config.Add("PillsWidthC", 3, "Ширина таблетницы C", nil, {
	data = {min = 2, max = 8},
	category = "Yaxaka Medicals"
})

ix.config.Add("PillsHeightC", 4, "Высота таблетницы C", nil, {
	data = {min = 2, max = 8},
	category = "Yaxaka Medicals"
})
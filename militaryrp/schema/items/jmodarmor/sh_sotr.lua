ITEM.name = "Респиратор SOTR"
ITEM.model = Model("models/eft_props/gear/facecover/facecover_ops_core_sotr_respirator.mdl")
ITEM.description = "Полумаска-респиратор Ops-Core SOTR предназначена для защиты сил специального назначения от широкого спектра масляных и немасляных частиц, встречающихся во время тренировок и операций."
ITEM.category = "Маска"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "SOTR"
ITEM.functions.drop = {
	tip = "dropTip",
	icon = "icon16/world.png",
	OnRun = function(item)
		local bSuccess, error = item:Transfer(nil, nil, nil, item.player)

		if (!bSuccess and isstring(error)) or (item:GetData("equip")) then
			item.player:Notify("Error")
			return false
		else
			item:Remove()
		end

		return false
		end,
		OnCanRun = function(item)
			return !IsValid(item.entity) and !item.noDrop and (item:GetData("equip") == false)
	end
}

ITEM.noBusiness = true
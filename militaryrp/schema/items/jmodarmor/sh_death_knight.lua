ITEM.name = "Маска Death Knight"
ITEM.model = Model("models/eft_props/gear/facecover/facecover_boss_black_knight.mdl")
ITEM.description = "Уникальная маска командира группы [ДАННЫЕ УДАЛЕННЫ]"
ITEM.category = "Шлем"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "Death Knight"
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
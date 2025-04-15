ITEM.name = "Hexatac HPC"
ITEM.model = Model("models/eft_props/gear/armor/ar_hexatac.mdl")
ITEM.description = "Чехол под бронеплиты фирмы Hexatac. Минималистичный вариант, предназначенный для совместного использования с нагрудными разгрузочными системами. Версия в камуфляже Multicam Black."
ITEM.category = "Бронежилет"
ITEM.width = 2 
ITEM.height = 3
ITEM.Jname = "Hexatac HPC"
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
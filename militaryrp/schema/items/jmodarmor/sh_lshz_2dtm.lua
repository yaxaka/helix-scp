ITEM.name = "LShZ-2DTM"
ITEM.model = Model("models/eft_props/gear/helmets/helmet_lshz2dtm.mdl")
ITEM.description = "Шлем «ЛШЗ-2ДТМ» предназначен для периодического ношения с целью защиты от пуль стрелкового оружия головы человека, а также для защиты от пуль стрелкового оружия лица и шеи человека при комплектации изделия забралом и бармицей."
ITEM.category = "Шлем"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "LShZ-2DTM"
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
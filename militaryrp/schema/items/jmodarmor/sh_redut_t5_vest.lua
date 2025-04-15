ITEM.name = "Redut-T5 Vest"
ITEM.model = Model("models/eft_props/gear/armor/ar_redut_t5.mdl")
ITEM.description = "Штурмовой бронежилет ФОРТ «Редут Т5» представляет собой усиленный вариант бронежилетов серии «Редут», разработанный с учетом многолетнего опыта проведения антитеррористических операций."
ITEM.category = "Бронежилет"
ITEM.width = 2 
ITEM.height = 3
ITEM.Jname = "Redut-T5 Vest"
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
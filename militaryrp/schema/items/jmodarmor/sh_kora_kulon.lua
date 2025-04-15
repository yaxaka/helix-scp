ITEM.name = "Kora-Kulon"
ITEM.model = Model("models/eft_props/gear/armor/ar_kirasa_black.mdl")
ITEM.description = "Бронежилет Кора-Кулон является средством индивидуальной бронезащиты длительного ношения, позволяющим выполнять все виды профессиональной деятельности личного состава подразделений."
ITEM.category = "Бронежилет"
ITEM.width = 2 
ITEM.height = 3
ITEM.Jname = "Kora-Kulon"
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
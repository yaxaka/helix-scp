ITEM.name = "Trooper TFO"
ITEM.model = Model("models/eft_props/gear/armor/ar_trooper.mdl")
ITEM.description = "Бронежилет фирмы Highcom, популярный среди ЧВК USEC. Облегченные плиты AR500 4-го класса защиты закрывают только области груди и спины."
ITEM.category = "Бронежилет"
ITEM.width = 2 
ITEM.height = 3
ITEM.Jname = "Trooper TFO"
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
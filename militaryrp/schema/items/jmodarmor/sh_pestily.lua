ITEM.name = "Маска Чумного Доктора"
ITEM.model = Model("models/eft_props/gear/facecover/facecover_pestily.mdl")
ITEM.description = "Отреставрированная маска чумного доктора Pestily. Редкая и страшная вещь."
ITEM.category = "Маска"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "Pestily"
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
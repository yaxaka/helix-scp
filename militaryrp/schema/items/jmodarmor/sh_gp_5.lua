ITEM.name = "Противогаз GP-5"
ITEM.model = Model("models/eft_props/gear/facecover/facecover_gasmask_gp5.mdl")
ITEM.description = "Гражданский противогаз модель 5 или ГП-5 — фильтрующее средство индивидуальной защиты органов дыхания, глаз и кожи лица человека."
ITEM.category = "Противогаз"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "GP-5"
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
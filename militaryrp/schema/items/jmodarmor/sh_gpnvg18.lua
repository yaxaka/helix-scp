ITEM.name = "GPNVG18"
ITEM.model = Model("models/eft_props/gear/nvgs/nvg_l3_gpnvg_18_anvis.mdl")
ITEM.description = "Элемент экипировки"
ITEM.category = "ПНВ"
ITEM.width = 1 
ITEM.height = 1
ITEM.Jname = "GPNVG-18"
ITEM.Shifrator = true

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
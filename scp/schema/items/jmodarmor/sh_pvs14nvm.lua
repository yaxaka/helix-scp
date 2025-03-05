ITEM.name = "PVS14-NVM"
ITEM.model = Model("models/eft_props/gear/nvgs/nvg_pvs14.mdl")
ITEM.description = "Элемент экипировки"
ITEM.category = "ПНВ"
ITEM.width = 1 
ITEM.height = 1
ITEM.Jname = "PVS-14 NVM"
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
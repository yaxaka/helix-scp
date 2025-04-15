ITEM.name = "Banshee"
ITEM.model = Model("models/eft_props/gear/armor/cr/cr_shellback_tactical_banshee.mdl")
ITEM.description = "Разгрузочный жилет с бронепластинами Shellback Tactical Banshee (A-Tacs AU) (Banshee)"
ITEM.category = "Бронежилет"
ITEM.width = 2 
ITEM.height = 3
ITEM.Jname = "Banshee"
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
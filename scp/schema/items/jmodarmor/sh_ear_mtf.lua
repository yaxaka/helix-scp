ITEM.name = "Tactical Sport"
ITEM.model = Model("models/eft_props/gear/headsets/headset_tactical_sport.mdl")
ITEM.description = "Элемент броневой индивидуальной защиты человека"
ITEM.category = "Наушники"
ITEM.width = 1 
ITEM.height = 1
ITEM.Jname = "Tactical Sport"
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
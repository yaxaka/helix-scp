ITEM.name = "Маска Michael Myers"
ITEM.model = Model("models/eft_props/gear/facecover/facecover_halloween_micheal.mdl")
ITEM.description = "Страшная маска известного героя фильма ужасов Хеллоуин"
ITEM.category = "Маска"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "Misha Mayorov"
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
ITEM.name = "WT TV-115"
ITEM.model = Model("models/eft_props/gear/armor/cr/cr_tv115.mdl")
ITEM.description = "Оперативная бронесистема TV-115 с бронеплитами из высокоплотного полиэтилена, защищающих только грудь и спину."
ITEM.category = "Бронежилет"
ITEM.width = 2 
ITEM.height = 3
ITEM.Jname = "WT TV-115"
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
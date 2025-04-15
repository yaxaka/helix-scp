ITEM.name = "Defender-2"
ITEM.model = Model("models/eft_props/gear/armor/ar_defender2.mdl")
ITEM.description = "Оперативный комплект ФОРТ ОК «Дефендер-2» – модификация популярного бронежилета ФОРТ «Дефендер» предназначенная как для VIP-персон, так и для сотрудников оперативных боевых подразделений. В комплекте использованы максимальные возможности модульного принципа построения брони на базе стальных плит."
ITEM.category = "Бронежилет"
ITEM.width = 2 
ITEM.height = 3
ITEM.Jname = "Defender-2"
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
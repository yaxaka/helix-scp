ITEM.name = "Fast Rac Headset"
ITEM.model = Model("models/eft_props/gear/helmets/helmet_ops_core_rac_headset.mdl")
ITEM.description = "Компонент для шлема Ops-Core FAST - cистема шумоподавления и усиливания тихих звуков, а также радиогарнитура для подключения к рации."
ITEM.category = "Наушники"
ITEM.width = 1 
ITEM.height = 1
ITEM.Jname = "FAST RAC Headset"
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
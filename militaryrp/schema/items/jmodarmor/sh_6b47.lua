ITEM.name = "6B47"
ITEM.model = Model("models/eft_props/gear/helmets/helmet_6b47.mdl")
ITEM.description = "Единый войсковой броневой арамидный шлем в чехле Цифровая Флора. Является частью экипировки Ратник. Схож со шлемами 6Б7-1М и 6Б27 предыдущих поколений. Имеет тот же защитный класс, но весит меньше, плавает в воде, и оснащен креплениями для установки приборов ночного видения и гаджетов. "
ITEM.category = "Шлем"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "6B47"
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
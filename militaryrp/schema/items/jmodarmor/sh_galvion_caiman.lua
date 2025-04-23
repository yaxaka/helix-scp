ITEM.name = "Galvion Caiman"
ITEM.model = Model("models/eft_props/gear/helmets/helmet_galvion_caiman.mdl")
ITEM.description = "Легкий шлем специального назначения нового поколения. Серия модульных аксессуаров улучшает комплектацию, обеспечивая пользователям легкую, удобную и максимально эффективную защиту головы."
ITEM.category = "Шлем"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "Galvion Caiman"
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
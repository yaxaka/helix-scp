ITEM.name = "Kolpak-1S"
ITEM.model = Model("models/eft_props/gear/helmets/helmet_k1c.mdl")
ITEM.description = "Защитный шлем Колпак-1С предохраняет голову от поражения холодным колюще-режущим оружием по специальному классу, от осколочных ранений с энергией удара до 50 Дж, а также служит для снижения динамических нагрузок, возникающих при воздействии вышеуказанных средств поражения."
ITEM.category = "Шлем"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "Kolpak-1S"
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
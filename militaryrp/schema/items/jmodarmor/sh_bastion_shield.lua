ITEM.name = "Bastion Shield"
ITEM.model = Model("models/eft_props/gear/helmets/helmet_diamond_age_bastion_shield.mdl")
ITEM.description = "Как заявляет производитель - шлем Бастион, это первый боевой шлем, способный выдерживать попадание из винтовки, даже, пулей с сердечником, со скоростью на срезе ствола."
ITEM.category = "Шлем"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "Bastion Shield"
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
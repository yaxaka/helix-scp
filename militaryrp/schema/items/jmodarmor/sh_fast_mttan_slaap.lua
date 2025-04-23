ITEM.name = "Fast MT Tan SLAAP"
ITEM.model = Model("models/eft_props/gear/helmets/helmet_ops_core_fast_tan_slaap.mdl")
ITEM.description = "Баллистический шлем Ops-Core Fast популярный у спецподразделений всего мира. Может быть модифицирован различными компонентами."
ITEM.category = "Шлем"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "Fast MT Tan SLAAP"
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
ITEM.name = "Tac-Kek FAST"
ITEM.model = Model("models/eft_props/gear/helmets/helmet_hops_core_fast.mdl")
ITEM.description = "Небаллистическая реплика шлема Ops-Core Fast от Tac-Kek. Может быть модифицирован различными компонентами."
ITEM.category = "Шлем"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "Tac-Kek FAST MT"
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
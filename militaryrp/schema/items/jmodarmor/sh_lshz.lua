ITEM.name = "LShZ"
ITEM.model = Model("models/eft_props/gear/helmets/helmet_lshz.mdl")
ITEM.description = "Легкий защитный шлем. По сути копия шлема Ops-core Fast, но с более низкими характеристиками."
ITEM.category = "Шлем"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "LShZ"
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
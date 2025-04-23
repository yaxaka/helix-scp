ITEM.name = "TSh-4M-L"
ITEM.model = Model("models/eft_props/gear/helmets/helmet_tsh_4m2.mdl")
ITEM.description = "Танковый шлемофон ТШ-4М-Л(З)-01 предназначен для обеспечения двухсторонней радиотелефонной связи в объектах с высоким уровнем шумов, защиты от воздействия климатических факторов и от ударов об элементы конструкций объектов."
ITEM.category = "Шлем"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "TSh-4M-L"
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
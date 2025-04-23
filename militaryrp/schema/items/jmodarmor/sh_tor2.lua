ITEM.name = "Tor-2"
ITEM.model = Model("models/eft_props/gear/helmets/helmet_tor_2.mdl")
ITEM.description = "НПП КлАСС Тор-2 - штурмовой защитный шлем со сьемным пулестойким забралом и интегрированной системой установки дополнительного оборудования (ПНВ, активные наушники с системой радиосвязи, тактические фонари, видеофиксаторы, ИК маячки и др.)."
ITEM.category = "Шлем"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "Tor2"
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
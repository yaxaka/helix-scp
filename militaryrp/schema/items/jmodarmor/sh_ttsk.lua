ITEM.name = "TT SK"
ITEM.model = Model("models/eft_props/gear/armor/cr/cr_tt_plate_carrier.mdl")
ITEM.description = "Ультралёгкий и скелетообразный жилет TT Plate Carrier SK изготовлен в основном из лёгкого, тонкого и прочного, ламинированного термополиуретаном, нейлонового материала Cordura с заявленной плотностью не ниже 700 денье."
ITEM.category = "Бронежилет"
ITEM.width = 2 
ITEM.height = 3
ITEM.Jname = "TT SK"
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
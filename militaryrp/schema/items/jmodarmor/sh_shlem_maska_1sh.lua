ITEM.name = "Shlem 1SH"
ITEM.model = Model("models/eft_props/gear/helmets/helmet_maska_1sh.mdl")
ITEM.description = "Защитный шлем «Маска-1» появился на вооружении в 1991 году, как замена шлему «Сфера»."
ITEM.category = "Шлем"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "Shlem Maska 1SH"
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
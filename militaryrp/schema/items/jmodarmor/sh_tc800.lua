ITEM.name = "TC 800"
ITEM.model = Model("models/eft_props/gear/helmets/helmet_msa_gallet.mdl")
ITEM.description = "Баллистический шлем MSA TC 800, предназначенный для применения тактическими командами полицейского спецназа, в боевых и разведывательных операциях. Может быть модифицирован различными компонентами."
ITEM.category = "Шлем"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "TC 800"
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
ITEM.name = "NeoSteel"
ITEM.model = Model("models/eft_props/gear/helmets/helmet_neosteel.mdl")
ITEM.description = "Шлем Diamond Age NeoSteel обладает уникальным дизайном, который сочетает в себе высокопрочную сталь с композитными материалами, обеспечивающим передовую защиту от баллистических и ударных угроз."
ITEM.category = "Шлем"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "NeoSteel"
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
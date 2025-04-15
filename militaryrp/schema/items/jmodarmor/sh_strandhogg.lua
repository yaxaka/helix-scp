ITEM.name = "Strandhogg"
ITEM.model = Model("models/eft_props/gear/armor/cr/cr_strandhogg.mdl")
ITEM.description = "Получив свое название от древнескандинавского термина «молниеносный рейд» викингов, Strandhogg был одной из первых формализованных боевых тактик, в которых использовались тайные лазутчики перед фактической операцией рейда."
ITEM.category = "Бронежилет"
ITEM.width = 2 
ITEM.height = 3
ITEM.Jname = "Strandhogg"
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
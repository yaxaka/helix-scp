ITEM.name = "PlateFrame GE"
ITEM.model = Model("models/eft_props/gear/armor/cr/cr_precision_bigpipe.mdl")
ITEM.description = "Минималистичный, легкий, полужесткий пластиковый дизайн обеспечивает жесткую монтажную платформу, в отличие от любого другого плейткерриера на рынке. Рама дает оператору возможность увеличивать или уменьшать нагрузку в соответствии с эксплуатационными требованиями. PlateFrame позволяет легко прикреплять подсумки для аксессуаров и подходит для стандартных подсумков MOLLE/PALS."
ITEM.category = "Бронежилет"
ITEM.width = 2 
ITEM.height = 3
ITEM.Jname = "PlateFrame GE"
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
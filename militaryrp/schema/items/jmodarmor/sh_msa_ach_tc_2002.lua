ITEM.name = "MSA ACH TC-2002"
ITEM.model = Model("models/eft_props/gear/helmets/helmet_mich2002.mdl")
ITEM.description = "Усовершенствованный боевой шлем MSA (ACH) обеспечивает улучшенную защиту от баллистических, осколочных и ударных воздействий, а также комфорт при длительном использовании. Низкопрофильная конструкция шлема снижает риск перекрываний при захвате цели и обеспечивает совместимость с головными приборами и гарнитурами."
ITEM.category = "Шлем"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "MSA ACH TC-2002"
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
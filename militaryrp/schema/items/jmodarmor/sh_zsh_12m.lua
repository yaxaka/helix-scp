ITEM.name = "ZSH-1-2M"
ITEM.model = Model("models/eft_props/gear/helmets/helmet_zsh_1_2m_v2.mdl")
ITEM.description = "Шлем ЗШ-1-2М состоит из прочного сплава, покрытого изнутри арамидными тканями, который не дает пробить защиту и впитывает в себе динамическое воздействие пули или осколков."
ITEM.category = "Шлем"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "ZSH-1-2M v2"
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
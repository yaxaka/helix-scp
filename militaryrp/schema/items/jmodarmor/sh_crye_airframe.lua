ITEM.name = "Crye AirFrame"
ITEM.model = Model("models/eft_props/gear/helmets/helmet_crye_airframe.mdl")
ITEM.description = "Баллистический шлем AirFrame устанавливает стандарты защиты, комфорта и модульности. Уникальный дизайн шлема совмещает в себе систему вентиляции и минимизирует урон от взрывной волны."
ITEM.category = "Шлем"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "Crye AirFrame"
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
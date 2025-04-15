ITEM.name = "6B13"
ITEM.model = Model("models/eft_props/gear/armor/ar_6b13_digi.mdl")
ITEM.description = "Общевойсковой штурмовой бронежилет является средством индивидуальной бронезащиты личного состава боевых подразделений сухопутных войск, ВДВ, морской пехоты и т.д."
ITEM.category = "Бронежилет"
ITEM.width = 2 
ITEM.height = 3
ITEM.Jname = "6B13"
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